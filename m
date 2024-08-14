Return-Path: <cgroups+bounces-4251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8B9517C6
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126341C224DC
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFA14A0A2;
	Wed, 14 Aug 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T7wG6y1S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433414A088
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628071; cv=none; b=c8mJpx3kJoBvY1JNN4D01tsPvrJlzgGFKD7DUk7+vNLJfRqRmjdZilCds7Z15BHTVrTu/h/JsR4baanXG+xGVQKFmd+9mZUBMim5nfJL4f8jGCJlDEBLLYX7I7HWRsBxWfw+jAZCGB3ndXcZL/yRAJRJXClcVBX9zyYwQvsiJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628071; c=relaxed/simple;
	bh=Hz9+krHOYcRemGxoMGOtfajLeP9OklMvahnVfUjJqeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=euarc04mbR926l/sTrwkNeWI+yqYn531A75mTJBTC4f8LYZxGp60PrBVj+XQO8beOaTV+TncwnWw356hUVTN1ky6QCiiCEqpAGmj0gloB3ZXbqqerJq9hzMIi3NmnkGmsiMrDto9w4JLr3Xs4CqI6WiK2yNdPYhka0ZaI45V1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T7wG6y1S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so54083245ad.2
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723628069; x=1724232869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bC0XfL2W5FE9snaEjt3YQk8wdW3PboX02I62azn3cOk=;
        b=T7wG6y1SdeCWIMxA2ra1l/+V819Y7v8xerCSHN9bnXMkgpk3JEby3UU4mUlgW/kovE
         B1B2xaMYXxnGzTYFNvJ4k1vrBlYe6jrMLfS80rni/HDvPt9ANPGc4ZtL36R54cfeQE9q
         E3u8cXMxBWdop6PlBKzrJWVUEgtivg1o2cBjL6KfUdCG81kYrc4aZvdhMfAZ6bRXDPO3
         tTsmHD1rnIbIMPeylL36wZnHM3RZ9vEscM8Wk+gtfrEKoWc2U8RpXNwHa+4zl8apoDXE
         5stMwutP7lq1KuMmNUgEscLw03hThjHuKmJQrLjK7p2JCVQEq6sO2CeXYRzuiDKqcjnl
         XTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628069; x=1724232869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC0XfL2W5FE9snaEjt3YQk8wdW3PboX02I62azn3cOk=;
        b=URHCGhEfxS6DxnqxvjEazRE1ckbEx6HXS4fd0gk1k5+lXECLJpiLqJpCxgq+nZdhGM
         f1s6o2l8VHJm2n7mpW/6AaNmUYLfIz+ICbO76i2qZpVCD+GgZc3HL4SSaXM2sum1eDHE
         MkilWmdlfK89hiQskJsmAmIZx/dNuUjWM6kofi51eROGSLvBss3tuMM73hOAJKMgP5qo
         q9u9vJsIYQMZP4gwbsszm6ROnQxbMbtEhjNUEMP4K8bFDeJjwYXkKnz/02rkibXC55jB
         rqIbom7gBNe2cIlgj3OEs8piTWvccvxbv9j7FI7Ol7wCth73RcgGrnq/GK08Kz5qfyxv
         jKdw==
X-Gm-Message-State: AOJu0YzfJIBvADxGJVV1SRlv7L6969HSGanMl80fZy/CxHlU3PpPqB6o
	msMi8VvdayA4OGZvSk3NRiZN8/T6adg4lEQ+Y/zmKkuQ0QHVRwOYh5LLVtnZGtc=
X-Google-Smtp-Source: AGHT+IFnKFOYsVUUabc+Y90K4OKmBUyGjwpN5//JCZ/fIRTXKELSBwTXP/hFNmyxqIj1Zzs3BDRnhw==
X-Received: by 2002:a17:903:191:b0:1fd:d6d8:1355 with SMTP id d9443c01a7336-201d63b61e9mr29347935ad.17.1723628069149;
        Wed, 14 Aug 2024 02:34:29 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a93ccsm26019765ad.168.2024.08.14.02.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Aug 2024 02:34:28 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RESEND v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Date: Wed, 14 Aug 2024 17:34:15 +0800
Message-Id: <20240814093415.17634-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The obj_cgroup_memcg() is supposed to safe to prevent the returned
memory cgroup from being freed only when the caller is holding the
rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
ignore thoes conditions when users call some upper APIs which call
obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
the link below). So it is better to add lockdep assertion to
obj_cgroup_memcg() to find those issues ASAP.

Because there is no user of obj_cgroup_memcg() holding objcg_lock
to make the returned memory cgroup safe, do not add objcg_lock
assertion (We should export objcg_lock if we really want to do).
Additionally, this is some internal implementation detail of memcg
and should not be accessible outside memcg code.

Some users like __mem_cgroup_uncharge() do not care the lifetime
of the returned memory cgroup, which just want to know if the
folio is charged to a memory cgroup, therefore, they do not need
to hold the needed locks. In which case, introduce a new helper
folio_memcg_charged() to do this. Compare it to folio_memcg(), it
could eliminate a memory access of objcg->memcg for kmem, actually,
a really small gain.

Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
Resend because commit 5161b48712dcd08 is not merged first.

v3:
 - Use lockdep_assert_once(Vlastimil).

v2:
 - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).

 include/linux/memcontrol.h | 20 +++++++++++++++++---
 mm/memcontrol.c            |  6 +++---
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fc94879db4dff..95f823deafeca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
- * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * The caller must ensure that the returned memcg won't be released.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
+	lockdep_assert_once(rcu_read_lock_held() || lockdep_is_held(&cgroup_mutex));
 	return READ_ONCE(objcg->memcg);
 }
 
@@ -438,6 +438,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return __folio_memcg(folio);
 }
 
+/*
+ * folio_memcg_charged - If a folio is charged to a memory cgroup.
+ * @folio: Pointer to the folio.
+ *
+ * Returns true if folio is charged to a memory cgroup, otherwise returns false.
+ */
+static inline bool folio_memcg_charged(struct folio *folio)
+{
+	if (folio_memcg_kmem(folio))
+		return __folio_objcg(folio) != NULL;
+	return __folio_memcg(folio) != NULL;
+}
+
 /**
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
@@ -454,7 +467,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
@@ -463,6 +475,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 		return obj_cgroup_memcg(objcg);
 	}
 
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
 	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 622d4544edd24..3da0284573857 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
+	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
 	/*
 	 * Any of the following ensures page's memcg stability:
 	 *
@@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	struct uncharge_gather ug;
 
 	/* Don't touch folio->lru of any random page, pre-check: */
-	if (!folio_memcg(folio))
+	if (!folio_memcg_charged(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
@@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 		return;
 
 	/* Page cache replacement: new folio already charged? */
-	if (folio_memcg(new))
+	if (folio_memcg_charged(new))
 		return;
 
 	memcg = folio_memcg(old);
-- 
2.20.1


