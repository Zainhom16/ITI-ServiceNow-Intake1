var app = angular.module("MyApp", []);

app.controller("MyController", function ($scope, ProductService) {
  $scope.products = [];
  $scope.newProduct = {
    name: "",
    price: null,
    brand: "",
  };

  $scope.loading = false;

  $scope.Init = function () {
    $scope.loading = true;
    ProductService.getProducts()
      .then(function (response) {
        $scope.products = response.data;
      })
      .catch(function (error) {
        console.error("Error fetching Products:", error);
      })
      .finally(function () {
        $scope.loading = false;
      });
  };

  $scope.Init();

  $scope.addProduct = function () {
    $scope.loading = true;
    ProductService.addProduct($scope.newProduct).then(function (response) {
      $scope.Init();
      $scope.newProduct = { name: "", price: null, brand: "" };
      $scope.loading = false;
    });
  };

  $scope.deleteProduct = function (id) {
    $scope.loading = true;
    ProductService.deleteProduct(id).then(function () {
      $scope.Init();
      $scope.loading = false;
    });
  };

  $scope.updateProduct = function (product) {
    $scope.loading = true;
    ProductService.updateProduct(product)
      .then(function () {
        $scope.Init();
      })
      .catch(function (error) {
        console.error("Update failed:", error);
      })
      .finally(function () {
        $scope.loading = false;
      });
  };
});

app.service("ProductService", function ($http) {
  const SUPABASE_URL =
    "https://chngxvrspxusynptfqfa.supabase.co/rest/v1/products";
  const SUPABASE_KEY = "sb_publishable_ti5vwFIF2zAgEWKY3rBFlw_TrTqwtC4";
  const headers = {
    apikey: SUPABASE_KEY,
    Authorization: `Bearer ${SUPABASE_KEY}`,
    "Content-Type": "application/json",
  };

  this.getProducts = function () {
    return $http.get(SUPABASE_URL, { headers: headers });
  };

  this.addProduct = function (product) {
    return $http.post(SUPABASE_URL, product, { headers: headers });
  };

  this.deleteProduct = function (id) {
    return $http.delete(`${SUPABASE_URL}?id=eq.${id}`, { headers: headers });
  };

  this.updateProduct = function (product) {
    return $http.put(`${SUPABASE_URL}?id=eq.${product.id}`, product, {
      headers: headers,
    });
  };
});
