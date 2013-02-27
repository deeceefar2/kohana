<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax=1">
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
						<xsl:text>Emergency Contacts</xsl:text>
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<dl class="formSection collapsible">
						<form method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_object='contact'">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf and /root/meta/post/_object='contact'">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden" value="{/root/meta/csrf}" />
							<input type="hidden" name="_object" value="contact" />
							<input type="hidden" name="_object_id" value="{contact/contact_id}" />
							<div class="halfPageForm floatLeft">
								<!-- First Name -->
								<xsl:if test="errors/contact_first_name">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_first_name" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_first_name">First Name</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencyFirstName" id="emergencyFirstName" type="text" name="contact_first_name" value="{contact/contact_first_name}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Last Name -->
								<xsl:if test="errors/contact_last_name">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_last_name" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_last_name">Last Name</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencyLastName" id="emergencyLastName" type="text" name="contact_last_name" value="{contact/contact_last_name}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Relationship -->
								<xsl:if test="errors/contact_relationship">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_relationship" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_relationship">Relationship</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencyRelationship" id="emergencyRelationship" type="text" name="contact_relationship" value="{contact/contact_relationship}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Primary Phone -->
								<xsl:if test="errors/contact_phone_1">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_phone_1" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_phone_1">Primary Phone</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencyPrimaryPhone" id="emergencyPrimaryPhone" type="text" name="contact_phone_1" value="{contact/contact_phone_1}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Secondary Phone -->
								<xsl:if test="errors/contact_phone_2">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_phone_2" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_phone_2">Secondary Phone</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencySecondaryPhone" id="emergencySecondaryPhone" type="text" name="contact_phone_2" value="{contact/contact_phone_2}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Email -->
								<xsl:if test="errors/contact_email">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/contact_email" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="contact_email">Email</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="emergencyEmail" id="emergencyEmail" type="text" name="contact_email" value="{contact/contact_email}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Save -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Save" />
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<form method="get">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input type="hidden" name="_object" value="contact" />
							<div class="halfPageForm floatLeft">
								<dd class="halfPageSelectbox floatRight">
									<select class="floatRight" name="_object_id" size="10">
										<xsl:apply-templates select="contacts/contact"/>
									</select>
									<div class="listManipulation floatRight">
										<input type="submit" name="_edit" value="1" class="editListItem" />
										<input type="submit" name="_delete" value="1" class="removeListItem" />
									</div>
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<div class="clearer"></div>
					</dl>
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
						Medical History
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<dl class="formSection collapsible">
						<form class="profileForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_object='procedure'">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf and /root/meta/post/_object='procedure'">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden" value="{/root/meta/csrf}" />
							<input type="hidden" name="_object" value="procedure" />
							<input type="hidden" name="_object_id" value="{procedure/procedure_id}" />
							<div class="halfPageForm floatLeft">
								<!-- Procedure -->
								<xsl:if test="errors/procedure_name">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/procedure_name" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="procedure_name">Procedure</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="historyProcedure" id="historyProcedure" type="text" name="procedure_name" value="{procedure/procedure_name}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Date -->
								<script type="text/javascript">
									<xsl:comment>
									$(document).ready(function() {
										$('input[name=procedure_date]').datepicker({
											changeYear: true,
											changeMonth: true
										});
									});
									//</xsl:comment>
								</script>
								<xsl:if test="errors/procedure_date">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/procedure_date" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="procedure_date">Date</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input type="text" name="procedure_date" class="historyProcedure" value="{procedure/procedure_date}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Hospital -->
								<xsl:if test="errors/procedure_hospital">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/procedure_hospital" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="procedure_hospital">Hospital</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="historyHospital" id="historyHospital" type="text" name="procedure_hospital" value="{procedure/procedure_hospital}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Physician -->
								<xsl:if test="errors/procedure_physician">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/procedure_physician" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="procedure_physician">Physician</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="historyProcedure" id="historyProcedure" type="text" name="procedure_physician" value="{procedure/procedure_physician}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Save -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Save" />
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<form method="get">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input type="hidden" name="_object" value="procedure" />
							<div class="halfPageForm floatLeft">
								<dd class="halfPageSelectbox floatRight">
									<select class="floatRight" name="_object_id" size="10">
										<xsl:apply-templates select="procedures/procedure"/>
									</select>
									<div class="listManipulation floatRight">
										<input type="submit" name="_edit" value="1" class="editListItem" />
										<input type="submit" name="_delete" value="1" class="removeListItem" />
									</div>
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<div class="clearer"></div>
					</dl>
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
						Medication
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<dl class="formSection collapsible">
						<form class="profileForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_object='medication'">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf and /root/meta/post/_object='medication'">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden" value="{/root/meta/csrf}" />
							<input type="hidden" name="_object" value="medication" />
							<input type="hidden" name="_object_id" value="{medication/medication_id}" />
							<div class="halfPageForm floatLeft">
								<!-- Medication -->
								<xsl:if test="errors/medication_name">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/medication_name" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="medication_name">Medication Name</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="medicationMedication" type="text" name="medication_name" value="{medication/medication_name}" />
								</dd>
								<div class="clearer"></div>

								<!-- Condition Used For -->
								<xsl:if test="errors/medication_condition">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/medication_condition" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="medication_condition">Condition Used For</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="medicationCondition" type="text" name="medication_condition" value="{medication/medication_condition}" />
								</dd>
								<div class="clearer"></div>

								<!-- Date -->
								<script type="text/javascript">
									<xsl:comment>
									$(document).ready(function() {
										$('input[name=medication_start_date]').datepicker({
											changeYear: true,
											changeMonth: true
										});
									});
									//</xsl:comment>
								</script>
								<xsl:if test="errors/medication_start_date">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/medication_start_date" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="medication_start_date">Start Date</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input type="text" class="medicationDosage" name="medication_start_date" value="{medication/medication_start_date}"/>
								</dd>
								<div class="clearer"></div>

								<!-- Dosage -->
								<xsl:if test="errors/medication_dose">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/medication_dose" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="medication_dose">Dosage</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="medicationDosage" id="medicationDosage" type="text" name="medication_dose" value="{medication/medication_dose}" />
								</dd>

								<!-- Save -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Save" />
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<form method="get">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input type="hidden" name="_object" value="medication" />
							<div class="halfPageForm floatLeft">
								<dd class="halfPageSelectbox floatRight">
									<select class="floatRight" name="_object_id" size="10">
										<xsl:apply-templates select="medications/medication"/>
									</select>
									<div class="listManipulation floatRight">
										<input type="submit" name="_edit" value="1" class="editListItem" />
										<input type="submit" name="_delete" value="1" class="removeListItem" />
									</div>
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
					</dl>
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
						Allergies
						<span class="expandHideIndividualSection">
							<div class="plusSmallBlue" style="display: none;"></div>
							<div class="minusSmallBlue"></div>
						</span>
					</h4>
					<dl class="formSection collapsible">
						<form class="profileForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="errors and /root/meta/post/_object='allergy'">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
								<div class="clearer"></div>
							</xsl:if>
							<xsl:if test="errors/_external/csrf and /root/meta/post/_object='allergy'">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden" value="{/root/meta/csrf}" />
							<input type="hidden" name="_object" value="allergy" />
							<input type="hidden" name="_object_id" value="{allergy/allergy_id}" />
							<div class="halfPageForm floatLeft">
								<!-- Allergy -->
								<xsl:if test="errors/allergy_name">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/allergy_name" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="allergy_name">Allergy Name</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="allergy" type="text" name="allergy_name" value="{allergy/allergy_name}" />
								</dd>
								<div class="clearer"></div>

								<!-- Medication -->
								<xsl:if test="errors/allergy_medication">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/allergy_medication" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="allergy_medication">Medication</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="allergiesMedication" type="text" name="allergy_medication" value="{allergy/allergy_medication}" />
								</dd>
								<div class="clearer"></div>



								<!-- Save -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Save" />
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<form method="get">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input type="hidden" name="_object" value="allergy" />
							<div class="halfPageForm floatLeft">
								<dd class="halfPageSelectbox floatRight">
									<select class="floatRight" name="_object_id" size="10">
										<xsl:apply-templates select="allergies/allergy"/>
									</select>
									<div class="listManipulation floatRight">
										<input type="submit" name="_edit" value="1" class="editListItem" />
										<input type="submit" name="_delete" value="1" class="removeListItem" />
									</div>
								</dd>
								<div class="clearer"></div>
							</div>
						</form>
						<div class="clearer"></div>
					</dl>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="contact">
	<option value="{contact_id}">
		<xsl:value-of select="contact_last_name"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="contact_first_name"/>
	</option>
</xsl:template>

<xsl:template match="procedure">
	<option value="{procedure_id}">
		<xsl:value-of select="procedure_name"/>
	</option>
</xsl:template>

<xsl:template match="medication">
	<option value="{medication_id}">
		<xsl:value-of select="medication_name"/>
	</option>
</xsl:template>

<xsl:template match="allergy">
	<option value="{allergy_id}">
		<xsl:value-of select="allergy_name"/>
	</option>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>