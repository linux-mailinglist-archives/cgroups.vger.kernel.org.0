Return-Path: <cgroups+bounces-7572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B70A8923B
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EA73B6E91
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647320C47A;
	Tue, 15 Apr 2025 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Eym07reE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23302356A3
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685298; cv=none; b=oHLBJAG/wWUpB4zCAkp/whjA6CpQqABoLX+scKMYy3wZM6XfhIREa5fjmjXutC7mfMl0uPio8DhyYMTPI7gYv7P5N0CtjTObxxgXKVdLmjuh9l45yDmWs++b66IFT4BgKlg5ReKXDwCU+2Wvjyq89ZzAfOvY2i+bhu8pTgg2k+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685298; c=relaxed/simple;
	bh=fGt3vwXzojBpwJ5OPFRNuUOpmtvk4WgFiUPe9G5ZOto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptyH+zqaqrF2ojh5Zmjkm2yGmmZq9/i0h8HUNxFTzZZ8ckfjSvX+RGXXddrIezK93q8dDuiWNxdIlQf1Z2w3YXPp0y9gej8P8zXfNOgIfffkxldfH2Lc1L/WDOIZsUD3J4M2MQLjah7o0PuRr8UXaqCiDNntSXuBzRb3nS/0LMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Eym07reE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225df540edcso59350595ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685296; x=1745290096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chHLX5G0loxHSohYhxyRHh7WVRRPsaZ78MDusal3hIs=;
        b=Eym07reEy2An2zdgKEO46ZR05K09ZnxkS0OjAKkBhzf6zxDEKDa9zQtmqAFjSLgn55
         nIGEpTSNqgAdWyL9sPkCE8UqrWMGel5iBICE/Tx2TGA4JN5sX8uXToExhEsKIgdbb8pP
         Je00YfR3G/qUdSJnOAQoVbikc970FT6PENU0p0RtKnrYXrZpOI2IVhUZEcOTZb7K9KPH
         8jF7RhIB+zzWNlpbeXaQgK8+CNCcrGQRYiPUMNO7uIxTr/zmwaJbedKu/kj3d9pqETZj
         JrBfm/U3zLrZdyfectktdZKdZzNGCJ3jN10DY/U922Op7bDL4Q8Vo6mcRg50WydkwiLQ
         fxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685296; x=1745290096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chHLX5G0loxHSohYhxyRHh7WVRRPsaZ78MDusal3hIs=;
        b=F3l2TtjmYGYVNbPXrONy4+3/RMnRo/j37nk5Sc2MWCdAB5g4QsT06GXUm2LwLUcjNs
         qxtjagnPr9fBtcz8+8MvoU8sZJw6vcDUObWT+9bQ9LHLdz1h/u2K24sOgZGZJu7Gqybb
         1tGJJj3jphP5up8m5E+wX2YWgYheLLjN/+6fACzInzRE1FWSilXUwayj9Up8JJyHEDSE
         o4tdG5ZuyRlRXzgXOoIBK2fVP6oW5KgKM1Qqnm2W4NR+Ucb54nCrKyPFuAtdFMBpHtSb
         KOuN2NHzVYddA6U7TteXP6EgG16CuNg4a+sLsSdCC3ZK3iLKRn7TJQZzEcNo/1DTfa5E
         oJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCX7WVa+SEN51WezbzsPY/EjEh4MBEHq6YuHWzUAzuW0yCTWeAayKAT8BGT4nTfuQ3rHBpMhASH1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V7mjY2oO8tvCRi2fme4ZmJY8woCTP+IPhV5XD4e+ErCw+/Sc
	y6rELgnGMVTFweNiOXP+FRkhKXlJzbOzNZ6Cuixdab4qATPV8x1uC2YhUZDYRrI=
X-Gm-Gg: ASbGncsBG6Z9pdUJsTkUq6mkFtTuzas+qT/0zcnVjYR6o8nFEIlKrAuckXlSo+rdKg8
	b9FW9lZyxib3ntgTiPUTUfiD3Xsuhjqy3E7C1hO/pnJjEB27JBXE0GTur4PEWt4O4PD41S9wy6z
	AfLL6kG1eRWo4sz9yMpiKPwjVr4iMRn3WFCah1pydtPPSWg4EPxNwa88f4N5mGmQn1hG4+y981L
	uVLjlZ0mPH8/UkVXAlVPPcLoS5n2I4nqtgltFpLeI2TBMk3iXH1uXDbmVp1Wl5TFpdCFgH2T2kg
	9rABBwJmaUXZNNDzf5AyN3OlEIaJhzWnA0zCV9QA+yzjgy5rRzOptkMZfl3CMYXyThG/hzL+
X-Google-Smtp-Source: AGHT+IHfdYPb0mTyQBEggcIEtJXMdJHS98DVkuG5qNfvvUIjwBW9edwqUb5MNEzj4f0Vk/I+xU8TBA==
X-Received: by 2002:a17:903:3203:b0:215:58be:3349 with SMTP id d9443c01a7336-22c24987312mr27942235ad.14.1744685296075;
        Mon, 14 Apr 2025 19:48:16 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.48.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:48:15 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 26/28] mm: memcontrol: introduce memcg_reparent_ops
Date: Tue, 15 Apr 2025 10:45:30 +0800
Message-Id: <20250415024532.26632-27-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous patch, we established a method to ensure the safety of the
lruvec lock and the split queue lock during the reparenting of LRU folios.
The process involves the following steps:

    memcg_reparent_objcgs(memcg)
        1) lock
        // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
        spin_lock(&lruvec->lru_lock);
        spin_lock(&lruvec_parent->lru_lock);

        2) relocate from current memcg to its parent
        // Move all the pages from the lruvec list to the parent lruvec list.

        3) unlock
        spin_unlock(&lruvec_parent->lru_lock);
        spin_unlock(&lruvec->lru_lock);

In addition to the folio lruvec lock, the deferred split queue lock
(specific to THP) also requires a similar approach. Therefore, we abstract
the three essential steps from the memcg_reparent_objcgs() function.

    memcg_reparent_objcgs(memcg)
        1) lock
        memcg_reparent_ops->lock(memcg, parent);

        2) relocate
        memcg_reparent_ops->relocate(memcg, reparent);

        3) unlock
        memcg_reparent_ops->unlock(memcg, reparent);

Currently, two distinct locks (such as the lruvec lock and the deferred
split queue lock) need to utilize this infrastructure. In the subsequent
patch, we will employ these APIs to ensure the safety of these locks
during the reparenting of LRU folios.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 20 ++++++++++++
 mm/memcontrol.c            | 62 ++++++++++++++++++++++++++++++--------
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 27b23e464229..0e450623f8fa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -311,6 +311,26 @@ struct mem_cgroup {
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
+struct memcg_reparent_ops {
+	/*
+	 * Note that interrupt is disabled before calling those callbacks,
+	 * so the interrupt should remain disabled when leaving those callbacks.
+	 */
+	void (*lock)(struct mem_cgroup *src, struct mem_cgroup *dst);
+	void (*relocate)(struct mem_cgroup *src, struct mem_cgroup *dst);
+	void (*unlock)(struct mem_cgroup *src, struct mem_cgroup *dst);
+};
+
+#define DEFINE_MEMCG_REPARENT_OPS(name)					\
+	const struct memcg_reparent_ops memcg_##name##_reparent_ops = {	\
+		.lock		= name##_reparent_lock,			\
+		.relocate	= name##_reparent_relocate,		\
+		.unlock		= name##_reparent_unlock,		\
+	}
+
+#define DECLARE_MEMCG_REPARENT_OPS(name)				\
+	extern const struct memcg_reparent_ops memcg_##name##_reparent_ops
+
 /*
  * size of first charge trial.
  * TODO: maybe necessary to use big numbers in big irons or dynamic based of the
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1f0c6e7b69cc..3fac51179186 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -194,24 +194,60 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static void objcg_reparent_lock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_lock(&objcg_lock);
+}
+
+static void objcg_reparent_relocate(struct mem_cgroup *src, struct mem_cgroup *dst)
 {
 	struct obj_cgroup *objcg, *iter;
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
-	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
+	objcg = rcu_replace_pointer(src->objcg, NULL, true);
+	/* 1) Ready to reparent active objcg. */
+	list_add(&objcg->list, &src->objcg_list);
+	/* 2) Reparent active objcg and already reparented objcgs to dst. */
+	list_for_each_entry(iter, &src->objcg_list, list)
+		WRITE_ONCE(iter->memcg, dst);
+	/* 3) Move already reparented objcgs to the dst's list */
+	list_splice(&src->objcg_list, &dst->objcg_list);
+}
 
-	spin_lock_irq(&objcg_lock);
+static void objcg_reparent_unlock(struct mem_cgroup *src, struct mem_cgroup *dst)
+{
+	spin_unlock(&objcg_lock);
+}
 
-	/* 1) Ready to reparent active objcg. */
-	list_add(&objcg->list, &memcg->objcg_list);
-	/* 2) Reparent active objcg and already reparented objcgs to parent. */
-	list_for_each_entry(iter, &memcg->objcg_list, list)
-		WRITE_ONCE(iter->memcg, parent);
-	/* 3) Move already reparented objcgs to the parent's list */
-	list_splice(&memcg->objcg_list, &parent->objcg_list);
-
-	spin_unlock_irq(&objcg_lock);
+static DEFINE_MEMCG_REPARENT_OPS(objcg);
+
+static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
+	&memcg_objcg_reparent_ops,
+};
+
+#define DEFINE_MEMCG_REPARENT_FUNC(phase)				\
+	static void memcg_reparent_##phase(struct mem_cgroup *src,	\
+					   struct mem_cgroup *dst)	\
+	{								\
+		int i;							\
+									\
+		for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)	\
+			memcg_reparent_ops[i]->phase(src, dst);		\
+	}
+
+DEFINE_MEMCG_REPARENT_FUNC(lock)
+DEFINE_MEMCG_REPARENT_FUNC(relocate)
+DEFINE_MEMCG_REPARENT_FUNC(unlock)
+
+static void memcg_reparent_objcgs(struct mem_cgroup *src)
+{
+	struct mem_cgroup *dst = parent_mem_cgroup(src);
+	struct obj_cgroup *objcg = rcu_dereference_protected(src->objcg, true);
+
+	local_irq_disable();
+	memcg_reparent_lock(src, dst);
+	memcg_reparent_relocate(src, dst);
+	memcg_reparent_unlock(src, dst);
+	local_irq_enable();
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.20.1


