Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993C41CB75C
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEHSdR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSc2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC608C061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y19so1243417qvv.4
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaPQ/6k0L3jh0C6o7CfSb8YWPSRRpIDUVegV83C74dM=;
        b=zsUtCnonxo6Zog/FPVNSwTnBaCeM0640kwri6ouMQy5dP2WS5K0VL3Uvua0clO1WBf
         BRitoPXoqUDeRAN3oCRArMc0i5WyRWV5zibXNnGvLKFsfxZfB46eyMtJ1T+ADLs86OCv
         LZx/kJXhWDmi573Z9v9iEtE7MPuSnPQAeSsW9ktSHlahFKAGyE3tgF/3HMfZppUOuR2T
         vtpeWzPAdHEQDHLQ+DLtQo6+dje3HLAIlF7UMTktdJowPW9vr1UAxTEoHprG65c/iRSm
         pLM0u4C80GxbnbdQrdhxsGROOssrDKHBbDmYIIdnn4iZb4ScmI8zkH0K8z67JNA8P1nt
         w/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaPQ/6k0L3jh0C6o7CfSb8YWPSRRpIDUVegV83C74dM=;
        b=C0kcY+lh1I+j3I9cp9QrwygOqHvZBsRPWT4j7O5cl79gFAw4qr1Tidon+MP1bHLzAQ
         gkfl3OlPXnFrpGGsV4P4CzbdKC+6q+pZMKUTdh+GuybTSXv3iW56MEfnMMPG3gWsRXkR
         o2TaX4S5acc83lnp52VeORrsDKXQWYG6S2GB1VBVytePOjlZ1hcOBdjZ1Rp9e/86GSn1
         2ypGpVm8mKSR6+U/ppSnvTfHE+3E6wlHLxXdn7MTtmr/itEFD9jm+4i/iV7Ygh85I5Q0
         qQ93V9K6o9eMo4sgPea08YtLFf2kqNZxbR2/05faSmTh5WHWLlJcQsvOQyJwu181vun3
         gk2Q==
X-Gm-Message-State: AGi0Puak3RO7tbfRoARVNv3jkR1SUTa75rUYKfUfuh6Cq6jzyMA7jd9h
        lIvBTeDAE72w3QYePYWJS8yqag==
X-Google-Smtp-Source: APiQypKCSdSc0epyu6nb+Tpb5XOJSFpmyaxgKolFX3J9ZjZhpGz+pazhpY0Kj+ub8fsq8v8fRnV6dg==
X-Received: by 2002:a05:6214:42b:: with SMTP id a11mr4097681qvy.186.1588962745866;
        Fri, 08 May 2020 11:32:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id o94sm2046783qtd.34.2020.05.08.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:25 -0700 (PDT)
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
Subject: [PATCH 08/19] mm: memcontrol: prepare cgroup vmstat infrastructure for native anon counters
Date:   Fri,  8 May 2020 14:30:55 -0400
Message-Id: <20200508183105.225460-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Anonymous compound pages can be mapped by ptes, which means that if we
want to track NR_MAPPED_ANON, NR_ANON_THPS on a per-cgroup basis, we
have to be prepared to see tail pages in our accounting functions.

Make mod_lruvec_page_state() and lock_page_memcg() deal with tail
pages correctly, namely by redirecting to the head page which has the
page->mem_cgroup set up.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57339514d960..5b110ac7dd83 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -723,16 +723,17 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!page->mem_cgroup) {
+	if (!head->mem_cgroup) {
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
-	lruvec = mem_cgroup_lruvec(page->mem_cgroup, pgdat);
+	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fe4212db8411..b7be4cd6ddc5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1979,6 +1979,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  */
 struct mem_cgroup *lock_page_memcg(struct page *page)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -1998,7 +1999,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page->mem_cgroup;
+	memcg = head->mem_cgroup;
 	if (unlikely(!memcg))
 		return NULL;
 
@@ -2006,7 +2007,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 		return memcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page->mem_cgroup) {
+	if (memcg != head->mem_cgroup) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2049,7 +2050,9 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
  */
 void unlock_page_memcg(struct page *page)
 {
-	__unlock_page_memcg(page->mem_cgroup);
+	struct page *head = compound_head(page);
+
+	__unlock_page_memcg(head->mem_cgroup);
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-- 
2.26.2

