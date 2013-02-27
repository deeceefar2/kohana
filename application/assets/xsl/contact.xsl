<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_help.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>

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
		<xsl:call-template name="subnav_help" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>Contact Us</h3>
					<div class="columnHalfPage floatLeft">
						<xsl:if test="errors">
							<span class="formResult formFailed">
								<xsl:text>Submission failed, please fix the errors and try again</xsl:text>
							</span>
							<div class="clearer"></div>
						</xsl:if>
						<div class="form halfPageForm">
							<form class="contactUsForm" method="post">
								<xsl:attribute name="action">
									<xsl:value-of select="/root/meta/url"/>
								</xsl:attribute>
								<xsl:if test="errors/csrf">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/csrf" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<input name="csrf" type="hidden">
									<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
								</input>
								<dl class="formSection">
									<!-- Name -->
									<xsl:if test="errors/name">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/name" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="name">Name</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="name" id="name" type="text" name="name" value="{/root/meta/post/name}" tabindex="1" />
									</dd>
									<div class="clearer"></div>

									<!-- Email -->
									<xsl:if test="errors/email">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/email" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="email">Email</label>
									</dt>
									<dd class="halfPageTextbox floatLeft">
										<input class="email" id="email" type="text" name="email" value="{/root/meta/post/email}" tabindex="2" />
									</dd>
									<div class="clearer"></div>

									<!-- Subject -->
									<xsl:if test="errors/subject">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/subject" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="subject">Subject</label>
									</dt>
									<dd class="halfPageSelect floatLeft">
										<select id="subject" name="subject" tabindex="3">
											<option value="empty">
												<xsl:if test="/root/meta/post/subject = 'empty'">
													<xsl:attribute name="selected">
														<xsl:text>selected</xsl:text>
													</xsl:attribute>
												</xsl:if>
											</option>
											<option value="listing">
												<xsl:if test="/root/meta/post/subject = 'listing'">
													<xsl:attribute name="selected">
														<xsl:text>selected</xsl:text>
													</xsl:attribute>
												</xsl:if>
												<xsl:text>Listing</xsl:text>
											</option>
											<option value="purchase">
												<xsl:if test="/root/meta/post/subject = 'purchase'">
													<xsl:attribute name="selected">
														<xsl:text>selected</xsl:text>
													</xsl:attribute>
												</xsl:if>
												<xsl:text>Purchase</xsl:text>
											</option>
											<option value="advertising">
												<xsl:if test="/root/meta/post/subject = 'advertising'">
													<xsl:attribute name="selected">
														<xsl:text>selected</xsl:text>
													</xsl:attribute>
												</xsl:if>
												<xsl:text>Advertising</xsl:text>
											</option>
											<option value="other">
												<xsl:if test="/root/meta/post/subject = 'other'">
													<xsl:attribute name="selected">
														<xsl:text>selected</xsl:text>
													</xsl:attribute>
												</xsl:if>
												<xsl:text>Other</xsl:text>
											</option>
										</select>
									</dd>
									<div class="clearer"></div>

									<!-- Message -->
									<xsl:if test="errors/message">
										<span class="formError floatLeft">
											<xsl:value-of select="errors/message" />
										</span>
										<div class="clearer"></div>
									</xsl:if>
									<dt class="floatLeft">
										<label for="message">Message</label>
									</dt>
									<dd class="halfPageTextarea floatLeft">
										<textarea id="message" name="message" tabindex="4">
											<xsl:value-of select="/root/meta/post/message" />
										</textarea>
									</dd>
									<div class="clearer"></div>

									<!-- ReCAPTCHA -->
									<xsl:apply-templates select="recaptcha">
										<xsl:with-param name="tabindex" select="5"/>
										<xsl:with-param name="theme" select="2"/>
									</xsl:apply-templates>
									<div class="clearer"></div>

									<!-- Send Button -->
									<dt class="floatLeft"></dt>
									<dd class="formSubmit floatLeft">
										<input class="formButton floatRight" type="submit" value="Send" tabindex="6" />
									</dd>
								</dl>
							</form>
						</div>
					</div>
					<div class="columnHalfPage floatLeft">
						<div class="contactUsAddressContainer">
							<span class="contactUsAddress floatLeft">
								Life Care Planning Solutions, LLC<br/>
								P.O. Box 1102<br/>
								Jenks, OK 74037-1102<br/>
								<a href="mailto:info@medvoyager.com">info@medvoyager.com</a><br/>
							</span>
							<div class="clearer"></div>
							<span class="contactUsAddress floatLeft">
								Support<br/>
								<a href="mailto:support@medvoyager.com">support@medvoyager.com</a><br/>
							</span>
							<div class="clearer"></div>
							<span class="contactUsAddress floatLeft">
								Advertising<br/>
								<a href="mailto:advertising@medvoyager.com">advertising@medvoyager.com</a><br/>
							</span>
							<div class="clearer"></div>
						</div>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>