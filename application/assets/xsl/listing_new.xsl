<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>
<xsl:include href="snippets/field_processor.xsl"/>
<xsl:include href="snippets/categories_form.xsl"/>
<xsl:include href="snippets/states.xsl" />

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
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<h5>Create Listing</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<form class="createListingForm" method="post">
			<xsl:attribute name="action">
				<xsl:value-of select="/root/meta/url"/>
			</xsl:attribute>
			<input name="csrf" type="hidden">
				<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
			</input>
			<input type="hidden" name="listing_default_category_id" value="07AD488C-E2A2-11E0-AD7D-1231380C1570"/>
			<div class="oneColumn floatLeft">
				<xsl:apply-templates select="categories"/>
			</div>
			<div class="twoColumn floatRight">
				<div class="padding15All">
					<div class="address largeSectionWhite">
						<dl class="formSection">
							<h4>Basic Information</h4>

							<!-- Type -->
							<xsl:if test="errors/type_id">
								<div class="clearer"></div>
								<span class="formError floatLeft">
									<xsl:value-of select="errors/type_id" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="selectType">Type</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="type_id" name="type_id" tabindex="1">
									<option value="">Select a Type</option>
									<xsl:apply-templates select="types/type">
										<xsl:with-param name="selected" select="/root/meta/post/type_id"/>
									</xsl:apply-templates>
								</select>
							</dd>

							<!-- Default Category -->
							<xsl:if test="errors/listing_default_category_id">
								<div class="clearer"></div>
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_default_category_id" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_default_category_id">Default Category</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="listing_default_category_id" name="listing_default_category_id" tabindex="1">
									<option value="">Select a Default Category</option>
									<xsl:apply-templates select="categories/category[parent_id=0]" mode="default_category">
										<xsl:with-param name="selected" select="/root/meta/post/listing_default_category_id"/>
									</xsl:apply-templates>
								</select>
							</dd>


							<!-- Name -->
							<xsl:if test="errors/listing_name">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_name" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_name">Name</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_name" id="listing_name" type="text" name="listing_name" value="{/root/meta/post/listing_name}" tabindex="2" />
							</dd>
							<div class="clearer"></div>

							<!-- Email -->
							<xsl:if test="errors/listing_email">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_email" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_email">Email</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_email" id="listing_email" type="text" name="listing_email" value="{/root/meta/post/listing_email}" tabindex="3" />
							</dd>
							<div class="clearer"></div>

							<!-- Website -->
							<xsl:if test="errors/listing_website">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_website" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_website">Website</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_website" id="listing_website" type="text" name="listing_website" value="{/root/meta/post/listing_website}" tabindex="4" />
							</dd>
							<div class="clearer"></div>

							<!-- Phone -->
							<xsl:if test="errors/listing_phone">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_phone" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_phone">Phone</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_phone" id="listing_phone" type="text" name="listing_phone" value="{/root/meta/post/listing_phone}" tabindex="5" />
							</dd>
							<div class="clearer"></div>

							<!-- Fax -->
							<xsl:if test="errors/listing_fax">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_fax" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_fax">Fax</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_fax" id="listing_fax" type="text" name="listing_fax" value="{/root/meta/post/listing_fax}" tabindex="6" />
							</dd>
							<div class="clearer"></div>

							<!-- Address Street 1 -->
							<xsl:if test="errors/listing_address_street_1">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_address_street_1" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_address_street_1">Street 1</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_address_street_1" id="listing_address_street_1" type="text" name="listing_address_street_1" value="{/root/meta/post/listing_address_street_1}" tabindex="7" />
							</dd>
							<div class="clearer"></div>

							<!-- Address Street 2 -->
							<xsl:if test="errors/listing_address_street_2">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_address_street_2" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_address_street_2">Street 2</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_address_street_2" id="listing_address_street_2" type="text" name="listing_address_street_2" value="{/root/meta/post/listing_address_street_2}" tabindex="8" />
							</dd>
							<div class="clearer"></div>

							<!-- Address City -->
							<xsl:if test="errors/listing_address_city">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_address_city" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_address_city">City</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_address_city" id="listing_address_city" type="text" name="listing_address_city" value="{/root/meta/post/listing_address_city}" tabindex="9" />
							</dd>
							<div class="clearer"></div>

							<!-- Address State -->
							<xsl:if test="errors/listing_address_state">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_address_state" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_address_state">State</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="listing_address_state" name="listing_address_state" tabindex="10">
									<xsl:call-template name="states">
										<xsl:with-param name="selected" select="/root/meta/post/listing_address_state"/>
									</xsl:call-template>
								</select>
							</dd>
							<div class="clearer"></div>

							<!-- Address Zip -->
							<xsl:if test="errors/listing_address_zip">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_address_zip" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="listing_address_zip">Zip</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="listing_address_zip" id="listing_address_zip" type="text" name="listing_address_zip" value="{/root/meta/post/listing_address_zip}" tabindex="11" />
							</dd>
							<div class="clearer"></div>

							<!-- Information -->
							<xsl:if test="errors/listing_information">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/listing_information" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="createListingInformation">Information</label>
							</dt>
							<dd class="halfPageTextarea floatLeft">
								<textarea id="createListingInformation" name="listing_information" tabindex="12">
									 <xsl:value-of select="/root/meta/post/listing_information"/>
								</textarea>
							</dd>
							<div class="clearer"></div>

							<!-- Save -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Save" tabindex="13"/>
							</dd>
							<div class="clearer"></div>
						</dl>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
			<div class="clearRight"></div>
			<div class="twoColumn floatRight">
				<div class="padding15All">
					<div class="largeSectionWhite">
						<dl class="formSection">
							<h4><xsl:value-of select="type/type_name"/> Properties</h4>

							<xsl:apply-templates select="type/fields"/>
							<div class="clearer"></div>

							<!-- Save -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Save" tabindex="1"/>
							</dd>
							<div class="clearer"></div>
						</dl>
					</div>
				</div>
			</div>
			<div class="clearRight"></div>
		</form>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="type">
	<xsl:param name="selected"/>
	<option>
		<xsl:attribute name="value">
			<xsl:value-of select="type_id"/>
		</xsl:attribute>
		<xsl:if test="$selected = type_id">
			<xsl:attribute name="selected">
				<xsl:text>selected</xsl:text>
			</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="type_name"/>
	</option>
</xsl:template>

<xsl:template match="category" mode="default_category">
	<xsl:param name="selected"/>
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:param name="category_id" select="category_id"/>
	<option>
		<xsl:if test="$selected = category_id">
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="value">
			<xsl:value-of select="category_id"/>
		</xsl:attribute>
		<xsl:call-template name="depth-marker">
			<xsl:with-param name="depth" select="category_depth"/>
		</xsl:call-template>
		<xsl:value-of select="category_name"/>
	</option>
	<xsl:apply-templates select="../category[parent_id=$category_id]" mode="default_category">
		<xsl:with-param name="selected" select="$selected"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="depth-marker">
	<xsl:param name="depth"/>
	<xsl:if test="$depth &gt; 0">
		<xsl:call-template name="depth-marker">
			<xsl:with-param name="depth" select="$depth - 1"/>
		</xsl:call-template>
		<xsl:text>&amp;nbsp;&amp;nbsp;</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>