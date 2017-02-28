__author__ = 'vmintam'
from selenium import webdriver
from selenium.webdriver import DesiredCapabilities

#create webpage
desired_capabilities = DesiredCapabilities.PHANTOMJS.copy()
desired_capabilities['phantomjs.page.customHeaders.msisdn'] = '84936315768'
driver = webdriver.PhantomJS(desired_capabilities=desired_capabilities)

driver.set_window_size(1120, 550)
driver.get("http://phongthuynguhanh.com.vn/site/register.html")
main_window = driver.current_window_handle

# driver.find_element_by_css_selector(".action >a").click()
driver.find_elements_by_xpath("(//div[@class=\"action\"])/a")[1].click()
# (//div[@class="action"])[2]/a
print(driver.current_url)

#process after click
driver.switch_to.window(main_window)
print(driver.current_url)
# driver.get(driver.current_url)
# print(driver.get_log("client"))
# driver.find_element_by_css_selector(".text-right >a").click()
driver.find_element_by_css_selector(".text-left >a").click()
print(driver.current_url)
driver.quit()