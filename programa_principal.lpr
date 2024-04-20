program programa_principal;
{$mode objfpc}
{$codepage utf-8}
uses archivos, crt;

VAR
archivo_estancias: T_ARCHIVO;
estancia:Estancias;
i: integer;
flag: boolean;
begin
    // CREAR(archivo_estancias);
    // inicializar_registro(estancia);
    // GUARDAR_REGISTRO(archivo_estancias, 0, estancia);
    // CARGAR_REGISTRO(estancia);
    // GUARDAR_REGISTRO(archivo_estancias, 1, estancia);
    if existe(archivo_estancias, ruta) = true then
     write(' abriendo el archivo estancias ')
    else
     write(' creando el archivo estancias ');

   inicializar_registro(estancia);
   GUARDAR_REGISTRO(archivo_estancias, 0, estancia);
//    ABRIR(archivo_estancias);
    writeln('tamaño archivo ', FileSize(archivo_estancias));
    while not EOF do
    begin
        LEER_REGISTRO(i, archivo_estancias, estancia);
        writeln(estancia.id);
        writeln(estancia.nombre);

    end;
end.
