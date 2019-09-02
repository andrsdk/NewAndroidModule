<#import "./shared_macros.ftl" as shared>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<#if isInstantApp>
apply plugin: 'com.android.feature'
<#else>
  <#if isLibraryProject>
apply plugin: 'com.android.library'
  <#elseif isDynamicFeature>
apply plugin: 'com.andorid.dynamic-feature'
  <#else>
apply plugin: 'com.android.application'
  </#if>
</#if>
<@kt.addKotlinPlugins />

<@shared.androidConfig hasApplicationId=isApplicationProject applicationId=packageName isBaseFeature=isBaseFeature hasTests=true canHaveCpp=true canUseProguard=isApplicationProject||isBaseFeature||(isLibraryProject&&!isInstantApp)/>

dependencies {
    ${getConfigurationName("compile")} fileTree(dir: 'libs', include: ['*.jar'])
    1111
    <#if !improvedTestDeps>
    ${getConfigurationName("androidTestCompile")}('com.android.support.test.espresso:espresso-core:+', {
        exclude group: 'com.android.support', module: 'support-annotations'
    })
    </#if>
    2222
    <@kt.addKotlinDependencies />
    3333
<#if isInstantApp||isDynamicFeature>
    4444
  <#if isBaseFeature>
    5555
    <#if monolithicModuleName?has_content>
    application project(':${monolithicModuleName}')
    <#else>
    // TODO: Add dependency to the main application.
    // application project(':app')
    </#if>
  <#else>
    implementation project(':${baseFeatureName}')
  </#if>
<#else>
  77777
  <@shared.watchProjectDependencies/>
  88888
</#if>
999999
}
