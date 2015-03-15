var app = angular.module('crockPotMarket', []);

$(document).ready(function() {
});

app.controller('PotCtrl', [
'$scope','$log','$http',
function($scope, $log, $http){
  $scope.crockPots = [{name: "poop"}];
  $scope.allCrockPots = [];
  $scope.viewCrockPots = [];
  $scope.init = function() {

    $http.get('/crockpots').
      success(function(data, status, headers, config) {
        console.log(data, status);
        $scope.allCrockPots = data;
        $scope.splitIntoColumns(data);
        // $scope.crockPots = data;
      }).
      error(function(data, status, headers, config) {
        console.log("failed retrieval of crockPots", status)      
      });
  }
  $scope.init();
  $scope.splitIntoColumns = function(data) {
    var newArray = []
    for (i = 0; i < data.length; i += 3) {
      newArray.push(data.slice(i, i+3));
    }
    $scope.viewCrockPots = newArray;
  }
  $scope.getAllProducts = function() {
     $scope.splitIntoColumns($scope.allCrockPots);
  }
  $scope.selectByBrand = function(selectedBrand) {
    var brandArray = [];
    if (selectedBrand === "Other") {
      for (var i=0; i < $scope.allCrockPots.length; i++) {
        if ($scope.allCrockPots[i].brand != "Crock-Pot" && $scope.allCrockPots[i].brand != "Breville" && $scope.allCrockPots[i].brand != "Hamilton Beach" && $scope.allCrockPots[i].brand != "Cuisinart" ) {
          brandArray.push($scope.allCrockPots[i]);
        }
      }  
    }
    for (var i=0; i < $scope.allCrockPots.length; i++) {
      if ($scope.allCrockPots[i].brand === selectedBrand) {
        brandArray.push($scope.allCrockPots[i]);
      }
    }
    $scope.splitIntoColumns(brandArray);
  }
  $scope.sortByBrand = function(brand) {
    var sortByPriceArray = data.sort(function(a, b) {
          if (a.price < b.price) {
            return 1;
          }
          if (a.price > b.price) {
            return -1;
          }
          // a must be equal to b
          return 0;
    });
    $scope.splitIntoColumns(sortByPriceArray);
  }
  $scope.selectByCapacity = function(cap) {
    var capacityArray = [];
    if (cap === "large") {
      for (var i=0; i < $scope.allCrockPots.length; i++) {
        if ($scope.allCrockPots[i].capacity > 6.5) {
          capacityArray.push($scope.allCrockPots[i]);
        }
      }
    } else if (cap === "medium") {
      for (var i=0; i < $scope.allCrockPots.length; i++) {
        if ($scope.allCrockPots[i].capacity >= 5 && $scope.allCrockPots[i].capacity <= 6.5) {
          capacityArray.push($scope.allCrockPots[i]);
        }
      }
    } else if (cap === "small") {
      for (var i=0; i < $scope.allCrockPots.length; i++) {
        if ($scope.allCrockPots[i].capacity < 5) {
          capacityArray.push($scope.allCrockPots[i]);
        }
      }
    }
    $scope.splitIntoColumns(capacityArray);
  }
  $scope.sortByCapacity = function(cap) {
    if (cap === "large") {
      $http.get('/crockpots/capacity/large').
        success(function(data, status, headers, config) {
          console.log(data, status);
          $scope.splitIntoColumns(data);
          // $scope.crockPots = data;
        }).
        error(function(data, status, headers, config) {
          console.log("failed retrieval of crockPots", status)      
        });
    } else if (cap === "medium") {
      $http.get('/crockpots/capacity/medium').
        success(function(data, status, headers, config) {
          console.log(data, status);
          $scope.splitIntoColumns(data);
          // $scope.crockPots = data;
        }).
        error(function(data, status, headers, config) {
          console.log("failed retrieval of crockPots", status)      
        });
    } else if (cap === "small") {
      $http.get('/crockpots/capacity/small').
        success(function(data, status, headers, config) {
          console.log(data, status);
          $scope.splitIntoColumns(data);
          // $scope.crockPots = data;
        }).
        error(function(data, status, headers, config) {
          console.log("failed retrieval of crockPots", status)      
        });  
    }
  }
  $scope.sortProduct = function(sortBy) {
    console.log("sorting by", sortBy)
    if (sortBy === "price") {
      $scope.sortByPrice();
    }
  }
  $scope.sortByPrice = function() {
      $http.get('/crockpots').
      success(function(data, status, headers, config) {
        console.log(data, status);
        var sortByPriceArray = data.sort(function(a, b) {
          if (a.price < b.price) {
            return 1;
          }
          if (a.price > b.price) {
            return -1;
          }
          // a must be equal to b
          return 0;
        });
        $scope.splitIntoColumns(sortByPriceArray);
      }).
      error(function(data, status, headers, config) {
        console.log("failed retrieval of crockPots")      
      });
    console.log("sorted by price");
  }
}]);