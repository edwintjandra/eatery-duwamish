<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DishRecipe.aspx.cs" Inherits="EateryDuwamish.DishRecipe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
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
