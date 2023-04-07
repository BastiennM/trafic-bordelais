double westBound = -0.8835;
double eastBound = -0.44377;
double southBound = 44.730085;
double northBound = 44.837789;

bool isInSquare(double lon, double lat) { //Here to check if the searched address is in area of bordeaux API response
  return lon >= westBound && lon <= eastBound && lat >= southBound && lat <= northBound;
}
