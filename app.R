library(shiny)

# アプリケーションのUIを定義
ui <- fluidPage(
  
  # アプリケーションのタイトル
  titlePanel("Old Faithful Geyser Data"),
  
  sidebarLayout(
    # サイドバー
    sidebarPanel(
      # スライダー
      sliderInput("bins", "ビンの数:", min = 1, max = 50, value = 30)
    ),
    
    # メインパネル
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
# サーバー側ロジックを定義
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # ui.Rから来た input$bins に基づいてビンを生成
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # 指定のビン数でヒストグラムを描画
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# アプリケーションを起動する
shinyApp(ui = ui, server = server)
