Return-Path: <cgroups+bounces-3772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CD934AC6
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63CD286D28
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AD81205;
	Thu, 18 Jul 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hW5P9sA5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAC78C8F
	for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294379; cv=none; b=E78ViF/Q6CO5MRrltsitlYtmxVqSLluTU09MQ5nOon0o71xoUynEOlrfKxKfXOP317r9BzgIi4UngisjN0c0mFIaPiq7Vh9uMfFXTwml85PAgUTe4a7kXl1gv4we/Azwz8ZeLktS+0j89ojH30BIBDdTgz0X5TeWSuZ2Ll/oDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294379; c=relaxed/simple;
	bh=cRBLaAKsjg60Bgx2QXSb7J4tMBoVTvtjecD2r8glEB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pTGzYa7E65B8ZcqN/j5++F83fuDoM1UlSfFTwpYubzwLR2n7rqqEkmRxOSluezloMUs5o/qG7VijrwD9KC7bbjZchWAXuXYVJYZTimF221jzjK2gZLb0ewuBtUvkcCo867LV38O00PSaukM1wnb6Z+tTEtPZkLPljCQtqH9X0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hW5P9sA5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so372055b3a.1
        for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721294376; x=1721899176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nU8sLB6vIuteXJgQPw++2LFGLgdg5qqMxhtbiU9nCuo=;
        b=hW5P9sA5J79fn1lfpVhbqXUrzS6hrFO1fV51TCepZLMi/JIMkCRMUoTL/RJoyBV2JA
         yog2/pVXAx7zXNt/fYij/fmByjIy6coyPX+V0o7SCqMIgCTd/JY7UzdPIeq10VYZcwiN
         5qS9lc4BCD920m48APKn2yQuUk6TjDzzQ7zgUD1gzkAwfTDhZRj36g5HaRH9XDH1uO6g
         q4d7VwTBZC1MrhpyRExkJtOVqaE8muZs6elO/tM0Ejf/CqCpdHpPU+/QBBc9ywm30sMz
         K+affVksDU4ew6bjzfm8Ksev/aBW762kDtA45u9zXhAUv0Cqd6e8BzGB8HuWEt+5oUY1
         gacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294376; x=1721899176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU8sLB6vIuteXJgQPw++2LFGLgdg5qqMxhtbiU9nCuo=;
        b=Amm3dtAFIlyMGfEb2SHZdpCekmglSwoRsC26ym0TuiKOvV7P/G6v46WMKvYXc3zpNq
         u+5GO5o2jBy1kG/qmisv+DwWLsTip1lTne9znUS9s1fNfLf4cEvSDUkpro/iG5gtmWqS
         a3N9LAArqwAbVvB9BBft6gR8TmcqEUZh7iKlqdw3XRH55F5OKehc1gTET/7uXElI9TSp
         cF3yRN7+dnvJtD4xdu7mAswR1YGgVmwlHSN71VbAFv8HEdGDNgO01sV6NWj0q938cWyi
         V/NTBhqhHzZGVpZYanKInboY1tuDycua/Z8UHcxxQrJB4PGcaMd1+IwgkhgODCnS1c3x
         zctA==
X-Gm-Message-State: AOJu0YxKF0NqJdtouq1Pc+7L/jkggh/EME/tgDWGXmMRf1DUvLdcpJWE
	vu/TGyPqGJvgu/ZtPcImjzIHaRnrZ26yBoLmpZWbaz5i4HUPWjImqVupEAcUgWM=
X-Google-Smtp-Source: AGHT+IGOaTVMJyS7kT7lM0bn1HJi6pUMyC1NCcBFyE3paLzEIwtWXl/YIIWAEle3euPKuYGHJElEaQ==
X-Received: by 2002:a05:6a00:3d0a:b0:705:6a0a:de14 with SMTP id d2e1a72fcca58-70ce4f47fd3mr4979886b3a.1.1721294376045;
        Thu, 18 Jul 2024 02:19:36 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca8c01sm9830421b3a.172.2024.07.18.02.19.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jul 2024 02:19:35 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: kmem: remove mem_cgroup_from_obj()
Date: Thu, 18 Jul 2024 17:18:21 +0800
Message-Id: <20240718091821.44740-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no user of mem_cgroup_from_obj(), remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  6 ------
 mm/memcontrol.c            | 32 +-------------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 394fd0a887ae7..461313307ec23 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1862,7 +1862,6 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
-struct mem_cgroup *mem_cgroup_from_obj(void *p);
 struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
 
 static inline void count_objcg_event(struct obj_cgroup *objcg,
@@ -1925,11 +1924,6 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return -1;
 }
 
-static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
-{
-	return NULL;
-}
-
 static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fabce2b50c695..d04fb1ae870e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3076,37 +3076,7 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 
 /*
  * Returns a pointer to the memory cgroup to which the kernel object is charged.
- *
- * A passed kernel object can be a slab object, vmalloc object or a generic
- * kernel page, so different mechanisms for getting the memory cgroup pointer
- * should be used.
- *
- * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the caller
- * can not know for sure how the kernel object is implemented.
- * mem_cgroup_from_obj() can be safely used in such cases.
- *
- * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
- * cgroup_mutex, etc.
- */
-struct mem_cgroup *mem_cgroup_from_obj(void *p)
-{
-	struct folio *folio;
-
-	if (mem_cgroup_disabled())
-		return NULL;
-
-	if (unlikely(is_vmalloc_addr(p)))
-		folio = page_folio(vmalloc_to_page(p));
-	else
-		folio = virt_to_folio(p);
-
-	return mem_cgroup_from_obj_folio(folio, p);
-}
-
-/*
- * Returns a pointer to the memory cgroup to which the kernel object is charged.
- * Similar to mem_cgroup_from_obj(), but faster and not suitable for objects,
- * allocated using vmalloc().
+ * It is not suitable for objects allocated using vmalloc().
  *
  * A passed kernel object must be a slab object or a generic kernel page.
  *
-- 
2.20.1


