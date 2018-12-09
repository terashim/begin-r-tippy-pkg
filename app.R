library(shiny)
library(tippy)

# アプリケーションのUIを定義
ui <- fluidPage(
  
  # アプリケーションのタイトル
  titlePanel("Shinyアプリにtippyパッケージでツールチップを追加"),
  
  sidebarLayout(
    # サイドバー
    sidebarPanel(
      
      # スライダー入力にツールチップを付けるための工夫 = ラッパーdiv要素で囲む
      # tippyバージョン0.1.0ではsliderInputとselectInputに直接ツールチップを付けられない
      # Cf. https://github.com/JohnCoene/tippy/issues/2
      div(
        id = "bins-wrapper",
        # スライダー入力
        sliderInput("bins", "ビンの数:", min = 1, max = 50, value = 30)
      ),
      # スライダー入力ウィジェットにツールチップを付ける
      tippy_this(elementId = "bins-wrapper", tooltip = "スライダー！!"),
      
      # テキスト入力
      textInput("text", "テキストを入力"),
      # テキスト入力ウィジェットにツールチップを付ける
      tippy_this(elementId = "text", tooltip = "テキスト！！"),
      
      
      p(
        "これは何？", 
        # font-awesomeのアイコンにツールチップを付けるため、ラッパーspan要素で囲む
        span(icon("info-circle"), id = "info"),
        tippy_this(
          elementId = "info",
          tooltip = "ヘルプです！！",
          placement = "right" # 右側にツールチップを出すオプション
        )
      )
    ),
    
    # メインパネル
    mainPanel(
      # ラッパーdiv要素で囲み、idを付ける
      div(
        id = "plot",
        plotOutput("distPlot")
      ),
      # ツールチップを付ける
      tippy_this(elementId = "plot", tooltip = "プロットです！！！")
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
