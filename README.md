# Projet_Signature_signaux

Le principal objectif de ce projet est d’extraire des signatures afin de caractériser le signal et
de détecter pour quelles fréquences la puissance est importante. Cela permet de repérer quelles
fréquences dominent le signal, et celles peu intéressantes dans le but de désigner de meilleurs
filtres. Différentes méthodes d’analyse spectrale existent comme la méthode des sous-espaces
bruit/signal, la projection sur une exponentielle complexe par le calcul d’une transformée de
Fourier, la méthode de Capon utilisant un filtre spécifique très sélectif, mais aussi l’utilisation de
périodogrammes et de spectrogrammes. Dans ce projet, nous nous sommes intéressés en premier
lieu, à l’implémentation de périodogrammes de différentes natures afin d’estimer la densité spectrale de puissance du signal reçu, puis à l’implémentation de la méthode de Capon permettant d’obtenir le spectre de puissance du signal dans une certaine bande de fréquence que l’on choisit.
Les tests ont été effectués pour différents signaux classiques : bruit blanc gaussien centré, cosinus
bruité, processus auto-régressif et processus à moyenne ajustée .
