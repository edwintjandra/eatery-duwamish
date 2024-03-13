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
            <asp:HiddenField ID="HiddenField1" runat="server" Value="0"/>
            <div class="form-slip">
                <div class="form-slip-header">
                    <div class="form-slip-title">
                        FORM DISH DETAIL
                        <asp:Literal runat="server" ID="litFormType"></asp:Literal>
                    </div>
                    <hr style="margin:0"/>
                </div>
                <div class="form-slip-main">
                    <!-- Hidden Field for DishDetailId, and DishId -->
                    <asp:HiddenField ID="hdfDishDetailId" runat="server" Value="0"/>
                    <asp:HiddenField ID="hdfDishId" runat="server" Value="0"/>

                    <div>
                       <%--Recipe Name Field--%>
                        <div class="col-lg-6 form-group">
                            <div class="col-lg-4 control-label">
                                Recipe Name*
                            </div>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtRecipeName" CssClass="form-control" runat="server"></asp:TextBox>
                                <%--Validator--%>
                                <asp:RequiredFieldValidator ID="rfvRecipeName" runat="server" ErrorMessage="Please fill this field"
                                    ControlToValidate="txtRecipeName" ForeColor="Red" 
                                    ValidationGroup="InsertUpdateRecipe" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revRecipeName" runat="server" ErrorMessage="This field has a maximum of 100 characters"
                                    ControlToValidate="txtRecipeName" ValidationExpression="^[\s\S]{0,100}$" ForeColor="Red"
                                    ValidationGroup="InsertUpdateRecipe" Display="Dynamic">
                                </asp:RegularExpressionValidator>
                                <%--End of Validator--%>
                            </div>
                        </div>
                        <%--End of Recipe Name Field--%>    
                         <%--Dish ID Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                    Dish ID*
                                </div>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtDishId" CssClass="form-control" runat="server" type="number"
                                    Min="0" Max="999999999"></asp:TextBox>
                                </div>
                            </div>
                            <%--End of Recipe Name Field--%>    
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

        <%-- DishDetail lists --%>
         <div>
            <h2>DishDetail Lists</h2>

            <asp:Repeater ID="rptDishDetail" runat="server" OnItemCommand="rptDishDetail_ItemCommand" OnItemDataBound="rptDishDetail_ItemDataBound">
                <HeaderTemplate>
                <table id="htblDish" class="table">
                    <thead>
                        <tr role="row">
                            <th aria-sort="ascending" style="" colspan="1" rowspan="1"
                                tabindex="0" class="sorting_asc center">
                            </th>
                            <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                class="sorting_asc text-center">
                                Recipe Name
                            </th>
                        </tr>
                    </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                    <tr class="odd" role="row" runat="server" onclick="">
                        <td>
                            <div style="text-align: center;">
                                <asp:CheckBox ID="chkChoose" CssClass="checkDelete" runat="server">
                                </asp:CheckBox>
                            </div>
                        </td>
                         <td>
                            <asp:LinkButton ID="lbRecipeName" runat="server" CommandName="EDIT"></asp:LinkButton>
                        </td>
                    </tr>
                    </tbody>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
