library(shiny)
library(shinyjs)

# Define UI for application
ui <- fluidPage(useShinyjs(),
    fluidRow(column(8, offset = 2,
                    title = "Testez votre niveau d'embourgeoisement.",
                    h1("Testez votre niveau d'embourgeoisement."),
                    h2("Le test exclusif d'Ouvrez les guillemets"),
                    h3("Via Mediapart"),
                    h4("(Abonnez-vous !)"),

                    HTML(
                        '<iframe width="560" height="315" src="https://www.youtube.com/embed/sQqd6YGDlEg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
                    ),

                    radioButtons(
                        inputId = "q1",
                        label = p(em("Question 1 :"), "Avez-vous déjà participé à un rallye (dansant) :"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q2",
                        label = p(em("Question 2 :"), "Avez-vous déjà défiscalisé un don à un parti politique (jusqu'au plafond maximal autorisé) :"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q3",
                        label = p(em("Question 3 :"), "Connaissez-vous l'histore de vos aïeux ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q4",
                        label = p(em("Question 4 :"), "Vous rendez-vous régulièrement à des cousinades ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q5",
                        label = p(em("Question 5 :"), "Comptez-vous recevoir un héritage ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q6",
                        label = p(em("Question 6 :"), "Prenez-vous l'avions plus de trois fois par an (vols intérieurs compris) ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q7a",
                        label = p(em("Question 7 :"), "Avez vous déjà vu un membre de votre famille du XXéme siècle en peinture ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q7b",
                        label = p(em("Bonus :"), "Avez vous déjà vu un membre de votre famille du 19éme siècle en photo ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q8",
                        label = p(em("Question 8 :"), "Votre famille possède-t-elle une jolie maison de famille niché
                                        dans un écrin de verdure ( même si elle a surtout une valeur sentimentale) ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    radioButtons(
                        inputId = "q9",
                        label = p(em("Question 9 :"), "Êtes-vous déjà allé à une manif de droite (même juste pour accompagner) ?"),
                        choices = c("Oui" = 1, "Non" = 0), inline = TRUE, selected = 0
                    ),

                    checkboxGroupInput(
                        inputId = "q10a",
                        label = p(em("Question 10 :"), "Avez-vous déjà fait :"),
                        choices = c("du golf" = 1, "de l'équitation" = 2, "du polo" = 3, "du tennis" = 4, "de la voile" = 5), inline = TRUE
                    ),

                    checkboxGroupInput(
                        inputId = "q10b",
                        label = p(em("Bonus :"), "Vos parents possèdent-ils :"),
                        choices = c("un voilier", "un cheval (ou plusieurs)", "un court de tennis"), inline = TRUE
                    ),

                    actionButton(
                        inputId = "go", label = "Cacluler mon niveau d'embourgeoisement"
                    ),

                    div(id = "preambule",
                        h3("Vous avez un score de")),

                    h1(textOutput("resultat"), align = "center", style = "color:#FF4000"),

                    div(id = "postambule",
                        h3("sur l'échelle d'embourgeoisement d'Ouvrez les guillemets.", align = "right"),
                        h4("Vous avez :"),
                        p("- 0 : 100% prolo"),
                        p("- entre 0.5 et 3 : suspect"),
                        p("- entre 3 et 6 : dangereux"),
                        p("- plus de 6 : bourgeois")),

                    a(href = "https://github.com/gdevailly/OLGtron", "Code source sur GitHub")
    ))
)

# Define server logic
server <- function(input, output) {

    hide(id = "preambule")
    hide(id = "postambule")

    olg_score <- eventReactive(
        input$go,
        {
            show(id = "preambule")
            show(id = "postambule")
            score <- isolate({
                # calcul du score
                as.numeric(input$q1) * 2 +
                    as.numeric(input$q2) * 2 +
                    as.numeric(input$q3) +
                    as.numeric(input$q4) +
                    as.numeric(input$q5) +
                    as.numeric(input$q6) +
                    as.numeric(input$q7a) +
                    as.numeric(input$q7b) +
                    as.numeric(input$q8) * 2 +
                    as.numeric(input$q9) +
                    0.5 * length(input$q10a) +
                    length(input$q10b)
            })

            score
        })

    output$resultat <- renderText({
        olg_score()
    })

}

# Run the application
shinyApp(ui = ui, server = server)

