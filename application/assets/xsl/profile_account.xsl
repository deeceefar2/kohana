<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>
<xsl:include href="snippets/states.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax != ''">
			<xsl:apply-templates select="/root/content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<xsl:call-template name="subnav_profile" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="expandableSection largeSectionWhite">
					<h4 class="sectionTitle">
						Change Password
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<div class="collapsible">
						<form id="passwordForm" class="passwordForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_password">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dl class="formSection">
								<!-- Username -->
								<dt class="floatLeft">
									<label>Username</label>
								</dt>
								<dd class="halfPageText darkGrayText floatLeft">
									<xsl:value-of select="/root/meta/user/username"/>
								</dd>
								<div class="clearer"></div>
								<xsl:if test="/root/meta/auth_forced!=1">
									<div class="halfPageForm floatLeft">
										<!-- Old Password -->
										<xsl:if test="errors/_external/current_password">
											<span class="formError floatLeft">
												<xsl:value-of select="errors/_external/current_password" />
											</span>
											<div class="clearer"></div>
										</xsl:if>
										<dt class="floatLeft">
											<label for="current_password">Current Password</label>
										</dt>
										<dd class="halfPageTextbox floatLeft">
											<input class="oldPassword" id="oldPassword" type="password" name="current_password" />
										</dd>
										<div class="clearer"></div>
									</div>
								</xsl:if>
								<div class="halfPageForm floatLeft">
									<!-- New Password -->
									<xsl:if test="errors/password">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/password" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="password">New Password</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="newPassword" id="newPassword" type="password" name="password" />
									</dd>
									<div class="clearer"></div>

									<!-- Confirm -->
									<xsl:if test="errors/_external/password_confirm">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/_external/password_confirm" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="password_confirm">Confirm Password</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="confirmPassword" id="password_confirm" type="password" name="password_confirm" />
									</dd>
									<div class="clearer"></div>

									<!-- Save -->
									<dt class="floatLeft"></dt>
									<dd class="formSubmit floatLeft">
										<input class="formButton floatRight" type="submit" name="_password" value="Save" />
									</dd>
									<div class="clearer"></div>
								</div>
								<div class="clearer"></div>
							</dl>
							<div class="clearer"></div>
						</form>
					</div>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="expandableSection largeSectionWhite">
					<h4 class="sectionTitle">
						Address
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<div class="collapsible">
						<form id="accountForm" class="accountForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_account">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dl class="formSection">
								<div class="halfPageForm floatLeft">
									<!-- First Name -->
									<xsl:if test="errors/user_first_name">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_first_name" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerFirstName">First Name</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerFirstName" id="registerFirstName" type="text" name="user_first_name" tabindex="5" value="{user/user_first_name}" />
									</dd>
									<div class="clearer"></div>

									<!-- Address 1 -->
									<xsl:if test="errors/user_address_street_1">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_address_street_1" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerAddress1">Address 1</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerAddress1" id="registerAddress1" type="text" name="user_address_street_1" tabindex="7" value="{user/user_address_street_1}" />
									</dd>
									<div class="clearer"></div>

									<!-- City -->
									<xsl:if test="errors/user_address_city">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_address_city" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerCity">City</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerCity" id="registerCity" type="text" name="user_address_city" tabindex="9" value="{user/user_address_city}" />
									</dd>
									<div class="clearer"></div>

									<!-- Zipcode -->
									<xsl:if test="errors/user_address_zip">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_address_zip" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerZipcode">Zip Code</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerZipcode" id="registerZipcode" type="text" name="user_address_zip" tabindex="11" value="{user/user_address_zip}" />
									</dd>
								</div>

								<div class="halfPageForm floatLeft">
									<!-- Last Name -->
									<xsl:if test="errors/user_last_name">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_last_name" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerLastName">Last Name</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerLastName" id="registerLastName" type="text" name="user_last_name" tabindex="6" value="{user/user_last_name}" />
									</dd>
									<div class="clearer"></div>

									<!-- Address 2 -->
									<xsl:if test="errors/user_address_street_2">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_address_street_2" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerAddress2">Address 2</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="registerAddress2" id="registerAddress2" type="text" name="user_address_street_2" tabindex="8" value="{user/user_address_street_2}" />
									</dd>
									<div class="clearer"></div>

									<!-- State -->
									<xsl:if test="errors/user_address_state">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/user_address_state" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="registerState">State</label>
									</dt>
									<dd class="halfPageSelect floatLeft">
										<select id="registerState" class="registerState" name="user_address_state" tabindex="10">
											<xsl:call-template name="states"/>
										</select>
									</dd>
									<div class="clearer"></div>

									<!-- Newsletter -->
									<xsl:if test="errors/register_newsletter">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/register_newsletter" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft"></dt>
									<dd class="halfPageCheckbox floatLeft">
										<input id="registerNewsletter" class="registerNewsletter" type="checkbox" name="registerNewsletter" value="Car" tabindex="11" /><label for="registerNewsletter">Subscribe Newsletter </label><a>[?]</a>
									</dd>
									<div class="clearer"></div>

									<!-- Save -->
									<dt class="floatLeft"></dt>
									<dd class="formSubmit floatLeft">
										<input class="formButton floatRight" type="submit" name="_account" value="Save" tabindex="12"/>
									</dd>
									<div class="clearer"></div>
								</div>
								<div class="clearer"></div>
							</dl>
						</form>
					</div>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
		<!--<xsl:call-template name="commented_out"/>-->
	</div>
</xsl:template>

<xsl:template name="commented_out">
		<div class="threeColumn">
			<div class="padding15All">
				<div class="expandableSection largeSectionWhite">
					<h4 class="sectionTitle">
						Payment Information
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<form class="accountForm" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection">
							<!-- Type -->
							<dt class="floatLeft">
								<label>Type</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								Credit Card
							</dd>
							<div class="clearer"></div>

							<!-- Card Number -->
							<dt class="floatLeft">
								<label>Card Number</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								**** **** **** 4278
							</dd>
							<div class="clearer"></div>

							<!-- Expiration -->
							<dt class="floatLeft">
								<label>Expiration</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								04/2015
							</dd>
							<div class="clearer"></div>

							<!-- Delete -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Delete" />
							</dd>
							<div class="clearer"></div>
						</dl>
						<div class="clearer"></div>
					</form>
				</div>
				<div class="expandableSection largeSectionWhite">
					<h4 class="sectionTitle">
						Billing Address
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<form class="accountForm" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection">
							<!-- First Name -->
							<dt class="floatLeft">
								<label>First Name</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								Adam
							</dd>
							<div class="clearer"></div>

							<!-- Last Name -->
							<dt class="floatLeft">
								<label>Last Name</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								West
							</dd>
							<div class="clearer"></div>

							<!-- Address -->
							<dt class="floatLeft">
								<label>Address</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								1500 South Road North
							</dd>
							<div class="clearer"></div>

							<!-- Address 2 -->
							<dt class="floatLeft">
								<label>Address 2</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								Suite 502
							</dd>
							<div class="clearer"></div>

							<!-- State -->
							<dt class="floatLeft">
								<label>State</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								Washington
							</dd>
							<div class="clearer"></div>

							<!-- City -->
							<dt class="floatLeft">
								<label>City</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								Seattle
							</dd>
							<div class="clearer"></div>

							<!-- Zipcode -->
							<dt class="floatLeft">
								<label>Zipcode</label>
							</dt>
							<dd class="halfPageText darkGrayText floatLeft">
								98188
							</dd>
							<div class="clearer"></div>


							<!-- Delete -->
							<dt class="floatRight"></dt>
							<dd class="formSubmit floatRight">
								<input class="formButton" type="submit" value="Delete" />
							</dd>
							<div class="clearer"></div>
						</dl>
						<div class="clearer"></div>
					</form>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>