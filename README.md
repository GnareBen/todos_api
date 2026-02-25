# 📝 Todos API – Flutter Clean Architecture

Une application Flutter de gestion de tâches (*todos*) construite avec les principes de la **Clean Architecture** et le pattern de gestion d'état **BLoC**. Les données proviennent de l'API publique [JSONPlaceholder](https://jsonplaceholder.typicode.com).

---

## ✨ Fonctionnalités

- 📋 Affichage de la liste des todos récupérés depuis une API REST
- ✅ Indicateur visuel du statut de complétion de chaque tâche
- ⚡ Gestion d'état réactive avec `flutter_bloc`
- 🌐 Appels HTTP robustes via `Dio` avec gestion des erreurs réseau
- 💉 Injection de dépendances légère avec `get_it`
- 🧱 Architecture découplée et testable (Clean Architecture)

---

## 🏗️ Architecture

Le projet suit les principes de la **Clean Architecture** organisée en couches indépendantes :

```
lib/
├── core/
│   ├── error/          # Classes d'erreurs (Failure)
│   ├── network/        # Client HTTP (DioClient)
│   └── usecase/        # Classe de base UseCase
└── feature/
    └── todo/
        ├── data/
        │   ├── datasources/    # Sources de données distantes (API)
        │   ├── models/         # Modèles JSON (TodoModel)
        │   └── repositories/  # Implémentation des repositories
        ├── domain/
        │   ├── entities/       # Entités métier (Todo)
        │   ├── repositories/   # Contrats abstraits des repositories
        │   └── usecase/        # Cas d'utilisation (GetTodos)
        └── presentation/
            ├── bloc/           # TodoBloc, TodoEvent, TodoState
            └── pages/          # UI (TodoPage, TodoCard)
```

### Flux de données

```
API (JSONPlaceholder)
  └─▶ TodoRemoteDataSource
        └─▶ TodoRepositoryImpl
              └─▶ GetTodos (UseCase)
                    └─▶ TodoBloc
                          └─▶ TodoPage (UI)
```

---

## 📦 Dépendances principales

| Package         | Rôle                                      |
|-----------------|-------------------------------------------|
| `flutter_bloc`  | Gestion d'état (pattern BLoC)             |
| `bloc`          | Bibliothèque BLoC core                    |
| `dio`           | Client HTTP avec intercepteurs            |
| `get_it`        | Service Locator / Injection de dépendances|
| `dartz`         | Programmation fonctionnelle (`Either`)    |
| `equatable`     | Comparaison d'objets simplifiée           |

---

## 🌐 API

L'application consomme l'API publique [JSONPlaceholder](https://jsonplaceholder.typicode.com).

| Endpoint   | Méthode | Description              |
|------------|---------|--------------------------|
| `/todos`   | `GET`   | Récupère tous les todos  |

**Modèle Todo :**
```json
{
  "id": 1,
  "title": "delectus aut autem",
  "completed": false
}
```

---

## 🚀 Lancer le projet

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.11.0
- Dart SDK `^3.11.0`

### Installation

```bash
# Cloner le dépôt
git clone <url-du-repo>
cd todos_api

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

---

## 🧪 Tests

```bash
flutter test
```

---

## 📁 Structure des fichiers clés

| Fichier | Rôle |
|---|---|
| `lib/main.dart` | Point d'entrée, injection de dépendances (`get_it`) |
| `lib/core/network/dio_client.dart` | Configuration de Dio (baseUrl, timeouts, intercepteurs) |
| `lib/feature/todo/domain/entities/todo.dart` | Entité `Todo` (id, title, completed) |
| `lib/feature/todo/presentation/bloc/todo_bloc.dart` | Logique BLoC : `FetchTodosEvent` → `TodoLoaded` / `TodoError` |
| `lib/feature/todo/presentation/pages/todo_page.dart` | Page principale de l'application |

---

## 🛠️ Ressources Flutter

- [Documentation Flutter](https://docs.flutter.dev/)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [Dio](https://pub.dev/packages/dio)
- [get_it](https://pub.dev/packages/get_it)
- [dartz](https://pub.dev/packages/dartz)
