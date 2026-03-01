var app = angular.module("MyApp", []);
app.controller("MyController", function ($scope) {
  $scope.sortBy = "name";
  $scope.students = [
    { name: "Hazem", grade: 99 },
    { name: "Youssif", grade: 90 },
    { name: "Mohamed", grade: 85 },
    { name: "Ali", grade: 60 },
    { name: "Sara", grade: 70 },
    { name: "Essam", grade: 82 },
  ];
});
