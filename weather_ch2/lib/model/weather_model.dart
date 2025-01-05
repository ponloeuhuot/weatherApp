class Weather{
 final String cityName;
 final double temperature;
 final String mainCondition;


 Weather({
   required this.cityName,
   required this.mainCondition,
   required this.temperature,
});

 factory Weather.fromJson(Map<String, dynamic> json){
   return Weather(
       cityName: json['name'],
       mainCondition: json['main'] ['temp'].toDouble(),
       temperature: json['weather'] [0] ['main'],
   );
 }
}