Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566D131A333
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 18:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBLRDK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBLRDB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 12:03:01 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F92C0613D6
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so149086plg.13
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcYt0NSihifXZf17H55Cj5Hl2GUjQyX5Z/whSKEEhxI=;
        b=QXdiNtz4icRE9wYOkzwNj/MEYjknOPfl+3qraA/tVpTL1yVUQ1uW/Egvq3zevZw11m
         20DnFlwvQipf18yyHzSbhvGpWQ214vwvIYstobFglcVWyBKXAYFVQKqdebGoExkRRSK5
         eiQft2Jyww09TKCwpm9fRe6tkSks1kczSXEdcv/laOSq5Cy74ohKIYxLVjPANARtpaLa
         liZ+acD0FILIz+lrXrA0/L9tZrDVhVAsNAGcQONgLpjgPGdqpzEP9NdCgVeVK6fjDxQo
         CXm7xNS6alE/sydQVkPcpDYcXQZrJZE64mOIICrRUaLwpDpPS5NX11mhQxdktolhNWPw
         vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcYt0NSihifXZf17H55Cj5Hl2GUjQyX5Z/whSKEEhxI=;
        b=s4ZVlWTWq8r8NLXus17OPylW8BW7EzoverZwn2x94zSgpcYzZE1OaWb0dax3KFNzs/
         hsMLbXIsxpTsb2aETI7zDnOsC38Zd+U4AqS+FGJvy3sKjT58Uhj+4y9Od6sjn+r4Xu06
         pNE679P0cQL+mh++34Myy2w4SkkppPtu1FCPhLn8XBeh98i+DFt0B5JlGeqJOfx04v4a
         2fj1Qgqr0iLXXHHXZTNMw9pZfZTcKq0i0+CRmx+eeCsqWj1dIXXjZEU79KHh5mTp0p3H
         sf4Ee6/2rCDmTKKYEXi3Ngyze2u7aS+qaOLmZ9IbVI8cSPuPzq5tv1NMKAV9DHtHaiWe
         ouJw==
X-Gm-Message-State: AOAM532XP5Lj3Ogh9LWWtyor8HE9FzvHNEzoR/hpLlqHxzGGs18SQSU3
        c8VRbR5UszdHmfn1SvKKKR5emE6akXgBqQ==
X-Google-Smtp-Source: ABdhPJy3fzcN97TILH5Pd2p9CjYCM+6s/EotNHOwcpsaLTt2cNdlvuafFJYbAs//bwycN8+3HlIfWA==
X-Received: by 2002:a17:903:31c4:b029:e1:8840:8ab9 with SMTP id v4-20020a17090331c4b02900e188408ab9mr3441164ple.70.1613149340708;
        Fri, 12 Feb 2021 09:02:20 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e21sm9317815pgv.74.2021.02.12.09.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:02:19 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] mm: memcontrol: add missing memcg_oom_recover() when uncharge slab page
Date:   Sat, 13 Feb 2021 01:01:57 +0800
Message-Id: <20210212170159.32153-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210212170159.32153-1-songmuchun@bytedance.com>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When we uncharge a page, we wake up oom victims when the memcg oom
handling is outsourced to the userspace. The uncharge_batch do that
for normal and kmem pages but not slab pages. It is likely an
omission. So add the missing memcg_oom_recover() to
__memcg_kmem_uncharge(). And the function of memory.oom_control
is only suitable for cgroup v1. So guard this test (memcg->under_oom)
by the cgroup_subsys_on_dfl(memory_cgrp_subsys).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7afca9677693..a3f26522765a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3126,8 +3126,10 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
  */
 static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		page_counter_uncharge(&memcg->kmem, nr_pages);
+		memcg_oom_recover(memcg);
+	}
 
 	refill_stock(memcg, nr_pages);
 }
@@ -6806,11 +6808,15 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	if (!mem_cgroup_is_root(ug->memcg)) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
+		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+			if (!cgroup_memory_noswap)
+				page_counter_uncharge(&ug->memcg->memsw,
+						      ug->nr_pages);
+			if (ug->nr_kmem)
+				page_counter_uncharge(&ug->memcg->kmem,
+						      ug->nr_kmem);
+			memcg_oom_recover(ug->memcg);
+		}
 	}
 
 	local_irq_save(flags);
-- 
2.11.0

