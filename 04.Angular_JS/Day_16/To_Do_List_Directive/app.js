var app = angular.module("MyApp", []);

app.controller("MyController", function ($scope) {
  $scope.items = [];
});

app.directive("toDoList", function () {
  return {
    scope: {
      listItems: "=",
    },
    template: `
      <div class="input-group input-group-sm mb-3">
        <input type="text" class="form-control form-control-sm" ng-model="newItem" placeholder="Add new item"/>
        <button class="btn btn-primary btn-sm" ng-click="addItem()">Add</button>
      </div>

      <ul class="ps-0 mb-0">
        <li class="d-flex justify-content-between align-items-center px-2 py-1 mb-1 rounded" ng-repeat="item in listItems track by $index">

          <div>
            <input type="checkbox" class="me-2" ng-model="item.completed">
            <span ng-style="{'text-decoration': item.completed ? 'line-through' : 'none'}">
              {{item.text}}
            </span>
          </div>

          <button class="btn btn-danger btn-sm py-0 px-2" ng-click="removeItem($index)">✕</button>
        </li>
      </ul>
    `,
    link: function (scope) {
      scope.addItem = function () {
        if (scope.newItem) {
          scope.listItems.push({
            text: scope.newItem,
            completed: false,
          });
          scope.newItem = "";
        }
      };

      scope.removeItem = function (index) {
        scope.listItems.splice(index, 1);
      };
    },
  };
});
