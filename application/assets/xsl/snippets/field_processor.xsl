<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="fields">
	<!-- Use template to drop into a field -->
	<xsl:apply-templates select="field" />

</xsl:template>

<xsl:template match="field">
	<xsl:choose>
		<xsl:when test="field_type/field_type_slug = 'textbox'">
			<xsl:apply-templates select="current()" mode="textbox" />
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'textarea'">
			<xsl:apply-templates select="current()" mode="textarea" />
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'checkbox'">
			<xsl:apply-templates select="current()" mode="checkbox" />
		</xsl:when>
		<xsl:when test="field_type/field_type_slug = 'select'">
			<xsl:apply-templates select="current()" mode="select" />
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="field" mode="textbox">
	<xsl:param name="field_name" select="concat(field_type/field_type_slug,'_',field_id)"/>

	<xsl:if test="errors/*[local-name() = $field_name]">
		<span class="formError floatLeft">
			<xsl:value-of select="errors/*[local-name() = $field_name]" />
		</span>
		<div class="clearer"></div>
	</xsl:if>
	<dt class="floatLeft">
		<label>
			<xsl:attribute name="for">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:value-of select="field_display_name" />
		</label>
	</dt>
	<dd class="halfPageTextbox floatLeft">
		<input type="text">
			<xsl:attribute name="id">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:value-of select="field_name" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$field_name" />
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="/root/meta/post/*[local-name() = $field_name]">
					<xsl:attribute name="value">
						<xsl:value-of select="/root/meta/post/*[local-name() = $field_name]" />
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="value">
						<xsl:value-of select="default_field_value/field_value" />
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</input>
	</dd>
</xsl:template>

<xsl:template match="field" mode="textarea">
	<xsl:param name="field_name" select="concat(field_type/field_type_slug,'_',field_id)"/>

	<xsl:if test="errors/*[local-name() = $field_name]">
		<span class="formError floatLeft">
			<xsl:value-of select="errors/*[local-name() = $field_name]" />
		</span>
		<div class="clearer"></div>
	</xsl:if>
	<dt class="floatLeft">
		<label>
			<xsl:attribute name="for">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:value-of select="field_display_name" />
		</label>
	</dt>
	<dd class="halfPageTextarea floatLeft">
		<textarea class="textarea_small">
			<xsl:attribute name="id">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:value-of select="field_name" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$field_name" />
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="/root/meta/post/*[local-name() = $field_name]">
					<xsl:value-of select="/root/meta/post/*[local-name() = $field_name]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="default_field_value/field_value" />
				</xsl:otherwise>
			</xsl:choose>
		</textarea>
	</dd>
</xsl:template>

<xsl:template match="field" mode="checkbox">
	<xsl:param name="field_name" select="concat(field_type/field_type_slug,'_',field_id)"/>

	<xsl:if test="errors/*[local-name() = $field_name]">
		<span class="formError floatLeft">
			<xsl:value-of select="errors/*[local-name() = $field_name]" />
		</span>
		<div class="clearer"></div>
	</xsl:if>
	<dt class="floatLeft">
		<label>
			<xsl:attribute name="for">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:value-of select="field_display_name" />
		</label>
	</dt>
	<dd class="halfPageCheckbox floatLeft">
		<input type="checkbox">
			<xsl:attribute name="id">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:value-of select="field_name" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$field_name" />
			</xsl:attribute>
			<xsl:attribute name="value">
				<xsl:text>on</xsl:text>
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="/root/meta/post/*[local-name() = $field_name]">
					<xsl:if test="/root/meta/post/*[local-name() = $field_name] = 'on'">
						<xsl:attribute name="checked">
							<xsl:text>checked</xsl:text>
						</xsl:attribute>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="default_field_value/field_value = 'on'">
						<xsl:attribute name="checked">
							<xsl:text>checked</xsl:text>
						</xsl:attribute>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</input>
	</dd>
</xsl:template>

<xsl:template match="field" mode="select">
	<xsl:param name="field_name" select="concat(field_type/field_type_slug,'_',field_id)"/>

	<xsl:if test="errors/*[local-name() = $field_name]">
		<span class="formError floatLeft">
			<xsl:value-of select="errors/*[local-name() = $field_name]" />
		</span>
		<div class="clearer"></div>
	</xsl:if>
	<dt class="floatLeft">
		<label>
			<xsl:attribute name="for">
				<xsl:value-of select="field_name" />
			</xsl:attribute>
			<xsl:value-of select="field_display_name" />
		</label>
	</dt>
	<dd class="halfPageSelect floatLeft">
		<select>
			<xsl:attribute name="id">
				<xsl:value-of select="field_id" />
			</xsl:attribute>
			<xsl:attribute name="class">
				<xsl:value-of select="field_type/field_type_slug" />
			</xsl:attribute>
			<xsl:attribute name="name">
				<xsl:value-of select="$field_name" />
			</xsl:attribute>

			<option><xsl:value-of select="field_display_name"/></option>
			<xsl:for-each select="field_values/field_value">
				<option>
					<xsl:choose>
						<xsl:when test="/root/meta/post/*[local-name() = $field_name]">
							<xsl:if test="/root/meta/post/*[local-name() = $field_name] = field_value_id">
								<xsl:attribute name="selected">
									<xsl:text>selected</xsl:text>
								</xsl:attribute>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="default_field_value_id = field_value_id">
								<xsl:attribute name="selected">
									<xsl:text>selected</xsl:text>
								</xsl:attribute>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:attribute name="value">
						<xsl:value-of select="field_value_id" />
					</xsl:attribute>
					<xsl:value-of select="field_value" />
				</option>
			</xsl:for-each>
		</select>
	</dd>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>