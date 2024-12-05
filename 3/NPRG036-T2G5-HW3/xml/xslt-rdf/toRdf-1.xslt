<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>

  <!-- Define a key to avoid duplicates based on dcterms:identifier -->
  <xsl:key name="uniqueBooks" match="Books/Book" use="BookID"/>
  <xsl:key name="uniqueMembers" match="Members/Member" use="MemberID"/>
  <xsl:key name="uniqueAuthors" match="Author" use="AuthorID"/>
  <xsl:key name="uniqueLibrarians" match="Librarians/Librarian" use="EmployeeID"/>

  <!-- Match the root element of the XML file -->
  <xsl:template match="/LibrarySystem">
    <!-- Define Prefixes -->
    <xsl:text>@prefix ex: &lt;http://example.org/library#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix schema: &lt;http://schema.org/&gt; .&#10;</xsl:text>
    <xsl:text>@prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; .&#10;</xsl:text>
    <xsl:text>@prefix vcard: &lt;http://www.w3.org/2006/vcard/ns#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix ptop: &lt;http://example.org/ptop#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix cdesc: &lt;http://example.org/cdesc#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix emp: &lt;http://example.org/emp#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix nlon: &lt;http://example.org/nlon#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix dcterms: &lt;http://purl.org/dc/terms/&gt; .&#10;</xsl:text>
    <xsl:text>@prefix dcat: &lt;http://www.w3.org/ns/dcat#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix member: &lt;http://example.org/member#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix author: &lt;http://example.org/author#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix dt: &lt;http://example.org/dt#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .&#10;</xsl:text>
    <xsl:text>@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .&#10;&#10;</xsl:text>

    <!-- Process each library in the XML data -->
    <xsl:for-each select="Libraries/Library">
      <!-- Output library details -->
      <xsl:text>ex:</xsl:text><xsl:value-of select="normalize-space(translate(Name, ' ', '_'))"/>
      <xsl:text> a schema:Library;&#10;                foaf:name "</xsl:text><xsl:value-of select="Name"/><xsl:text>"@en;&#10;                vcard:hasAddress "</xsl:text><xsl:value-of select="Address"/><xsl:text>"@en;&#10;</xsl:text>

      <!-- Output employee references -->
      <xsl:for-each select="Librarians/Librarian[generate-id() = generate-id(key('uniqueLibrarians', EmployeeID)[1])]">
        <xsl:text>                ptop:hasEmployee emp:</xsl:text><xsl:value-of select="EmployeeID"/><xsl:text>;&#10;</xsl:text>
      </xsl:for-each>

      <!-- Output inventory references -->
      <xsl:for-each select="Books/Book">
        <xsl:text>                cdesc:hasInventory ex:</xsl:text><xsl:value-of select="normalize-space(translate(Title, ' ', '_'))"/><xsl:text>;&#10;</xsl:text>
      </xsl:for-each>

      <!-- Output member references -->
      <xsl:for-each select="Members/Member[generate-id() = generate-id(key('uniqueMembers', MemberID)[1])]">
        <xsl:text>                schema:member member:</xsl:text><xsl:value-of select="MemberID"/><xsl:text>;&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>.&#10;&#10;</xsl:text>
    </xsl:for-each>

    <!-- Process each librarian in the XML data -->
    <xsl:for-each select="Libraries/Library/Librarians/Librarian[generate-id() = generate-id(key('uniqueLibrarians', EmployeeID)[1])]">
      <xsl:text>emp:</xsl:text><xsl:value-of select="EmployeeID"/>
      <xsl:text> a nlon:Librarian;&#10;        dcterms:identifier </xsl:text><xsl:value-of select="EmployeeID"/><xsl:text>;&#10;        foaf:givenName "</xsl:text><xsl:value-of select="Name"/><xsl:text>"@en;&#10;        dcat:contactPoint ex:contact_point_</xsl:text><xsl:value-of select="EmployeeID"/><xsl:text>.&#10;&#10;</xsl:text>
    </xsl:for-each>

    <!-- Process each book in the XML data -->
    <xsl:for-each select="Libraries/Library/Books/Book[generate-id() = generate-id(key('uniqueBooks', BookID)[1])]">
      <xsl:text>ex:</xsl:text><xsl:value-of select="normalize-space(translate(Title, ' ', '_'))"/>
      <xsl:text> a schema:Book;&#10;               dcterms:identifier </xsl:text><xsl:value-of select="BookID"/><xsl:text>;&#10;               schema:ISBN </xsl:text><xsl:value-of select="ISBN"/><xsl:text>;&#10;               dcterms:title "</xsl:text><xsl:value-of select="Title"/><xsl:text>"@en;&#10;               schema:datePublished </xsl:text><xsl:value-of select="PublishYear"/><xsl:text>;&#10;               schema:creator author:</xsl:text><xsl:value-of select="Author/AuthorID"/><xsl:text>;&#10;</xsl:text>
      <xsl:if test="Title = 'Forth Wing'">
        <xsl:text>               schema:offers 1;&#10;</xsl:text>
      </xsl:if>
      <xsl:if test="Title = 'Hard to Be a God'">
        <xsl:text>               schema:offers 10, 11, 12;&#10;</xsl:text>
      </xsl:if>
      <xsl:text>.&#10;&#10;</xsl:text>
    </xsl:for-each>

    <!-- Process each member in the XML data -->
    <xsl:for-each select="Libraries/Library/Members/Member[generate-id() = generate-id(key('uniqueMembers', MemberID)[1])]">
      <xsl:text>member:</xsl:text><xsl:value-of select="MemberID"/>
      <xsl:text> a foaf:Person;&#10;            dcterms:identifier </xsl:text><xsl:value-of select="MemberID"/><xsl:text>;&#10;            foaf:givenName "</xsl:text><xsl:value-of select="Name"/><xsl:text>"@en;&#10;            dcat:contactPoint ex:contact_point_</xsl:text><xsl:value-of select="MemberID"/><xsl:text>.&#10;&#10;</xsl:text>
    </xsl:for-each>

    <!-- Process each author in the XML data -->
    <xsl:for-each select="Libraries/Library/Books/Book/Author[generate-id() = generate-id(key('uniqueAuthors', AuthorID)[1])]">
      <xsl:text>author:</xsl:text><xsl:value-of select="AuthorID"/>
      <xsl:text> a dt:Author;&#10;            dcterms:identifier </xsl:text><xsl:value-of select="AuthorID"/><xsl:text>;&#10;            foaf:givenName "</xsl:text><xsl:value-of select="Name"/><xsl:text>"@en;&#10;            dcat:contactPoint ex:contact_point_</xsl:text><xsl:value-of select="AuthorID"/><xsl:text>.&#10;&#10;</xsl:text>
    </xsl:for-each>

    <!-- Process each contact point in the XML data -->
    <xsl:for-each select="Libraries/Library/Librarians/Librarian | Libraries/Library/Members/Member | Libraries/Library/Books/Book/Author">
      <xsl:if test="generate-id() = generate-id(key('uniqueLibrarians', EmployeeID)[1]) or generate-id() = generate-id(key('uniqueMembers', MemberID)[1]) or generate-id() = generate-id(key('uniqueAuthors', AuthorID)[1])">
        <xsl:text>ex:contact_point_</xsl:text><xsl:value-of select="concat(EmployeeID, MemberID, AuthorID)"/>
        <xsl:text> a vcard:Kind;&#10;                   vcard:hasTelephone &lt;tel:+</xsl:text><xsl:value-of select="ContactInformation/PhoneNumber"/><xsl:text>&gt;;&#10;                   vcard:hasEmail &lt;mailto:</xsl:text><xsl:value-of select="ContactInformation/Email"/><xsl:text>&gt;;&#10;</xsl:text>
        <xsl:if test="ContactInformation/DeliveryAddress">
          <xsl:text>                   vcard:hasAddress "</xsl:text><xsl:value-of select="ContactInformation/DeliveryAddress"/><xsl:text>".&#10;</xsl:text>
        </xsl:if>
        <xsl:text>.&#10;&#10;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
