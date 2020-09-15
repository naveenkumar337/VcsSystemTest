<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="VcsSystem_MachineTest.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="entry-tag">
    <div class="div-tab" style="position: relative; z-index: auto; top: -6px; left: 10px; width: 1180px;" tabindex="2">
        <div id="basic-details" style="width: 420px">
        <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
        <asp:TextBox ID="txtName" runat="server"></asp:TextBox><br/>
        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" required="required" ></asp:TextBox><br/>
        <asp:Label ID="lblCalender" runat="server" Text="Date of Birth:"></asp:Label>
            <asp:TextBox ID="txtcalnder" runat="server"></asp:TextBox><br/><br/>
            <asp:Label ID="lblImage" runat="server" Text="Image:"></asp:Label>
        <asp:FileUpload ID="fuImage" runat="server" /><br/>
            </div>
        </div>

        <asp:Button ID="btnSubmit" runat="server" Text="Sumit" OnClick="btnSubmit_Click" /><br/>
        <br/>
            </div>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
       
        <div id="gridView">
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="False" 
            GridLines="None" DataKeyNames="Eid" OnPageIndexChanging="GridView1_PageIndexChanging" 
            OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" 
            OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" allowpaging="True" >
            <AlternatingRowStyle BackColor="White"  />
            <pagersettings mode="Numeric"
                        position="Bottom"           
                    pagebuttoncount="10"/>
                      
                <pagerstyle backcolor="LightBlue"
                  height="30px"
                  verticalalign="Bottom"
                  horizontalalign="Center"/>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
             <Columns>  
                        <asp:BoundField DataField="Eid" HeaderText="S.No." />  
                        <asp:BoundField DataField="Ename" HeaderText="Name" />  
                        <asp:BoundField DataField="Email" HeaderText="email" />
                        <asp:BoundField DataField="Dob" HeaderText="DOB" />  
                 <asp:TemplateField HeaderText="Image_URL">
                     <EditItemTemplate>
                         <asp:FileUpload ID="FileUpload1" runat="server" style="margin-bottom: 0px" />
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Image ID="image_file" runat="server" ImageUrl='<%#Eval("pic")%>' Height="100px" Width="100px"/>
                     </ItemTemplate>
                 </asp:TemplateField>
                        <asp:CommandField ShowEditButton="true" />  
                        <asp:CommandField ShowDeleteButton="true" /> 
                        <asp:TemplateField></asp:TemplateField>
                        <asp:TemplateField></asp:TemplateField>
                        <asp:TemplateField></asp:TemplateField>
            </Columns>
             <EmptyDataTemplate>
        <div align="center">No records found.</div>
    </EmptyDataTemplate>
        </asp:GridView>
            </div>
    </form>
    <style>
        .div-tab {
            flex:2;
        display:flex;
        }
        input[type=text] {
        margin-left:45px;
        }
        input#txtcalnder {
        margin-left:0px;
        }
        #fuImage {
        margin-left:45px;
        }
    </style>
   <script>
       <%--var email = document.getElementById('TextBox2');
       ValidEmail(email.innerText);

       function ValidateDate(date) {
           if (date < Date.now()) {
               return true;
           } else {
               return false;
           }
       }--%>
       //function ValidEmail(emailid) {
       //    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(myForm.emailAddr.value)) {
       //        return true;
       //    }
       //    alert("You have entered an invalid email address!")
       //    return false;
       //}
       var grdv = document.querySelectorAll('#GridView1');
       grdv.forEach(e=> {
           e.addEventListener('click', e=> {
               e=> {
                   var image = document.getElementById('#Image1');
                   image.setAttribute('ImageUrl', "E:\\VS_Code\\VcsSystem_MachineTest\\VcsSystem_MachineTest\\Images\\" + e.cells[4].innerText);
               }});
           });
   </script>
</body>
</html>
