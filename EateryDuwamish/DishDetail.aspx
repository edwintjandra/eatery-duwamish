<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DishDetail.aspx.cs" Inherits="EateryDuwamish.DishDetail" %>
<%@ Register Src="~/UserControl/NotificationControl.ascx" TagName="NotificationControl" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <uc1:NotificationControl ID="notifDish" runat="server" />

        <div class="page-title">Master Dish</div><hr style="margin:0"/>
        
        <%--FORM DISH--%>
        <asp:Panel runat="server" ID="pnlFormDish" Visible="true">
            <div class="form-slip">
                <div class="form-slip-header">
                    <div class="form-slip-title">
                        FORM DISH DETAIL
                        <asp:Literal runat="server" ID="litFormType"></asp:Literal>
                    </div>
                    <hr style="margin:0"/>
                </div>
                <div class="form-slip-main">
                    <asp:HiddenField ID="hdfDishId" runat="server" Value="0"/>
                    <div>
                        <%--Dish Name Field--%>
                        <div class="col-lg-6 form-group">
                            <div class="col-lg-4 control-label">
                                Recipe Name*
                            </div>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtDishName" CssClass="form-control" runat="server"></asp:TextBox>
                                <%--Validator--%>
                                <asp:RequiredFieldValidator ID="rfvDishName" runat="server" ErrorMessage="Please fill this field"
                                    ControlToValidate="txtDishName" ForeColor="Red" 
                                    ValidationGroup="InsertUpdateDish" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revDishName" runat="server" ErrorMessage="This field has a maximum of 100 characters"
                                    ControlToValidate="txtDishName" ValidationExpression="^[\s\S]{0,100}$" ForeColor="Red"
                                    ValidationGroup="InsertUpdateDish" Display="Dynamic">
                                </asp:RegularExpressionValidator>
                                <%--End of Validator--%>
                            </div>
                        </div>
                        <%--End of Dish Name Field--%>
                        
                        
                    </div>
                    <div class="col-lg-12">
                        <div class="col-lg-2">
                        </div>
                        <div class="col-lg-2">
                            <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Width="100px"
                                Text="SAVE" OnClick="btnSave_Click" ValidationGroup="InsertUpdateDish">
                            </asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <%--END OF FORM DISH--%>
    </form>
</body>
</html>
