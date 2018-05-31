<span class="Filters-separator"></span>

<div class="Filters-row">
  <div class="Filters-group">
    <div class="Filters-typeItem Filters-typeItem--searchEnabler js-search-enabler">
      <a href="#/search" class="Filters-searchLink CDB-Text CDB-Size-medium u-actionTextColor u-upperCase is-semibold u-flex js-search-link">
        <div class="CDB-Shape u-rSpace">
          <div class="CDB-Shape-magnify is-small is-blue"></div>
        </div>
        Search
      </a>
    </div>

    <ul class="Filters-group js-links-list">
      <li class="Filters-typeItem">
        <a href="<%- currentDashboardUrl %>" class="Filters-typeLink CDB-Text CDB-Size-medium is-semibold u-upperCase js-link <%- shared === "no" && !liked && !library ? 'is-selected' : '' %>">
          <% if (totalItems) { %>
            <strong><%- totalItems %></strong>
          <% } %>
          <%- pluralizedContentType.charAt(0).toUpperCase() + pluralizedContentType.substring(1) %>
        </a>
      </li>
      <% if (isInsideOrg) { %>
        <li class="Filters-typeItem">
          <a class="Filters-typeLink CDB-Text CDB-Size-medium is-semibold u-upperCase js-link <%- shared === "only" ? 'is-selected' : '' %>" href="<%- currentDashboardUrl.sharedItems() %>">
            <% if (totalShared) { %>
              <strong><%- totalShared %></strong>
            <% } %>
            Shared with you
          </a>
        </li>
      <% } %>
      <li class="Filters-typeItem">
        <a class="Filters-typeLink CDB-Text CDB-Size-medium is-semibold u-upperCase js-link <%- liked ? 'is-selected' : '' %>" href="<%- currentDashboardUrl.likedItems() %>">
          <% if (totalLiked) { %>
            <strong><%- totalLiked %></strong>
          <% } %>
          Liked
        </a>
      </li>
      <% if (hasCreateMapsFeature && !isMaps && isDataLibraryEnabled) { %>
        <li class="Filters-typeItem CDB-Text CDB-Size-medium is-semibold u-upperCase">
          <a class="Filters-typeLink js-link <%- library ? 'is-selected' : '' %>" href="<%- currentDashboardUrl.dataLibrary() %>">
            Data library
          </a>
        </li>
      <% } %>
    </ul>
  </div>

  <div class="Filters-typeItem Filters-typeItem--searchField js-search-field">
    <form class="Filters-searchForm js-search-form" action="<%- router.currentUrl({ search: '', shared: 'yes', locked: false, liked: false  }) %>">
      <input class="Filters-searchInput CDB-Text CDB-Size-medium js-search-input" type="text" value="<%- ( tag && (':' + tag) ) || q %>" placeholder="by name, description or :tag" />
      <% if (tag || q) { %>
        <a href="<%- router.currentUrl({ search: '', tag: '', shared: 'no' }) %>" class="Filters-cleanSearch js-clean-search">
          <div class="CDB-Shape">
            <div class="CDB-Shape-close is-blue is-large"></div>
          </div>
        </a>
      <% } %>
    </form>
  </div>

  <div class="Filters-group js-order-list">
    <ul class="Filters-group">
      <li class="Filters-orderItem">
        <a data-title="date" class="js-order-link Filters-orderLink Filters-orderLink--clock js-updated_at <%- !order || order === 'updated_at' ? 'is-selected' : '' %>" href="#/time">
          <i class="CDB-IconFont CDB-IconFont-clock"></i>
        </a>
      </li>
      <li class="Filters-orderItem">
        <a data-title="visits" class="js-order-link Filters-orderLink Filters-orderLink--graph js-mapviews <%- order === 'mapviews' ? 'is-selected' : '' %>" href="#/views">
          <i class="CDB-IconFont CDB-IconFont-stats"></i>
        </a>
      </li>
      <li class="Filters-orderItem">
        <a data-title="likes" class="js-order-link Filters-orderLink Filters-orderLink--heart js-likes <%- order === 'likes' ? 'is-selected' : '' %>" href="#/likes">
          <i class="CDB-IconFont CDB-IconFont-heartEmpty"></i>
        </a>
      </li>
      <% if (!isMaps) { %>
        <li class="Filters-orderItem">
          <a data-title="size" class="js-order-link Filters-orderLink Filters-orderLink--size js-size <%- order === 'size' ? 'is-selected' : '' %>" href="#/size">
            <i class="CDB-IconFont CDB-IconFont-floppy"></i>
          </a>
        </li>
      <% } %>
    </ul>
    <% if((hasCreateMapsFeature && isMaps) || (hasCreateDatasetsFeature && !isMaps)) { %>
      <button class="
        CDB-Button CDB-Button--primary
        <%- !isMaps && !canCreateDatasets ? 'is-disabled' : '' %>
        <%- isMaps ? 'js-new_map' : 'js-new_dataset' %>

        <% if (pageItems === 0 && !tag && !q && shared === 'no' && !locked && !liked && isMaps && totalShared === 0) { %>
          fs-new_map_onboarding
        <% } %>
        ">
        <span class="CDB-Button-Text CDB-Text is-semibold CDB-Size-small u-upperCase"><%- isMaps ? 'New Map' : 'New dataset' %></span>
      </button>
    <% } %>
  </div>
</div>

<div class="Filters-row">
  <label class="CDB-Text CDB-Size-medium u-secondaryTextColor"><%- selectedItemsCount %> <%- pluralizedContentTypeSelected %> selected</label>
  <div class="Filters-actions">
    <ul class="Filters-actionsList">
      <% if (shared !== "only" && shared !== "yes" && !library && !liked) { %>
        <li class="CDB-Text CDB-Size-medium u-altTextColor">
          <% if (selectedItemsCount < pageItems) { %>
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-select_all" href="#/select-all">Select all <%- tag || q ? 'yours' : '' %></a>
          <% }%>
          <% if (selectedItemsCount > 1) { %>
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-deselect_all" href="#/deselect-all">Deselect all <%- tag || q ? 'yours' : '' %></a>
          <% } %>
        </li>
      <% } %>
      <% if (!isMaps && canCreateDatasets && hasCreateDatasetsFeature && selectedItemsCount === 1 ) { %>
        <% if (isSelectedItemLibrary) { %>
          <li class="Filters-actionsItem">
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-import_remote" href="#/connect-dataset">Connect dataset</a>
          </li>
        <% } %>
      <% } %>
      <% if (!isMaps && canCreateDatasets && hasCreateDatasetsFeature && selectedItemsCount === 1 && !library && !liked && !isSelectedItemLibrary) { %>
        <li class="Filters-actionsItem">
          <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-duplicate_dataset" href="#/duplicate-dataset">Duplicate dataset</a>
        </li>
      <% } %>
      <% if (!isMaps && !liked && hasCreateMapsFeature && hasCreateDatasetsFeature) { %>
        <li class="Filters-actionsItem">
          <% if (selectedItemsCount <= maxLayersByMap) { %>
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-create_map" href="#/create-map">Create map</a>
          <% } else { %>
            <span class="Filters-actionsText CDB-Text CDB-Size-medium u-secondaryTextColor">Max map layers selected (<%- maxLayersByMap %> max)</span>
          <% } %>
        </li>
      <% } %>
      <% if (!library && hasCreateDatasetsFeature) { %>
        <% if (selectedItemsCount === 1 && !liked) { %>
          <li class="Filters-actionsItem">
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-privacy" href="#/change-privacy">Change privacy...</a>
          </li>
          <% if (isMaps) { %>
            <li class="Filters-actionsItem">
              <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-duplicate_map" href="#/duplicate-map">Duplicate map</a>
            </li>
          <% } %>
        <% } %>
        <% if (!q && !tag && !liked) { %>
          <li class="Filters-actionsItem">
            <a class="Filters-actionsLink CDB-Text CDB-Size-medium js-lock" href="#/lock">
              <%- locked ? 'Unlock' : 'Lock' %> <%- pluralizedContentTypeSelected %>&hellip;
            </a>
          </li>
        <% } %>
      <% } %>
      <% if (canDeleteItems && hasCreateDatasetsFeature) { %>
        <li class="Filters-actionsItem">
          <a class="Filters-actionsLink CDB-Text CDB-Size-medium is--critical js-delete" href="#/delete">Delete <%- tag || q ? 'your' : '' %> <%- pluralizedContentTypeSelected %>&hellip;</a>
        </li>
      <% } %>
    </ul>
  </div>
</div>
