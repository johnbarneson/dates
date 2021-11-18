		{* How to cite *}
			{if $citation}
				<div class="item citation">
					<div class="sub_item citation_display">
						<div class="label">
							{translate key="submission.howToCite"}
						</div>
						<div class="value">
							<div id="citationOutput" role="region" aria-live="polite">
								{$citation}
							</div>
							<div class="citation_formats">
								<button class="cmp_button citation_formats_button" aria-controls="cslCitationFormats" aria-expanded="false" data-csl-dropdown="true">
									{translate key="submission.howToCite.citationFormats"}
								</button>
								<div id="cslCitationFormats" class="citation_formats_list" aria-hidden="true">
									<ul class="citation_formats_styles">
										{foreach from=$citationStyles item="citationStyle"}
											<li>
												<a
													aria-controls="citationOutput"
													href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
													data-load-citation
													data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
												>
													{$citationStyle.title|escape}
												</a>
											</li>
										{/foreach}
									</ul>
									{if count($citationDownloads)}
										<div class="label">
											{translate key="submission.howToCite.downloadCitation"}
										</div>
										<ul class="citation_formats_styles">
											{foreach from=$citationDownloads item="citationDownload"}
												<li>
													<a href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
														<span class="fa fa-download"></span>
														{$citationDownload.title|escape}
													</a>
												</li>
											{/foreach}
										</ul>
									{/if}
								</div>
							</div>
						</div>
					</div>
				</div>
			{/if}

			{* Issue article appears in *}
			<div class="item issue">
				<div class="sub_item">
					<div class="label">
						{translate key="issue.issue"}
					</div>
					<div class="value">
						<a class="title" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							{$issue->getIssueIdentification()}
						</a>
					</div>
				</div>

				{if $section}
					<div class="sub_item">
						<div class="label">
							{translate key="section.section"}
						</div>
						<div class="value">
							{$section->getLocalizedTitle()|escape}
						</div>
					</div>
				{/if}
			</div>

			{* PubIds (requires plugins) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() == 'doi'}
					{*{php}continue;{/php}*}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					<div class="item pubid">
						<div class="label">
							{$pubIdPlugin->getPubIdDisplayType()|escape}
						</div>
						<div class="value">
							{if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">
									{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								</a>
							{else}
								{$pubId|escape}
							{/if}
						</div>
					</div>
				{/if}
			{/foreach}

                        {* Licensing info *}
                        {if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
                                <div class="item copyright">
                                        <h2 class="label">
                                                {translate key="submission.license"}
                                        </h2>
                                        {if $publication->getData('licenseUrl')}
                                                {if $ccLicenseBadge}
                                                        {if $publication->getLocalizedData('copyrightHolder')}
                                                                <p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}</p>
                                                        {/if}
							{$ccLicenseBadge}
                                                {else}
                                                        <a href="{$publication->getData('licenseUrl')|escape}" class="copyright">
                                                                {if $publication->getLocalizedData('copyrightHolder')}
                                                                        {translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
                                                                {else}
                                                                        {translate key="submission.license"}
                                                                {/if}
                                                        </a>
                                                {/if}
                                        {/if}
                                        {$currentContext->getLocalizedData('licenseTerms')}
                                </div>
                        {/if}

			{call_hook name="Templates::Article::Details"}

		</div><!-- .entry_details -->
	</div><!-- .row -->

</article>
