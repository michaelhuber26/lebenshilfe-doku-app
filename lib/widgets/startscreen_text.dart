import 'package:flutter/material.dart';

// widget used in startscreen to display the text
var startScreenText1 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
          text: "Hallo und Willkommen bei der Dokumentation.\n",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "Warum braucht es die Dokumentation?\n",
      ),
      TextSpan(
        text: "Die Dokumentation ist ein Hilfsmittel.",
      ),
    ],
  ),
);

var startScreenText2 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: "Es beschreibt die ",
      ),
      TextSpan(
          text: "Unterstützung ",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "für eine Person.\n",
      ),
      TextSpan(
        text: "Es unterstützt ",
      ),
      TextSpan(
          text: "Wünsche ",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "zu beschreiben.\n",
      ),
      TextSpan(
        text: "Es unterstützt bei der Beschreibung „",
      ),
      TextSpan(
          text: "Was kann die Person machen",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "“.\n",
      ),
      TextSpan(
        text: "Es unterstützt bei der ",
      ),
      TextSpan(
          text: "Teilhabe",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: ". Teilhabe ist, was man gemeinsam mit anderen macht.\n",
      ),
      TextSpan(
        text: "Damit kann man besser erkennen, welche Sachen wichtig sind.",
      ),
    ],
  ),
);

var startScreenText3 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text:
            "Die Dokumentation beschreibt auch welche Hilfen eine Person braucht.\n",
      ),
      TextSpan(
        text: "z.B. Hilfe beim Gehen (Rollstuhl oder Rollator)",
      ),
    ],
  ),
);

var startScreenText4 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: "z.B. Hilfen für den ",
      ),
      TextSpan(
          text: "Austausch ",
          style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "mit anderen Menschen.",
      ),
    ],
  ),
);

var startScreenText5 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: "Der ",
      ),
      TextSpan(
          text: "Stern ", style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(
        text: "beschreibt, ob es besonders wichtig ist.",
      ),
    ],
  ),
);

var startScreenText6 = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: "Wenn du möchtest, kannst du starten. ",
      ),
    ],
  ),
);
