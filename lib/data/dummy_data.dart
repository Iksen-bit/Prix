// lib/data/dummy_data.dart

// Asegúrate de tener los imports correctos para tus modelos
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/routine_model.dart';
import 'package:myapp/models/product_model.dart'; // <--- Importa el nuevo modelo de producto

// --- Lista de Todos los Ejercicios Disponibles ---
final List<Exercise> allExercises = [
  // Pecho
  Exercise(
    id: 'ex01',
    name: 'Press de Banca',
    description: 'El press de banca es un ejercicio fundamental para desarrollar la fuerza y el tamaño de los músculos pectorales, así como los deltoides y tríceps.',
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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
    videoUrl: 'YQ2s_Y7g5Qk', // ID de YouTube
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


// --- Productos de la Tienda ---
// Asegúrate de que el enum ProductCategory esté definido en product_model.dart
final List<Product> allProducts = [
  Product(
    id: 'prod01',
    name: 'ON Gold Standard Whey',
    description: 'Proteína de suero de leche de alta calidad, ideal para recuperación muscular post-entrenamiento.',
    imageUrl: 'https://m.media-amazon.com/images/I/71BFejouWCL.jpg',
    price: 60.99,
    category: ProductCategory.proteina,
    nutritionalInfo: {
      'Porción': '1 scoop (30.4g)',
      'Calorías': '120',
      'Proteína': '24g',
      'Carbohidratos': '3g',
      'Grasa': '1.5g',
    },
  ),
  Product(
    id: 'prod02',
    name: 'Lipodrene Hardcore',
    description: 'Potente quemador de grasa termogénico para máxima definición y energía.',
    imageUrl: 'https://resources.sears.com.mx/medios-plazavip/mkt/605bfea0e22a4_lipodrene-hardcore-90-capsjpg.jpg',
    price: 34.95,
    category: ProductCategory.quemador,
    nutritionalInfo: {
      'Porción': '1 tableta',
      'Cafeína': '200mg',
      'Extracto Ephedra': '25mg', // Nota: Verifica la legalidad de este componente en tu región
      'Yohimbina': '1.5mg',
    },
  ),
   Product(
    id: 'prod03',
    name: 'Birdman Falcon Performance',
    description: 'Proteína vegana de alto rendimiento con BCAA y enzimas digestivas.',
    imageUrl: 'https://www.costco.com.mx/medias/sys_master/products/he6/h3a/349876588576798.jpg',
    price: 45.50,
    category: ProductCategory.proteina,
    nutritionalInfo: {
      'Porción': '1 scoop (30g)',
      'Calorías': '110',
      'Proteína': '22g',
      'Carbohidratos': '4g',
      'Grasa': '1g',
    },
  ),
   Product(
    id: 'prod04',
    name: 'Nutrex Lipo-6 Black UC',
    description: 'Quemador de grasa ultra concentrado de acción rápida.',
    imageUrl: 'https://gnc.com.mx/media/catalog/product/1/4/141603180_a_1.jpg',
    price: 29.99,
    category: ProductCategory.quemador,
    nutritionalInfo: {
       'Porción': '1 cápsula',
       'Cafeína Anhidra': '200mg',
       'Teobromina': '100mg',
       'Yohimbina HCl': '4.5mg',
    },
  ),
    Product(
    id: 'prod05',
    name: 'Edge of Insanity Preworkout',
    description: 'Pre-entreno extremo para energía explosiva, enfoque mental y bombeos intensos.',
    imageUrl: 'https://suplementosmty.com/cdn/shop/files/F54EF15A-B466-444C-A8FB-C1C191034638_1800x1800.webp?v=1750725720',
    price: 39.99,
    category: ProductCategory.preworkout,
    nutritionalInfo: {
      'Porción': '1 scoop (12.8g)',
      'Beta-Alanina': '3.2g',
      'Citrulina Malato': '8g',
      'Cafeína': '350mg',
      'Yohimbina HCl': '3mg',
    },
  ),
      Product(
    id: 'prod06',
    name: 'Nutrex Creatine',
    description: 'Creatina Monohidradata pare recuperacion en tus entrenamientos explosivos.',
    imageUrl: 'https://cdn5.coppel.com/mkp/258148467-1.jpg',
    price: 50.99,
    category: ProductCategory.preworkout,
    nutritionalInfo: {
      'Porción': '1 scoop (5.0g)',
    },
  ),
  // Puedes añadir más productos aquí si lo deseas
];