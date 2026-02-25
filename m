Return-Path: <cgroups+bounces-14339-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIg2HEyrnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14339-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:57:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E059193D1F
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5DB730152DA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062C330BF69;
	Wed, 25 Feb 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1YwsQ2P"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2143054C7
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006162; cv=none; b=UNM7tzzv7Am8YwPEQEdzMoqoUFDcXOcrvaxxnMWEm83zKPsLRrcrh/ssWUbVh5kDCvB5erjJuWCGn6S7dLZ/QFi2RM1dCTY7jedzG7GmuSDltsmBC339oh/B/ClRTFl/jOpcGeH5jQ2/xnmPYC1MDpJ9DC3DBmpMucsbGFSAXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006162; c=relaxed/simple;
	bh=Sg7X0J2LeOj21kGyyAuviahyCnjetwqckops/SwYF7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUQW9J4PoYKW8X7MQMxZ5+2RCds3vQ35Z5ThfvbVAzp0KV7TI9gv5FONh2pVt+nMWvGYibUxfmiOg1N8Fr26zLreeyddpDghGtuEdD82UKUhGIMpg0sW1rVMn+SS95d/xePKWHQv8RW+jaIb3nnRJ5eodCL5m04y9X6/xMIDmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1YwsQ2P; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ih1p6IEUWMwvOImSKCL1YcoSFVupYh3GoMOZwrQGBdQ=;
	b=a1YwsQ2PzzmX/ma7ssZUFCwp9hvUyPHoOcM4V22f4Ryq7nhp6VOl7tQ2b9GrlO4ZGbE19u
	BGemZ3AfFYpjeikpWspM57ajQ/aRUMsL3XBmcOfwS1f/c4UcxT09aV2wUuUYG9hrK95w4i
	tMpM6lSDBvtaZm3TWKzHPURAFSmi6Lg=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev,
	bhe@redhat.com,
	usamaarif642@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 27/32] mm: memcontrol: refactor memcg_reparent_objcgs()
Date: Wed, 25 Feb 2026 15:53:10 +0800
Message-ID: <2e5696db1993e593a51004c1dacedbc261689629.1772005110.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772005110.git.zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14339-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,bytedance.com:mid,bytedance.com:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: 8E059193D1F
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
LRU folios here.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/memcontrol.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 49a076b7c2e42..5929e397c3c31 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -209,15 +209,12 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memcg,
+							 struct mem_cgroup *parent)
 {
 	struct obj_cgroup *objcg, *iter;
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
-
-	spin_lock_irq(&objcg_lock);
-
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
 	/* 2) Reparent active objcg and already reparented objcgs to parent. */
@@ -226,7 +223,29 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
+	return objcg;
+}
+
+static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	spin_lock_irq(&objcg_lock);
+}
+
+static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
 	spin_unlock_irq(&objcg_lock);
+}
+
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg;
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+
+	reparent_locks(memcg, parent);
+
+	objcg = __memcg_reparent_objcgs(memcg, parent);
+
+	reparent_unlocks(memcg, parent);
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.20.1


