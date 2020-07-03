using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace VcsSystem_MachineTest
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string imagepath = @"E:\VS_Code\VcsSystem_MachineTest\VcsSystem_MachineTest\Images\";
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[
               "connection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                binddata();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Employee emp = new Employee();
          emp= GetDetails(emp);
            if (Path.GetExtension(emp.image) == ".png" || Path.GetExtension(emp.image) == ".jpeg" || Path.GetExtension(emp.image) == ".jpg")
            {
                var result = SaveData(emp);
                if (result > 0)
                {
                    Label1.Text = "Data Saved Successfully";
                    using (FileStream fstream = new FileStream(imagepath + fuImage.FileName, FileMode.Create, FileAccess.ReadWrite))
                    {
                        fuImage.FileContent.CopyTo(fstream);
                    }
                }
                else
                {
                    Label1.Text = "Data Add Fail! may be duplicate data found";
                }
                binddata();
            }
            else {
                Label1.Text = "Image Formate is worng! please select correct file";
            }

        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlCommand cmd = new SqlCommand("DeleteEmployee", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@eid", Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString()));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            binddata();
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            binddata();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int userid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            TextBox Name = (TextBox)row.Cells[1].Controls[0];
            TextBox Email = (TextBox)row.Cells[2].Controls[0];
            TextBox Dob = (TextBox)row.Cells[3].Controls[0];
            TextBox image = (TextBox)row.Cells[4].Controls[0];  
            GridView1.EditIndex = -1;
            SqlCommand cmd = new SqlCommand("UpdateEmployee", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@eid", userid);
            cmd.Parameters.AddWithValue("@ename", Name.Text);
            cmd.Parameters.AddWithValue("@email", Email.Text);
            cmd.Parameters.AddWithValue("@dob", Convert.ToDateTime(Dob.Text));
            cmd.Parameters.AddWithValue("@image", image.Text);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            binddata();
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            binddata();
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            binddata();
        }

        private Employee GetDetails(Employee emp)
        {
            emp = new Employee();
            emp.name = txtName.Text;
            emp.email = txtEmail.Text;
            emp.dob =Convert.ToDateTime(txtcalnder.Text);
            emp.image = fuImage.FileName;
            return emp;
        }

        public int SaveData(Employee emp) {
            SqlCommand cmd = new SqlCommand("AddEmployee", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ename", emp.name);
            cmd.Parameters.AddWithValue("@email", emp.email);
            cmd.Parameters.AddWithValue("@dob", emp.dob);
            cmd.Parameters.AddWithValue("@image", emp.image);
            conn.Open();
            var res= cmd.ExecuteNonQuery();
            conn.Close();
            
            return res;
        }
        public void binddata()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("GetAllEmployeeDetails", conn);
            cmd.CommandType = CommandType.StoredProcedure;
           // conn.Close();
            conn.Open();
            using (SqlDataAdapter ad = new SqlDataAdapter(cmd)) {
                ad.Fill(dt);
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (dt.Rows.Count <= 1)
            {
                //GridView1.Rows[0].Cells.Clear();
                //GridView1.Rows[0].Cells[0].Text = "record not found";
            }
            conn.Close();
        }

    }
   
    public class Employee {
        public string name { get; set; }
        public string email { get; set; }
        public DateTime dob { get; set; }
        public string image { get; set; }
    }
}