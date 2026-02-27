var app = angular.module("MyApp", []);

app.controller("MyController", function ($scope) {
  $scope.students = [];
  $scope.errorMessage = "";

  $scope.addStudent = function () {
    if (!$scope.stdName) {
      $scope.errorMessage = "Student name is required!";
      return;
    }

    if ($scope.stdName.trim().length < 3) {
      $scope.errorMessage = "Name must be at least 3 characters!";
      return;
    }

    $scope.students.push($scope.stdName.trim());
    $scope.stdName = "";
    $scope.errorMessage = "";
  };

  $scope.removeStudent = function (index) {
    $scope.students.splice(index, 1);
  };
});
