<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="recaptcha">
	<xsl:param name="tabindex"/>
	<xsl:param name="theme" select="1"/>
	<xsl:choose>
		<xsl:when test="$theme = 1">
			<script type="text/javascript">
				var RecaptchaOptions = {
					theme : 'clean',
					tabindex : '<xsl:value-of select="$tabindex"/>',
				}
			</script>
			<xsl:if test="/root/content/errors/_external/recaptcha_response_field or /root/content/errors/recaptcha_response_field">
				<span class="fullPageFormError formError floatRight">
					<xsl:value-of select="/root/content/errors/_external/recaptcha_response_field" />
					<xsl:value-of select="/root/content/errors/recaptcha_response_field" />
				</span>
				<div class="clearer"></div>
			</xsl:if>
		</xsl:when>
		<xsl:when test="$theme = 2">
			<script type="text/javascript">
				var RecaptchaOptions = {
					tabindex : '<xsl:value-of select="$tabindex"/>',
					theme : 'custom',
					custom_theme_widget: 'recaptcha_widget',
				};
			</script>
			<div id="recaptcha_widget" style="display: none;">
				<dt class="floatLeft">
					<label for="recaptcha_response_field">Recaptcha</label>
				</dt>
				<dd class="floatRight" style="margin: 10px 0 10px -10px; height: 25px; line-height: 25px; vertical-align: middle;">
					<span class="recaptcha_only_if_image">
						<a href="javascript:Recaptcha.switch_type('audio')">Get an audio CAPTCHA</a>
						<xsl:text> | </xsl:text>
					</span>
					<span class="recaptcha_only_if_audio">
						<a href="javascript:Recaptcha.switch_type('image')">Get an image CAPTCHA</a>
						<xsl:text> | </xsl:text>
					</span>
					<span><a href="javascript:Recaptcha.reload()">Get another CAPTCHA</a></span>
					<xsl:text> | </xsl:text>
					<span><a href="javascript:Recaptcha.showhelp()">Help</a></span>
					<div class="clearer"></div>
				</dd>
				<dd class="floatRight" style="text-align: center; height: 75px; min-width: 300px; padding-top: 15px;">
					<label for="recaptcha_response_field" id="recaptcha_image"></label>
				</dd>
				<div class="clearer"></div>

				<xsl:if test="/root/content/errors/_external/recaptcha_response_field or /root/content/errors/recaptcha_response_field">
					<span class="formError floatRight">
						<xsl:value-of select="/root/content/errors/_external/recaptcha_response_field" />
						<xsl:value-of select="/root/content/errors/recaptcha_response_field" />
					</span>
					<div class="clearer"></div>
				</xsl:if>
				<dt class="floatLeft recaptcha_only_if_image">
					<label for="recaptcha_response_field">Enter words above*</label>
				</dt>
				<dt class="floatLeft recaptcha_only_if_audio">
					<label for="recaptcha_response_field">Enter numbers heard*</label>
				</dt>
				<dd class="floatRight halfPageTextbox">
					<input type="text" id="recaptcha_response_field" name="recaptcha_response_field" />
				</dd>
			</div>
		</xsl:when>
	</xsl:choose>
	<script type="text/javascript">
		<xsl:attribute name="src">
			<xsl:value-of select="server"/>
			<xsl:text>/challenge?k=</xsl:text>
			<xsl:value-of select="key"/>
		</xsl:attribute>
	</script>
	<noscript>
		<xsl:if test="/root/content/errors/_external/recaptcha_response_field or /root/content/errors/recaptcha_response_field">
			<span class="formError floatRight">
				<xsl:value-of select="/root/content/errors/_external/recaptcha_response_field" />
				<xsl:value-of select="/root/content/errors/recaptcha_response_field" />
			</span>
			<div class="clearer"></div>
		</xsl:if>
		<div class="halfPageTextbox floatRight">
			<iframe height="340" width="310" frameborder="0">
				<xsl:attribute name="src">
					<xsl:value-of select="server"/>
					<xsl:text>/noscript?k=</xsl:text>
					<xsl:value-of select="key"/>
				</xsl:attribute>
			</iframe><br/>
			<textarea name="recaptcha_challenge_field" rows="3" cols="40">
				<xsl:attribute name="tabindex"><xsl:value-of select="$tabindex"/></xsl:attribute>
			</textarea>
			<input type="hidden" name="recaptcha_response_field" value="manual_challenge"/>
		</div>
	</noscript>
</xsl:template>

</xsl:stylesheet>