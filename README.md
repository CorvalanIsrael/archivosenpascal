# archivosenpascal
TP pascal: administración de archivos
prueba de concepto con ejemplo de como utilizar archivos en Pascal, administrando con tipos de archivos .dat en tipos de datos personalizados, creacion, modificación, ordenamiento de elementos dentro del archivo
# set up y configuracion
instalar FPC en el sistema
correr el comando 
fpc ./programa_principal.pas
ejecutar el archivo "programa_principal.exe"

# descripción de unit archivos.pas
+ PROCEDURE CREAR (VAR ARCH: T_ARCHIVO); 
crea el archivo asignando la ruta
  ASSIGN(ARCH,ruta); //le asigna a el archivo ARCH la ruta definida en "const ruta = 'estancias.dat' modificando el contenido de ruta se cambia el archivo al que hace referencia
  REWRITE(ARCH); //crea o sobreescribe el archivo. Si ya hay un archivo con el mismo nombre lo reescribe (se pierde la información)

+ PROCEDURE ABRIR (VAR ARCH: T_ARCHIVO); 
abre un archivo previamente creado sin sobreescribirlo 
  ASSIGN(ARCH,ruta);  
  RESET(ARCH); //abre un archivo existente. Si no existe, el programa crashea

- **otra forma de abrir o crear archivos**
    {$I-} //desactiva temporalmente la detección de errores
        reset(arch);
        {$I+}
        Close(arch);
        if IOresult <> 0 then rewrite(arch);
intenta abrir el archivo, con la directiva de compilación {$I-} se desactiva temporalmente la detección de errores de entrada y salida, si el archivo existe, la variable reservada IOresult arroja 0 como resultado, en caso contrario, si el archivo no existe, devuelve otro valor. Comparando el resultado de la variable se puede saber si utilizar reset o rewrite
(~~si, pascal es una verga~~)

+ procedure inicializacion(var arch:T_ARCHIVO);
    realiza todo lo mencionado anteriormente de forma automática (en teoría)
```pascal
`
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
end;`
```
utiliza la función FileExist que realiza la comprobación

- function FileExists (var arch:T_ARCHIVO):boolean;
`   function FileExists (var arch:T_ARCHIVO):boolean;
   //comprobación de la existencia del archivo
      begin
        {$I-}
         reset(arch);
         {$I+}
         Close(arch);
         if IOresult = 0 then FileExists:= true else FileExists:= false;
      end;
`
comprueba la existencia del archivo, devolviendo True en caso de que el archivo exista previamente, y False en caso de que no

## descricpión de los tipos de datos utilizados
`provincias = (

    BuenosAires, CABA, Catamarca, Chaco, Chubut, Cordoba, Corrientes,
    EntreRios, Formosa, Jujuy, Pampa, Rioja, Mendoza, Misiones,
    Neuquen, RioNegro, Salta, SanJuan, SanLuis, SantaCruz, SantaFe,
    SantiagoDelEstero, TierraDelFuego, Tucuman
 );`
 es un tipo enumerado conteniendo las provincias de Argentina
- estancias
`Estancias = record
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
end;`
    es un tipo de datos de tipo registro que contiene la información que se guarda dentro de los archivos

- tipo Archivo
    T_ARCHIVO = file of estancias;
se declara el tipo de archivos a utilizar:
    file of estancias: tipo de archivo que guarda los registros dentro de segmentos dentro del archivo, a modo de un "array infinito", cada posición del archivo corresponde a una ubicación de este tipo
    las posiciones del archivo corresponden a posiciones dentro de un vector