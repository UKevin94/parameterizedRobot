Prerequisites :
pip install --upgrade robotframework-seleniumlibrary
pip install --upgrade RESTinstance
pip install -U robotframework-databaselibrary
pip install psycopg2
jacksonviews + postgres db (http://repo.squashtest.org/acceptance/jackson_image.tar) docker-compose -f docker/app.yml up -d

Instructions :
1. Update the host address in resources/api.robot, resources/database.robot, resources/selenium.robot
2. robot main.robot
3. Profit

Overview :

This test will inject data in the jac_contact table.
The API will then be used to check if the injected data are present.
We'll then use selenium to delete them.
We use the test template setting to iterate 4 times with different cases. (Standard, Special characters, without lastname, without firstname)
No custom libraries are used.