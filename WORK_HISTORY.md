# Work History - VSP Development (Custom Fork)

## Objectif
Améliorer et corriger le pont ADT/MCP "VSP" (vibing-steampunk) pour mieux supporter les besoins spécifiques du workflow ABAP :
- Correction de la gestion des namespaces (objets en `/NAMESPACE/`).
- Amélioration de la gestion des classes de test (`testclasses` include).
- Résolution des problèmes de verrouillage (Status 423).

## Historique
- **2026-06-17** : 
    - Installation de Go 1.26.4 via winget.
    - Mise à jour de Git vers 2.54.
    - Création du fork GitHub : `https://github.com/pooyoukun/vibing-steampunk`.
    - Clonage local dans `G:\Mon Drive\Travail\SAP\gemini\vibing_steampunk`.
    - **Test de compilation** : Succès total du build de `cmd/vsp`. Environnement prêt pour le développement.
    - **Support des Includes (INCL)** :
        - Implémentation du workflow `CreateAndActivateInclude` dans `pkg/adt/workflows.go`.
        - Mise à jour de `WriteSource` pour supporter le type `INCL` (création et mise à jour).
        - Ajout de l'extension `.incl.abap` dans `pkg/adt/fileparser.go` pour supporter `ImportFromFile`.
        - Exposition du type `INCL` dans la définition de l'outil MCP (`internal/mcp/handlers_source.go`).
        - Compilation réussie du binaire personnalisé `vsp_custom.exe`.
    - **Gestion des Namespaces (Point 1)** :
        - Correction de `normalizeObjectURLForPackageCheck` dans `pkg/adt/client.go` : suppression du bug qui tronquait les noms d'objets contenant des slashes (Includes/Programmes).
        - Correction de `canonicalizeObjectURL` : ajout d'une normalisation des slashes (`//` -> `/`) pour fiabiliser la résolution du package via `SearchObject`.
        - Mise à jour de `routeSourceAction` dans `internal/mcp/handlers_source.go` pour supporter l'action `edit` sur les `INCL`.
        - Fiabilisation de `getObjectPackage` dans `pkg/adt/client.go` : ajout d'une stratégie de lecture directe des métadonnées via l'URL ADT (évite les échecs de `SearchObject` on namespaces).
        - Correction de `WriteSource` dans `pkg/adt/workflows_source.go` : construction préventive de l'URL de l'objet pour permettre la résolution du package par la "mutation gate" lors des mises à jour.
        - Correction du schéma JSON pour `SearchObject` et `GrepObjects` : encapsulation des résultats (tableaux) dans un objet `{"results": [...]}` pour satisfaire les attentes du client MCP.
        - Mise à jour des messages d'aide dans `internal/mcp/handlers_help.go` pour inclure `INCL`.
        - Compilation réussie du binaire `vsp_namespace_v3.exe`.
- **2026-06-22** :
    - **Compatibilité Windows et Tests Unitaires** :
        - Remplacement du driver SQLite CGO (`go-sqlite3`) par le driver 100% Go (`modernc.org/sqlite`) dans `pkg/cache/sqlite.go`, `cmd/vsp/audit_cache.go` et `go.mod` pour permettre la compilation et l'exécution des tests sur des environnements Windows sans compilateur GCC.
        - Correction des chemins temporaires `/tmp` écrits en dur dans `pkg/jseval/oracle_test.go` et `pkg/cache/example_test.go` pour utiliser `os.TempDir()` et garantir le support de Windows.
    - **Gestion Automatique du Transport SAP** :
        - Correction de l'erreur `Parameter corrNr could not be found` lors de l'édition d'includes transportables. Modification dans `pkg/adt/workflows_edit.go` et `pkg/adt/workflows.go` pour récupérer le numéro de transport retourné par le verrouillage ADT (`lock.CorrNr`) et l'injecter automatiquement si aucun transport n'est fourni.
    - **Sécurité CLI par défaut** :
        - Activation par défaut de `AllowTransportableEdits` et `EnableTransports` dans `UnrestrictedSafetyConfig` (`pkg/adt/safety.go`) afin de permettre les modifications d'objets transportables via la CLI sans blocage de sécurité préalable.
    - **Compilation et Tests** :
        - Compilation réussie du binaire `vsp_test.exe` et passage complet de tous les tests unitaires via `go test ./...` sous Windows.

