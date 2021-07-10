import 'package:flutter/material.dart';
import './main_drawer.dart';

class FiltersScreem extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreem(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreemState createState() => _FiltersScreemState();
}

class _FiltersScreemState extends State<FiltersScreem> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactosefree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    
                      'gluten': _glutenFree,
                      'lactose': _lactosefree,
                      'vegan': _vegan,
                      'vegetarian': _vegetarian,
                    
                  };
                  widget.saveFilters(selectedFilters);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust Your Meal Selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                      'Gluten-free',
                      'Only include gluten-free meals',
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include Vegan meals', _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose-free',
                      'Only include Lactose-free meals',
                      _lactosefree, (newValue) {
                    setState(() {
                      _lactosefree = newValue;
                    });
                  }),
                  _buildSwitchListTile('Vegetarian',
                      'Only include Vegetarian meals', _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}
