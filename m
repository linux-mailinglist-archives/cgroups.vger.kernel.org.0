Return-Path: <cgroups+bounces-3893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AD93BF3F
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED50282644
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CE198A06;
	Thu, 25 Jul 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EtY3FTRe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E2197A7E
	for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900625; cv=none; b=sJ71Pih+nV0bEtC5dM9d84+AHJcU8DSu5kHJpN7gFSGx6pFvZR6EOdZeN+i7zJAqlmtmui2guAdRfwZpQrrRBaxZfrpde5bW8kzZIptDkOFS77anWnnvHsWWk7F/k+YE5xMU5No/F7lG0On+6LCHo8TYmmSfKwR3qGiq8MpbUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900625; c=relaxed/simple;
	bh=/YjnkXOScXDrIAsihbMrWMI2ywu8cO7TH5Ge7ewZVCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQ8ySb6tqOd7yRjVuSTxeP5kAhf5YeOeUc7wBPbCoWasfBKmPIJxWyrWXbj53C1fRZta98M2WjcyMJOMBhbaEdS9XhXsI8iAeZxGbGgamfPEQ/wSpJfF1wUaE1IopmCg2bgeqYyrj+1bcSyt5x9O9+RW8z+MV4jC7yWxbI0zoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EtY3FTRe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso462783a12.0
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2024 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721900623; x=1722505423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwdJcLKz/5f8keH5JShytJBM+1xtFuhCZMNTi7Yke18=;
        b=EtY3FTReEhGMHr3+IagILjbCtnmayu5J8mLdXuxURzwpnx+c8iXaqtSwXG3lFsRe1S
         6wyaYV+MmNc9z7iZDSN6IK5ZfA/HKwSyKsKKio2pkyWutdGSaafhw0i0xEZR6z0YWQgu
         T9S+/S3YL0XHgz6fppuqo/wMr2e4UW2iA+ucm4vUhSw6MufdcwcEogIGm6yzF4tKa5s1
         AmSgdteqIhrDNtf63J+ytKjYyNeJ1y9jH78gW8+Gigz7t7jnWKULKlPvHgjJCC7Ws56c
         EQE/5lZLx8JJ1gnuc5PhV2NCs2kNp33IfCxBwkITzkCCvZs7tX6Blfyz0mUxlcR7kh/4
         Ensw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900623; x=1722505423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwdJcLKz/5f8keH5JShytJBM+1xtFuhCZMNTi7Yke18=;
        b=Jxg3fIqEiDgyddXeUoQwA77xSdFBbv8FZpT6xuvMMV/nM/tGCstZw7eAbS+5upCF4Y
         OsNz2jJYmAcojDJdu5DpqPivL0JtUmitThoBGIADNrP+q6CJZHFqfUvCqemZMpWcA3c6
         VyFYmgaZp0DmDKRv6oqBkaHNgHW0qan+VRCFr4XWRf+KM66fbmMSBpZJG4hmRwX/PiRz
         U2Ujhbka+gZIOZ7RpACNJo28r5lLQSUkaohtXZ4D7RUXQybwz3yQjrvgIwExAwnvXQ3U
         VChVlJZLq3wiSWhYGjrcbik6MBqUEQKIcj9gBmHGs/te3dxLnq6zE/vGhPq7tLr74xZ6
         Le7Q==
X-Gm-Message-State: AOJu0YxaBfAPd2HN7ylwqHeF8oV05tiDBSL5ncfzj48WqxzEXWKBx6TY
	M/Iq/K4uAxjRAAYAajPoBXldPIw7Hp2GvE2cSZPlEg4LSs0YdyPCzyvpB2qRZcI=
X-Google-Smtp-Source: AGHT+IEVAsa3ZBsFgD39pMLw2LVoMjX7BbCCQjMcMcYrKg6bxSued2Hy0XURQjw7WOeO/dWSuV3Fmg==
X-Received: by 2002:a05:6a20:8402:b0:1be:2e2e:5ae8 with SMTP id adf61e73a8af0-1c472ce45c2mr2933218637.40.1721900622845;
        Thu, 25 Jul 2024 02:43:42 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1477sm10029425ad.169.2024.07.25.02.43.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jul 2024 02:43:42 -0700 (PDT)
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
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Date: Thu, 25 Jul 2024 17:43:30 +0800
Message-Id: <20240725094330.72537-1-songmuchun@bytedance.com>
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
---
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


