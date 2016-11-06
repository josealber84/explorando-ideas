### Método SportVU
Recoleccion de datos mediante cámaras: http://www.stats.com/sportvu-basketball-media/

### Artículos sobre la NBA y los datos
http://www.astronomer.io/blog/data-in-basketball

Me encanta esto :) :
>[Take] the average possession of the Lakers. They were going to score .98 points every time they had a possession. [Yet] Kobe Bryant only shot the left handed pull up jumper at a 44 percent clip. So every time that he went left and shot that pull up jumper he was generating .88 points per possession. Well that’s a tenth of a point less than the average Laker possession. And so if I could make him do that time and time again which is a lot tougher to do than to say, I’m shaving off a tenth of a point every single time. I’m actually making him detrimental to his team.

--Carlos
En cuanto al deporte y los datos tengo una enmienda a la totalidad que quiero plantearos. Para ello usare tres deportes, beisbol, baloncesto y futbol.
Beisbol, en el que las estadisticas han funcionado, es un deporte muy estatico y muy repetivo. Un jugador lanza la bola siempre desde la misma posición y esta en bateada también siempre desde la misma posición. La unica variacion en el juego es cuantos corredores hay actualmente en las bases. Esta situacion se repetite durante todo el partido

Baloncesto, en el que parece que las estadisticas estan funcionando, es un deporte menos estatico pero todavía repetitivo. Los jugadores lanzan desde distantas posiciones, se pasan el balon,... Pero sigue siendo repetitivo en el sentido de que las posesiones se repiten cada 24 segundos.

Futbol, es posiblemente igual de poco estatico que el futbol..pero es mucho menos repetitivo. Con esto solo quiere hacer notar la complejidad de encontrar patrones en el futbol.



### Propuesta (¿qué opináis?)

Propongo (para empezar) hacer algo parecido a lo que hacen en la NBA (lo que se comenta en el artículo anterior) pero centrándonos en equipos de fútbol españoles. El problema para hacer cosas en tiempo real es que esos datos valen dinero. Pero los datos a posteriori son gratis :) Y parece más sencillo empezar por ahí.

Es increíble la cantidad de datos gratuitos que hay después de cada partido. ¡Y sólo he mirado en una web! Algunos ejemplos:

- [Aquí](http://resultados.as.com/resultados/futbol/primera/2016_2017/directo/regular_a_10_179604/estadisticas/?omnaut=1) están las estadísticas de tiros a puerta de un partido normalito de la liga española. Como veis, no sólo se documenta el porcentaje de tiros que van a puerta, fuera o al palo. Todos los tiros a puerta están localizados (en 2D y 3D) en el campo, con el autor, el minuto y el resultado del tiro (y a qué punto de la portería fue dirigido).

Es decir, que para cada equipo tenemos disponibles todos los tiros a puerta, quién los ha hecho, en qué minuto y con qué resultado. Pero aún mejor, tenemos esa misma información disponible **para todos los jugadores y porteros**. Podemos extraer conclusiones de la habilidad de cada jugador/portero en función de las circunstancias.


- [Aquí](http://resultados.as.com/resultados/futbol/primera/2016_2017/directo/regular_a_10_179604/afondo/) hay mapas de calor del movimiento de cada jugador con precisión de 1 minuto (puedes elegir el fragmento de partido que quieras y te pinta el mapa de calor). También hay un mapa de acciones con el balón de cada jugador.

Es decir, que sabemos cómo se mueve cada jugador con y sin balón a lo largo de cada minuto de cada partido. Not bad.

Más abajo tenemos todos los pases (acertados y fallados), todas las acciones defensivas (exitosas o no), regates, faltas, paradas... Todo con el jugador implicado y el minuto.

Y más abajo, todas las jugadas del partido, divididas por equipos, y explicadas de forma esquemática.

En otras páginas de la misma web (as.com) hay valoraciones subjetivas de cada jugador y una narración escrita del partido.

Tenemos disponible una cantidad ingente de datos, que creo que haría posible responder a preguntas como:

- ¿Cómo mete goles el equipo X? ¿Cuál es la mejor forma de evitar que meta goles?
- ¿Cómo recibe goles el equipo Y? ¿Cuál es la forma más fácil de meterle un gol?
- ¿Cuánto aporta cada jugador a su equipo en cada partido?
- ¿Qué jugadores son los mejores en cada posición? ¿Cuáles son los más valiosos?
- ¿A qué jugador debe fichar el equipo X para la posición Y?
- ¿Qué jugador debe alinear el equipo X en la posición Y para maximizar las probabilidades de ganar al equipo Z?


-- Carlos
He esta mirando los datos del AS y no se como podriamos descargarnoslos..vamos que de momento pongo en duda la disponibilidad de la cantidad ingente de datos :-). Pero suguro que conseguis sorprenderme


La cuestión es: ¿pagarían los equipos de fútbol por este tipo de información?

***

La única forma de saberlo es probarlo. Aquí veo dos opciones (las dos "lean"):

1.- Preparar un informe con las debilidades y fortalezas de un equipo concreto, algo muy currado, e ir ofreciéndoselo a todos los futuros rivales una semana antes de cada partido, aunque sea gratis, a ver cómo responden.

2.- No hacer el informe, pero ofrecerlo de todos modos. Así vemos el interés de los posibles clientes antes de ponernos a hacer nada.

Me gusta más la opción 1, porque así vemos de qué somos capaces, y enseñar algo siempre es mejor que no enseñar nada, pero me valen las dos :)

¿Qué opináis?
