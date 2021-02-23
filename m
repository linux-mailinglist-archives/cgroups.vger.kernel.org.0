Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42923227C7
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBWJ05 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 04:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBWJ0g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 04:26:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C77C06174A
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 01:25:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t26so12013583pgv.3
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mu2c4DZ3wSvp2hWIYY8iGN/5x9vHcWAfw9ARv3kyqaM=;
        b=LO30HGhJEEoDclp09pG3Zhuhe4o587oo39dmuNomrLg61H6NzuMkL0xL1vBoOKFkuy
         s5wFOFudC2zzK0/9HCBgmyHk5dt3QNNyE0FvMB/0LHRZjtr3OfC/Jda4G713nBDXbkUw
         DsvahiAtdD1q5HImPQ1tnNyvxxDLAp8akFgugDk60PJQJGTk185uuHOcXRA4aZBl2gDS
         hMOS3C/AZ20hOPMt7eW25LMJz7bQNwRsbBIeLbNVU7Ct3lFZ1nK7RpS847vlMYKXsgTd
         8L0GHFjCVFxsl4ObqTHMsj1/xeCdD5wC1ADe1TFzPuwQvd5lHI3iYz0HRPZIOOWXpq5K
         i2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mu2c4DZ3wSvp2hWIYY8iGN/5x9vHcWAfw9ARv3kyqaM=;
        b=BK9IjVVclJ9NUKUkanxAzw4R48tkocB6oo4UnTaZJfs9yrUECkuNTDjs3szPV1gWUA
         NZGLHUzP4ZbSWrFz/3O6ZQZtK1z0rTSGRTBvJUOG4mOeyfkleNEVpsLcnK1EReyLZUp2
         MQCmrKQ7gYM0HEmBuFz8+Y0+jbBvxcH4btgLcb+ssjrychP2/MkzoS+4lW3xr6YnrquH
         TZD7hlOo76OMR5a7DPBSLrdzDHetdF10UBWIAizq5sXx2YQuHjtXXwFvoZn/Oq4xg97h
         ZoON00RF7vGBKaKF+NbbRorK1m/IVkxV23f4jgkhW5xtuxZ6xW6ILDG2y6t6+X0xn/n0
         U3gQ==
X-Gm-Message-State: AOAM5302lQqzHnm9NlyE3Nsb8R3/RZOGTVszNcwLnYTQLjfhT2bxanpE
        O14z27WNScq2eSEivdDm5055eQ==
X-Google-Smtp-Source: ABdhPJzvGlwiRLMi9EIg0liLMWJEFp4n/kdqajnxkrCrhCu8fi9gpNP4ucf237OTb4TvSn/w6Cne1g==
X-Received: by 2002:a62:ae05:0:b029:1ed:9384:3e6f with SMTP id q5-20020a62ae050000b02901ed93843e6fmr10898262pff.44.1614072355999;
        Tue, 23 Feb 2021 01:25:55 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id iq6sm2397154pjb.6.2021.02.23.01.25.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 01:25:55 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix slub memory accounting
Date:   Tue, 23 Feb 2021 17:24:23 +0800
Message-Id: <20210223092423.42420-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SLUB currently account kmalloc() and kmalloc_node() allocations larger
than order-1 page per-node. But it forget to update the per-memcg
vmstats. So it can lead to inaccurate statistics of "slab_unreclaimable"
which is from memory.stat. Fix it by using mod_lruvec_page_state instead
of mod_node_page_state.

Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slab_common.c | 4 ++--
 mm/slub.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 821f657d38b5..20ffb2b37058 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -906,8 +906,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	if (likely(page)) {
 		ret = page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
-				    PAGE_SIZE << order);
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      PAGE_SIZE << order);
 	}
 	ret = kasan_kmalloc_large(ret, size, flags);
 	/* As ret might get tagged, call kmemleak hook after KASAN. */
diff --git a/mm/slub.c b/mm/slub.c
index e564008c2329..f2f953de456e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4057,8 +4057,8 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	page = alloc_pages_node(node, flags, order);
 	if (page) {
 		ptr = page_address(page);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
-				    PAGE_SIZE << order);
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      PAGE_SIZE << order);
 	}
 
 	return kmalloc_large_node_hook(ptr, size, flags);
@@ -4193,8 +4193,8 @@ void kfree(const void *x)
 
 		BUG_ON(!PageCompound(page));
 		kfree_hook(object);
-		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
-				    -(PAGE_SIZE << order));
+		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+				      -(PAGE_SIZE << order));
 		__free_pages(page, order);
 		return;
 	}
-- 
2.11.0

