import streamlit as st
import pandas as pd
from ucimlrepo import fetch_ucirepo 
  
# fetch dataset 
wine_quality = fetch_ucirepo(id=186) 
df = wine_quality.data.original


X = wine_quality.data.features 
y = wine_quality.data.targets 

#Page title
st.title('Wine Quality Viewer')

tab1, tab2, tab3, tab4, tab5, tab6, tab7 = st.tabs(['Metadata', 'Data', 'Color', 'Quality', 'Scatter', 'Box', 'Classification'])
with tab1:
    st.header('Metadata')
    st.write(wine_quality.variables)
    


with tab2: 
    st.header('Dataset Viewer')
    columns = st.radio('Choose Dataset View:', ['Chemical', 'Alcohol', 'Quality', 'All'])
    if columns == 'Chemical':
        st.write(df[['color', 'fixed_acidity', 'volatile_acidity', 'citric_acid', 'chlorides',
                    'free_sulfur_dioxide', 'density', 'pH', 'sulphates']])
    elif columns == 'Alcohol':
        st.write(df[['color', 'alcohol']])
    elif columns == 'Quality':
        st.write(df[['color', 'quality']])
    else: 
        st.write(df)

    
with tab3:
    st.header('Color Distribution')

with tab4:
    st.header('Quality Distribution')

with tab5:
    st.header('Scatter Plots')
    check_1 = st.checkbox('fixed_acidity')
    check_2 = st.checkbox('volatile_acidity')
    check_3 = st.checkbox('citric_acid')
    check_4 = st.checkbox('residual_sugar')
    check_5 = st.checkbox('chlorides')
    check_6 = st.checkbox('free_sulfur_dioxide')
    check_7 = st.checkbox('total_sulfur')
    check_8 = st.checkbox('density')
    check_9 = st.checkbox('pH')
    check_10 = st.checkbox('sulphates')
    check_11 = st.checkbox('alcohol')

with tab6: 
    st.header('Box Plots')
    st.write('Choose which box plot to display')
    columns = st.radio('Choose column to plot', ['fixed_acidity', 'volatile_acidity', 'citric_acid',
                                                   'residual_sugar', 'chlorides', 'free_sulfur_dioxide',
                                                     'total_sulfur', 'density', 'pH',
                                                       'sulphates', 'alcohol'], index = None)


with tab7:
    st.header('Classification')
    st.write('Classification Report')
   
   

# data (as pandas dataframes) 
X = wine_quality.data.features 
y = wine_quality.data.targets 
  











