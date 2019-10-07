%#####################################################
%################ Base de conocimiento ###############
%#####################################################

%Detalle de defecto
%defecto(ID,nombre,[colores,manchas,coberturas,heridas,deformidades,texturas])

defecto(0,"sin defecto",[1,2,3,4,5]).
defecto(1,"herida cicatrizada",[1,2,3,4,5,11,13,14,19,20,22,28,29]).
defecto(2,"machucon",[1,2,3,4,5,11,13,14,15,21,22,26,28]).
defecto(3,"perforacion cicatrizada",[1,2,3,4,5,11,13,18,22,26,29]).
defecto(4,"fruto gemelo",[1,2,3,4,5,12,16,21,23,24,29]).
defecto(5,"quemadura solar",[1,2,3,4,5,9,13,14,21,27,29]).
defecto(6,"fruto doble",[1,2,3,4,5,12,16,21,24,29]).
defecto(7,"sin color",[7,12,16,21,27,29]).
defecto(8,"pitting",[1,2,3,4,5,11,15,16,21,26,28]).
defecto(9,"sin pedicelo",[1,2,3,4,5,12,16,21,25,29]).
defecto(10,"medialuna",[1,2,3,4,5,11,14,20,22,29]).
defecto(11,"fruto arrugado",[1,2,3,4,5,8,13,14,15,21,27,28]).
defecto(12,"madurez excesiva",[6,8,14,21,27,28]).

%Lista de caracteristicas 

listaDefectos([1,2,3,4,5,6,7,8,9,10,11,12]).

%Color de cerezas
caracteristica(1,"crema").
caracteristica(2,"rojo sobre crema").
caracteristica(3,"rojo").
caracteristica(4,"rojo oscuro").
caracteristica(5,"granate").
caracteristica(6,"negruzco").
caracteristica(7,"blanca").

%Tipo de manchas
caracteristica(8,"russet").
caracteristica(9,"quemadura de sol").
caracteristica(10,"ramaleo").
caracteristica(11,"cafe").
caracteristica(12,"sin mancha").

%Cobertura de manchas
caracteristica(13,"alto").
caracteristica(14,"medio").
caracteristica(15,"bajo").
caracteristica(16,"ninguna").

%Tipo de heridas en fruta
caracteristica(17,"corte alargado").
caracteristica(18,"corte circular").
caracteristica(19,"desgarro alargado").
caracteristica(20,"desgarro circular").
caracteristica(21,"sin corte/desgarro").

%Tipo de deformidad en fruta
caracteristica(22,"hendidura").
caracteristica(23,"protuberancia baja").
caracteristica(24,"protuberancia grande").
caracteristica(25,"sin predicileo").
caracteristica(26,"hundimiento").
caracteristica(27,"sin deformidad").

%Texturas
caracteristica(28,"rugosa").
caracteristica(29,"lisa").

%Calibres
%calibre(ID,Calibres,Tipo)
calibre(1,18,"pequeno").
calibre(2,19,"pequeno").
calibre(3,20,"pequeno").
calibre(4,21,"mediano").
calibre(5,22,"mediano").
calibre(6,23,"mediano").
calibre(7,24,"mediano").
calibre(8,25,"grande").
calibre(9,26,"grande").
calibre(10,27,"grande").
calibre(11,28,"grande").
calibre(12,29,"grande").
calibre(13,30,"muy grande").
calibre(14,31,"muy grande").
calibre(15,32,"muy grande").
calibre(16,0,"desecho").

%Saliadas linea de embalaje
%salidaEmbalaje(ID,Nombre,Defectos,Calibres)
salidaEmbalaje(1,"exportable",[0,9],[8,9,10,11,12,13,14,15]).
salidaEmbalaje(2,"mercado interno",[1,4,5,6,7,8,10,11],[1,2,3,4,5,6,7]).
salidaEmbalaje(3,"desechable",[2,3,12],[16]).

calibreIgual("exportable","exportable").
calibreIgual("mercado interno","mercado interno").
calibreIgual("desechable","desechable").

%Lista salida embalaje
listaSalidaEmbalaje([1,2,3]).

%#############################################
%############### CODIGO FUENTE ###############
%#############################################

%Reglas

%############### Pregunta 2: ###############

%Predicado: detectarDefecto
%Dominio: DefectoID,Nombre,[Color,Mancha,Cobertura,Herida,Deformidad,Textura]
%Meta primaria: Dado las caracteristicas de la cereza, entregar el defecto de esta fruta.
%Meta secundaria: Realizar la búsqueda de caracteristica en cada hecho, generando un nombre e Id de defecto.

detectarDefecto(DefectoID,Nombre,CaracteristicasIngresadas):- detectarDefectoIterativo(DefectoID,Nombre,CaracteristicasIngresadas).

%Predicado: detectarDefectoIterativo
%Dominio: DefectoID,Nombre,[CaracteristicasIngresadas]
%Meta primaria: Para todas las caracteristicas, econtrar un defecto en especifico.
%Meta secundaria: Comparar las caracteristicas con las existentes en los defectos.

detectarDefectoIterativo(_,_,[]).
detectarDefectoIterativo(DefectoID,Nombre,[X|Xs]):- caracteristica(IDCaracteristica,X),defecto(DefectoID,Nombre,Caracteristicas),
                                                    member(IDCaracteristica,Caracteristicas),detectarDefectoIterativo(DefectoID,Nombre,Xs).


%############### Pregunta 3: ###############
%Parte a:

%Predicado: encontrarConjuntoDefectos
%Dominio: [ListaResultante],[CaracteristicasIngresadas]
%Meta primaria: Encontrar el conjunto de defectos de la cereza.
%Meta secundaria: Buscar los defectos según las caracteristicas escritas.

encontrarConjuntoDefectos(ListaResultante,CaracteristicasIngresadas):- listaDefectos(IDsDefectos),recorrerListaDefectos(IDsDefectos,ListaResultante,CaracteristicasIngresadas),!.

%Predicado: encontrarConjuntoDefectos
%Dominio: [ListaResultante],[CaracteristicasIngresadas]
%Meta primaria: Listar los defectos de la cereza.
%Meta secundaria: Recorrer cada ID de defecto y encontrar el defecto que será almacenado en una lista.

recorrerListaDefectos([],[],_).
recorrerListaDefectos([X|Xs],[Nombre|Ys],CaracteristicasIngresadas):- recorrerListaDefectos(Xs,Ys,CaracteristicasIngresadas),detectarDefecto(X,Nombre,CaracteristicasIngresadas).
recorrerListaDefectos([_|Xs],ListaResultante,CaracteristicasIngresadas):- recorrerListaDefectos(Xs,ListaResultante,CaracteristicasIngresadas).

%Parte b:

buscarCalibre(CalibreID,Calibre,DatoIngresado):- calibre(CalibreID,Calibre,DatoIngresado),!.


encontrarSalida(ListaDefectos,Salida,NombreCalibre,Caracteristicas,Calibre):- buscarCalibre(CalibreID,Calibre,NombreCalibre),listaSalidaEmbalaje(ListaSalidas), encontrarConjuntoDefectos(ListaDefectos,Caracteristicas),
                                                                              encontrarSalidaVentaIterativo(ListaSalidas,ListaDefectos,CalibreID,TiposVentaUno),encontarSalidaDefectoIterativo(ListaSalidas,ListaDefectos,CalibreID,TiposVentaDos),
                                                                              aplanarLista(TiposVentaDos,TiposVentaDosAux),union(TiposVentaUno,TiposVentaDosAux,SalidaAux),comprobarVenta(Salida,SalidaAux),!.

encontrarSalidaVentaIterativo([],_,_,[]).
encontrarSalidaVentaIterativo([X|Xs],_,CalibreID,[Y|Ys]):- encontrarSalidaVentaIterativo(Xs,_,CalibreID,Ys),salidaEmbalaje(X,NombreVenta,_,CalibresSalida),member(CalibreID,CalibresSalida),Y = NombreVenta.
encontrarSalidaVentaIterativo([_|Xs],_,CalibreID,TiposVenta):- encontrarSalidaVentaIterativo(Xs,_,CalibreID,TiposVenta).


encontarSalidaDefectoIterativo([],_,_,[]).
encontarSalidaDefectoIterativo([X|Xs],ListaDefectos,_,[Y|Ys]):- encontarSalidaDefectoIterativo(Xs,ListaDefectos,_,Ys),salidaEmbalaje(X,NombreVenta,DefectosSalida,_),
                                                                    perteneceDefectoIterativoSalida(TiposVenta,ListaDefectos,DefectosSalida,NombreVenta),Y = TiposVenta.
encontarSalidaDefectoIterativo([_|Xs],ListaDefectos,_,TiposVenta):- encontarSalidaDefectoIterativo(Xs,ListaDefectos,_,TiposVenta).


perteneceDefectoIterativoSalida([],[],_,_).
perteneceDefectoIterativoSalida([X|Xs],[Y|Ys],DefectosSalida,NombreVenta):- perteneceDefectoIterativoSalida(Xs,Ys,DefectosSalida,NombreVenta),defecto(DefectoID,Y,_),member(DefectoID,DefectosSalida),X = NombreVenta.
perteneceDefectoIterativoSalida(TiposVenta,[_|Ys],DefectosSalida,NombreVenta):- perteneceDefectoIterativoSalida(TiposVenta,Ys,DefectosSalida,NombreVenta).

aplanarLista([],[]).
aplanarLista([X|Xs],Resultado):- aplanarLista(X,ApX),aplanarLista(Xs,ApXs),append(ApX,ApXs,Resultado).
aplanarLista(X,[X]).


comprobarVenta(Salida,SalidaAux):- member("desechable",SalidaAux),Salida = "desechable".
comprobarVenta(Salida,SalidaAux):- member("mercado interno",SalidaAux), Salida = "mercado interno".
comprobarVenta(Salida,_):- Salida = "exportable".


