Return-Path: <cgroups+bounces-12324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34ACB3592
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16874312BDCB
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6C73191CA;
	Wed, 10 Dec 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="L3e20nzQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DA28934F
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381395; cv=none; b=T5KiAxUV5ckcOwI8WYQyaahRPbvEg4NvdKQIB50H5aRx4pGRudO3BPqncVolH6GtBq9AeVAGaSfbt1GbBNoLvvAcTQDbnBtdCE1rtTfXgQdDcjYmeGg/yMUAYlScOFZMhbQ1m9Qu7IWO9zpaetBjX4+VVsRp64iKSCvx0IPV0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381395; c=relaxed/simple;
	bh=9vvPHC+jQ4bu92PPjt/VUPjpIcGJYxmVy2OuZM+XpGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LY8jbUZvRfnY9W+Q9DnuhLJZWgGc5WcGbr4T6QHbTTt0HQO17TsE4HwiXo8krRES8zzvEy72AOrwZ3Ep9TdZaeFT6xTOT5fwBLZCxcUh3AwzIUpsjf66xbd+6/8K+wsIBAQMdZuOmYmKrEpp+RRCi1IDaea7S0eKLaX3AxKsDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=L3e20nzQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed75832448so90085461cf.2
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765381392; x=1765986192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RK4QBOSJ1ETPPkTsE5aRaLlAhXzJmTbjPxuvjBfxx3M=;
        b=L3e20nzQeXCCPxE7qCR3uwbw62PA7gpn+Ckw5Lde9PN5L6u/JAtW230MYEFJQCIREU
         v2z7+FgZxkJBBjBR17LgHgbC+MDtW/D6kdXLNcsK6I3HNuLiXSj/S2c05IiX1AFvUBAZ
         BzK1xiAkiLJj/qAFL6dw6iXPrl1OAovtkabKQxH6YxjLMUyfrDVucMh5C75/tJ5GsrWf
         Fb+D7lQTVgfhtUbS1bkVWf1Yqi7GP/FUbARstrfPF7MssKVveK5P33IKcIaEWoxMGybd
         V3gzW4Z1wZ47D6Vb7gpL1PKVenP0+v34G6OQVs1T0+txQETgNlSTpUTFdsMha9jcbLEY
         vrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765381392; x=1765986192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK4QBOSJ1ETPPkTsE5aRaLlAhXzJmTbjPxuvjBfxx3M=;
        b=PednOOd7xjTig1MJADU76LTMRK1vjYS/WdHWm6Al0GmUM24x89nEHdz1eb/Q9h3j0y
         8/NALeQN6wq2mweCM4zECXtYc+W7nbl/jNc/+FZ2zfyMDVOhWnB+v7lSNdWWBEqkUzQV
         lDLY4+YdqwAaSJp9c6dIeuKIUExjfT2HwLRN0LzzvAoOXXDUwe5zJ45mNjhq2ZXVysdU
         smvSETqV061j0PrKzJQDr6hTcUvwUiHXSU854sOnb5d2s6+MhT97OinO0CU3Yv5w/7Zf
         2jyQaWYdwzsmv4kgc2EbE2J+DdbCV6OZiqijp663mvwL/PKZErlEUrPt0eXF1i4+PkiX
         9vQw==
X-Forwarded-Encrypted: i=1; AJvYcCUC43qLuCJuUaneyx6b9pLLbejea82DAMcWSz1NcFcAS7kwo/0Q0snuWpxnccmdbLeLGT1Qeq2K@vger.kernel.org
X-Gm-Message-State: AOJu0YwX61P85rxuYGYm1GO9DmGPFjc8SMJqznMXKirolf1izMNAmK0w
	EKrJL/s7akt0XSDoPSFodxgmynclMIIBz8VaO8/4Gdv6GaCxOqCex3igpiZc2Yzw+hA=
X-Gm-Gg: ASbGncs2eoYackY3zDtMJlhWWxJMJnrGaHl25w+2/+rfXeUBclJ0wjylbAsWnlnzfMo
	Cxgk/gl0aWBKZsvayjUsJYWzYzeg+pvKv3z3kYyqji5hod2ciiw8tv0Hk1G7ytpgSrXdJZinKb3
	puJq1737h/E4PzG2pojgQMSxg8M00T5hLkhGKCOBiybV6Qhj52p7dP7J1k1+GHztgGM3yjHMgJ4
	EYKEOKp/Qtvs4cldgNSr727JjwEnSiHjLrZyZ4um9tVKxOPYOMfXjDgy3nolksASvVITlst0x7n
	yA2GKCb6rK38eHPBRXefy7nBfyPmEMFLth7QaCEUUP6lweI4+DF60bLCFj9eaJywpO+D9Vlw1o2
	D+EHWHahj4bU795uMS/F+1iuTh+dVsNKncPBU4JGK24u0CcYmDby7WNXaF8MI1do1rp8wdnFmxB
	D5ziQ19cN/ew==
X-Google-Smtp-Source: AGHT+IElOjLE5rbcqYu4F/R+HCfn9jPxWZdNKUhuhWsu8mUAZgrglF0s2qhg7pSLqr7FMjuEMrobIg==
X-Received: by 2002:ac8:5d14:0:b0:4f1:ac12:b01b with SMTP id d75a77b69052e-4f1b1a7a156mr37209431cf.38.1765381391629;
        Wed, 10 Dec 2025 07:43:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888287a56d2sm162353706d6.29.2025.12.10.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:43:10 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: rename mem_cgroup_from_slab_obj()
Date: Wed, 10 Dec 2025 10:43:01 -0500
Message-ID: <20251210154301.720133-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to slab objects, this function is used for resolving
non-slab kernel pointers. This has caused confusion in recent
refactoring work. Rename it to mem_cgroup_from_virt(), sticking with
terminology established by the virt_to_<foo>() converters.

Link: https://lore.kernel.org/linux-mm/20251113161424.GB3465062@cmpxchg.org/
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 4 ++--
 mm/list_lru.c              | 4 ++--
 mm/memcontrol.c            | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564..17ad5cf43129 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1727,7 +1727,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
-struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
+struct mem_cgroup *mem_cgroup_from_virt(void *p);
 
 static inline void count_objcg_events(struct obj_cgroup *objcg,
 				      enum vm_event_item idx,
@@ -1799,7 +1799,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 	return -1;
 }
 
-static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
+static inline struct mem_cgroup *mem_cgroup_from_virt(void *p)
 {
 	return NULL;
 }
diff --git a/mm/list_lru.c b/mm/list_lru.c
index ec48b5dadf51..37b642f6cbda 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -187,7 +187,7 @@ bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 
 	if (list_lru_memcg_aware(lru)) {
 		rcu_read_lock();
-		ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		ret = list_lru_add(lru, item, nid, mem_cgroup_from_virt(item));
 		rcu_read_unlock();
 	} else {
 		ret = list_lru_add(lru, item, nid, NULL);
@@ -224,7 +224,7 @@ bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 
 	if (list_lru_memcg_aware(lru)) {
 		rcu_read_lock();
-		ret = list_lru_del(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		ret = list_lru_del(lru, item, nid, mem_cgroup_from_virt(item));
 		rcu_read_unlock();
 	} else {
 		ret = list_lru_del(lru, item, nid, NULL);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..e552072e346c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -806,7 +806,7 @@ void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_slab_obj(p);
+	memcg = mem_cgroup_from_virt(p);
 
 	/*
 	 * Untracked pages have no memcg, no lruvec. Update only the
@@ -2619,7 +2619,7 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
  * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
  * cgroup_mutex, etc.
  */
-struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
+struct mem_cgroup *mem_cgroup_from_virt(void *p)
 {
 	struct slab *slab;
 
-- 
2.52.0


