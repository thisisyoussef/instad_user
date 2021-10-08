import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenueFilters extends ChangeNotifier {
  String _area = "Tagamoa";
  List<String> _areas = [];
  List<String> _unappliedAreas = [];
  List<String> _selectedAreas = [];

  DateTime _startDate = DateTime(2021);
  DateTime _selectedStartDate = DateTime(2021);
  DateTime _unappliedStartDate = DateTime(2021);

  DateTime _startTime = DateTime(2021);
  DateTime _selectedStartTime = DateTime(2021);
  DateTime _unappliedStartTime = DateTime(2021);

  DateTime _endTime = DateTime(2021);
  DateTime _selectedEndTime = DateTime(2021);
  DateTime _unappliedEndTime = DateTime(2021);

  DateTime _endDate = DateTime(2022);
  String _sport = "Football";
  int _distanceFromUser = 0;
  int _maxPrice = 400;
  List<String> _amenities;
  double _rating = 6.0;
  String _selectedArea = "Tagamoa";
  DateTime _selectedEndDate = DateTime(2022);
  String _selectedSport = "Football";
  int _selecteDistanceFromUser = 0;
  int _selectedMaxPrice = 400;
  List<String> _selectedAmenities;
  double _selectedRating = 6.0;
  String _unappliedArea = "Tagamoa";
  DateTime _unappliedEndDate = DateTime(2022);
  int _unappliedDistanceFromUser = 0;
  String _unappliedSport = "Football";
  int _unappliedMaxPrice = 400;
  List<String> _unappliedAmenities;
  double _unappliedRating = 6.0;
  void reset() {
    _startTime = DateTime(2021);
    _selectedStartTime = DateTime(2021);
    _endTime = DateTime(2021);
    _selectedEndTime = DateTime(2021);
    _selectedAreas = [];
    _areas = [];
    _startDate = DateTime(2021);
    _selectedStartDate = DateTime(2021);
    _sport = "";
    _selectedSport = "";
    _unappliedSport = "";
    _distanceFromUser = null;
    _maxPrice = 750;
    _selectedMaxPrice = 750;
    _amenities = [];
    _rating = 5;
    notifyListeners();
  }

  void applyFilters() {
    _areas = List.from(_selectedAreas);
    _startDate = _selectedStartDate;
    _endDate = _selectedEndDate;
    _sport = _selectedSport;
    _distanceFromUser = _selecteDistanceFromUser;
    _maxPrice = _selectedMaxPrice;
    _amenities = _selectedAmenities;
    _rating = _selectedRating;
    notifyListeners();
  }

  bool inAreas(String stage, String area) {
    if (stage == "Unapplied" && _unappliedAreas.isNotEmpty) {
      return _unappliedAreas.contains(area);
    } else if (stage == "Selected" && _selectedAreas.isNotEmpty) {
      return _selectedAreas.contains(area);
    } else if (stage == "Applied" && _areas.isNotEmpty) {
      return _areas.contains(area);
    } else {
      return false;
    }
  }

  void addToAreas(String stage, String area) {
    if (stage == "Unapplied") {
      _unappliedAreas.add(area);
    } else if (stage == "Selected") {
      _selectedAreas.add(area);
    } else if (stage == "Applied") {
      _areas.add(area);
    }
    notifyListeners();
  }

  void removeFromAreas(String stage, String area) {
    if (stage == "Unapplied") {
      _unappliedAreas.remove(area);
    } else if (stage == "Selected") {
      _selectedAreas.remove(area);
    } else if (stage == "Applied") {
      _areas.remove(area);
    }
    notifyListeners();
  }

  void updateAreas(String stage) {
    if (stage == "Unapplied") {
      _selectedAreas = List.from(_unappliedAreas);
      //_unappliedAreas.clear();
      print("Selected Areas: " + _selectedAreas.toString());
      notifyListeners();
    } else if (stage == "Selected") {
      _areas = List.from(_selectedAreas);
      //_selectedAreas.clear();
      print("Applied Areas: " + _selectedAreas.toString());
      notifyListeners();
    }
  }

  String getAreas(String stage) {
    if (stage == "Unapplied") {
      return _unappliedAreas
          .toString()
          .substring(1, _selectedAreas.toString().length - 1);
    } else if (stage == "Selected") {
      return _selectedAreas
          .toString()
          .substring(1, _selectedAreas.toString().length - 1);
    } else if (stage == "Applied") {
      return _areas.toString().substring(1, _areas.toString().length - 1);
    }
  }

  void setMaxPrice(String stage, int newPrice) {
    if (stage == "Unapplied") {
      _unappliedMaxPrice = newPrice;
    } else if (stage == "Selected") {
      _selectedMaxPrice = newPrice;
    } else if (stage == "Applied") {
      _maxPrice = newPrice;
    }
    notifyListeners();
  }

  String getArea() {
    return _area;
  }

  String getSport() {
    return _sport;
  }

  DateTime getDate(String stage) {
    if (stage == "Unapplied") {
      return _unappliedStartDate;
    } else if (stage == "Selected") {
      return _selectedStartDate;
    } else if (stage == "Applied") {
      return _startDate;
    }
    return null;
  }

  void setDate(String stage, DateTime newDate) {
    if (stage == "Unapplied") {
      _unappliedStartDate = newDate;
    } else if (stage == "Selected") {
      _selectedStartDate = newDate;
    } else if (stage == "Applied") {
      _startDate = newDate;
    }
    notifyListeners();
  }

  DateTime getStartTime(String stage) {
    if (stage == "Unapplied") {
      return _unappliedStartTime;
    } else if (stage == "Selected") {
      return _selectedStartTime;
    } else if (stage == "Applied") {
      return _startTime;
    }
    return null;
  }

  void setStartTime(String stage, DateTime newTime) {
    if (stage == "Unapplied") {
      _unappliedStartTime = newTime;
    } else if (stage == "Selected") {
      _selectedStartTime = newTime;
    } else if (stage == "Applied") {
      _startTime = newTime;
    }
    notifyListeners();
  }

  DateTime getEndTime(String stage) {
    if (stage == "Unapplied") {
      return _unappliedEndTime;
    } else if (stage == "Selected") {
      return _selectedEndTime;
    } else if (stage == "Applied") {
      return _endTime;
    }
    return null;
  }

  void setEndTime(String stage, DateTime newTime) {
    if (stage == "Unapplied") {
      _unappliedEndTime = newTime;
    } else if (stage == "Selected") {
      _selectedEndTime = newTime;
    } else if (stage == "Applied") {
      _endTime = newTime;
    }
    notifyListeners();
  }

  List<String> getAmenities() {
    return _amenities;
  }

  double getRating() {
    return _rating;
  }

  int getMaxPrice(String stage) {
    if (stage == "Unapplied") {
      return _unappliedMaxPrice;
    } else if (stage == "Selected") {
      return _selectedMaxPrice;
    } else if (stage == "Applied") {
      return _maxPrice;
    }
  }

  void get() {
    return;
  }

  String setSport(String sport) {
    _sport = sport;
    notifyListeners();
  }

  String setUnappliedSport(String sport) {
    _unappliedSport = sport;
    notifyListeners();
  }

  String getUnappliedSport() {
    return _unappliedSport;
  }

  String setSelectedSport(String sport) {
    _selectedSport = sport;
    notifyListeners();
  }

  String getSelectedSport() {
    return _selectedSport;
  }
}
