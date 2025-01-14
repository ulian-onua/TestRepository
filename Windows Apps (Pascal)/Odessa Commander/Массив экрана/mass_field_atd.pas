unit mass_field_atd;


interface
        uses crt;

        const MaxX = 80;
        const MaxY = 25;


        type charmx = array [1..MaxY, 1..MaxX] of char;  {����� ᨬ�����}
        type colormx = array [1..MaxY, 1..MaxX] of byte; {����� ⨯� ����}
             charmx_pointer = ^charmx;   {㪠��⥫� �� �harmx}
             colormx_pointer = ^colormx;   {㪠��⥫� �� colormx}

        type Figure_position = record
                 x1, y1, x2, y2, color, backcolor : byte;
                 sym : char
        end;

        mass_field = object
        public

        procedure init;  {���樠������ - ᮧ������ ����� ����}
        procedure get_from_file;  {����� �� 䠩��}
        procedure copy_to_file; {᪮��஢��� � 䠩�}
        procedure addrectangle (position : Figure_position);
                                                        {���ᮢ��� ��אַ㣮���� ���� ���ᨢ�}
        procedure DrawForwardLine (position : Figure_position); {���ᮢ��� ����� ���।}
        procedure DrawDownLine (position : Figure_position);  {���ᮢ��� ����� ����}
        procedure DrawPoint (X, Y, color, backcolor : byte; sym : char); {���ᮢ��� ���� ᨬ��� � 㪠������ ����}
        procedure displaymass; {�⮡ࠧ��� ���� ���ᨢ}
        procedure add_rectangleline (position : Figure_position); {��㥬 ����� ��אַ㣮�쭨��}
        procedure add_String (S : String; X, Y, color, backcolor : byte);  {�������� ��ப�}
        procedure DisplayLine (Y : byte); {�⮡ࠧ��� ��ப�, Y - ����� ��ப�}
        procedure DisplayScreen; {�뢥�� ���� ���ᨢ �� ��࠭}
        procedure Display_partline (Y, X1, X2 : byte); {�⮡ࠧ��� ��ப�, Y - ����� ��ப�, X1 - ��砫�, X2 - �����}
        procedure DisplayRectangle (X1, X2, Y1, Y2 : byte); {�뢥�� ��אַ㣮���� ���� ��࠭�}


        private
             char_mass : charmx_pointer;      {����� ᨬ�����}
             text_mass : colormx_pointer; {����� 梥�}
             back_mass : colormx_pointer; {����� 䮭�}

        end;



        implementation


        procedure mass_field.init;    {���樠������}
         var i, i2 : byte;

       begin
              Getmem (char_mass, MaxX * MaxY);  {�᢮������� ������ ��� ������ ᨬ�����}
              Getmem (text_mass, MaxX * MaxY);  {�᢮������� ������ ��� ������ 梥�}
              Getmem (back_mass, MaxX * MaxY);  {�᢮������� ������ ��� ������ 䮭�}

              for i := 1 to MaxY do               {��⠭�������� ��砫�� ���祭�� ��� ���ᨢ��}
              for i2 := 1 to MaxX do begin
                Char_mass^ [i, i2] := '*';  {�஡��}
                Text_mass^ [i, i2] := 1;   {��� 梥�}
                Back_mass^ [i, i2] := 0;   {��� 梥�}
              end
        end;


        procedure mass_field.get_from_file;  {����� �� 䠩��}

         var char_file : file of charmx;   {䠩� ᨬ�����}
             text_file : file of colormx;   {䠩� 梥�}
             back_file : file of colormx;   {䠩� 䮭�}

        begin
                Assign (char_file, 'cf.mf');    {cf - char file, mf - mass field}
                Assign (text_file, 'tf.mf');    {tf - text file}
                Assign (back_file, 'bf.mf');    {bf - back file}

                Reset (char_file);     {���뢠��}
                Reset (text_file);      {��}
                Reset (back_file);      {䠩��}

                Read (char_file, char_mass^);    {���뢠�� }
                Read (text_file, text_mass^);    {���ᨢ�}
                Read (back_file, back_mass^);

                Close (char_file);       {����뢠��}
                Close (text_file);       {䠩��}
                Close (back_file);
           end;

        procedure mass_field.copy_to_file;

         var char_file : file of charmx;   {䠩� ᨬ�����}
             text_file : file of colormx;   {䠩� 梥�}
             back_file : file of colormx;   {䠩� 䮭�}
        begin
                Assign (char_file, 'cf.mf');    {cf - char file, mf - mass field}
                Assign (text_file, 'tf.mf');    {tf - text file}
                Assign (back_file, 'bf.mf');    {bf - back file}

                Rewrite (char_file);     {���뢠��}
                Rewrite (text_file);      {��}
                Rewrite (back_file);      {䠩��}

                Write (char_file, char_mass^);    {�����뢠�� }
                Write (text_file, text_mass^);    {���ᨢ�}
                Write (back_file, back_mass^);

                Close (char_file);       {����뢠��}
                Close (text_file);       {䠩��}
                Close (back_file);
          end;


        procedure mass_field.displaymass;
           var i, i2 : byte;
           begin
                window (1, 1, MaxX, MaxY);
                clrscr;

                for i := 1 to MaxY do begin
                Gotoxy (1, i);  {���室�� � � = 1 � � ��⠭��������� y}
                for i2 := 1 to MaxX do begin
                 textbackground (Back_mass^[i, i2]);
                 textcolor (Text_mass^[i, i2]);
                 Write (Char_mass^[i, i2]);
                 end
               end;


        end;

        procedure mass_field.addrectangle (Position : Figure_position); {���ᮢ��� ��אַ㣮���� ����}
             var i, i2 : byte;

             begin
                   for i := Position.y1 to Position.y2 do
                        for i2:= Position.x1 to Position.x2 do begin
                        Char_Mass^ [i, i2] := Position.sym;
                        Text_Mass^ [i, i2] := Position.color;
                        Back_Mass^ [i, i2] := Position.backcolor;
                        end
             end;

         procedure mass_field.DrawForwardLine (position : Figure_position); {��㥬 ����� ���।}
             var i : byte;
         begin
                for i := position.x1 to position.x2 do begin
                    with position do begin
                        Char_Mass^ [Y1, i] := sym;
                        Text_Mass^ [Y1, i] := color;
                        Back_Mass^ [Y1, i] := backcolor
                    end
                end
         end;

          procedure mass_field.DrawDownLine (position : Figure_position); {��㥬 ����� ����}
             var i : byte;
          begin
                for i := position.y1 to position.y2 do begin
                    with position do begin
                          Char_Mass^ [i, X1] := sym;
                          Text_Mass^ [i, X1] := color;
                          Back_Mass^ [i, X1] := backcolor
                    end
                end
          end;

          procedure mass_field.DrawPoint (X, Y, color, backcolor : byte; sym : char); {��㥬 ᨬ���}
                begin
                      Char_mass^ [Y, X] := sym;
                      Text_Mass^ [Y, X] := color;
                      Back_Mass^ [Y, X] := backcolor
                end;

         procedure mass_field.add_rectangleline (position : Figure_position); {���ᮢ뢠�� ��אַ㣮�쭨�}
           var Temp : Figure_position;
         begin


            Temp := position;

                        with position do begin     {��㥬 㣫�}
               Self.DrawPoint (Y1, X1, color, backcolor, #213);
               Self.DrawPoint (Y1, X2, color, backcolor, #184);
               Self.DrawPoint (Y2, X1, color, backcolor, #212);
               Self.DrawPoint (Y2, X2, color, backcolor, #190);
                        end;

             inc (Temp.X1);
             dec (Temp.X2);
             Temp.sym := #205;
             Self.DrawForwardLine (Temp);   {��㥬 ������ �����}

             Temp.Y1 := Temp.Y2;
             Self.DrawForwardLine (Temp);   {��㥬 ������ �����}

             Temp.X1 := Position.X1;
             Self.DrawDownLine (position);   {��㥬 ����� ����� ����}

             Temp.X2 := Temp.X1;
             Self.DrawDownLine (position);   {��㥬 �ࠢ�� ����� ����}

        end;

            procedure mass_field.add_String (S : String; X, Y, color, backcolor : byte);
                 var i2 : byte;
            begin


                  for i2 := 1 to Length (S) do begin
                          Char_Mass^ [Y, X] := S [i2];
                          Text_Mass^ [Y, X] := color;
                          Back_Mass^ [Y, X] := backcolor;

                     inc (X);
                     if X > 25 then
                     break;

                  end
            end;

            procedure mass_field.DisplayLine (Y : byte);
            var i : byte;
            begin
               if Y in [1..25] then begin
                 Gotoxy (1, Y);
                for i := 1 to MaxX do begin
                    textcolor (Text_Mass^ [Y, i]);
                    textbackground (Back_Mass^ [Y, i]);
                    Write (Char_Mass^ [Y, i])
                end
               end
            end;


            procedure mass_field.DisplayScreen;
            var Y : byte;
            begin
                 for Y := 1 to MaxY do
                 Self.DisplayLine (Y);
            end;


           procedure mass_field.Display_partline (Y, X1, X2 : byte);
           var i : byte;
           begin
                GotoXY (Y, X1);

                for i := X1 to X2 do begin
                    textcolor (Text_Mass^ [Y, i]);
                    textbackground (Back_Mass^ [Y, i]);
                    Write (Char_Mass^ [Y, i])
                end;
           end;

            procedure mass_field.DisplayRectangle (X1, X2, Y1, Y2 : byte);
            var i : byte;
            begin

                 Gotoxy (Y1, X1);

                 repeat

                        for i := X1 to X2 do begin
                    textcolor (Text_Mass^ [Y1, i]);
                    textbackground (Back_Mass^ [Y1, i]);
                    Write (Char_Mass^ [Y1, i])
                        end;
                       inc (Y1);

                 until Y1 > Y2
            end;

        end.






















