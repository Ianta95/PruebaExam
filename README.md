# Prueba de Evaluacion con VIPER
Adjunto mi progreso medio de prueba de evaluacion con VIPER. La api esta caida y no pude por exceso de trabajo desarrollar los modelos con la modificación. Les dejo mi prueba de VIPER, les dejo un ejemplo (Que fue justo el que trabaje) de mi componente en VIPER, una prueba con otra API para ejemplificar el consumo, el POD Init con mi lectura al proyecto de FIREBASE para el background con 3 nodos y un modelo con el CODABLE / DECODABLE
Tambien dejo la solución a las preguntas:



Explique el ciclo de vida de una aplicación:

Explique el ciclo de vida de un view controller:
Al igual que la aplicación, los view controllers tienen su propio ciclo de vida. El ciclo de vida de un view controller inicia desde que se crea por primera vez, se muestra, se oculta hasta cuando se destruye. De acuerdo al flujo y lo que pase con este, sus funciones importantes son:
ViewDidLoad -> Se construye o carga (Se activa 1 vez)
ViewWillAppear / ViewDidAppear -> Se activan antes y despues de mostrar pantalla o cada que se muestra al usuario. Si pasa a segundo plano y se vuelve a esta pantalla se activan (Varias veces depende del flujo).
ViewWillDisappear / ViewDidDisappear -> Mismo caso que el anterior pero se dedida a cuando la pantalla desaparece de foco o de mostrarse con el usuario (Varias veces depende del flujo).
Hay mas funciones para complementar pero esas son las mas importantes.

En que casos se usa un weak, un strong y un unowned:

Cuando queremos determinar la importancia de cierta información para el ARC. se usa weak cuando queremos una referencia debil que nos permitira que el ARC sepa que puede borrarla o romperla si lo necesita. Se usa strong cuando le queremos comunicar que necesitamos una referencia fuerte y que no lo deseheche tan facil. El unowned es cuando no estamos seguros del tipo de referencia que necesitamos

¿Qué es el ARC?
El encargado de manejar la memoria y controlar las instancias que se generan de las clases

Analizar las siguientes capturas de pantalla y justificar tu respuesta :
Se pinta de color rojo porque aunque le asignas el color antes del lanzamiento en la creacion de instancia, hasta que se lanza, se termina de cargar la view controller.

