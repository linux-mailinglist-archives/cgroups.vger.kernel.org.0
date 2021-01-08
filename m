Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9442F2EF551
	for <lists+cgroups@lfdr.de>; Fri,  8 Jan 2021 17:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbhAHP7m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jan 2021 10:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbhAHP7m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Jan 2021 10:59:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D55C0612FF
        for <cgroups@vger.kernel.org>; Fri,  8 Jan 2021 07:58:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m9so6576532plt.5
        for <cgroups@vger.kernel.org>; Fri, 08 Jan 2021 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=K2Y9mypxMIxy8dN+zcRs31GW/sxwp8pLzjC2qV3HZYM=;
        b=fMonvPlmyErI1mcmDqi8RukzV5Gouy8wYMiM08zbjaJoYY/yMo2UeZ3eFOCbCO4G3V
         1dNSMEgcrcAW4KhGmKYCnZ6gHz6Zm6OxbpYBIC2OlWG4q+2ERmSUQ+06FvficujEJlCP
         aclJ2Mgm+Z11APWXPofJaQ0TC866/C2I07zzrH+U1rVnBYRILKTYVa6BZvc7AaDn9HCn
         KJWPYY8Sp062kGre+hawhEd+73NbNkCUdLbUcINVGzRBsBLfZyFMwCRxWPidkrtik3r3
         Em3OIUYOin0H1HHj4pyovunplJrm6QkBM5y+nA5yXxjXToe7++wf/2hu7JXNCItGfNmc
         dGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2Y9mypxMIxy8dN+zcRs31GW/sxwp8pLzjC2qV3HZYM=;
        b=RPyVvezxlEy+vt1NpMHW1Dp4wXp1qc+liB0sqnKzBoMOnhJbu/YlwK6Eg5BBaixyb2
         BMi5yLN+U/59CZdxHoZJWXucw83UxOxojiMmR4eDLetgT7M0/z+5DRxFuI+hIsnj9rBX
         R5u9pV/tpTWl+qOpVFjrp6ebv8BvIFpZfAaPN9ikQoTcYkZ32I6GzBCd6Hifb0RUNVoJ
         iXoDeHp5buxUBw1ZB8c5NPgNh4b8SvKoe0NdcqtDh7LNW0u/XEYBSwa+LG9icAANaYMZ
         KMFLwE3IsFAx8kRnlRhM/fukw9L82k6NAuv6JBgraK2DF0eZ9UhXaBrCWf2OnlPF+Ju7
         YBzw==
X-Gm-Message-State: AOAM5324OaWcwnKirgQzU7j0gEtON92JJSitNV4nT5Sl+ZT91TkvcZwA
        pPeNcfdZwx83hryCJkvVLXqBCU8aKaHbcw==
X-Google-Smtp-Source: ABdhPJy2Jp4f8exDZLZva3gOaWtknVud3DXstpbjibsQkH3dGVI/OiWvSUtfZt1GwnzEcZ/HZqVbQGIJ2IBEKg==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a65:460d:: with SMTP id v13mr7632675pgq.414.1610121523757;
 Fri, 08 Jan 2021 07:58:43 -0800 (PST)
Date:   Fri,  8 Jan 2021 07:58:12 -0800
In-Reply-To: <20210108155813.2914586-1-shakeelb@google.com>
Message-Id: <20210108155813.2914586-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210108155813.2914586-1-shakeelb@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2 2/3] mm: fix numa stats for thp migration
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the kernel is not correctly updating the numa stats for
NR_FILE_PAGES and NR_SHMEM on THP migration. Fix that. For NR_FILE_DIRTY
and NR_ZONE_WRITE_PENDING, although at the moment there is no need to
handle THP migration as kernel still does not have write support for
file THP but to be more future proof, this patch adds the THP support
for those stats as well.

Fixes: e71769ae52609 ("mm: enable thp migration for shmem thp")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Cc: <stable@vger.kernel.org>
---
Changes since v1:
- Fixed a typo

 mm/migrate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 613794f6a433..c0efe921bca5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -402,6 +402,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	struct zone *oldzone, *newzone;
 	int dirty;
 	int expected_count = expected_page_refs(mapping, page) + extra_count;
+	int nr = thp_nr_pages(page);
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
@@ -437,7 +438,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 */
 	newpage->index = page->index;
 	newpage->mapping = page->mapping;
-	page_ref_add(newpage, thp_nr_pages(page)); /* add cache reference */
+	page_ref_add(newpage, nr); /* add cache reference */
 	if (PageSwapBacked(page)) {
 		__SetPageSwapBacked(newpage);
 		if (PageSwapCache(page)) {
@@ -459,7 +460,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	if (PageTransHuge(page)) {
 		int i;
 
-		for (i = 1; i < HPAGE_PMD_NR; i++) {
+		for (i = 1; i < nr; i++) {
 			xas_next(&xas);
 			xas_store(&xas, newpage);
 		}
@@ -470,7 +471,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 * to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	page_ref_unfreeze(page, expected_count - thp_nr_pages(page));
+	page_ref_unfreeze(page, expected_count - nr);
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
@@ -493,17 +494,17 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
 
-		__dec_lruvec_state(old_lruvec, NR_FILE_PAGES);
-		__inc_lruvec_state(new_lruvec, NR_FILE_PAGES);
+		__mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
+		__mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
 		if (PageSwapBacked(page) && !PageSwapCache(page)) {
-			__dec_lruvec_state(old_lruvec, NR_SHMEM);
-			__inc_lruvec_state(new_lruvec, NR_SHMEM);
+			__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
+			__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
 		}
 		if (dirty && mapping_can_writeback(mapping)) {
-			__dec_lruvec_state(old_lruvec, NR_FILE_DIRTY);
-			__dec_zone_state(oldzone, NR_ZONE_WRITE_PENDING);
-			__inc_lruvec_state(new_lruvec, NR_FILE_DIRTY);
-			__inc_zone_state(newzone, NR_ZONE_WRITE_PENDING);
+			__mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
+			__mod_zone_page_state(oldzone, NR_ZONE_WRITE_PENDING, -nr);
+			__mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
+			__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
 		}
 	}
 	local_irq_enable();
-- 
2.29.2.729.g45daf8777d-goog

