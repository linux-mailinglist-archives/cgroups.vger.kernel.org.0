Return-Path: <cgroups+bounces-10392-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF06B95342
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCB6190120F
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EE320CCC;
	Tue, 23 Sep 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XKsXqBuj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE225320A10
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619044; cv=none; b=i1WzJ6OM4MyGgl+N5o03jbcgOOH7jRgOJXlVwZax0aP6cdFHDGMR4Y0tB2ceDVwydxqs70DhPrqrXV7bTN0XKj8VFBiFNS10OnpJd/ArH1cPXkThz2wt/MXPe1EK7rQC4ywTSEekAFnfcwmUj4oSi6R0VXKhnjREs54N9lryVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619044; c=relaxed/simple;
	bh=10Y+XNOiXyb/vrv5K9CM6W3Fnz9B0Mh4n4ASqtZuho0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeFrhGmYQrz4w0yw8h36j5u+We9Z7+kCeYXfZDPVp/HJF2otJ6JsQXIkP7FmQucOSuErjKxOi72wAjjdjaKzOmUWl2ORwN4h+iSZeJwXjzqt/ERpV6x6gJ8VLgbdYqYdIPGTloB48IEr5EKfMBmzpOmTEA+IlfdpIMx90mfVGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XKsXqBuj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5343097b3a.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619040; x=1759223840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsqflaZCptn+OqUf7yzOdIjdD2+Qx392fdtpQO1y/sE=;
        b=XKsXqBujT1YcdcpXDj0A9MXvYvam8fnnNcKDCHx3YQVLJwcEOND3p5GN7jWRtlUVtU
         /E8iFqkEYgzWmQyO+T+gcJtc62g+mPgerBcvhiyqAcLg33F748GnxqLieKwCFTo9V/+0
         02zw5jcJoiHJFilvBEWG22sOXDXJEdj9Tuif3YYLPrkKhg/KOrB8sZS+Fwey7VlICKTG
         fG4b3VpqIYPY7SwoiypUFH8pUutWtwrNfpvITuwjFsWTJpA4ZS6QKM9CnDHzdQ6k2Ij5
         Lk83kaXan8DgEun3ObqCZO4jh7sCmnXn3dR39Mxeboo57fzxHfY4KTCRj0qnmN5aIQLX
         rRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619040; x=1759223840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsqflaZCptn+OqUf7yzOdIjdD2+Qx392fdtpQO1y/sE=;
        b=Jn+bkgRMJHIyDKwAyWgnHf/3qxgQc0VH/xSJ1OPyfjIdYxcIMvdguD+eB/JwP6TXVV
         kQ+I0j4t0yt1EEQ6+Kgza3obsGcnaBVMJiAgE6eVxRyQi4piqVo5pQYXpPmeUBTeI9cm
         quHPaLvbpWZlCGBrjZOVUWBy4JOwkklfKAa+IRDJG4mVSJrtZeIczhfKl275mqLfbM47
         XRVOs5TPl2aq8LrBh39RKEwW7vlqkEshKNedMXzeDQXv7dxUb4RlJRB+nQtMSnvqLmVH
         Z6hWU+ivN/FLLTlLBsFCidOLjafuDkO9xzlkqN+CXsrN078aANvxTTj4EsLYDx0sl9yH
         AMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvHklNx4+NL6zG3A68XSjFsa0l9lBZuga1LxTKsVUPVFvTJ6EhD9Wj8h1m79GUJdbDVXotWHIA@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbsK5TKphxc+a3BIwsiL4mEdBfxb2+IzzXS3wQpd2IERtNTt5
	tQ5SITVzKz/2m2xVd4bXePqViOudSu+XlLjvbdRB8+tf7LhHNgz6sadbcCVGUe+o9k0=
X-Gm-Gg: ASbGnctcEJ72UP/dO5xwB7elrfR5xmRyU6ytnEsL8etrgYQkFEPG1SDeCfUuICzvCTf
	yMiG2od19u1BX35kgq7RDFxHLEM3DhTnlvzDbiOMvC3QYfeav5khQ0Vne/8Tz7onYRYz623iZ1A
	rpO7H/BwmSMbNMlk0za829bshqHlg0+LnK2k6S5OqTlI/YWnheFUxxsA/QzRSQZBnCHGNQjfDpB
	QjFpuwAmfYwZD2bQclf3Yeft9R8c31qj4KC6zhHdqy+B3t22/PxABSDs0s8xePB03+aAVgHytD0
	egN6MShXNYpBb/OQ9QAUlDIpsnH6q7YfJ5vQTrfmLd1Oi8F7sEkEqiT5aX1jhoYKkKMLsAtTpvU
	feKJHyKC4ToZbT0K9n1jGAIdNs8SLAeIuilQOBwhPhZfC9Hey8pygrpP+Myqp9bz6j9m+jvo=
X-Google-Smtp-Source: AGHT+IF8RvtbGMLomOdXVkDJ+YxzFvLcecwxKm+jrWt7odK5vRmlP4nv8ElQjsO9rstnUpRj/Gaa/w==
X-Received: by 2002:a05:6a20:a122:b0:2ba:e2c5:7281 with SMTP id adf61e73a8af0-2cfe903f449mr2771078637.35.1758619040289;
        Tue, 23 Sep 2025 02:17:20 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:17:19 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg offline
Date: Tue, 23 Sep 2025 17:16:25 +0800
Message-ID: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the future, we will reparent LRU folios during memcg offline to
eliminate dying memory cgroups, which requires reparenting the split queue
to its parent.

Similar to list_lru, the split queue is relatively independent and does
not need to be reparented along with objcg and LRU folios (holding
objcg lock and lru lock). So let's apply the same mechanism as list_lru
to reparent the split queue separately when memcg is offine.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/huge_mm.h |  2 ++
 include/linux/mmzone.h  |  1 +
 mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c         |  1 +
 mm/mm_init.c            |  1 +
 5 files changed, 44 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f327d62fc9852..a0d4b751974d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
 	return split_huge_page_to_list_to_order(page, NULL, ret);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
+void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
@@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
 }
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
+static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c57250..f3eb81fee056a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1346,6 +1346,7 @@ struct deferred_split {
 	spinlock_t split_queue_lock;
 	struct list_head split_queue;
 	unsigned long split_queue_len;
+	bool is_dying;
 };
 #endif
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 48b51e6230a67..de7806f759cba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
 	struct deferred_split *queue;
 
 	memcg = folio_memcg(folio);
+retry:
 	queue = memcg ? &memcg->deferred_split_queue :
 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
 	spin_lock(&queue->split_queue_lock);
+	if (unlikely(queue->is_dying == true)) {
+		spin_unlock(&queue->split_queue_lock);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
 	struct deferred_split *queue;
 
 	memcg = folio_memcg(folio);
+retry:
 	queue = memcg ? &memcg->deferred_split_queue :
 			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+	if (unlikely(queue->is_dying == true)) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		memcg = parent_mem_cgroup(memcg);
+		goto retry;
+	}
 
 	return queue;
 }
@@ -4284,6 +4296,33 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	return split;
 }
 
+void reparent_deferred_split_queue(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	struct deferred_split *ds_queue = &memcg->deferred_split_queue;
+	struct deferred_split *parent_ds_queue = &parent->deferred_split_queue;
+	int nid;
+
+	spin_lock_irq(&ds_queue->split_queue_lock);
+	spin_lock_nested(&parent_ds_queue->split_queue_lock, SINGLE_DEPTH_NESTING);
+
+	if (!ds_queue->split_queue_len)
+		goto unlock;
+
+	list_splice_tail_init(&ds_queue->split_queue, &parent_ds_queue->split_queue);
+	parent_ds_queue->split_queue_len += ds_queue->split_queue_len;
+	ds_queue->split_queue_len = 0;
+	/* Mark the ds_queue dead */
+	ds_queue->is_dying = true;
+
+	for_each_node(nid)
+		set_shrinker_bit(parent, nid, shrinker_id(deferred_split_shrinker));
+
+unlock:
+	spin_unlock(&parent_ds_queue->split_queue_lock);
+	spin_unlock_irq(&ds_queue->split_queue_lock);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static void split_huge_pages_all(void)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e090f29eb03bd..d03da72e7585d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	zswap_memcg_offline_cleanup(memcg);
 
 	memcg_offline_kmem(memcg);
+	reparent_deferred_split_queue(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c5..cbda5c2ee3241 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1387,6 +1387,7 @@ static void pgdat_init_split_queue(struct pglist_data *pgdat)
 	spin_lock_init(&ds_queue->split_queue_lock);
 	INIT_LIST_HEAD(&ds_queue->split_queue);
 	ds_queue->split_queue_len = 0;
+	ds_queue->is_dying = false;
 }
 #else
 static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
-- 
2.20.1


