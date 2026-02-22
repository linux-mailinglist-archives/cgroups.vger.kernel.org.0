Return-Path: <cgroups+bounces-14114-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMpoAknEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14114-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:54:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CB16EB6C
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F5B30886DE
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74123E320;
	Sun, 22 Feb 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="blk5jjB9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288723BD17
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750186; cv=none; b=U9kEn2WQR3QnQB/WeLyBQdmLa+J/vpdvoWrlByGfWEGSlgrVf2+e17I07vbMnqNKgpBbuPcXXRI1dCflXocdM0iSpOGqKeNuo6590V7xJyXOoJBnUWgQQgDCPeI041px0o79SdNxlv2oduopZ0iuabfAf1zAw1uw5yMxj8aL9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750186; c=relaxed/simple;
	bh=teac0LnbJnCynydeYVd7GsbjaKn6DnZeMEIoB7iv0us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv2Sx/ZrhG+kreFpCTxICcY8h78r1fLSKUGsu6rVy6BgonDua2TEAF/0mNjlLZsaFLth/y+5LfaWmdrQApDGoAYr5vEyznFquGTlmNaVozfQX/ftEsElY841uZHj4ZATla0Bjo+eTOHa6phkI1kY/jIHBzXvWL3u+JOpRwFhKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=blk5jjB9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a6cf8242so28980321cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750184; x=1772354984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf1ZWp0V25jDsi9L3Unk8bUddTMI7A2gwbgNKk4lUpk=;
        b=blk5jjB9UhXo2nMm2kFrjnA20fdDdgcjzOI9FfIllMYMJWVG1TUWfJDS2SjDXF2rEN
         bA+S8TelN3UNdO8oWSNbA2DvRWlNPmYim+wdURcnhB/6m5FjRAJEQy8K8XWMbo8MDm8Z
         qTLD6lNYAwR741tFfO6j3a6YnAFX6omdGxwPlr5t3SWDyactxRR4yPHULdXAa2L/gZ6A
         UYUXx3GjXdq8F/+1QwqyQBqlKLyGCcVqmTTgLRDqZzwFaTpJkjXBYtBgHZRC7kHc4Ot5
         3pOydvF7VWeT+F9hOU/Y8Q9xmZ1/5tDChksIriABaI0Wgtmfx4mJGvMui12XlaQlzQs+
         j0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750184; x=1772354984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uf1ZWp0V25jDsi9L3Unk8bUddTMI7A2gwbgNKk4lUpk=;
        b=bInHlVTnDQu4AYGkWHBxzM3JHXZ9o7wUn+O55xHJygioXfwzyA+q4ZW9o9nf/jYxHH
         QVQrHIxjqv3oBEjl0OUJH/2BI3RxWsceTCOkFIarHfj3GB/hMBHxWr/vk/Wbvro4c9C9
         vzDdMOI0Cj+Gc9CdEuZxqlwdUe66HQxKy8v7C1bks9JSoChWMHyfkMJ3f6NOL+ISwkeK
         87Ln1pfcBOIw9gvlDfK9jup9asuRI1OYXi32HiUjUSZxWiY8ig8MAb1Kf+Tg0aBIBbjh
         C0r2tmwFCK20ZkEhhYFGYztt8Yz2qCM2LmxR5R6YVmaCggW2Yynug+459rmdMX7A8n3Z
         sMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeAR3NjHGlyNXTSbwkBPN4ba3wfQahleK7YnuzdJsuNefJFccBwst/iPtvPMuRsJ4UjHFpKg14@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4gplMfzRyDQ6crc1erdMkoKFMNfFvF4jaFhqLY+lY+4+D2Rz
	2TbhKZr5FDDvy+zipoDkVtTlER8t5/MVhPTUZedFxO6Vyjghx1fDFH7k6k6cAMIrEEQ=
X-Gm-Gg: AZuq6aLb6brrfHx+sKsKraMICzAROA/zqL+7E8/MF85jduPitgQUpgQcKoWmWHaes0x
	sPXJtYH9HhyY84y0jqKhmmz+4T51UtPpn0noZ/ceBOMazi4aGNfTBLyM5ClN1lIz5Vb+FVTQCj8
	Eqj3F5G31IDA/gaNkQqo6p+j8/7xBCJCDBJnMXQA5yqH1OvZ+bZhYbskmeyArhxCsG2A6z5pFx8
	byc0NXisn4iN3JGvcJcqyzO9H0xNgJqzbcLb/aBvGniXbGk0U4bfzPlPjVVjCSlTtspm/vpKs4F
	dGjxh3CoOoggcxnvEX9TXZ3DvNgJxFL5cDz7fvzavyDe5q2iYw5AtzvOl6Dqpv5MVHYMG/yqdUu
	eyJj5B4KxA45aP2ATEmhK2+WBe173Oopervcp6QQU9ShRcq2kC80UuhYoToADP5vmeRm8ImYcJy
	os8oUoDX+JbVHJxZhvtlR7CK5RRY7M6FcAZxeRg5Nn7Undhp+H7adoqmDl0d5dzmNwgx1gSD4Mb
	ZkvqJ2KJ5WvOYU=
X-Received: by 2002:a05:622a:14d1:b0:506:6e65:2325 with SMTP id d75a77b69052e-5070bba2239mr73493701cf.8.1771750183726;
        Sun, 22 Feb 2026 00:49:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:43 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 13/27] mm/mempolicy: NP_OPS_MEMPOLICY - support private node mempolicy
Date: Sun, 22 Feb 2026 03:48:28 -0500
Message-ID: <20260222084842.1824063-14-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14114-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 983CB16EB6C
X-Rspamd-Action: no action

Some private nodes want userland to directly allocate from the node
via set_mempolicy() and mbind() - but don't want that node as normal
allocable system memory in the fallback lists.

Add NP_OPS_MEMPOLICY flag requiring NP_OPS_MIGRATION (since mbind can
drive migrations).  Only allow private nodes in policy nodemasks if
all private nodes in the mask support NP_OPS_MEMPOLICY. This prevents
__GFP_PRIVATE from unlocking nodes without NP_OPS_MEMPOLICY support.

Add __GFP_PRIVATE to mempolicy migration sites so moves to opted-in
private nodes succeed.

Update the sysfs "has_memory" attribute to include N_MEMORY_PRIVATE
nodes with NP_OPS_MEMPOLICY set, allowing existing numactl userland
tools to work without modification.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c            | 22 +++++++++++++-
 include/linux/node_private.h   | 40 +++++++++++++++++++++++++
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 54 ++++++++++++++++++++++++++++++----
 mm/page_alloc.c                |  5 ++++
 5 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index e587f5781135..c08b5a948779 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -953,6 +953,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    (!ops->migrate_to || !ops->folio_migrate))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_MEMPOLICY) &&
+	    !(ops->flags & NP_OPS_MIGRATION))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
@@ -1145,6 +1149,21 @@ static ssize_t show_node_state(struct device *dev,
 			  nodemask_pr_args(&node_states[na->state]));
 }
 
+/* has_memory includes N_MEMORY + N_MEMORY_PRIVATE that support mempolicy. */
+static ssize_t show_has_memory(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	nodemask_t mask = node_states[N_MEMORY];
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY_PRIVATE) {
+		if (node_private_has_flag(nid, NP_OPS_MEMPOLICY))
+			node_set(nid, mask);
+	}
+
+	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&mask));
+}
+
 #define _NODE_ATTR(name, state) \
 	{ __ATTR(name, 0444, show_node_state, NULL), state }
 
@@ -1155,7 +1174,8 @@ static struct node_attr node_state_attr[] = {
 #ifdef CONFIG_HIGHMEM
 	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
 #endif
-	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
+	[N_MEMORY] = { __ATTR(has_memory, 0444, show_has_memory, NULL),
+		       N_MEMORY },
 	[N_MEMORY_PRIVATE] = _NODE_ATTR(has_private_memory, N_MEMORY_PRIVATE),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 0c5be1ee6e60..e9b58afa366b 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -86,6 +86,8 @@ struct node_private_ops {
 
 /* Allow user/kernel migration; requires migrate_to and folio_migrate */
 #define NP_OPS_MIGRATION		BIT(0)
+/* Allow mempolicy-directed allocation and mbind migration to this node */
+#define NP_OPS_MEMPOLICY		BIT(1)
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -276,6 +278,34 @@ static inline int node_private_migrate_to(struct list_head *folios, int nid,
 
 	return ret;
 }
+
+static inline bool node_mpol_eligible(int nid)
+{
+	bool ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return node_state(nid, N_MEMORY);
+
+	rcu_read_lock();
+	ret = node_private_has_flag(nid, NP_OPS_MEMPOLICY);
+	rcu_read_unlock();
+	return ret;
+}
+
+static inline bool nodes_private_mpol_allowed(const nodemask_t *nodes)
+{
+	int nid;
+	bool eligible = false;
+
+	for_each_node_mask(nid, *nodes) {
+		if (!node_state(nid, N_MEMORY_PRIVATE))
+			continue;
+		if (!node_mpol_eligible(nid))
+			return false;
+		eligible = true;
+	}
+	return eligible;
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #else /* !CONFIG_NUMA */
@@ -364,6 +394,16 @@ static inline int node_private_migrate_to(struct list_head *folios, int nid,
 	return -ENODEV;
 }
 
+static inline bool node_mpol_eligible(int nid)
+{
+	return false;
+}
+
+static inline bool nodes_private_mpol_allowed(const nodemask_t *nodes)
+{
+	return false;
+}
+
 static inline int node_private_register(int nid, struct node_private *np)
 {
 	return -ENODEV;
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 8fbbe613611a..b606eae983c8 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -64,6 +64,7 @@ enum {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_PRIVATE	(1 << 5) /* policy targets private node; use __GFP_PRIVATE */
 
 /*
  * Enabling zone reclaim means the page allocator will attempt to fulfill
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2b0f9762d171..8ac014950e88 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -406,8 +406,6 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 static int mpol_set_nodemask(struct mempolicy *pol,
 		     const nodemask_t *nodes, struct nodemask_scratch *nsc)
 {
-	int ret;
-
 	/*
 	 * Default (pol==NULL) resp. local memory policies are not a
 	 * subject of any remapping. They also do not need any special
@@ -416,9 +414,12 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return 0;
 
-	/* Check N_MEMORY */
+	/* Check N_MEMORY and N_MEMORY_PRIVATE*/
 	nodes_and(nsc->mask1,
 		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+	nodes_and(nsc->mask2, cpuset_current_mems_allowed,
+		  node_states[N_MEMORY_PRIVATE]);
+	nodes_or(nsc->mask1, nsc->mask1, nsc->mask2);
 
 	VM_BUG_ON(!nodes);
 
@@ -432,8 +433,13 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	else
 		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
 
-	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
-	return ret;
+	/* All private nodes in the mask must have NP_OPS_MEMPOLICY. */
+	if (nodes_private_mpol_allowed(&nsc->mask2))
+		pol->flags |= MPOL_F_PRIVATE;
+	else if (nodes_intersects(nsc->mask2, node_states[N_MEMORY_PRIVATE]))
+		return -EINVAL;
+
+	return mpol_ops[pol->mode].create(pol, &nsc->mask2);
 }
 
 /*
@@ -500,6 +506,7 @@ static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	nodemask_t tmp;
+	int nid;
 
 	if (pol->flags & MPOL_F_STATIC_NODES)
 		nodes_and(tmp, pol->w.user_nodemask, *nodes);
@@ -514,6 +521,21 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	if (nodes_empty(tmp))
 		tmp = *nodes;
 
+	/*
+	 * Drop private nodes that don't have mempolicy support.
+	 * cpusets guarantees at least one N_MEMORY node in effective_mems
+	 * and mems_allowed, so dropping private nodes here is safe.
+	 */
+	for_each_node_mask(nid, tmp) {
+		if (node_state(nid, N_MEMORY_PRIVATE) &&
+		    !node_private_has_flag(nid, NP_OPS_MEMPOLICY))
+			node_clear(nid, tmp);
+	}
+	if (nodes_intersects(tmp, node_states[N_MEMORY_PRIVATE]))
+		pol->flags |= MPOL_F_PRIVATE;
+	else
+		pol->flags &= ~MPOL_F_PRIVATE;
+
 	pol->nodes = tmp;
 }
 
@@ -661,6 +683,9 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	}
 	if (!queue_folio_required(folio, qp))
 		return;
+	if (folio_is_private_node(folio) &&
+	    !folio_private_flags(folio, NP_OPS_MIGRATION))
+		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma) ||
 	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
@@ -717,6 +742,9 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
+		if (folio_is_private_node(folio) &&
+		    !folio_private_flags(folio, NP_OPS_MIGRATION))
+			continue;
 		if (folio_test_large(folio) && max_nr != 1)
 			nr = folio_pte_batch(folio, pte, ptent, max_nr);
 		/*
@@ -1451,6 +1479,9 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 	else
 		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
 
+	if (pol->flags & MPOL_F_PRIVATE)
+		gfp |= __GFP_PRIVATE;
+
 	return folio_alloc_mpol(gfp, order, pol, ilx, nid);
 }
 #else
@@ -2280,6 +2311,15 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 			nodemask = &pol->nodes;
 		if (pol->home_node != NUMA_NO_NODE)
 			*nid = pol->home_node;
+		else if ((pol->flags & MPOL_F_PRIVATE) &&
+			 !node_isset(*nid, pol->nodes)) {
+			/*
+			 * Private nodes are not in N_MEMORY nodes' zonelists.
+			 * When the preferred nid (usually numa_node_id()) can't
+			 * reach the policy nodes, start from a policy node.
+			 */
+			*nid = first_node(pol->nodes);
+		}
 		/*
 		 * __GFP_THISNODE shouldn't even be used with the bind policy
 		 * because we might easily break the expectation to stay on the
@@ -2533,6 +2573,10 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 		gfp |= __GFP_NOWARN;
 
 	pol = get_vma_policy(vma, addr, order, &ilx);
+
+	if (pol->flags & MPOL_F_PRIVATE)
+		gfp |= __GFP_PRIVATE;
+
 	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
 	mpol_cond_put(pol);
 	return folio;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5a1b35421d78..ec6c1f8e85d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3849,8 +3849,13 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		 * if another process has NUMA bindings and is causing
 		 * kswapd wakeups on only some nodes. Avoid accidental
 		 * "node_reclaim_mode"-like behavior in this case.
+		 *
+		 * Nodes without kswapd (some private nodes) are never
+		 * skipped - this causes some mempolicies to silently
+		 * fall back to DRAM even if the node is eligible.
 		 */
 		if (skip_kswapd_nodes &&
+		    zone->zone_pgdat->kswapd &&
 		    !waitqueue_active(&zone->zone_pgdat->kswapd_wait)) {
 			skipped_kswapd_nodes = true;
 			continue;
-- 
2.53.0


