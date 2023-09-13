Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8679EF56
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjIMQtw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIMQtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 12:49:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCBDC;
        Wed, 13 Sep 2023 09:49:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c39a4f14bcso39929925ad.3;
        Wed, 13 Sep 2023 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694623787; x=1695228587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=08hV17UrGwqSsOU/Pj3BP46JQZzZQz8kR1HYrZEWtOg=;
        b=Uvk3EXHB4F1Wel64AQWHSstm1WwyAzHkxqerazJ3z69W5Dq2pRdsMzfrn//NACTGCQ
         f5PwdB2pb1IvxrAePz0VQEMwy51nhIqaRdqqfBQtFdJ8IviQFSLrbO6QwqSF2mz9q88V
         zzHixbz7igLOamF+/crLXQ9DP6HfhVTtrBiRmd0w0DGT+M/fZYORfDItVUP1gs3MhLVg
         lwrYqRbQCrP2Pggq51zTU8+wXU8g6a5KahY4WBr/mZkvy8MgtTJ/k/U2g6WR+whXqky/
         bVjZoBNv6CkrXf6nwm1phc98d/5kvlPqghJs9U4MifD93AhO1IajyDVlwYzsXtX3R7Ch
         gTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694623787; x=1695228587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08hV17UrGwqSsOU/Pj3BP46JQZzZQz8kR1HYrZEWtOg=;
        b=at/fl8QBU1+VWjLcYKdRSs6rnrHHWORuNa3WGc9xLLV95KXGm6wfu/6kQq7lwJIJYc
         AyasWh3aC9RM/S4uApgWX4ztZZcc01l5te7M82LReDcopv46hRGcDcGlOnCdBLZv9j+i
         8zrgEELux2hbN+L+JFq86wVbdjrLh4qWKrnbK6Z1MV3n5Cqx5/X8UkA+zxlgAawMKa9/
         F56poBH/cnyWRBb1qVfZnO8CskWpRCcPnn3H/XV6/xCAkzkLZ2NqA82i1Wpc2FUJ6qkr
         RY5yRPD+Y+SIonN0/mthw61M9r0gmZ1bZg1lxpSU3lfIuFMx8GUUhRlZgi644mPZO12n
         dWXw==
X-Gm-Message-State: AOJu0YyoE7nd1TX+ypVOrnFytv1J5ydm2NonK+WcJJE4W08TTmSLT78p
        iXjTnQD209oTvVfNAZALD0M=
X-Google-Smtp-Source: AGHT+IFk2+aD7lidOi2/i3oxl3cOgOhU3i2C7yGs/iI4FsnaTfNcKp01QUXLj8ZiS9xV1h9E60++zw==
X-Received: by 2002:a17:902:dac9:b0:1b8:6987:de84 with SMTP id q9-20020a170902dac900b001b86987de84mr4035325plx.48.1694623787574;
        Wed, 13 Sep 2023 09:49:47 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([111.197.253.118])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001b89536974bsm1707520pll.202.2023.09.13.09.49.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Sep 2023 09:49:47 -0700 (PDT)
From:   Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <vernhao@tencent.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        haoxing990@gmail.com, Xin Hao <vernhao@tencent.com>
Subject: [PATCH v3] mm: memcg: add THP swap out info for anonymous reclaim
Date:   Thu, 14 Sep 2023 00:49:37 +0800
Message-ID: <20230913164938.16918-1-vernhao@tencent.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xin Hao <vernhao@tencent.com>

At present, we support per-memcg reclaim strategy, however we do not
know the number of transparent huge pages being reclaimed, as we know
the transparent huge pages need to be splited before reclaim them, and
they will bring some performance bottleneck effect. for example, when
two memcg (A & B) are doing reclaim for anonymous pages at same time,
and 'A' memcg is reclaiming a large number of transparent huge pages, we
can better analyze that the performance bottleneck will be caused by 'A'
memcg.  therefore, in order to better analyze such problems, there add
THP swap out info for per-memcg.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Xin Hao <vernhao@tencent.com>
---
v2 -> v3
	- Do little fix as Johannes Weiner suggestion.
	- add 'thp_swpout' and 'thp_swpout_fallback' to Documentation/admin-guide/cgroup-v2.rst
v1 -> v2
	- Do some fix as Johannes Weiner suggestion.
v2:
https://lore.kernel.org/linux-mm/20230912021727.61601-1-vernhao@tencent.com/
v1: 
https://lore.kernel.org/linux-mm/20230911160824.GB103342@cmpxchg.org/T/

 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 mm/memcontrol.c                         | 2 ++
 mm/page_io.c                            | 8 ++++----
 mm/vmscan.c                             | 1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..622a7f28db1f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1532,6 +1532,15 @@ PAGE_SIZE multiple when read back.
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
 
+	  thp_swpout (npn)
+		Number of transparent hugepages which are swapout in one piece
+		without splitting.
+
+	  thp_swpout_fallback (npn)
+		Number of transparent hugepages which were split before swapout.
+		Usually because failed to allocate some continuous swap space
+		for the huge page.
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 811491b99e3e..9f84b3f7b469 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -704,6 +704,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
 	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
 #endif
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..7cf358158cf1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio)))
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
+	}
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
@@ -278,9 +280,6 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 			set_page_dirty(page);
 			ClearPageReclaim(page);
 		}
-	} else {
-		for (p = 0; p < sio->pages; p++)
-			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	}
 
 	for (p = 0; p < sio->pages; p++)
@@ -296,6 +295,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = page_file_offset(page);
 
+	count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	set_page_writeback(page);
 	unlock_page(page);
 	if (wbc->swap_plug)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 00b24c3b2b04..661615fa709b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1227,6 +1227,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+					count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
-- 
2.42.0

