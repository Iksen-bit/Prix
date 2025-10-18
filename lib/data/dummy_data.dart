// lib/data/dummy_data.dart

// Asegúrate de tener los imports correctos para tus modelos
import 'package:myapp/models/exercise_model.dart';
import 'package:myapp/models/routine_model.dart';
import 'package:myapp/models/product_model.dart'; // <--- Importa el nuevo modelo de producto
import 'package:myapp/models/professional_model.dart';

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
//Puedes añadir más productos aquí si lo deseas
];

// --- Profesionales Disponibles ---
  final List<Professional> allProfessionals = [
  // Coaches
  Professional(
    id: 'prof01',
    name: 'Carlos Mendez',
    category: ServiceCategory.coach,
    description: 'Entrenador personal certificado con 10 años de experiencia en transformación física.',
    focusArea: 'Hipertrofia y pérdida de grasa',
    availability: 'Lunes a Viernes: 7am - 12pm / 4pm - 8pm',
    imageUrl: 'https://via.placeholder.com/150/FF5733/FFFFFF?text=CM', // Placeholder
    availableSlots: {
      1: ['07:00', '08:00', '09:00', '10:00', '11:00', '16:00', '17:00', '18:00', '19:00'], // Lunes
      2: ['07:00', '08:00', '09:00', '10:00', '11:00', '16:00', '17:00', '18:00', '19:00'], // Martes
      3: ['07:00', '08:00', '09:00', '10:00', '11:00', '16:00', '17:00', '18:00', '19:00'], // Miércoles
      4: ['07:00', '08:00', '09:00', '10:00', '11:00', '16:00', '17:00', '18:00', '19:00'], // Jueves
      5: ['07:00', '08:00', '09:00', '10:00', '11:00'], // Viernes
    },
  ),
  Professional(
    id: 'prof02',
    name: 'Sofia Reyes',
    category: ServiceCategory.coach,
    description: 'Especialista en entrenamiento funcional y preparación para competencias fitness.',
    focusArea: 'Rendimiento deportivo y funcional',
    availability: 'Martes a Sábado: 9am - 2pm / 5pm - 7pm',
    imageUrl: 'https://via.placeholder.com/150/33FF57/FFFFFF?text=SR', // Placeholder
    availableSlots: {
      2: ['09:00', '10:00', '11:00', '12:00', '13:00', '17:00', '18:00'],
      3: ['09:00', '10:00', '11:00', '12:00', '13:00', '17:00', '18:00'],
      4: ['09:00', '10:00', '11:00', '12:00', '13:00', '17:00', '18:00'],
      5: ['09:00', '10:00', '11:00', '12:00', '13:00', '17:00', '18:00'],
      6: ['10:00', '11:00', '12:00'],
    },
  ),
  // Nutriólogos
  Professional(
    id: 'prof03',
    name: 'Dr. Alberto Pérez',
    category: ServiceCategory.nutriologo,
    description: 'Nutriólogo clínico enfocado en planes alimenticios personalizados para objetivos específicos.',
    focusArea: 'Nutrición deportiva y control de peso',
    availability: 'Lunes, Miércoles, Viernes: 10am - 6pm',
    imageUrl: 'https://via.placeholder.com/150/3357FF/FFFFFF?text=AP', // Placeholder
    availableSlots: {
      1: ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'],
      3: ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'],
      5: ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'],
    },
  ),
   Professional(
    id: 'prof04',
    name: 'Lic. Laura García',
    category: ServiceCategory.nutriologo,
    description: 'Asesora en nutrición holística y alimentación consciente.',
    focusArea: 'Bienestar general y dietas especiales',
    availability: 'Martes y Jueves: 8am - 3pm',
    imageUrl: 'https://via.placeholder.com/150/FF33A1/FFFFFF?text=LG', // Placeholder
    availableSlots: {
      2: ['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
      4: ['08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
    },
  ),
  // Masaje Deportivo
  Professional(
    id: 'prof05',
    name: 'Ricardo Torres',
    category: ServiceCategory.masaje,
    description: 'Terapeuta físico con especialización en masaje de tejido profundo y liberación miofascial.',
    focusArea: 'Recuperación muscular y prevención de lesiones',
    availability: 'Lunes a Jueves: 2pm - 9pm',
    imageUrl: 'https://via.placeholder.com/150/F1C40F/FFFFFF?text=RT', // Placeholder
    availableSlots: {
       1: ['14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'],
       2: ['14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'],
       3: ['14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'],
       4: ['14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'],
    },
  ),
   Professional(
    id: 'prof06',
    name: 'Elena Castillo',
    category: ServiceCategory.masaje,
    description: 'Especialista en masaje deportivo pre y post competencia, y técnicas de relajación.',
    focusArea: 'Optimización del rendimiento y relajación',
    availability: 'Viernes y Sábado: 11am - 7pm',
    imageUrl: 'https://via.placeholder.com/150/9B59B6/FFFFFF?text=EC', // Placeholder
    availableSlots: {
      5: ['11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00'],
      6: ['11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00'],
    },
  ),
];//d