// lib/data/dummy_data.dart

import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/routine_model.dart';

// --- Lista de Todos los Ejercicios Disponibles ---
final List<Exercise> allExercises = [
  // Pecho
  Exercise(
    id: 'ex01',
    name: 'Press de Banca',
    description: 'El press de banca es un ejercicio fundamental para desarrollar la fuerza y el tamaño de los músculos pectorales, así como los deltoides y tríceps.',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Acuéstate en un banco plano.',
      'Agarra la barra con las manos un poco más anchas que el ancho de los hombros.',
      'Baja la barra lentamente hasta que toque tu pecho.',
      'Empuja la barra hacia arriba hasta que tus brazos estén completamente extendidos.',
    ],
  ),
  Exercise(
    id: 'ex02',
    name: 'Aperturas con Mancuernas',
    description: 'Este ejercicio aísla los músculos del pecho, ayudando a mejorar la amplitud y definición.',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Acuéstate en un banco plano con una mancuerna en cada mano.',
      'Extiende los brazos por encima de tu pecho.',
      'Baja las mancuernas hacia los lados en un arco amplio.',
      'Regresa a la posición inicial contrayendo los pectorales.',
    ],
  ),

  // Pierna
  Exercise(
    id: 'ex03',
    name: 'Sentadillas con Barra',
    description: 'La sentadilla es el rey de los ejercicios de piernas, trabajando cuádriceps, glúteos e isquiotibiales.',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Coloca la barra sobre tus trapecios.',
      'Mantén la espalda recta y el pecho hacia arriba.',
      'Baja las caderas como si te fueras a sentar en una silla.',
      'Asegúrate de que tus rodillas no sobrepasen la punta de tus pies.',
    ],
  ),
  Exercise(
    id: 'ex04',
    name: 'Prensa de Piernas',
    description: 'Una excelente alternativa a las sentadillas para enfocar el trabajo en los cuádriceps de forma segura.',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Siéntate en la máquina y coloca los pies en la plataforma.',
      'Empuja la plataforma hasta que tus piernas estén extendidas.',
      'Baja el peso de forma controlada.',
      'No bloquees las rodillas al final del movimiento.',
    ],
  ),

  // Espalda
  Exercise(
    id: 'ex05',
    name: 'Dominadas',
    description: 'Ejercicio de peso corporal ideal para desarrollar la amplitud de la espalda (dorsales).',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Sujeta la barra con las palmas hacia afuera.',
      'Cuélgate con los brazos completamente extendidos.',
      'Sube tu cuerpo hasta que tu barbilla sobrepase la barra.',
      'Baja de forma lenta y controlada.',
    ],
  ),
  Exercise(
    id: 'ex06',
    name: 'Remo con Barra',
    description: 'Un ejercicio fundamental para dar densidad y grosor a los músculos de la espalda media.',
    videoUrl: 'YQ2s_Y7g5Qk',
    steps: [
      'Inclina tu torso hacia adelante manteniendo la espalda recta.',
      'Sujeta la barra con un agarre prono.',
      'Tira de la barra hacia la parte baja de tu abdomen.',
      'Contrae los músculos de la espalda en la parte superior del movimiento.',
    ],
  ),
];


// --- Rutinas Predeterminadas ---
final Routine chestRoutine = Routine(
  id: 'rt01',
  name: 'Rutina de Pecho',
  exercises: [allExercises[0], allExercises[1]],
);

final Routine legRoutine = Routine(
  id: 'rt02',
  name: 'Rutina de Pierna',
  exercises: [allExercises[2], allExercises[3]],
);

final Routine backRoutine = Routine(
  id: 'rt03',
  name: 'Rutina de Espalda',
  exercises: [allExercises[4], allExercises[5]],
);

final List<Routine> predefinedRoutines = [
  chestRoutine,
  legRoutine,
  backRoutine,
];