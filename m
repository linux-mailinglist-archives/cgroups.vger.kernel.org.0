Return-Path: <cgroups+bounces-14102-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCxLIhTDmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14102-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:49:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2816EA50
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35B913011067
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D420459A;
	Sun, 22 Feb 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vUAbBzTT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43092046BA
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750140; cv=none; b=rxbcwzaKFrmsw5DQ1B/1poXXAXUcuU8aKqi57EADs4BvQyo/XMDh8ME9GWNERNHLUqNUT0b4ivtnYH8JbADlijDiEeI9j4qbZ4+KySrd78eyLqZVYaQPuHXa/1Vq9ZwD54oBpICtkZO5ORDiQnXm8jGYObqj1rdbXxzVusPB7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750140; c=relaxed/simple;
	bh=LkVkNq/aKscUFmfu6MV0XClY9PmENDtKMyza4lnpWKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyRYnlW98ixbXZP4Vr2IZOc0Lr7v6nhVhWhu0sGmgN5DUCTKbiwBzQen39F5YT7TRddykNOmK4do9ZbPp+y7FFSJ2v8QI0eSYVgjwXfLJ2nfMf+JGbrjfnQunkJAE+ffUcCsCmJMRJBqIUaRmOtXl+rju+NYeJXAaIbzPadhLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vUAbBzTT; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89549b2f538so37888556d6.2
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750136; x=1772354936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgAF2gtVAnq1fInoChXWKm0rRX8xSwD2e+wYRBZcfuo=;
        b=vUAbBzTTtfGAG0lU0RlRhT+L3k82CVSCGtZqzIHjnGnt4iGo+e6c7SRCihHRlnu+3+
         SH5KDlb15wNu1zTH9cGYq2aUmWFDxQHs2nr9TiTfvwdyv+aRkuUZ5RrvXEMOS7GV6426
         5eKd/jqeoPnoj1LFK1PCLqC+8DxNaCmL13tEfxsXKfuKt9B7kmL+HgkISwMEFq9TenrF
         coF+rggl5Yrlat8jp+75hCNYC0V6WX5DomE92YkvizIZyfvsHIv+vA1NTLXQJp5kF2hL
         S63ApMirT8ti6PCdLBetYzG47kh6XCgMVZ+vwEzB8PiTjfNUcqG5/LGO4dq+VnaJUFHp
         npGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750136; x=1772354936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TgAF2gtVAnq1fInoChXWKm0rRX8xSwD2e+wYRBZcfuo=;
        b=vrRtB0iRuJn6gb/1zR1FEoBxW53EqxDdDIBGO9KvMgwSc6mXqFOn1WHBbrqaN3jh/g
         r1F5qbYoWzOgMtJvO6nDOlGmPtKk/GJLoHKqkCZn64aV94MfVSzcIjypdtDEQssG3XiP
         vVoEmt4L6nxP92hRcdnOl3XywEbPBwqqgACBlThgnI030/RrD4fUW+hXAWv9pCK2yTU4
         4CmFQ8wOsVUU2ZkoqyQ3CMwIRqIsVt6VRChqEcVOYFImcGuLE71RQBIjKrvGU3KAVt8d
         +QOnZ9CE4pnZovvuCMLl+RZ4HcvyTXAgrfeCZXJ6elVh9liQ2xJ9Gwo0Zi2o3vS/O+KY
         sfgA==
X-Forwarded-Encrypted: i=1; AJvYcCVNPqaotRskmAJ/hpJw7KvFsKWXm4wjBmDiljK+aGo9h2DF19P507prcCEwKHF/8RzDx4whseNi@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE+x0l2whHhymGGCUlq3/W5sRq0rDOepXtVubtDjqL1MRaEy7
	muLPatRGAVAcp4hdEgVLgXySG+84RPmwbto5aCOT4tyU6pfbubu52hzt2sNgrTWOG9E=
X-Gm-Gg: AZuq6aILWN8rsM1G+gtvFzA2f2RXPQ4DRabF3lTGFZodrpBNWEzpRy+E3wQmqEply5g
	cN2Xa2mbWtyTulUuH8xfpsKAe0exmSpG4UlhhUtdsdveA3B7LmGu97P2vJ1Hlwo9of990c1+IyJ
	NPUlcvYuEiqQzZ3qnKMSaLg9MpcLneLojzL5caxifOUXTQaG75W/LkJHnZQVloflsJoDX76lRGY
	mGMUip7kNlDSk1Hy95nTuX31V+Q6NRw+ttVNRmLOzq2Tm5MTHoCZlSp7E/dqeMcsixsRgII9BuD
	5JNnSP6AM0Kzd9GQJ1VnFP5S0WrRi0bQ3PmSjvWvXuP/yyGSlZHpK1Pk824ECWItXVe3C1Rqs/S
	7xTG2Zrvr2Q7PLj6klH7EtheeJsOmIF4stKijs2+6s1hk/vlDFOWABzv/IiJsIBBH4ZzyLQF+iW
	A5PvTHGi47NOZKXT3q/arzVzznPxS3oWWICXRymLJccMyBRoIBnLdWwfooDFhyhaYQdBMY+9rns
	i3/eIUcnTM4944=
X-Received: by 2002:a05:622a:180b:b0:501:49f9:7488 with SMTP id d75a77b69052e-5070bc727d6mr79493791cf.49.1771750136265;
        Sun, 22 Feb 2026 00:48:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:48:55 -0800 (PST)
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
Subject: [RFC PATCH v4 01/27] numa: introduce N_MEMORY_PRIVATE node state
Date: Sun, 22 Feb 2026 03:48:16 -0500
Message-ID: <20260222084842.1824063-2-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14102-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 1FF2816EA50
X-Rspamd-Action: no action

N_MEMORY nodes are intended to contain general System RAM. Today, some
device drivers hotplug their memory (marked Specific Purpose or Reserved)
to get access to mm/ services, but don't intend it for general consumption.

Create N_MEMORY_PRIVATE for memory nodes whose memory is not intended for
general consumption. This state is mutually exclusive with N_MEMORY.

Add the node_private infrastructure for N_MEMORY_PRIVATE nodes:

  - struct node_private: Per-node container stored in NODE_DATA(nid),
    holding driver callbacks (ops), owner, and refcount.

  - struct node_private_ops: Initial structure with void *reserved
    placeholder and flags field.  Callbacks will be added by subsequent
    commits as each consumer is wired up.

  - folio_is_private_node() / page_is_private_node(): check if a
    folio/page resides on a private node.

  - folio_node_private_ops() / node_private_flags(): retrieve the ops
    vtable or flags for a folio's node.

  - Registration API: node_private_register()/unregister() for drivers
    to register callbacks for private nodes. Only one driver callback
    can be registered per node - attempting to register different ops
    returns -EBUSY.

  - sysfs attribute exposing N_MEMORY_PRIVATE node state.

Zonelist construction changes for private nodes are deferred to a
subsequent commit.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          | 197 ++++++++++++++++++++++++++++++++
 include/linux/mmzone.h       |   4 +
 include/linux/node_private.h | 210 +++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h     |   1 +
 4 files changed, 412 insertions(+)
 create mode 100644 include/linux/node_private.h

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 00cf4532f121..646dc48a23b5 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -22,6 +22,7 @@
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/node_private.h>
 
 static const struct bus_type node_subsys = {
 	.name = "node",
@@ -861,6 +862,198 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 			   (void *)&nid, register_mem_block_under_node_hotplug);
 	return;
 }
+
+static DEFINE_MUTEX(node_private_lock);
+static bool node_private_initialized;
+
+/**
+ * node_private_register - Register a private node
+ * @nid: Node identifier
+ * @np: The node_private structure (driver-allocated, driver-owned)
+ *
+ * Register a driver for a private node. Only one driver can register
+ * per node. If another driver has already registered (with different np),
+ * -EBUSY is returned. Re-registration with the same np is allowed.
+ *
+ * The driver owns the node_private memory and must ensure it remains valid
+ * until refcount reaches 0 after node_private_unregister().
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int node_private_register(int nid, struct node_private *np)
+{
+	struct node_private *existing;
+	pg_data_t *pgdat;
+	int ret = 0;
+
+	if (!np || !node_possible(nid))
+		return -EINVAL;
+
+	if (!node_private_initialized)
+		return -ENODEV;
+
+	mutex_lock(&node_private_lock);
+	mem_hotplug_begin();
+
+	/* N_MEMORY_PRIVATE and N_MEMORY are mutually exclusive */
+	if (node_state(nid, N_MEMORY)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pgdat = NODE_DATA(nid);
+	existing = rcu_dereference_protected(pgdat->node_private,
+					     lockdep_is_held(&node_private_lock));
+
+	/* Only one source my register this node */
+	if (existing) {
+		if (existing != np) {
+			ret = -EBUSY;
+			goto out;
+		}
+		goto out;
+	}
+
+	refcount_set(&np->refcount, 1);
+	init_completion(&np->released);
+
+	rcu_assign_pointer(pgdat->node_private, np);
+	pgdat->private = true;
+
+out:
+	mem_hotplug_done();
+	mutex_unlock(&node_private_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_private_register);
+
+/**
+ * node_private_set_ops - Set service callbacks on a registered private node
+ * @nid: Node identifier
+ * @ops: Service callbacks and flags (driver-owned, must outlive registration)
+ *
+ * Validates flag dependencies and sets the ops on the node's node_private.
+ * The node must already be registered via node_private_register().
+ *
+ * Returns 0 on success, -EINVAL for invalid flag combinations,
+ * -ENODEV if no node_private is registered on @nid.
+ */
+int node_private_set_ops(int nid, const struct node_private_ops *ops)
+{
+	struct node_private *np;
+	int ret = 0;
+
+	if (!ops)
+		return -EINVAL;
+
+	if (!node_possible(nid))
+		return -EINVAL;
+
+	mutex_lock(&node_private_lock);
+	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
+				       lockdep_is_held(&node_private_lock));
+	if (!np)
+		ret = -ENODEV;
+	else
+		np->ops = ops;
+	mutex_unlock(&node_private_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_private_set_ops);
+
+/**
+ * node_private_clear_ops - Clear service callbacks from a private node
+ * @nid: Node identifier
+ * @ops: Expected ops pointer (must match current ops)
+ *
+ * Clears the ops only if @ops matches the currently registered ops,
+ * preventing one service from accidentally clearing another's callbacks.
+ *
+ * Returns 0 on success, -ENODEV if no node_private is registered,
+ * -EINVAL if @ops does not match.
+ */
+int node_private_clear_ops(int nid, const struct node_private_ops *ops)
+{
+	struct node_private *np;
+	int ret = 0;
+
+	if (!node_possible(nid))
+		return -EINVAL;
+
+	mutex_lock(&node_private_lock);
+	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
+				       lockdep_is_held(&node_private_lock));
+	if (!np)
+		ret = -ENODEV;
+	else if (np->ops != ops)
+		ret = -EINVAL;
+	else
+		np->ops = NULL;
+	mutex_unlock(&node_private_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_private_clear_ops);
+
+/**
+ * node_private_unregister - Unregister a private node
+ * @nid: Node identifier
+ *
+ * Unregister the driver from a private node. Only succeeds if all memory
+ * has been offlined and the node is no longer N_MEMORY_PRIVATE.
+ * When successful, drops the refcount to 0 indicating the driver can
+ * free its context.
+ *
+ * N_MEMORY_PRIVATE state is cleared by offline_pages() when the last
+ * memory is offlined, not by this function.
+ *
+ * Return: 0 if unregistered, -EBUSY if N_MEMORY_PRIVATE is still set
+ * (other memory blocks remain on this node).
+ */
+int node_private_unregister(int nid)
+{
+	struct node_private *np;
+	pg_data_t *pgdat;
+
+	if (!node_possible(nid))
+		return 0;
+
+	mutex_lock(&node_private_lock);
+	mem_hotplug_begin();
+
+	pgdat = NODE_DATA(nid);
+	np = rcu_dereference_protected(pgdat->node_private,
+				       lockdep_is_held(&node_private_lock));
+	if (!np) {
+		mem_hotplug_done();
+		mutex_unlock(&node_private_lock);
+		return 0;
+	}
+
+	/*
+	 * Only unregister if all memory is offline and N_MEMORY_PRIVATE is
+	 * cleared. N_MEMORY_PRIVATE is cleared by offline_pages() when the
+	 * last memory block is offlined.
+	 */
+	if (node_state(nid, N_MEMORY_PRIVATE)) {
+		mem_hotplug_done();
+		mutex_unlock(&node_private_lock);
+		return -EBUSY;
+	}
+
+	rcu_assign_pointer(pgdat->node_private, NULL);
+	pgdat->private = false;
+
+	mem_hotplug_done();
+	mutex_unlock(&node_private_lock);
+
+	synchronize_rcu();
+
+	if (!refcount_dec_and_test(&np->refcount))
+		wait_for_completion(&np->released);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(node_private_unregister);
+
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 /**
@@ -959,6 +1152,7 @@ static struct node_attr node_state_attr[] = {
 	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
+	[N_MEMORY_PRIVATE] = _NODE_ATTR(has_private_memory, N_MEMORY_PRIVATE),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
@@ -972,6 +1166,7 @@ static struct attribute *node_state_attrs[] = {
 	&node_state_attr[N_HIGH_MEMORY].attr.attr,
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
+	&node_state_attr[N_MEMORY_PRIVATE].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
 	NULL
@@ -1007,5 +1202,7 @@ void __init node_dev_init(void)
 			panic("%s() failed to add node: %d\n", __func__, ret);
 	}
 
+	node_private_initialized = true;
+
 	register_memory_blocks_under_nodes();
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b01cb1e49896..992eb1c5a2c6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -25,6 +25,8 @@
 #include <linux/zswap.h>
 #include <asm/page.h>
 
+struct node_private;
+
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
 #define MAX_PAGE_ORDER 10
@@ -1514,6 +1516,8 @@ typedef struct pglist_data {
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
 #ifdef CONFIG_NUMA
 	struct memory_tier __rcu *memtier;
+	struct node_private __rcu *node_private;
+	bool private;
 #endif
 #ifdef CONFIG_MEMORY_FAILURE
 	struct memory_failure_stats mf_stats;
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
new file mode 100644
index 000000000000..6a70ec39d569
--- /dev/null
+++ b/include/linux/node_private.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NODE_PRIVATE_H
+#define _LINUX_NODE_PRIVATE_H
+
+#include <linux/completion.h>
+#include <linux/mm.h>
+#include <linux/nodemask.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+
+struct page;
+struct vm_area_struct;
+struct vm_fault;
+
+/**
+ * struct node_private_ops - Callbacks for private node services
+ *
+ * Services register these callbacks to intercept MM operations that affect
+ * their private nodes.
+ *
+ * Flag bits control which MM subsystems may operate on folios on this node.
+ *
+ * The pgdat->node_private pointer is RCU-protected.  Callbacks fall into
+ * three categories based on their calling context:
+ *
+ * Folio-referenced callbacks (RCU released before callback):
+ *   The caller holds a reference to a folio on the private node, which
+ *   pins the node's memory online and prevents node_private teardown.
+ *
+ * Refcounted callbacks (RCU released before callback):
+ *   The caller has no folio on the private node (e.g., folios are on a
+ *   source node being migrated TO this node).  A temporary refcount is
+ *   taken on node_private under rcu_read_lock to keep the structure (and
+ *   the service module) alive across the callback.  node_private_unregister
+ *   waits for all temporary references to drain before returning.
+ *
+ * Non-folio callbacks (rcu_read_lock held during callback):
+ *   No folio reference exists, so rcu_read_lock is held across the
+ *   callback to prevent node_private from being freed.
+ *   These callbacks MUST NOT sleep.
+ *
+ * @flags: Operation exclusion flags (NP_OPS_* constants).
+ *
+ */
+struct node_private_ops {
+	unsigned long flags;
+};
+
+/**
+ * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
+ *
+ * This structure is allocated by the driver and passed to node_private_register().
+ * The driver owns the memory and must ensure it remains valid until after
+ * node_private_unregister() returns with the reference count dropped to 0.
+ *
+ * @owner: Opaque driver identifier
+ * @refcount: Reference count (1 = registered; temporary refs for non-folio
+ *		callbacks that may sleep; 0 = fully released)
+ * @released: Signaled when refcount drops to 0; unregister waits on this
+ * @ops: Service callbacks and exclusion flags (NULL until service registers)
+ */
+struct node_private {
+	void *owner;
+	refcount_t refcount;
+	struct completion released;
+	const struct node_private_ops *ops;
+};
+
+#ifdef CONFIG_NUMA
+
+#include <linux/mmzone.h>
+
+/**
+ * folio_is_private_node - Check if folio is on an N_MEMORY_PRIVATE node
+ * @folio: The folio to check
+ *
+ * Returns true if the folio resides on a private node.
+ */
+static inline bool folio_is_private_node(struct folio *folio)
+{
+	return node_state(folio_nid(folio), N_MEMORY_PRIVATE);
+}
+
+/**
+ * page_is_private_node - Check if page is on an N_MEMORY_PRIVATE node
+ * @page: The page to check
+ *
+ * Returns true if the page resides on a private node.
+ */
+static inline bool page_is_private_node(struct page *page)
+{
+	return node_state(page_to_nid(page), N_MEMORY_PRIVATE);
+}
+
+static inline const struct node_private_ops *
+folio_node_private_ops(struct folio *folio)
+{
+	const struct node_private_ops *ops;
+	struct node_private *np;
+
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(folio_nid(folio))->node_private);
+	ops = np ? np->ops : NULL;
+	rcu_read_unlock();
+
+	return ops;
+}
+
+static inline unsigned long node_private_flags(int nid)
+{
+	struct node_private *np;
+	unsigned long flags;
+
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	flags = (np && np->ops) ? np->ops->flags : 0;
+	rcu_read_unlock();
+
+	return flags;
+}
+
+static inline bool folio_private_flags(struct folio *f, unsigned long flag)
+{
+	return node_private_flags(folio_nid(f)) & flag;
+}
+
+static inline bool node_private_has_flag(int nid, unsigned long flag)
+{
+	return node_private_flags(nid) & flag;
+}
+
+static inline bool zone_private_flags(struct zone *z, unsigned long flag)
+{
+	return node_private_flags(zone_to_nid(z)) & flag;
+}
+
+#else /* !CONFIG_NUMA */
+
+static inline bool folio_is_private_node(struct folio *folio)
+{
+	return false;
+}
+
+static inline bool page_is_private_node(struct page *page)
+{
+	return false;
+}
+
+static inline const struct node_private_ops *
+folio_node_private_ops(struct folio *folio)
+{
+	return NULL;
+}
+
+static inline unsigned long node_private_flags(int nid)
+{
+	return 0;
+}
+
+static inline bool folio_private_flags(struct folio *f, unsigned long flag)
+{
+	return false;
+}
+
+static inline bool node_private_has_flag(int nid, unsigned long flag)
+{
+	return false;
+}
+
+static inline bool zone_private_flags(struct zone *z, unsigned long flag)
+{
+	return false;
+}
+
+#endif /* CONFIG_NUMA */
+
+#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
+
+int node_private_register(int nid, struct node_private *np);
+int node_private_unregister(int nid);
+int node_private_set_ops(int nid, const struct node_private_ops *ops);
+int node_private_clear_ops(int nid, const struct node_private_ops *ops);
+
+#else /* !CONFIG_NUMA || !CONFIG_MEMORY_HOTPLUG */
+
+static inline int node_private_register(int nid, struct node_private *np)
+{
+	return -ENODEV;
+}
+
+static inline int node_private_unregister(int nid)
+{
+	return 0;
+}
+
+static inline int node_private_set_ops(int nid,
+				       const struct node_private_ops *ops)
+{
+	return -ENODEV;
+}
+
+static inline int node_private_clear_ops(int nid,
+					 const struct node_private_ops *ops)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_NUMA && CONFIG_MEMORY_HOTPLUG */
+
+#endif /* _LINUX_NODE_PRIVATE_H */
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index bd38648c998d..c9bcfd5a9a06 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -391,6 +391,7 @@ enum node_states {
 	N_HIGH_MEMORY = N_NORMAL_MEMORY,
 #endif
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
+	N_MEMORY_PRIVATE,	/* The node's memory is private */
 	N_CPU,		/* The node has one or more cpus */
 	N_GENERIC_INITIATOR,	/* The node has one or more Generic Initiators */
 	NR_NODE_STATES
-- 
2.53.0


