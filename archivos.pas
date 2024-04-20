UNIT archivos; 
{$mode objfpc}
INTERFACE
uses crt, sysutils;
type
provincias = (

    BuenosAires, CABA, Catamarca, Chaco, Chubut, Cordoba, Corrientes,
    EntreRios, Formosa, Jujuy, Pampa, Rioja, Mendoza, Misiones,
    Neuquen, RioNegro, Salta, SanJuan, SanLuis, SantaCruz, SantaFe,
    SantiagoDelEstero, TierraDelFuego, Tucuman
 );
Estancias = record
    ID:integer;
    nombre:STRING[10];
    dueno:STRING[20];
    dni:integer;
    domicilio:string[100];
    tel:string[15];
    Email:string[15];
    caracteristicas:string[50];
    piscina:boolean;
    Cap_Max:integer;
    codProv:integer; //numero clave de la provincia asociada a la estancia
end;
Provincia = record

    codProv:integer;
    prov:provincias;
    tel:string[15];
  end;
T_ARCHIVO = file of estancias;
const
ruta = 'estancias.dat';
rutaProvincias = 'provincias.dat';

// INTERFACE 
// TYPE 
// Estancias = RECORD 
//                     N_CLIENTE: INTEGER; 
//                    APyNOM: STRING[60]; 
//                    ESTADO: BOOLEAN; 
//          END; 
// T_ARCHIVO = FILE OF Estancias; 
PROCEDURE CREAR (VAR ARCH:T_ARCHIVO); 
PROCEDURE ABRIR(VAR ARCH:T_ARCHIVO); 
PROCEDURE CERRAR(VAR ARCH:T_ARCHIVO); 
PROCEDURE LEER_REGISTRO(POS:INTEGER; VAR ARCH:T_ARCHIVO;  VAR REG: Estancias); 
PROCEDURE GUARDAR_REGISTRO(VAR ARCH:T_ARCHIVO; POS:INTEGER; REG:Estancias); 
//PROCEDURE LISTAR1(VAR ARCH:T_ARCHIVO); 
PROCEDURE MOSTRAR_REGISTRO(r: Estancias); 
PROCEDURE CARGAR_registro (VAR r: Estancias); 
//PROCEDURE LISTAR2 (VAR ARCH:T_ARCHIVO;pos:Integer); 
PROCEDURE ORDEN_BURBUJA (VAR ARCH: T_ARCHIVO); 
PROCEDURE BBIN (VAR ARCH:T_ARCHIVO; BUSCADO:INTEGER; VAR POS:LONGINT); 
procedure cargar_valores_int(texto:string; var input:integer);
procedure cargar_valores_string(texto:string; var input:string);
procedure cargar_valores_bool(texto:string; var input:boolean);
procedure inicializar_registro (VAR reg: estancias);
function PosFinalArchivo(var arch: T_Archivo): Integer;
function FileExists (var arch:T_ARCHIVO):boolean;
// function existe(var archivo: T_ARCHIVO; ruta: string = ''):boolean;
  
implementation

procedure inicializacionArchivos(var arch: T_Archivo; reg:Estancias);
begin
  Assign(arch,ruta);
  try
    Reset(arch);
  except
    Rewrite(arch);
  end;
  try
    Seek(arch,1);
    Read(arch,reg);
    MOSTRAR_REGISTRO(reg);
  
  try
    Seek(arch,0);
    Read(arch,reg);
    MOSTRAR_REGISTRO(reg);

  except
    WriteLn('error leyendo el archivo')  
  end;
end;

   function FileExists (var arch:T_ARCHIVO):boolean;
   //comprobación de la existencia del archivo
      begin
        {$I-}
         reset(arch);
         {$I+}
         Close(arch);
         if IOresult = 0 then FileExists:= true else FileExists:= false;
      end;

procedure inicializacion(var arch:T_ARCHIVO);
var
begin
  if FileExists(arch) then
  begin
    reset(arch);
    inicializar_registro(reg: Estancias);
    
  end
  else
  begin
    
  end;
end;
// function existe(var archivo: T_ARCHIVO; ruta: string = ''):boolean;
// var
// test: integer;
// begin
//    assign(archivo,ruta);
//    {$I-} reset(archivo); {$I+}
//    if ioresult <> 0 then
//    begin
//       rewrite(archivo);
//       existe:=false;
//    end
//  else
//     begin
//        test:= filesize(archivo);
//        //seek(archivo,filesize(archivo)-1);
//        existe:=true;

//     end;
// end;
  function PosFinalArchivo(var arch: T_Archivo): Integer;

     begin
        if filesize(arch) = 0 then
                SEEK(arch, 0);
        else if filesize(arch) = 1 then
                SEEK(arch, 1);
        else if filesize(arch) > 1 then
            begin
              
              
            end;  
        end;
        
          
        end;

     end;   
procedure append(var arch: T_ARCHIVO; r: Estancias);
begin
  GUARDAR_REGISTRO(arch, PosFinalArchivo(arch), r);
  
end;
PROCEDURE CREAR (VAR ARCH: T_ARCHIVO); 
BEGIN 
  ASSIGN(ARCH,ruta); 
  REWRITE(ARCH); 
END; 
 
PROCEDURE ABRIR (VAR ARCH: T_ARCHIVO); 
BEGIN 
  ASSIGN(ARCH,ruta); 
  RESET(ARCH); 
END; 
 
PROCEDURE CERRAR (VAR ARCH: T_ARCHIVO); 
  BEGIN 
    CLOSE(ARCH); 
  END; 
 
PROCEDURE LEER_REGISTRO(POS:INTEGER; VAR ARCH:T_ARCHIVO;  VAR REG: Estancias); 

BEGIN 
  SEEK(ARCH, POS); 
  READ(ARCH, REG); 
END; 
PROCEDURE GUARDAR_REGISTRO (VAR ARCH:T_ARCHIVO; POS:INTEGER; REG:Estancias); 
BEGIN 
  SEEK(ARCH, POS); 
  WRITE(ARCH, REG); 
END; 
procedure inicializar_registro (VAR reg: estancias);
begin
  reg.ID:=0;
  reg.nombre:='';
  reg.dueno:='';
  reg.DNI:=0;
  reg.domicilio:='';
  reg.TEL:='';
  reg.email:='';
  reg.caracteristicas:='';
  reg.piscina:=false;
  reg.cap_Max:=0;

  // write(arch,reg);

end;

procedure cargar_valores_bool(texto:string; var input:boolean);	//muestra un texto en pantalla y toma unos valores de entrada de cualquier tipo de dato primario
begin
	writeln(texto);
	if (upcase(readkey()) = 'S' ) then
		input:=true
	else
		input:=false;
end;
procedure cargar_valores_int(texto:string; var input:integer);//muestra un texto en pantalla y toma unos valores de entrada de cualquier tipo de dato primario
var aux:string; //contiene el valor obtenido del READLn para luego evaluar 
	i:integer;
	flag:boolean; //true si no encontro letras
begin
	i:= 1;
	flag:= true;
	writeln(texto);
	readln(aux);
	//#48 al #57 caracteres ASCII numeros
	while (i < Length(aux)) or (flag = true) do
	  
	begin
		if (ord(aux[i]) >= 48) and (ord(aux[i]) <= 57) then
		begin
			input:=strtoint(aux);
			i:= i+1;
			
		end
		else
			writeln(' no ingreso correctamente el número');
			flag:= false;
	end;
end;
procedure cargar_valores_String(texto:string; var input: string);
begin
  writeln(texto);
  readln(input);
end;
// procedure cargar_valores_int(texto:string; var input:integer);	//muestra un texto en pantalla y toma unos valores de entrada de cualquier tipo de dato primario
// var aux:string; //contiene el valor obtenido del READLn para luego evaluar 
// 	i:integer;
// 	introdujoLetra:boolean;	//si es False vuelve a preguntar si introdujo bien los numeros
// begin
// 	introdujoLetra:= False;
// 	//#48 al #57 caracteres ASCII numeros
// 	repeat
		
// 	begin
// 		writeln(texto);
// 		readln(aux);
			
// 		for i:=1 to Length(aux) do
		
// 			begin
// 			if (ord(aux[i]) >= 48) and (ord(aux[i]) <= 57) then
// 			begin
				
// 				input:=strtoint(aux);
// 				introdujoLetra:=True;
// 			end
// 			else
// 				writeln(' no ingreso correctamente el número');
// 				introdujoLetra:=false;
// 		end;
// 	end;
// 	until (introdujoLetra = True);
	
//end;
PROCEDURE CARGAR_registro (VAR r: Estancias); 
begin
  cargar_valores_int('ingrese id', r.ID);
  cargar_valores_string('ingrese nombre', r.nombre);
  cargar_valores_string('ingrese dueño', r.dueno);
  cargar_valores_int('ingrese DNI', r.dni);
  cargar_valores_string('ingrese domicilio', r.domicilio);
  cargar_valores_string('ingrese telefono', r.tel);
  cargar_valores_string('ingrese email', r.email);
  cargar_valores_string('ingrese caracteristicas', r.caracteristicas);
  cargar_valores_bool('tiene piscina? S/n', r.piscina);
  cargar_valores_int('ingrese la capacidad maxima', r.cap_Max);

end;
PROCEDURE ORDEN_BURBUJA (VAR ARCH: T_ARCHIVO); 
VAR R1, R2:Estancias; 
LIM,I,J:INTEGER; 
BEGIN 
LIM:= FILESIZE(ARCH)-1; 
FOR I:= 0 TO LIM - 1 DO 

FOR J:= 0 TO LIM - I DO 
   BEGIN 
    SEEK (ARCH,J); 
    READ (ARCH,R1); 
    SEEK (ARCH,J+1); 
    READ (ARCH,R2); 
    IF R1.Nombre > R2.Nombre THEN 
                                  BEGIN 
                                   SEEK (ARCH,J+1); 
                                   WRITE(ARCH,R1); 
         END; 
    END; 
END; 
 
PROCEDURE BBIN (VAR ARCH:T_ARCHIVO; BUSCADO:INTEGER; VAR 
POS:LONGINT); 
VAR  R1:Estancias; 
PRI,ULT,MED:LONGINT; 
BEGIN 
PRI:=0; 
ULT:= FILESIZE (ARCH)-1; 
POS := -1; 
WHILE (POS = -1) AND (PRI<= ULT) DO 
 BEGIN 
  MED:= (PRI + ULT) DIV 2; 
  SEEK (ARCH,MED); 
  READ (ARCH,R1); 
  IF R1.ID = BUSCADO THEN POS:= MED 
     ELSE 
          IF R1.ID > BUSCADO THEN ULT:= MED -1 
             ELSE PRI:= MED +1; 
 END; 
END; 
 
 procedure mostrar_registro(r:Estancias; x:integer = 10; y: integer = 10);
 begin
  with r do 
  begin
    
    GotoXY(x,y);
    writeln('el ID de la estancia: ', ID) ;
    writeln('nombre de la estancia: ', nombre) ;
    writeln('dueño de la estancia ', dueno) ;
    writeln('DNI de la persona', DNI) ;
    writeln('domicilio: ', domicilio) ;
    writeln('teléfono: ', tel) ;
    writeln('Email: ', email) ;
    writeln('características: ', caracteristicas) ;
    writeln('piscina: ', piscina) ;
    writeln('capacidad máxima: ', cap_Max) ;
  end;4
 end; 
  
 
// PROCEDURE LISTAR1(VAR ARCH:T_ARCHIVO); 
// VAR 
//  REG:Estancias; 
// BEGIN 
//   RESET(ARCH); 
//   WHILE NOT(EOF(ARCH)) DO 
//     BEGIN 
//      READ(ARCH, REG); 
//      MOSTRAR_REGISTRO(REG); 
//     END; 
// END; 
 
// PROCEDURE LISTAR2 (VAR ARCH:T_ARCHIVO; pos:Integer); 
// VAR 
// REG:Estancias; 
// BEGIN 
//     BEGIN 
//       SEEK(ARCH,POS); 
//       READ(ARCH, REG); 
//       if reg.ESTADO = TRUE then MOSTRAR_REGISTRO(REG); 
//     END; 
//  END; 
// END. 

//------------
begin
    
end.
