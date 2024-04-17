#importing necessary libraries
import streamlit as st
import pandas as pd
from ucimlrepo import fetch_ucirepo 


from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay, classification_report
from sklearn.ensemble import RandomForestClassifier
import seaborn as sns
import matplotlib.pyplot as plt

  
# fetch dataset 
wine_quality = fetch_ucirepo(id=186) 
df = wine_quality.data.original




#title 
st.title('Wine Quality Viewer')

#creating and naming the tabs of page
tab1, tab2, tab3, tab4, tab5, tab6, tab7 = st.tabs(['Metadata', 'Data', 'Color', 'Quality', 'Scatter', 'Box', 'Classification'])
with tab1:
    st.header('Metadata')
    st.write(wine_quality.variables)
    


with tab2: 
    st.header('Dataset Viewer')
    #radio buttons to display different selections of the dataset
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
    wine_type_counts = df['color'].value_counts()
    fig, ax = plt.subplots()
    wine_type_counts.plot(kind='bar', ax=ax)
    ax.set_xlabel('Wine Color')
    ax.set_ylabel('Number of Wines')
    ax.set_title('Count by Wine Type')  
    st.pyplot(fig)

with tab4:
    st.header('Quality Distribution')
    fig, ax= plt.subplots()
    quality_range = range(3,10)
    wine_quality_counts = df['quality'].value_counts().reindex(quality_range)
    wine_quality_counts.plot(kind='bar', ax=ax)
    ax.set_xlabel('Quality Rating')
    ax.set_ylabel('Number of Wines')
    st.pyplot(fig)
   
 

with tab5:
    st.header('Scatter Plots')
    variables = [
        'fixed_acidity', 'volatile_acidity', 'citric_acid', 'residual_sugar',
        'chlorides', 'free_sulfur_dioxide', 'total_sulfur_dioxide', 'density',
        'pH', 'sulphates', 'alcohol'
    ]
    #using a for loop to iterate through variables and create a separate checkbox
    selected_options = {variable: False for variable in variables}
    for variable in variables:
        if st.checkbox(variable):
            selected_options[variable] = True
    
    #checking which items are selected and creating plot
    selected_variables = [variable for variable, selected in selected_options.items() if selected]
    if len(selected_variables) == 2:
        fig, ax = plt.subplots()
        ax.scatter(df[selected_variables[0]], df[selected_variables[1]])
        ax.set_xlabel(selected_variables[0])
        ax.set_ylabel(selected_variables[1])
        ax.set_title(f"Scatter Plot of {selected_variables[0]} vs {selected_variables[1]}")
        st.pyplot(fig)
    else:
        st.error('Please select exactly two variables for the scatterplot.')



with tab6: 
    st.header('Box Plots')
    st.write('Choose which box plot to display')
    #radio buttons that determine which column to plot
    columns = st.radio('Choose column to plot', ['fixed_acidity', 'volatile_acidity', 'citric_acid',
                                                   'residual_sugar', 'chlorides', 'free_sulfur_dioxide',
                                                     'total_sulfur', 'density', 'pH',
                                                       'sulphates', 'alcohol'], index = None)
    plt.figure(figsize=(8, 6))
    #boxplot created by accessing currently selected radio button
    sns.boxplot(data=df, y=columns, orient='v')
    st.pyplot(plt)
    
       

with tab7:
    st.header('Classification')
    st.write('Classification Report')
    
    #random forest model
    X = wine_quality.data.features 
    y = wine_quality.data.targets 
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=1)
    classifier = RandomForestClassifier()
    classifier.fit(X_train.values, y_train.values.ravel())
    y_pred = classifier.predict(X_test.values)
    #creating the report and converting it to table format
    report = classification_report(y_test, y_pred,output_dict=True)
    report_df = pd.DataFrame(report).transpose()
    st.dataframe(report_df, width=1000)


    #feature importance
    st.write('Feature Importance')
    importances = classifier.feature_importances_
    plt.figure(figsize=(10, 6))
    feature_names = X.columns
    plt.bar(feature_names, importances, align='center')
    plt.xticks(rotation=90)
    plt.title('Feature Importances')
    st.pyplot(plt)


    
    




   
   













