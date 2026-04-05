<#--
  Shared helper functions and macros for progress bar rendering.
  Color logic (by completion rate):
    100%      → dark green   (bg-green-700 / border-green-700 / text-green-800)
    >= 75%    → light green  (bg-green-400 / border-green-400 / text-green-700)
    >= 60%    → yellow       (bg-yellow-400 / border-yellow-400 / text-yellow-700)
    >= 45%    → orange       (bg-orange-400 / border-orange-400 / text-orange-700)
    < 45%     → red          (bg-red-500   / border-red-400   / text-red-700)
-->

<#function progressBarColor prog>
  <#if prog == 100><#return "bg-green-700">
  <#elseif prog >= 75><#return "bg-green-400">
  <#elseif prog >= 60><#return "bg-yellow-400">
  <#elseif prog >= 45><#return "bg-orange-400">
  <#else><#return "bg-red-500">
  </#if>
</#function>

<#function progressBorderColor prog>
  <#if prog == 100><#return "border-green-700">
  <#elseif prog >= 75><#return "border-green-400">
  <#elseif prog >= 60><#return "border-yellow-400">
  <#elseif prog >= 45><#return "border-orange-400">
  <#else><#return "border-red-400">
  </#if>
</#function>

<#function progressTextColor prog>
  <#if prog == 100><#return "text-green-800">
  <#elseif prog >= 75><#return "text-green-700">
  <#elseif prog >= 60><#return "text-yellow-700">
  <#elseif prog >= 45><#return "text-orange-700">
  <#else><#return "text-red-700">
  </#if>
</#function>

<#--
  Renders a progress bar widget.
  Parameters:
    prog        – completion percentage (0-100)
    label       – overlay text; if empty, displays "${prog}%"
    height      – Tailwind height class, default "h-5"
    showBorder  – wrap with a coloured border ring, default true
-->
<#macro progressBar prog label="" height="h-5" showBorder=true>
<#local barColor    = progressBarColor(prog)>
<#local borderColor = progressBorderColor(prog)>
<#if showBorder>
<div class="border-2 ${borderColor} rounded-full p-0.5">
</#if>
  <div class="relative ${height} bg-gray-300 rounded-full overflow-hidden">
    <div class="${barColor} h-full rounded-full transition-all" style="width: ${prog}%"></div>
    <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-white drop-shadow">
      <#if label?has_content>${label}<#else>${prog}%</#if>
    </span>
  </div>
<#if showBorder>
</div>
</#if>
</#macro>
