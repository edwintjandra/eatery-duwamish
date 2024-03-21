<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master" CodeBehind="DishRecipe.aspx.cs" Inherits="EateryDuwamish.DishRecipe"%>
<%@ Register Src="~/UserControl/NotificationControl.ascx" TagName="NotificationControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <%--Datatable Configuration--%>
    <script type="text/javascript">
        function ConfigureDatatable() {
            var table = null;
            if ($.fn.dataTable.isDataTable('#htblDish')) {
                table = $('#htblDish').DataTable();
            }
            else {
                table = $('#htblDish').DataTable({
                    stateSave: false,
                    order: [[1, "asc"]],
                    columnDefs: [{ orderable: false, targets: [0] }]
                });
            }
            return table;
        }
    </script>
    <%--Checkbox Event Configuration--%>
    <script type="text/javascript">
        function ConfigureCheckboxEvent() {
            $('#htblDish').on('change', '.checkDelete input', function () {
                var parent = $(this).parent();
                var value = $(parent).attr('data-value');
                var deletedList = [];

                if ($('#<%=hdfDeletedDishes.ClientID%>').val())
                    deletedList = $('#<%=hdfDeletedDishes.ClientID%>').val().split(',');

                if ($(this).is(':checked')) {
                    deletedList.push(value);
                    $('#<%=hdfDeletedDishes.ClientID%>').val(deletedList.join(','));
                }
                else {
                    var index = deletedList.indexOf(value);
                    if (index >= 0)
                        deletedList.splice(index, 1);
                    $('#<%=hdfDeletedDishes.ClientID%>').val(deletedList.join(','));
                }
            });
        }
    </script>
    <%--Main Configuration--%>
    <script type="text/javascript">
        

        function ConfigureElements() {
            ConfigureDatatable();
            ConfigureCheckboxEvent();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
             <script type="text/javascript">
                 $(document).ready(function () {
                     ConfigureElements();
                 });
                 <%--On Partial Postback Callback Function--%>
                             var prm = Sys.WebForms.PageRequestManager.getInstance();
                             prm.add_endRequest(function () {
                                 ConfigureElements();
                             });
                         </script>
             <uc1:NotificationControl ID="notifDish" runat="server" />
             <div class="page-title">Recipe Details</div><hr style="margin:0"/>

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
                                        <%-- Validator for Ingredient --%>
                                          <asp:RequiredFieldValidator ID="rfvIngredient" runat="server" ErrorMessage="Please fill this field"
                                             ControlToValidate="txtIngredient" ForeColor="Red" 
                                             ValidationGroup="InsertUpdateRecipe" Display="Dynamic">
                                         </asp:RequiredFieldValidator>
                                  </div>
                              </div>
                              <%--END Ingredient Field--%>

                            <%--Quantity Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                Quantity*
                                </div>
                               <div class="col-lg-6">
                                   <div class="input-price">
                                       <asp:TextBox ID="txtQuantity" type="number"  Min="0" Max="999999999" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                       <%-- Validator for Quantity --%>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ErrorMessage="Please fill this field"
                                        ControlToValidate="txtQuantity" ForeColor="Red" 
                                        ValidationGroup="InsertUpdateRecipe" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
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
                                        <%-- Validator for Unit --%>
                                        <asp:RequiredFieldValidator ID="rfvUnit" runat="server" ErrorMessage="Please fill this field"
                                            ControlToValidate="txtUnit" ForeColor="Red" 
                                            ValidationGroup="InsertUpdateRecipe" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
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
                                      Text="SAVE" OnClick="btnSave_Click" ValidationGroup="InsertUpdateRecipe">
                                  </asp:Button>
                              </div>
                          </div>
                 
                    </div>
                  </div>
              </asp:Panel>
              <%--END OF FORM DISH--%>

              <%-- REPEATER --%>
              <div class="row">
                <div class="table-header">
                    <div class="table-header-title">
                        DISHES
                    </div>
                    <div class="table-header-button">
                        <asp:Button ID="btnDelete" runat="server" Text="DELETE" CssClass="btn btn-danger" Width="100px"
                            OnClick="btnDelete_Click" />
                    </div>
                </div>
            </div>
              <div class="row">
                <div class="table-main col-sm-12">
                    <asp:HiddenField ID="hdfDeletedDishes" runat="server" />
                    <asp:Repeater ID="rptDishRecipe" runat="server" OnItemDataBound="rptDishRecipe_ItemDataBound" OnItemCommand="rptDishRecipe_ItemCommand">
                        <HeaderTemplate>
                            <table id="htblDish" class="table">
                                <thead>
                                    <tr role="row">
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0" class="sorting_asc center">
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0" class="sorting_asc text-center">
                                            Ingredient
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0" class="sorting_asc text-center">
                                            Quantity
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0" class="sorting_asc text-center">
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
                                        <asp:LinkButton ID="lbIngredient" runat="server" CommandName="EDIT"></asp:LinkButton>
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
            </div>

                <%-- Container for Description --%>
                <div class="row">
                    <div class="table-header">
                        <div class="table-header-title">
                            Recipe Description
                        </div>
                    <div class="">
                        <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" TextMode="MultiLine" ReadOnly="true" EnableViewState="true" ></asp:TextBox>
                         <%-- Validator for text description --%>
                        
                    </div>

                     <div class="table-header-button">
                          <%-- toggle button --%>
                          <asp:Button ID="btnToggleDescription" runat="server" Text="EDIT" CssClass="btn btn-primary" Width="100px"
                            OnClick="btnToggleDescription_Click" /> 
                         <%-- save button --%>
                         <asp:Button ID="btnSaveDescription" runat="server" Text="SAVE DESCRIPTION" CssClass="btn btn-primary" Width="100px"
                             OnClick="btnSaveDescription_Click" /> 
                     </div>
                    </div>
                    
                </div>


       </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

 

  
