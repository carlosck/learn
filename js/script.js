var App, current_section;

current_section = 1;

App = {
  init: function() {
    this.correct = false;
    this.goal_numbers = 0;
    this.current_score = 0;
    this.current_screen = $("#sec_numbers_s1");
    this.bind_menu();
    this.sec1_s1 = false;
    this.numbers_sec1_init();
    return this.bussy = false;
  },
  bind_menu: function() {
    $("#sec_numbers1").on("click", function(event) {
      event.preventDefault();
      if (App.busy) {
        return false;
      }
      if ($(this).hasClass("active")) {
        return false;
      }
      App.busy = true;
      App.numbers_sec1_init();
      $("#sec1_nav .active").removeClass("active");
      return $(this).addClass("active");
    });
    $("#sec_numbers2").on("click", function(event) {
      event.preventDefault();
      if (App.busy) {
        return false;
      }
      if ($(this).hasClass("active")) {
        return false;
      }
      App.busy = true;
      App.numbers_sec2_init();
      $("#sec1_nav .active").removeClass("active");
      return $(this).addClass("active");
    });
    return $("#sec_numbers3").on("click", function(event) {
      event.preventDefault();
      if (App.busy) {
        return false;
      }
      if ($(this).hasClass("active")) {
        return false;
      }
      App.busy = true;
      App.numbers_sec3_init();
      $("#sec1_nav .active").removeClass("active");
      return $(this).addClass("active");
    });
  },
  numbers_init: function() {
    App.start_container.find("div").addClass("active").draggable({
      revert: true
    }).css({
      position: "relative",
      left: 0,
      top: 0
    });
    App.final_container.find("div").addClass("active").removeClass("filled").droppable({
      drop: function(event, ui) {
        var elid, that;
        elid = ui.draggable.context.attributes.data_id.value;
        if ($(this).attr("data_id") === elid) {
          console.log("si es");
          App.addScore();
          that = $(this);
          ui.draggable.draggable("option", "revert", false);
          that.addClass("filled");
          return ui.draggable.animate({
            "opacity": 0
          }, {
            "duration": 500,
            complete: function() {
              return $(this).draggable("option", "revert", true);
            }
          });
        }
      },
      hoverClass: "ondragover"
    }).css({
      position: "relative",
      left: 0,
      top: 0
    });
    App.start_container.css("display", "block");
    App.start_container.find("div").css("opacity", "0");
    if (App.current_screen.attr("id") !== App.screen.attr("id")) {
      console.log("diferentes");
      return App.number_change_screen();
    } else {
      console.log("iguales");
      return App.number_animate_entrance();
    }
  },
  number_animate_entrance: function() {
    App.start_container.find("div").each(function() {
      var rand, that;
      rand = Math.random() * 1500;
      that = $(this);
      return setTimeout(function() {
        return that.animate({
          opacity: 1
        }, {
          duration: 500
        });
      }, rand);
    });
    App.final_container.find("div").each(function() {
      var rand, that;
      rand = Math.random() * 1500;
      that = $(this);
      return setTimeout(function() {
        return that.animate({
          opacity: 1
        }, {
          duration: 500,
          complete: function() {}
        }, App.current_screen = App.screen);
      }, rand);
    });
    return setTimeout(function() {
      return App.busy = false;
    }, 1000);
  },
  number_change_screen: function() {
    App.current_screen.animate({
      top: "-100%"
    }, {
      duration: 500
    });
    return App.screen.animate({
      top: "0%"
    }, {
      duration: 500,
      complete: function() {
        App.current_screen = App.screen;
        return App.number_animate_entrance();
      }
    });
  },
  numbers_sec1_init: function() {
    App.goal_numbers = 10;
    App.current_score = 0;
    App.screen = $("#sec_numbers_s1");
    App.start_container = App.screen.find(".start_container");
    App.final_container = App.screen.find(".final_container");
    App.reload = App.screen.find(".reload");
    App.reload.on("click", event, App.numbers_sec1_init);
    return App.numbers_init();
  },
  numbers_sec2_init: function() {
    var arreglo, i, rand, resultado;
    App.goal_numbers = 10;
    App.current_score = 0;
    App.screen = $("#sec_numbers_s2");
    App.start_container = App.screen.find(".start_container");
    arreglo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    i = 1;
    App.start_container.html("");
    while (i <= 10) {
      rand = Math.floor(Math.random() * arreglo.length);
      resultado = parseInt(arreglo.splice(rand, 1));
      App.start_container.append('<div class="active " data_id="' + resultado + '" href="http://void/' + resultado + '">' + resultado + '</div>');
      i++;
    }
    App.final_container = App.screen.find(".final_container");
    App.reload = App.screen.find(".reload");
    App.reload.on("click", event, App.numbers_sec2_init);
    return App.numbers_init();
  },
  numbers_sec3_init: function() {
    App.goal_numbers = 10;
    App.current_score = 0;
    App.screen = $("#sec_numbers_s3");
    App.start_container = App.screen.find(".start_container");
    App.final_container = App.screen.find(".final_container");
    App.reload = App.screen.find(".reload");
    App.reload.on("click", event, App.numbers_sec3init);
    return App.numbers_init();
  },
  addScore: function() {
    App.current_score++;
    if (App.current_score === App.goal_numbers) {
      return App.win();
    }
  },
  win: function() {
    App.final_container.find("div").each(function() {
      var rand, that;
      console.log(rand);
      rand = Math.random() * 1500;
      console.log(rand);
      that = $(this);
      return setTimeout(function() {
        return that.animate({
          opacity: 0
        }, {
          duration: 500,
          complete: function() {
            return that.removeClass("active");
          }
        });
      }, rand);
    });
    return setTimeout(function() {
      return App.start_container.css("display", "none");
    }, 2000);
  }
};

$(function() {
  return App.init();
});
