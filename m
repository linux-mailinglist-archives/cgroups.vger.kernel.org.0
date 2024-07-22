Return-Path: <cgroups+bounces-3833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D739389A3
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E0A1F214DC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECC17BB6;
	Mon, 22 Jul 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YCPZUKGU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272217BD5
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632136; cv=none; b=t+EsLZv9XFmdLDzoCOwyu67hJX95e4+0VbuLLmJLo4Wb/dE4wAG6UM5/MlGSoFgYQvuIq5C+9xgq33f6ke0zERRjgPkd1C5PVWlBlid9isvsydwAB/XsG86JMgsUtOzxE1dezGk/lz1GagbuOVM02OSK4SrhANDeF8BiR0aiD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632136; c=relaxed/simple;
	bh=V8g0NHByCB8Qyv9K9tuDa0hOGBUPepJmv/HKefsrIvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdSyKtlvtkM5A902N3wVX5VKYesEOB1hXcaD+EXnwPghBaCLLV65ajzTCsh6CVldZSBLOmZSCp7mYFQ6IsVh399aB0R7ozwmcRsQ/KD8QxRZlChMJPL1q0zlvIt6OUyFXFdk2d+HzmBf+i00u3KYFlo5BsDTaRNDbqMdWTCWL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YCPZUKGU; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3daf0e73a5bso658166b6e.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721632132; x=1722236932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHPVRWiuUtWTrvLskZ3yStEQcSQvqjLGmDrDS3cHO/M=;
        b=YCPZUKGUk0E+TnwYVnJdEYDBXW5IT3qkeQPvlCRlKEgoH9vV9LYO5U8u/8MG6wOOt0
         lqV99Lfq9kQpbbRWYC+fm3TdcBjiSET4jwieU+7TOmFd1KdoKok5+5dTocX3UqRYg4qv
         rr4PEYP7RS0CARjvn96Is7Sbfd7Uuow43CX/IZxpcy6lHZFQy5DEYgS9it4HUIZFjYij
         TzOkYZrjcTGNSjJX3UOQ838iq5RbZ3HL7Wq3y9qPsP/hByF4aicnbIGvpE6s3YIZfXHS
         Cp36lOPuxr7LhsuQw0dZyMSFUrSB+Hz96gH84YJmDFSIdP+vN0QacMgcU1K6MCI3Fu/A
         yXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632132; x=1722236932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHPVRWiuUtWTrvLskZ3yStEQcSQvqjLGmDrDS3cHO/M=;
        b=ruEyB4SUB0WYc5/daO1lIm0OUUsgpymHdlw0jEcp9RCCuK7oLaofD1KuVrQ6aHlgL7
         v1LqPN8DphCEsq3RhWxyPEeIrjZa5k+SVLTFD1p5VwGziIEvazJScZpI+ZBf9bO0dcbz
         ZuJ3ffYv/Hh8a+NqHkV3FbgOokV4ffQ3F04zCRT3Su4ICD4eOhj5fqZLk6iWnkfehF6z
         NgDq3u3taHkicGblS93RwFCqBZQTTRBuqsRjQQ6TFh+hb98aMl+x3gYI4UhI6wy4U0E/
         jEmVX0zkFTFRQPdSxsyFnQ1YOKTwusiT8iflT2iBnksNYiUkvbY/Hrdxq4FkVXvSP3g9
         AVZg==
X-Gm-Message-State: AOJu0YwSmKQmJp7YcPjw5p8VIQrETT56fjweKGhdFx1nlBzqUGMzWl8v
	3Z9Fb+dIZv/4twFMdQoG3DsAOhSvjI4AuK9qV+sOty/8CBK5cN8rEUQBitJLBhxHAsvIWrk/Q3o
	0
X-Google-Smtp-Source: AGHT+IHr7HkR/anMuG3VKEXdqsl9UtpZ/IDbd1la2gHLu5qQkQ1uPTgweGow+GK9PeOlEBlcbdHfrw==
X-Received: by 2002:a05:6808:19a9:b0:3da:3207:edb1 with SMTP id 5614622812f47-3dae5f401aamr9948741b6e.7.1721632131712;
        Mon, 22 Jul 2024 00:08:51 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d11b66ef9sm2914539b3a.219.2024.07.22.00.08.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Jul 2024 00:08:51 -0700 (PDT)
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
Subject: [PATCH] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Date: Mon, 22 Jul 2024 15:08:10 +0800
Message-Id: <20240722070810.46016-1-songmuchun@bytedance.com>
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
assertion (We should export objcg_lock if we really want to do)
and leave a comment to indicate it is intentional.

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
 include/linux/memcontrol.h | 22 +++++++++++++++++++---
 mm/memcontrol.c            |  6 +++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fc94879db4dff..d616c50025098 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -360,11 +360,13 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
- * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * The caller must ensure that the returned memcg won't be released.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
+	WARN_ON_ONCE(!rcu_read_lock_held() &&
+		  /* !lockdep_is_held(&objcg_lock) && */
+		     !lockdep_is_held(&cgroup_mutex));
 	return READ_ONCE(objcg->memcg);
 }
 
@@ -438,6 +440,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
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
@@ -454,7 +469,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
 		struct obj_cgroup *objcg;
@@ -463,6 +477,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
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


