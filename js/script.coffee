current_section = 1

# correct = false
App =
  init: ->
    this.correct = false
    this.goal_numbers = 0
    this.current_score = 0
    this.current_screen = $("#sec_numbers_s1")    
    this.bind_menu()
    this.sec1_s1 = false
    this.numbers_sec1_init()
    this.bussy = false
  bind_menu: ->  
    $("#sec_numbers1").on "click", (event) ->
      event.preventDefault();
      return false if App.busy
      return false if $(this).hasClass("active")
      App.busy = true
      App.numbers_sec1_init()
      $("#sec1_nav .active").removeClass("active")
      $(this).addClass("active")
    
    $("#sec_numbers2").on "click", (event) ->
      event.preventDefault();
      return false if App.busy
      return false if $(this).hasClass("active")
      App.busy = true
      App.numbers_sec2_init()
      $("#sec1_nav .active").removeClass("active")
      $(this).addClass("active")

    $("#sec_numbers3").on "click", (event) ->
      event.preventDefault();
      return false if App.busy
      return false if $(this).hasClass("active")
      App.busy = true
      App.numbers_sec3_init()
      $("#sec1_nav .active").removeClass("active")
      $(this).addClass("active")

    $("#sec_numbers4").on "click", (event) ->
      event.preventDefault();
      return false if App.busy
      return false if $(this).hasClass("active")
      App.busy = true
      App.numbers_sec4_init()
      $("#sec1_nav .active").removeClass("active")
      $(this).addClass("active")


  numbers_init:(callb = null) ->

    App.start_container.find("div").addClass("active").draggable({revert: true}).css({position:"relative",left:0,top:0})

    App.final_container.find("div").addClass("active").removeClass("filled").droppable(
      drop: (event, ui) ->        
        elid = ui.draggable.context.attributes.data_id.value
        
        if $(this).attr("data_id") is elid
            console.log "si es"
            if callb != null 
              App.addScore(callb,elid)
            else
              App.addScore()
            that = $(this)
            ui.draggable.draggable( "option", "revert", false )
            that.addClass("filled")
            ui.draggable.animate(
              "opacity": 0
            ,
              "duration": 500
              complete: ->
                $(this).draggable( "option", "revert", true )
            )
      hoverClass: "ondragover"                  
    ).css({position:"relative",left:0,top:0})
    
    App.start_container.css("display","block")
    App.start_container.find("div").css("opacity","0") 
    if App.current_screen.attr("id") != App.screen.attr("id")
      console.log "diferentes"
      App.number_change_screen()      
    else
      console.log "iguales"
      App.number_animate_entrance()

        
  number_animate_entrance : ->
    App.start_container.find("div").each( ->      
      rand = Math.random()*1500      
      that =$(this)
      setTimeout( ->
          that.animate(
              opacity: 1
            ,
              duration:500              
          )
      ,rand)       
    )        
    App.final_container.find("div").each( ->      
      rand = Math.random()*1500      
      that =$(this)
      setTimeout( ->
          that.animate(
              opacity: 1
            ,
              duration:500
              complete: ->              
              App.current_screen = App.screen              
          )
      ,rand)       
    )
    setTimeout( ->
      App.busy = false

    ,1000)         


  number_change_screen: -> 
    App.current_screen.animate(
        top: "-100%"
      ,
        duration:500              
    )
    App.screen.animate(
        top: "0%"
      ,
      duration:500
      complete: ->              
        App.current_screen = App.screen
        App.number_animate_entrance()
    )

  numbers_sec1_init : ->
    App.goal_numbers = 10
    App.current_score = 0    
    App.screen = $("#sec_numbers_s1")
    App.start_container = App.screen.find(".start_container")
    App.final_container = App.screen.find(".final_container")    
    App.reload = App.screen.find(".reload")
    App.reload.on "click", (event) , App.numbers_sec1_init
            
    App.numbers_init()

  numbers_sec2_init : ->
    App.goal_numbers = 10
    App.current_score = 0    
    App.screen = $("#sec_numbers_s2")
    App.start_container = App.screen.find(".start_container")
    arreglo= [1,2,3,4,5,6,7,8,9,10]
    i = 1
    App.start_container.html("")
    while i <= 10
      rand= Math.floor(Math.random()*arreglo.length)      
      resultado = parseInt(arreglo.splice(rand,1))
      App.start_container.append('<div class="active " data_id="'+resultado+'" href="http://void/'+resultado+'">'+resultado+'</div>')      
      i++
    
    App.final_container = App.screen.find(".final_container")    
    App.reload = App.screen.find(".reload")
    App.reload.on "click", (event) , App.numbers_sec2_init
    
    App.numbers_init()
  numbers_sec3_init : ->
    App.goal_numbers = 10
    App.current_score = 0    
    App.screen = $("#sec_numbers_s3")
    App.start_container = App.screen.find(".start_container")
    arreglo= [1,2,3,4,5,6,7,8,9,10]
    i = 1
    App.start_container.html("")
    while i <= 10
      rand= Math.floor(Math.random()*arreglo.length)      
      resultado = parseInt(arreglo.splice(rand,1))
      App.start_container.append('<div class="active " data_id="'+resultado+'" href="http://void/'+resultado+'">'+resultado+'</div>')      
      i++
    App.start_container = App.screen.find(".start_container")
    App.final_container = App.screen.find(".final_container")    
    App.reload = App.screen.find(".reload")
    App.reload.on "click", (event) , App.numbers_sec3init
            
    App.numbers_init(App.number_active_next)
    App.final_container.children().droppable( "option", "disabled", true )    
    App.final_container.find("div").first().droppable( "option", "disabled", false )
    console.log App.final_container.find("div").first()
  numbers_sec4_init : ->
    App.goal_numbers = 10
    App.current_score = 0    
    App.screen = $("#sec_numbers_s4")
    App.start_container = App.screen.find(".start_container")
    arreglo= [1,2,3,4,5,6,7,8,9,10]
    i = 1
    App.start_container.html("")
    while i <= 10
      rand= Math.floor(Math.random()*arreglo.length)      
      resultado = parseInt(arreglo.splice(rand,1))
      App.start_container.append('<div class="active " data_id="'+resultado+'" href="http://void/'+resultado+'">'+resultado+'</div>')      
      i++
    
    App.final_container = App.screen.find(".final_container") 
    App.final_container.html("")   
    i = 1
    while i <= 10
      rand= Math.floor(Math.random()*11) 
      console.log rand     
      if rand > 4
        App.final_container.append('<div class="active " data_id="'+i+'" href="http://void/'+i+'">'+i+'</div>')      
      else
        App.final_container.append('<div class="active " data_id="'+i+'" href="http://void/'+i+'"></div>')      
      i++
    App.reload = App.screen.find(".reload")
    App.reload.on "click", (event) , App.numbers_sec4_init
    
    App.numbers_init(App.number_write_number)
  number_active_next : ->
    console.log App.final_container.find("div").eq(1)
    App.final_container.find("div").eq(App.current_score).droppable( "option", "disabled", false )
  number_write_number :(elid) ->
    App.final_container.find("div").eq(elid-1).html(elid )
  addScore: (callb = null,elid = 0) -> 

    App.current_score++
    if App.current_score is App.goal_numbers
      App.win()
    else
      if callb != null
        console.log ("callb ")
        callb(elid)
      
  win: ->
    
    App.final_container.find("div").each( ->
      console.log rand
      rand = Math.random()*1500
      console.log rand
      that =$(this)
      setTimeout( ->
          that.animate(
              opacity: 0
            ,
              duration:500
              complete: ->
                that.removeClass("active")
          )
      ,rand)       
    )
    setTimeout( ->
      App.start_container.css("display","none")
    ,2000)


  
      

    
      


    


$ ->  
  App.init()