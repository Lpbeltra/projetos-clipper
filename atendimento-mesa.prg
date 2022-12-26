//LISANDRO PINHEIRO BELTRA
setmode (25,80)
clear
set date to british
set epoch to 1930
set message to 12 center
/*default settings*/

do while .t.

    nMesa            := 0
    nAlertaMesa      := 0
    nLinha           := 10
    nQuant           := 0
    nPrecoUnt        := 0
    nSubTotal        := 0
    nTotalMesa1      := 0
    nTotalMesa2      := 0
    nTotalMesa3      := 0
    nTotalRecebido   := 0
    nValorTroco      := 0
    nPedidosMesa1    := 0
    nPedidosMesa2    := 0
    nPedidosMesa3    := 0
    nPedidosCMesa1   := 0
    nPedidosCMesa2   := 0
    nPedidosCMesa3   := 0
    nTotalCancelado1 := 0
    nTotalCancelado2 := 0
    nTotalCancelado3 := 0
    nTotalDia1       := 0
    nTotalDia2       := 0
    nTotalDia3       := 0
    nTaxaTotal       := 0
    nQuantGeral      := 0
    nQuantGeralC     := 0
    nValorGeral      := 0
    nValorGeralC     := 0
    nTicket          := 0
    nTotalMesa       := 0
    nApagarMesa      := 0
    
    cStatusMesa1 := "/g"
    cStatusMesa2 := "/g"
    cStatusMesa3 := "/g"
    cProduto     := Space(15)
    cFormaPgto   := Space(1)
    cLogin       := Space(10)
    cSenha       := Space(6)

    lGerente := .t.

    @ 02,02 say "Login....: "
    @ 03,02 say "Senha....: "

    @ 02,13 get cLogin picture'@!' valid !Empty(cLogin)
    @ 03,13 get cSenha             valid !Empty(cSenha)
    read

    if lastkey() == 27
        clear
        exit

    endif

    if (Alltrim(cLogin) == "GERENTE" .and. cSenha == "Sup123")
        lGerente := .t.

    elseif (Alltrim(cLogin) == "ATENDENTE" .and. cSenha == "Gar123")
        lGerente := .f.

    else
        Alert("Login/senha incorretos!")
        loop

    endif

    do while .t.
        clear
        @ 01,33 say "RESTAURANTE SG"
        @ 04,01 say "Mesa....: "
        @ 04,15 say "01" color cStatusMesa1
        @ 04,18 say "02" color cStatusMesa2
        @ 04,21 say "03" color cStatusMesa3

        @ 04,12 get nMesa picture'9' valid nMesa = 1 .or. nMesa = 2 .or. nMesa = 3
        Read

        if lastkey() == 27
            nAlertaMesa := Alert('Deseja sair do programa?',{'Sim','Nao'})

            if nAlertaMesa == 1

                if lGerente = .t.
                    clear
                    nValorGeral = nTotalDia1 + nTotalDia2
                    nValorGeralC = nTotalCancelado1 + nTotalCancelado2
                    nTicket := nTotalDia1 + nTotalDia2 + nTotalDia3 / 3

                    @ 03,01 to 05,79 double
                    @ 04,33 say "RELATORIO GERENCIAL"
                    @ 07,01 say "Quantidade de atendimentos...............:      " + Transform(nPedidosMesa1,'99') + "      " + Transform(nPedidosMesa2,'99') + "      " + Transform(nPedidosMesa3,'99') + "       " + Transform(nQuantGeral,'99')
                    @ 08,01 say "Quantidade de atendimentos cancelados....:      " + Transform(nPedidosCMesa1,'99') + "      " + Transform(nPedidosCMesa2,'99') + "      " + Transform(nPedidosCMesa3,'99') + "       " + Transform(nQuantGeralC,'99')
                    @ 09,01 say "Val. total de atendimentos...............: " + Transform(nTotalDia1,'9999.99') + " " + Transform(nTotalDia2,'9999.99') + " " + Transform(nTotalDia2,'9999.99') + "  " + Transform(nValorGeral,'9999.99')
                    @ 10,01 say "Val. total de atendimentos cancelados....: " + Transform(nTotalCancelado1,'9999.99') + " " + Transform(nTotalCancelado2,'9999.99') + " " + Transform(nTotalCancelado3,'9999.99') + "  " + Transform(nValorGeralC,'9999.99')
                    @ 11,01 say "Ticket medio.............................: " + Transform(nTicket,'9999.99')
                    @ 14,01 say "Taxa de servico..........................: " + Transform(nTaxaTotal,'9999.99')
                    @ 20,01 say "Pressione qualquer tecla para sair..."

                    inkey(0)
                    clear
                    
                endif

                clear
                exit
                
            else
                loop

            endif

        endif

        if (nMesa == 1 .and. cStatusMesa1 == "/g") .or. (nMesa == 2 .and. cStatusMesa2 == "/g") .or. (nMesa == 3 .and. cStatusMesa3 == "/g")
            @ 08,32 say "PEDIDO MESA --" + Str(nMesa) + "--"
            @ 07,01 to 09,79 double

            do while .t.
                @ 22,05 say "Sub-total da mesa: R$ " + Str(nTotalMesa)
                cProduto  := Space(15)
                nQuant    := 0
                nPrecoUnt := 0
                nSubTotal := 0

                if nLinha == 20
                    nLinha := 12
                    @ 12,01 clear to 20,79

                endif

                @ nLinha,01 get cProduto  picture'@!'
                @ nlinha,17 get nQuant    picture'99'
                @ nLinha,21 get nPrecoUnt picture'999.99'
                Read

                if lastkey() == 27
                    nAlerta := Alert('O que deseja fazer?',{'Enviar para producao','Continuar digitando','Abandonar digitacao'})

                    if nAlerta == 1
                        Alert('Pedido enviado para a producao!')

                        if nMesa == 1
                            nPedidosMesa1++
                            cStatusMesa1 := "/r"

                        elseif nMesa == 2
                            nPedidosMesa2++
                            cStatusMesa2 := "/r"

                        elseif nMesa==3
                            nPedidosMesa3++
                            cStatusMesa3 := "/r"

                        endif

                        clear
                        exit
                    
                    elseif nAlerta == 2
                        loop

                    elseif nAlerta == 3
                        nTotalMesa := 0
                        if nMesa == 1
                            nPedidosMesa1--

                        elseif nMesa == 2
                            nPedidosMesa2--
                            
                        else
                            nPedidosMesa3--

                        endif

                        nLinha := 10
                        clear
                        exit
                    
                    endif

                endif

                nSubTotal += nQuant * nPrecoUnt

                @ nLinha, 30 say nSubTotal

                if nMesa == 1
                    nTotalMesa1 += nSubTotal
                    
                elseif nMesa == 2
                    nTotalMesa2 += nSubTotal

                else
                    nTotalMesa3 += nSubTotal

                Endif

                nTotalMesa  += nSubTotal
                nLinha++
                
            enddo

        elseif (nMesa == 1 .and. cStatusMesa1 == "/r") .or. (nMesa == 2 .and. cStatusMesa2 == "/r") .or. (nMesa == 3 .and. cStatusMesa3 == "/r")
            if lGerente = .f.
                Alert('Modulo gerencial!')
                loop

            else 
                nAlerta := Alert("Mesa ocupada! O que voce deseja fazer?",{'Digitar outra mesa','Faturar atendimento','Cancelar atendimento'})

                if lastkey() == 27
                    nMesa := 0
                    loop

                endif

                if nAlerta == 1
                    loop

                elseif nAlerta == 2
                    nAlerta := Alert('Aceita taxa de servico?',{'Sim','Nao'})

                    if lastkey() == 27
                        loop

                    endif

                    if nAlerta == 1 .and. nMesa == 1
                        nTaxaTotal += nTotalMesa1 * 0.10
                        nTotalMesa1 := nTotalMesa1 + nTaxaTotal
                        nApagarMesa := nTotalMesa1

                    elseif nAlerta == 1 .and. nMesa == 2
                        nTaxaTotal += nTotalMesa2 * 0.10
                        nTotalMesa2 := nTotalMesa2 + nTaxaTotal
                        nApagarMesa := nTotalMesa2

                    elseif nAlerta == 1 .and. nMesa == 3
                        nTaxaTotal += nTotalMesa3 * 0.10
                        nTotalMesa3 := nTotalMesa3 + nTaxaTotal
                        nApagarMesa := nTotalMesa3

                    endif

                    @ 08,32 say "FATURAMENTO"
                    @ 07,01 to 09,79 double
                    @ 10,01 say "[D]inheiro / [C]artao / Che[Q]ue: "
                    @ 11,01 say "Total a pagar.................: R$" + Transform(nApagarMesa,'9999.99')
                    @ 12,01 say "Valor recebido................: R$"

                    cFormaPgto     := Space(1)
                    nTotalRecebido := 0

                    @ 10,36 get cFormaPgto     picture'@!'      valid cFormaPgto $ ('DCQ')
                    @ 12,36 get nTotalRecebido picture'9999,99' valid nTotalRecebido >= nApagarMesa
                    Read

                    if lastkey() == 27
                        nAlerta := Alert('O que deseja?',{'Cancelar pagamento','Recomeçar pagamento'})

                        if nAlerta == 1
                            nMesa       := 0
                            nApagarMesa := 0
                            nTaxaTotal  := 0
                            clear
                            loop
                        
                        else
                            clear
                            loop

                        endif

                    endif

                    if nApagarMesa < nTotalRecebido
                        nValorTroco := nTotalRecebido - nTotalMesa
                        @ 13,01 say "Valor troco.....................: " + Transform(nValorTroco,'9999.99')

                    elseif nApagarMesa > nTotalRecebido
                        @ 13,01 say "Valor recebido e menor que valor faturado!"
                        loop

                    endif

                    @ 15,01 say "Pagamento efetuado com sucesso!"
                    @ 16,01 say "Pressione uma tecla para continuar"

                    inkey(0)

                    if nMesa == 1
                        nTotalDia1 += nApagarMesa
                        nTotalMesa1  := 0
                        cStatusMesa1 := "/g"
                        nSubTotal := 0

                    elseif nMesa == 2
                        nTotalDia2 += nApagarMesa
                        nTotalMesa2  := 0
                        cStatusMesa2 := "/g"
                        nSubTotal := 0

                    else
                        nTotalDia3 += nApagarMesa
                        nTotalMesa3  := 0
                        cStatusMesa3 := "/g"
                        nSubTotal := 0

                    endif

                    clear
                    loop

                elseif nAlerta == 3
                    Alert('Atendimento/pedido cancelado com sucesso.')
                    
                    if nMesa == 1
                        nPedidosMesa1--
                        nPedidosCMesa1++
                        cStatusMesa1     := "/g"
                        nTotalCancelado1 += nTotalMesa1
                        nTotalMesa1      := 0

                    elseif nMesa == 2
                        nPedidosMesa2--
                        nPedidosCMesa2++
                        cStatusMesa2     := "/g"
                        nTotalCancelado2 += nTotalMesa2
                        nTotalMesa2      := 0

                    else
                        nPedidosMesa3--
                        nPedidosCMesa3++
                        cStatusMesa3     := "/g"
                        nTotalCancelado3 += nTotalMesa3
                        nTotalMesa3      := 0

                    endif

                    nTotalMesa := 0
                    nSubTotal  := 0
                    nLinha     := 10
                    loop

                endif
            endif
        endif
    enddo
enddo