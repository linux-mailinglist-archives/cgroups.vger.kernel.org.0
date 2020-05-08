Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62C1CB742
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEHScZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgEHScY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D19C05BD0A
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so1533598qkh.11
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfCvK5ICX9RLV3lPlzIAY41JRodQH86fFkwrgQlSEf8=;
        b=CmwijAWGrB9GpiDIRRkJD4jSnT43gKAmAnGfjMaA25Kt/6/LLUOt4eOCmLPfSIMGOT
         aW9ShVJ6f895PpkJvDJVVoFWx5BgKEjpiM1k6aB0HHEse5SZQ2jgfYQwrhgGFc295/53
         c0firhINkXK8AhvGbh6gPtL7EkztISznspA8/2XedHiWj27+y2kPRk+C3Qyyd37UqCb/
         Llgeupzc7yudqB6GBoOzm51I3hJ4r0VphHkIxYSiDfkxQJHcvK4xfuG+CLwHYBO4dkIO
         LbKGvdO0IK037kd4xPNaYTmJxNke7bjWj88R1s0cINtHKjji7z8isPYV8KpPWPEjBxTw
         d/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfCvK5ICX9RLV3lPlzIAY41JRodQH86fFkwrgQlSEf8=;
        b=GZRn4f1I2lwisXe/1ED64RIwIb6l9u9a8kiYRLNiKmLR6r+WTYjszBTDU1WS120Au4
         MNolE6xQT0/XBdwKyRCPI6dOyK2w87RNwvJSAA1X/rvHrbMe3GI0Mhk6rFrFprkky/Qv
         nASvjrnS7+wJzBgrElMF+2HDFlpDyPmi7Uqs+tuatFwHCjMja4HYUnK5iXBCTqFe/MjK
         sF14OZAyx5qoI5oSJhsANjaqon/9sVislfhUXGOcW8DEjZG0GcLCSCgtqTf5gIwJdMDc
         dKRtl0Kh7GWD4mAZS0V1ZhsAXREB9fB1n9W3O+fdLvXwPcv51ljapFsMUAq2LIT8YV4g
         3r1A==
X-Gm-Message-State: AGi0PuYS1DEpaXRK/QLGVWWQLHOMdgSYectWqTcQrFWOQK1h6pkvjWtO
        0Rh06IImxAshiBzVTjchfGdtNw==
X-Google-Smtp-Source: APiQypKoUnRPBruun23L9ix6YeFW3MKtoKGcwFDVaXCfwmbnoLeO5xCS2xT2NOKAvJKQaNWvn2Nc9w==
X-Received: by 2002:a37:a417:: with SMTP id n23mr4055028qke.480.1588962743924;
        Fri, 08 May 2020 11:32:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id s4sm2145270qth.61.2020.05.08.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:23 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 07/19] mm: memcontrol: prepare move_account for removal of private page type counters
Date:   Fri,  8 May 2020 14:30:54 -0400
Message-Id: <20200508183105.225460-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memcg uses the generic vmstat counters, it doesn't need to do
anything at charging and uncharging time. It does, however, need to
migrate counts when pages move to a different cgroup in move_account.

Prepare the move_account function for the arrival of NR_FILE_PAGES,
NR_ANON_MAPPED, NR_ANON_THPS etc. by having a branch for files and a
branch for anon, which can then divided into sub-branches.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memcontrol.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a5efdad77be4..fe4212db8411 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5378,7 +5378,6 @@ static int mem_cgroup_move_account(struct page *page,
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
-	bool anon;
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5396,25 +5395,27 @@ static int mem_cgroup_move_account(struct page *page,
 	if (page->mem_cgroup != from)
 		goto out_unlock;
 
-	anon = PageAnon(page);
-
 	pgdat = page_pgdat(page);
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
 	lock_page_memcg(page);
 
-	if (!anon && page_mapped(page)) {
-		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
-		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
-	}
+	if (!PageAnon(page)) {
+		if (page_mapped(page)) {
+			__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
+			__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
+		}
 
-	if (!anon && PageDirty(page)) {
-		struct address_space *mapping = page_mapping(page);
+		if (PageDirty(page)) {
+			struct address_space *mapping = page_mapping(page);
 
-		if (mapping_cap_account_dirty(mapping)) {
-			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
-			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
+			if (mapping_cap_account_dirty(mapping)) {
+				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
+						   nr_pages);
+			}
 		}
 	}
 
-- 
2.26.2

