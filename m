Return-Path: <cgroups+bounces-8240-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB1ABA2F0
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1201C0385D
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7727FD58;
	Fri, 16 May 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9Xud4nU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB127F73A
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420365; cv=none; b=XwMURLX2IYrNsQjXnvbk+1FNErnn6jRO0xAxSsGcJD8mD32Mb08uZg47XgFMl0eVkcYIIJAvjnuxLNG/QZByySoIJtLAVbkpOP/Ipr6ECh5dEHAYbAlio2XIA423D+oY5wu1XBmwvSY/w0BFnQvzlJCk4VygSI/ti7Bn8aaSddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420365; c=relaxed/simple;
	bh=4ZjTVBpWHcRhiktqzgid2qNVT421D1E6/FiuocKdIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxvwj1ZnmFuZHFjmWF2KyK8c6Uyu6s3VmX7279G1TKjdYnkLrPtyxWpUh7hFoqoAalMKyQQRVKfOuOiKVeV3ueodW/0+l6KPXm+bH+qdzWpCQ3c6tn93/9AcIHwpJf83chLgqHFiup9t3hBYKd41soRtKESvi/S0wBFlJLiBHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9Xud4nU; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2t99xT19g/7qy5mAbIT4AWoGMrbj8qhuG2xvxaCqjsc=;
	b=g9Xud4nUZSS+w16AXeSr86eISPm8z0RnsTRYEC0O7EG0WtZS2ILoi8kVtrFW57WBpTaSIi
	XBqNB77YOyqqJWg9yZW3MXM4KdQYrg+GewqdNyW3Kvx7LqNRJDuu4v9Pqd/pDno4e1MYoR
	X7yvh6M5HH3crF/7viXSJSX1y4rogok=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 1/5] memcg: disable kmem charging in nmi for unsupported arch
Date: Fri, 16 May 2025 11:32:27 -0700
Message-ID: <20250516183231.1615590-2-shakeel.butt@linux.dev>
In-Reply-To: <20250516183231.1615590-1-shakeel.butt@linux.dev>
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg accounting and stats uses this_cpu* and atomic* ops. There are
archs which define CONFIG_HAVE_NMI but does not define
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
memcg accounting for such archs in nmi context is not possible to
support. Let's just disable memcg accounting in nmi context for such
archs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v2:
- reorder the in_nmi() check as suggested by Vlastimil

 include/linux/memcontrol.h |  5 +++++
 mm/memcontrol.c            | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f7848f73f41c..53920528821f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
+#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
+	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+#define MEMCG_SUPPORTS_NMI_CHARGING
+#endif
+
 #define MEM_CGROUP_ID_SHIFT	16
 
 struct mem_cgroup_id {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e17b698f6243..0f182e4a9da0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(void)
 	return objcg;
 }
 
+#ifdef MEMCG_SUPPORTS_NMI_CHARGING
+static inline bool nmi_charging_allowed(void)
+{
+	return true;
+}
+#else
+static inline bool nmi_charging_allowed(void)
+{
+	return false;
+}
+#endif
+
 __always_inline struct obj_cgroup *current_obj_cgroup(void)
 {
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
+	if (!nmi_charging_allowed() && in_nmi())
+		return NULL;
+
 	if (in_task()) {
 		memcg = current->active_memcg;
 		if (unlikely(memcg))
-- 
2.47.1


