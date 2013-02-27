<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="http://static.med.dev.colorfulstudio.com/assets/css/med_structure.css"/>
		<link rel="stylesheet" type="text/css" href="http://static.med.dev.colorfulstudio.com/assets/css/med_theme.css"/>
	</head>
	<body>
		<xsl:apply-templates select="/root/content"/>
	</body>
</html>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<div class="alignCenter" style="width:280px; margin: 20px;">
			<img src="/assets/images/theme/header/logo.png" width="280"/>
			<form method="post">
				<xsl:attribute name="action">
					<xsl:value-of select="/root/meta/url"/>
				</xsl:attribute>
				<xsl:if test="errors/csrf">
					<span class="floatLeft" style="color: #ff0000; margin-top: 10px;">
						<xsl:value-of select="errors/csrf" />
					</span>
					<div class="clearer"></div>
				</xsl:if>
				<input name="csrf" type="hidden">
					<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
				</input>
				<dl>
					<!-- Username -->
					<xsl:if test="errors/username">
						<span class="floatLeft" style="color: #ff0000; margin-top: 10px;">
							<xsl:value-of select="errors/username" />
						</span>
						<div class="clearer"></div>
					</xsl:if>
					<dd style="padding-top: 12px;">
						<input id="username" class="username" style="width: 260px; height: 30px; font-size: 20px;" type="text" name="username" placeholder="username" value="{/root/meta/post/username}" />
					</dd>
					<div class="clearer"></div>

					<!-- Password -->
					<xsl:if test="errors/password">
						<span class="floatLeft" style="color: #ff0000; margin-top: 10px;">
							<xsl:value-of select="errors/password" />
						</span>
						<div class="clearer"></div>
					</xsl:if>
					<dd style="padding-top: 12px;">
						<input class="password" id="password" type="password" name="password" placeholder="password" style="width: 260px; height: 30px; font-size: 20px;" />
					</dd>
					<div class="clearer"></div>

					<dd style="margin: 12px 0; font-size: 17px;">
						<a class="floatLeft" href="/register/api">Register Account</a>
						<a class="floatRight" href="/login/forgot_api">Forgot password?</a>
						<div class="clearer"></div>
					</dd>
					<div class="clearer"></div>

					<dd style="margin-top: 12px;">
						<input style="height: 40px; width: 135px; font-size: 20px; margin-right: 10px;" type="submit" value="Sign in" />
						<input style="height: 40px; width: 135px; font-size: 20px;" type="submit" name="cancel" value="Cancel" />
					</dd>
				</dl>
			</form>
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>