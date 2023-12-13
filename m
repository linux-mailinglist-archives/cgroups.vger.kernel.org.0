Return-Path: <cgroups+bounces-935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F281126F
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B37B20C8C
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894BF2C870;
	Wed, 13 Dec 2023 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLjQHW55"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB94D0
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 05:04:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e20c9c4080so20944017b3.3
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702472658; x=1703077458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vCXE7g0+VpXRLRcaIF4VoQOYAIZ4TbByITks61Imd2w=;
        b=BLjQHW559dfmI1UvfuWviOKyyj9z/twSMH+1oreZbxL5Wg8eI5vcADUiAATTIolzPC
         pYM/ljKcNPc0jsp1mMa0GIvuEPKzSKPv5cxfI1adZNMGdRvSXtI4BtECew88BFEnxP8g
         AUzYP9GzoWUEnLfLWfPMjS1yTET81K0KRPWbPMwQYrIzLfnoIFmlJuXc29vBVzuBxO8w
         C4bTRlIpMOnhN0lSUF1isQjhZmXIY/HWCu7TI6oIDksGHErrbRph4X3SBqvjCR1SrGQa
         pGKWNo4vWErKBLyns6YvXKb/nwE4ehlRrzeDQULf1fXt+mZK/sJu8ut9BVxfNlScHR24
         lt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472658; x=1703077458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCXE7g0+VpXRLRcaIF4VoQOYAIZ4TbByITks61Imd2w=;
        b=kJWOTWSfYBrNxKgHyHqJ3eckLGCB3/xMnH6Bfl+4oH/QYQ2oeixQuTKWXri2FdPD2a
         CszUifBiAeMb1iqbEjh3tbzHKTpBs5+Vod1M5wRVqQ0PeqpRVOBrVwYWMFPUcMkMfSNF
         1aVzvBxUf3CHLhoSGtEfiPgCOkk1GUwTAs0xIWsyyMVrgJfPk+SZuC+NrJE0KqoDhbU8
         u7DVmiAboNt01rlbiRga++JghShjNPSgHD5cCNHhxiRSFmhWnq2PhYklwTQp2aPaqLAQ
         TRgvSfpJceYOrQxyB7Z9OZaOP5hRaKufyHfbxAxFifV5SHfIJLcuDMot5tV2XdpSd2rK
         sJKA==
X-Gm-Message-State: AOJu0YzUIXfWICesHPZizh189Y5aeRNazddW9ebn2LqnMPIbWNXubyTn
	OfysVvLlwYO7xnDCEq3g4w4Gd/L4qSnrbopf
X-Google-Smtp-Source: AGHT+IHFyl5FYdDTCrGeZyNNjuEA0Y+CP3zEYtG+YyGQAliiPJKAt0BsPzfTeOGxsKyB2/mcMXNxQgfYHSTxErWf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:3749:b0:5e2:c745:7f63 with
 SMTP id fw9-20020a05690c374900b005e2c7457f63mr12307ywb.10.1702472658353; Wed,
 13 Dec 2023 05:04:18 -0800 (PST)
Date: Wed, 13 Dec 2023 13:04:14 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213130414.353244-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

memcg_kmem_uncharge_page() is an inline wrapper around
__memcg_kmem_uncharge_page() that checks memcg_kmem_online() before
making the function call. Internally, __memcg_kmem_uncharge_page() has a
folio_memcg_kmem() check.

The only direct user of __memcg_kmem_uncharge_page(),
free_pages_prepare(), checks PageMemcgKmem() before calling it to avoid
the function call if possible. Move the folio_memcg_kmem() check from
__memcg_kmem_uncharge_page() to memcg_kmem_uncharge_page() as
PageMemcgKmem() -- which does the same thing under the hood. Now
free_pages_prepare() can also use memcg_kmem_uncharge_page().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h | 2 +-
 mm/memcontrol.c            | 3 ---
 mm/page_alloc.c            | 3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a308c8eacf20d..2009ca508271a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1844,7 +1844,7 @@ static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 
 static inline void memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	if (memcg_kmem_online())
+	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69b0ad4552425..09efbfa2733e8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3301,9 +3301,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	struct obj_cgroup *objcg;
 	unsigned int nr_pages = 1 << order;
 
-	if (!folio_memcg_kmem(folio))
-		return;
-
 	objcg = __folio_objcg(folio);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	folio->memcg_data = 0;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ea9c33320bf1..f72693d91ac22 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1086,8 +1086,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
-	if (memcg_kmem_online() && PageMemcgKmem(page))
-		__memcg_kmem_uncharge_page(page, order);
+	memcg_kmem_uncharge_page(page, order);
 
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/* Do not let hwpoison pages hit pcplists/buddy */
-- 
2.43.0.472.g3155946c3a-goog


