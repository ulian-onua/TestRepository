unit onefile_atd;

interface

uses Dos;

     type types_of_file = (executable, down_dir, up_dir, textfile, archive, other);


 type onefile = object

     public
     constructor init (get_name : namestr);   {���樠������}
     function GetFileName : NameStr;  {������� ��� 䠩��}
     procedure SetExtension; {�롨�� ���७��}
     procedure SetFiletype;    {��⠭����� ⨯ 䠩��}
     procedure SetFileColor;   {��⠭����� 梥� 䠩��}
     procedure SetFileSize (Size : Comp); {��⠭����� ࠧ��� 䠩��}
     procedure SetFileTime (Time : longint); {��⠭����� �६� 䠩��}
     procedure SetCoordinates (x, y : byte); {��⠭����� ���न����}
     function  GetCoordinates : byte;  {������� ���न����}
     procedure SetFileInformation;
     function GetFileColor : byte;
     procedure GetFromSearch (S: SearchRec);
     destructor destroy;             {㭨�⮦���}


     private
        Filename : string[12];     {������ ��� 䠩��}
        Extension : ExtStr;     {���७��}
        Filetype : types_of_file; {⨯ 䠩��}
        FileColor  : byte;    {梥�}
        Start_CoordX, Start_CoordY : byte;  {��砫�� ���न����}
        FileSize : Comp;        {ࠧ��� 䠩��}
        FileTime : longint;    {�६� ᮧ����� ��� ���������� 䠩��}
     end;


implementation

        constructor onefile.init (get_name : namestr);
        begin
             Filename := Get_name
        end;

        function onefile.GetFileName : NameStr;
        begin
                GetFileName := Filename
        end;

        procedure onefile.SetExtension;
        var x : byte;
        begin
              x := pos ('.', Filename); {�饬 ���}

              if x = 0 then          {�᫨ �� ��諨, �}
                Extension := ''   {���७�� ���}
              else if x = 1 then    {�᫨ 1, � �� ���-��४���}
                Extension := '.'
              else
                 Extension := Copy (Filename, x + 1, Length(Filename) - x); {����, �����㥬}
        end;

        procedure onefile.SetFileType;
        begin

               if  (Extension = 'com') or (Extension = 'exe') or (Extension = 'bat') then
                   FileType := executable
              else if Extension = '' then
                   FileTYpe := down_dir
              else if Extension = '.' then
                   FileType := up_dir
              else if Extension = 'txt' then
                   FileType := textfile
              else if (Extension = 'rar') or (Extension = 'zip') then
                   FileType := archive
              else
                   FileType := other
        end;

        procedure onefile.SetFileColor;
          begin
                if FileType = down_dir then  {�᫨ ��४���, � 梥� - �����}
                     FileColor := 14
                else                       {���� - ����}
                     Filecolor := 15
          end;


        procedure onefile.SetFileSize (Size : comp);
           begin
                  FileSize := Size
           end;

        procedure onefile.SetFileTime (Time : LongInt);
           begin
                   FileTime := Time
           end;

        procedure onefile.SetFileInformation;
           begin
                  SetExtension;
                  SetFileType;
                  SetFileColor
           end;

            procedure onefile.SetCoordinates (x, y : byte);
            begin
                   Start_CoordX := x;
                   Start_CoordY := y;
            end;

            function onefile.GetCoordinates : byte;
            begin
                     GetCoordinates := Start_CoordX

            end;

             function onefile.GetFileColor : byte;
             begin
                    GetFileColor := FileColor
             end;

            procedure onefile.GetFromSearch (S: SearchRec);
             begin
                 Filename := S.Name;

                  FileSize := S.Size;
                  FileTime := S.Time
             end;


            destructor onefile.destroy;
            begin
            end;


end.








