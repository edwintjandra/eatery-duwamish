<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DishRecipe.aspx.cs" Inherits="EateryDuwamish.DishRecipe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
          <h2>Dish Recipes</h2>
          <%--FORM DISH--%>
          <asp:Panel runat="server" ID="pnlFormDish" Visible="true">
              <asp:HiddenField ID="HiddenField1" runat="server" Value="0"/>
              <div class="form-slip">
                  <div class="form-slip-header">
                      <div class="form-slip-title">
                          <asp:Label ID="lblDishName" runat="server" Text="Dish Name:"></asp:Label>
                          <asp:Literal runat="server" ID="litFormType"></asp:Literal>
                      </div>
                      <hr style="margin:0"/>
                  </div>
                  <div class="form-slip-main">

                      <div>
                         <%--Ingredient Field--%>
                          <div class="col-lg-6 form-group">
                              <div class="col-lg-4 control-label">
                                  Ingredient*
                              </div>
                              <div class="col-lg-6">
                                  <asp:TextBox ID="txtIngredient" CssClass="form-control" runat="server"></asp:TextBox>
                              </div>
                          </div>
                          <%--END Ingredient Field--%>

                        <%--Quantity Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                    Quantity*
                                </div>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtQuantity" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <%--END Quantity Field--%>

                           <%--Unit Field--%>
                             <div class="col-lg-6 form-group">
                                 <div class="col-lg-4 control-label">
                                     Unit*
                                 </div>
                                 <div class="col-lg-6">
                                     <asp:TextBox ID="txtUnit" CssClass="form-control" runat="server"></asp:TextBox>
                                 </div>
                             </div>
                             <%--END Unit Field--%>


                          <%-- hidden field dish id --%>
                          
                         <asp:HiddenField ID="hdfDishRecipeID" runat="server" Value="0"/>
                         <asp:HiddenField ID="hdfDishDetailID" runat="server" Value="0"/>


                        <%--End of Dish ID Field--%>   
                   
                      </div>
                      <%-- save Button --%>
                      <div class="col-lg-12">
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

        <%-- DISH DETAIL LISTS --%>
        <div>
        <h2>DishRecipe Lists</h2>
        <asp:Repeater ID="rptDishRecipe" runat="server" OnItemDataBound="rptDishRecipe_ItemDataBound">
            <HeaderTemplate>
            <table id="htblDish" class="table">
                <thead>
                    <tr role="row">
                        <th aria-sort="ascending" style="" colspan="1" rowspan="1"
                            tabindex="0" class="sorting_asc center">
                        </th>
                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                            class="sorting_asc text-center">
                            Ingredient
                        </th>
                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                            class="sorting_asc text-center">
                            Quantity
                        </th>
                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                            class="sorting_asc text-center">
                            Unit
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
                        <asp:Literal ID="litIngredient" runat="server"></asp:Literal>
                    </td>
                     <td>
                        <asp:Literal ID="litQuantity" runat="server"></asp:Literal>
                    </td>
                     <td>
                        <asp:Literal ID="litUnit" runat="server"></asp:Literal>
                     </td>
                </tr>
                </tbody>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    </form>
</body>
</html>
