//LISANDRO PINHEIRO BELTRA
setmode (25,80)
clear
set date to british
set epoch to 1930
set message to 12 center
/*default settings*/

do while .t.
    clear

    nLetras     := 0
    nTentativa  := 0
    nContador   := 0
    nContAcerto := 0

    cNome            := Space(15)
    cPalavra         := Space(15)
    cLetraEspecifica := Space(1)
    cLetraChute      := Space(1)
    cNivel           := Space(8)
    cDica1           := Space(15)
    cDica2           := Space(15)
    cDica3           := Space(15)
    cCheck           := Space(10)

    @ 01,01 say "Insira o nome.......: "
    @ 02,01 say "Insira a palavra!...: " color 'r/'

    @ 01,24 get cNome    picture'@!' valid !Empty(cNome)
    @ 02,24 get cPalavra picture'@!' valid !Empty(cPalavra)
    Read

    if LastKey() == 27
        nAlerta := Alert('Deseja finalizar o jogo?',{'Sim','Nao'})

        if nAlerta == 1
            exit

        else
            loop

        endif
    endif

    nAlerta := Alert('Escolha o nivel de dificuldade!',{'Facil','Medio','Dificil'})
    
    if nAlerta = 1
        cNivel := "Facil"

    elseif nAlerta = 2
        cNivel := "Medio"

    else
        cNivel := "Dificil"

    endif

    if cNivel = "Facil" .or. cNivel = "Medio"
        @ 04,01 say "Dica 1: "
        @ 05,01 say "Dica 2: "

        if cNivel = "Facil"
            @ 06,01 say "Dica 3: "

        endif

        @ 04,10 get cDica1 picture'@!' valid !Empty(cDica1)
        @ 05,10 get cDica2 picture'@!' valid !Empty(cDica2)

        if cNivel = "Facil"
            @ 06,10 get cDica3 picture'@!' valid !Empty(cDica3)
        
        endif
        read

        if LastKey() == 27
            nAlerta := Alert('Deseja finalizar o jogo?',{'Sim','Nao'})

            if nAlerta == 1
                exit

            else
                loop

            endif
        endif

    endif

    clear

    @ 05,38 say "|"
    @ 06,38 say "|"
    @ 04,39 say "________________"
    @ 05,55 say "|"
    @ 06,55 say "|"
    @ 07,55 say "|"
    @ 08,55 say "|"
    @ 09,55 say "|"
    @ 10,55 say "|"
    @ 11,55 say "|"
    @ 12,55 say "|"
    @ 13,55 say "|"
    @ 14,55 say "|"
    @ 15,55 say "|"
    @ 16,55 say "|"

    do while nTentativa < 6
        nLetras   := Len(Alltrim(cPalavra))
        nContador := nLetras

        cLetraChute = Space(1)

        if nContAcerto == nLetras
            Alert('Parabens! Voce ganhou!','/g')
            exit

        endif

        @ 04,01 say "Digite uma letra: "

        @ 04,20 get cLetraChute picture'@!'
        Read

        if LastKey() == 27
            exit

        endif

        if cLetraChute $ cCheck
            Alert('Letra ja digitada! Tente novamente...')
            loop

        endif

        if cLetraChute $ cPalavra

            do while nContador > 0
                cLetraEspecifica := SubStr(cPalavra,nContador--,1)

                if cLetraChute = cLetraEspecifica
                    @ 06,(nContador + 6) say cLetraEspecifica
                    nContAcerto++
                    
                endif
            enddo

            cCheck += cLetraChute

        else
            nTentativa++

            if nTentativa = 2
                if cNivel == "Facil" .or. cNivel == "Medio"
                    @ 08,02 say cDica1 color '/g'

                endif

                @ 05,25 say "        ___  |     "
                @ 06,25 say "       /   \ |     "
                @ 07,25 say "       \___/       "

            elseif nTentativa = 4
                if cNivel == "Facil" .or. cNivel == "Medio"
                    @ 10,02 say cDica2 color '/g'

                endif

                @ 08,25 say "         |         "
                @ 09,25 say "      __/|\__      "
                @ 10,25 say "         |         "

            elseif nTentativa == 5
                if cNivel == "Facil"
                    @ 12,02 say cDica3 color '/g'

                endif

            elseif nTentativa = 6
                @ 06,25 say "       /x x\ |     "
                @ 11,25 say "        / \        "
                @ 12,25 say "       /   \       "
                @ 13,25 say "      /     \      "

            endif

            @ 18,01 say "Voce errou: " + Alltrim(Str(nTentativa)) + " vezes..."

        endif
    enddo
    inkey(0)

    if nTentativa == 6
        nAlerta := Alert('Que triste, voce perdeu! Quer jogar novamente?',{'Sim','Nao'})

        if nAlerta == 1
            loop

        else
            exit

        endif

    endif
enddo