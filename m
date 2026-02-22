Return-Path: <cgroups+bounces-14124-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDusBwLEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14124-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B350516EB12
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F0493012E5B
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC012417C3;
	Sun, 22 Feb 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cuYnE2WN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E352405E7
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750225; cv=none; b=f3PczGLrNczMgo6Hl+7ugDldORHLRdU3ZQGmPMXelXElQzVJOByBYoZjGFfi4YXVbeLnc0RWLMYR3MeI+k224j1mxQBh59VPVhtoAce+EiStwZwK2D6/cBHkotzLZJY+QDhv6XZ2NS08/Nh7uEkWJ+E4Dv3ABAs/LAcEm+uykEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750225; c=relaxed/simple;
	bh=zs0qPPz1cXLwzykOWwAs3OVPMWhIFtepSRt4f1NIIrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4EJ89KZ+aEvaSmF0GOVJG9g06vBG7t6FsYs/r2PM+3o/B2C1ecW6z3fDSzj4zLYV//ptnAKZZKA6bQdoqEmtHm7x7BfId8H8s0SWXJZYxmiSsDjjuPTMCe4KrGmKvL/+K/Xmj0opE+5XQIRVJLZDxTl5M4dRsulgXkXIJearn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cuYnE2WN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506cb1b63d0so36185091cf.2
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750222; x=1772355022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTSr2egiGZrzh+7+ZlbqD5qhC+A1cnXWqtUesRojnlw=;
        b=cuYnE2WNllRK1BaGXcrjBaqbBcUpbnDsQh4X+kqsCNCrQDhCg2GLXBOZhc2sScLELh
         /QyqlcrpK7nf3/LcZVlIMfphkGEcKuP7eY5DrjExPo3CaYyONBU97OUwm6IQt3iGb+Ky
         27LKBkJiIx4Uyb+yRvDenjVQFZsZnsZuA1fQ7/gFfMAljpqucMNvPDGYVyP7He+x3jZh
         yVchzDyQ+SPfyBSR1pdflXipR6Q/nlyO0uUpgV515aOjsC/X1Sz4PfwYH2OkR0ST46iD
         mSt4Gdu9S7sFpKXjavmQXDAsc+HBsDN1j30QbiS0nH1niArBmwXy6J6LP4Jkfp6aQ7ir
         wuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750222; x=1772355022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTSr2egiGZrzh+7+ZlbqD5qhC+A1cnXWqtUesRojnlw=;
        b=VasWUdRjGqcktCc/VxXvAntoDb4v960vb4QXUM57AZpT6LTlpHXOV05BY5fgOyrdR+
         g/cZ9V2Rpwd5iRjoJaKUcL1sKtxudnX9kAcBxYpXJOETXKd2JjGCDX9RnPjT0P5nbnpc
         CFLf9EzgPkFaQZRMZC69ZMjUfHnOIIspTkAFsFihe3mljWUDFMl0b+Lzu5IG9pvMcUxV
         lzBs0j7joAzjjKJeybWMEZPj6qQbTN7GnHOETWcg97/rorQSaWVx+W+YVFd18tKDzJmz
         o2N0oO2cykbq/uzA+++pqV3GuoBY1mpILyLT3/d9/siq5Ii15Yi+5as6C2rSTHCJwtmg
         hvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZPSXHYOxEIRZ9aubqjVUsRH4OhFpFztE5A4l9K0gM2lIzemrbxJiNsuFNgKG3SBgy//Gt3ci@vger.kernel.org
X-Gm-Message-State: AOJu0YyeU3San0xEtsQID0Fy4b7jvAstdusY7XlWfPFjOOGSooHWGltr
	cxH+1eSTsXSDPC0chA85NzyuH6SengHaOv6LSxIV3w7PjiDY+jufJs0KKoMUikmisL0=
X-Gm-Gg: AZuq6aJCTpkiB69chgHmOZA/hiaTZjYWYZcDzufFHw7Aa3cnCfGx3W9WlGGHpGpZhb0
	4iqixsPqbfuZUA0ngzTjYel8rC0cnfaLKTHFTSrEBB0nU6nH0ZjvkECFiVorY8D+ZUo22t7Vskh
	lhVAbhDU8oZkzoKApaA8X6b3hSZRkpX8M4eKixAjn2Wb7ZK/L/scws1A2f/n5SaaKRewjv4DRpo
	yITeCYXpjWjpJx9Fch9FopCDQ+/NA4VW2R6/5hYkyL/Lbbl8q5hfTXhXAkV4xIaJ0cEXH4WlS5p
	iLXKK8V7AxIUysyMW7xQW6VLbkpXjmrBzOMqeZ1bjCUH5tJi/cf2XZiPYDhAYL+nrnjIAqqVXRB
	LeA0g5S9Y08mq2Sp/B9j509LKoOOJ2UrYJ+j2OtEbkBEl5yKRI2yuAoNWMhmljy/aQaR+zcSu4O
	Oxbz0B6VpJrFUGfCkeYD1gt/EWnAumxynSiaRkIkI9Bf8gSPvkh8gKHrdA44qT8Y0XyVgUWGdGT
	Ab7ISWF4ZgipAM=
X-Received: by 2002:a05:622a:96:b0:506:bc9c:e140 with SMTP id d75a77b69052e-5070bcfa5d8mr76045201cf.71.1771750221945;
        Sun, 22 Feb 2026 00:50:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:21 -0800 (PST)
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
Subject: [RFC PATCH v4 23/27] mm/cram: add compressed ram memory management subsystem
Date: Sun, 22 Feb 2026 03:48:38 -0500
Message-ID: <20260222084842.1824063-24-gourry@gourry.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14124-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: B350516EB12
X-Rspamd-Action: no action

Add the CRAM (Compressed RAM) subsystem that manages folios demoted
to N_MEMORY_PRIVATE nodes via the standard kernel LRU.

We limit entry into CRAM by demotion in to provide devices a way for
drivers to close access - which allows the system to stabiliz under
memory pressure (the device can run out of real memory when compression
ratios drop too far).

We utilize write-protect to prevent unbounded writes to compressed
memory pages, which may cause run-away compression ratio loss without
a reliable way to prevent the degenerate case (cascading poisons).

CRAM provides the bridge between the mm/ private node infrastructure
and compressed memory hardware.  Folios are aged by kswapd on the
private node and reclaimed to swap when the device signals pressure.

Write faults trigger promotion back to regular DRAM via the
ops->handle_fault callback.

Device pressure is communicated via watermark_boost on the private
node's zone.

CRAM registers node_private_ops with:
  - handle_fault:   promotes folio back to DRAM on write
  - migrate_to:     custom demotion to the CRAM node
  - folio_migrate:  (no-op)
  - free_folio:     zeroes pages on free to scrub stale data
  - reclaim_policy: provides mayswap/writeback/boost overrides
  - flags: NP_OPS_MIGRATION | NP_OPS_DEMOTION |
	   NP_OPS_NUMA_BALANCING | NP_OPS_PROTECT_WRITE
           NP_OPS_RECLAIM

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cram.h |  66 ++++++
 mm/Kconfig           |  10 +
 mm/Makefile          |   1 +
 mm/cram.c            | 508 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 585 insertions(+)
 create mode 100644 include/linux/cram.h
 create mode 100644 mm/cram.c

diff --git a/include/linux/cram.h b/include/linux/cram.h
new file mode 100644
index 000000000000..a3c10362fd4f
--- /dev/null
+++ b/include/linux/cram.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CRAM_H
+#define _LINUX_CRAM_H
+
+#include <linux/mm_types.h>
+
+struct folio;
+struct list_head;
+struct vm_fault;
+
+#define CRAM_PRESSURE_MAX	1000
+
+/**
+ * cram_flush_cb_t - Driver callback invoked when a folio on a private node
+ *                   is freed (refcount reaches zero).
+ * @folio: the folio being freed
+ * @private: opaque driver data passed at registration
+ *
+ * Return:
+ *   0: Flush resolved -- page should return to buddy allocator (e.g., flush
+ *      record bit was set, meaning this free is from our own flush resolution)
+ *   1: Page deferred -- driver took a reference, page will be flushed later.
+ *      Do NOT return to buddy allocator.
+ *   2: Buffer full -- caller should zero the page and return to buddy.
+ */
+typedef int (*cram_flush_cb_t)(struct folio *folio, void *private);
+
+#ifdef CONFIG_CRAM
+
+int cram_register_private_node(int nid, void *owner,
+			       cram_flush_cb_t flush_cb, void *flush_data);
+int cram_unregister_private_node(int nid);
+int cram_unpurge(int nid);
+void cram_set_pressure(int nid, unsigned int pressure);
+void cram_clear_pressure(int nid);
+
+#else /* !CONFIG_CRAM */
+
+static inline int cram_register_private_node(int nid, void *owner,
+					     cram_flush_cb_t flush_cb,
+					     void *flush_data)
+{
+	return -ENODEV;
+}
+
+static inline int cram_unregister_private_node(int nid)
+{
+	return -ENODEV;
+}
+
+static inline int cram_unpurge(int nid)
+{
+	return -ENODEV;
+}
+
+static inline void cram_set_pressure(int nid, unsigned int pressure)
+{
+}
+
+static inline void cram_clear_pressure(int nid)
+{
+}
+
+#endif /* CONFIG_CRAM */
+
+#endif /* _LINUX_CRAM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index bd0ea5454af8..054462b954d8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -662,6 +662,16 @@ config MIGRATION
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
+config CRAM
+	bool "Compressed RAM - private node memory management"
+	depends on NUMA
+	depends on MIGRATION
+	depends on MEMORY_HOTPLUG
+	help
+	  Enables management of N_MEMORY_PRIVATE nodes for compressed RAM
+	  and similar use cases. Provides demotion, promotion, and lifecycle
+	  management for private memory nodes.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index 2d0570a16e5b..0e1421512643 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
+obj-$(CONFIG_CRAM) += cram.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_LIVEUPDATE) += memfd_luo.o
diff --git a/mm/cram.c b/mm/cram.c
new file mode 100644
index 000000000000..6709e61f5b9d
--- /dev/null
+++ b/mm/cram.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mm/cram.c - Compressed RAM / private node memory management
+ *
+ * Copyright 2026 Meta Technologies Inc.
+ *   Author: Gregory Price <gourry@gourry.net>
+ *
+ * Manages folios demoted to N_MEMORY_PRIVATE nodes via the standard kernel
+ * LRU.  Folios are aged by kswapd on the private node and reclaimed to swap
+ * (demotion is suppressed for private nodes).  Write faults trigger promotion
+ * back to regular DRAM via the ops->handle_fault callback.
+ *
+ * All reclaim/demotion uses the standard vmscan infrastructure. Device pressure
+ * is communicated via watermark_boost on the private node's zone.
+ */
+
+#include <linux/atomic.h>
+#include <linux/cpuset.h>
+#include <linux/cram.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/jiffies.h>
+#include <linux/highmem.h>
+#include <linux/memory-tiers.h>
+#include <linux/list.h>
+#include <linux/migrate.h>
+#include <linux/mm.h>
+#include <linux/huge_mm.h>
+#include <linux/mmzone.h>
+#include <linux/mutex.h>
+#include <linux/nodemask.h>
+#include <linux/node_private.h>
+#include <linux/pagemap.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+#include <linux/swap.h>
+
+#include "internal.h"
+
+struct cram_node {
+	void		*owner;
+	bool		purged;		/* node is being torn down */
+	unsigned int	pressure;
+	refcount_t	refcount;
+	cram_flush_cb_t	flush_cb;	/* optional driver flush callback */
+	void		*flush_data;	/* opaque data for flush_cb */
+};
+
+static struct cram_node *cram_nodes[MAX_NUMNODES];
+static DEFINE_MUTEX(cram_mutex);
+
+static inline bool cram_valid_nid(int nid)
+{
+	return nid >= 0 && nid < MAX_NUMNODES;
+}
+
+static inline struct cram_node *get_cram_node(int nid)
+{
+	struct cram_node *cn;
+
+	if (!cram_valid_nid(nid))
+		return NULL;
+
+	rcu_read_lock();
+	cn = rcu_dereference(cram_nodes[nid]);
+	if (cn && !refcount_inc_not_zero(&cn->refcount))
+		cn = NULL;
+	rcu_read_unlock();
+
+	return cn;
+}
+
+static inline void put_cram_node(struct cram_node *cn)
+{
+	if (cn)
+		refcount_dec(&cn->refcount);
+}
+
+static void cram_zero_folio(struct folio *folio)
+{
+	unsigned int i, nr = folio_nr_pages(folio);
+
+	if (want_init_on_free())
+		return;
+
+	for (i = 0; i < nr; i++)
+		clear_highpage(folio_page(folio, i));
+}
+
+static bool cram_free_folio_cb(struct folio *folio)
+{
+	int nid = folio_nid(folio);
+	struct cram_node *cn;
+	int ret;
+
+	cn = get_cram_node(nid);
+	if (!cn)
+		goto zero_and_free;
+
+	if (!cn->flush_cb)
+		goto zero_and_free_put;
+
+	ret = cn->flush_cb(folio, cn->flush_data);
+	put_cram_node(cn);
+
+	switch (ret) {
+	case 0:
+		/* Flush resolved: return to buddy (already zeroed by device) */
+		return false;
+	case 1:
+		/* Deferred: driver holds a ref, do not free to buddy */
+		return true;
+	case 2:
+	default:
+		/* Buffer full or unknown: zero locally, return to buddy */
+		goto zero_and_free;
+	}
+
+zero_and_free_put:
+	put_cram_node(cn);
+zero_and_free:
+	cram_zero_folio(folio);
+	return false;
+}
+
+static struct folio *alloc_cram_folio(struct folio *src, unsigned long private)
+{
+	int nid = (int)private;
+	unsigned int order = folio_order(src);
+	gfp_t gfp = GFP_PRIVATE | __GFP_KSWAPD_RECLAIM |
+		     __GFP_HIGHMEM | __GFP_MOVABLE |
+		     __GFP_NOWARN | __GFP_NORETRY;
+
+	/* Stop allocating if backpressure fired mid-batch */
+	if (node_private_migration_blocked(nid))
+		return NULL;
+
+	if (order)
+		gfp |= __GFP_COMP;
+
+	return __folio_alloc_node(gfp, order, nid);
+}
+
+static void cram_put_new_folio(struct folio *folio, unsigned long private)
+{
+	cram_zero_folio(folio);
+	folio_put(folio);
+}
+
+/*
+ * Allocate a DRAM folio for promotion out of a private node.
+ *
+ * Unlike alloc_migration_target(), this does NOT strip __GFP_RECLAIM for
+ * large folios, the generic helper does that because THP allocations are
+ * opportunistic, but promotion from a private node is mandatory: the page
+ * MUST move to DRAM or the process cannot make forward progress.
+ *
+ * __GFP_RETRY_MAYFAIL tells the allocator to try hard (multiple reclaim
+ * rounds, wait for writeback) before giving up.
+ */
+static struct folio *alloc_cram_promote_folio(struct folio *src,
+					      unsigned long private)
+{
+	int nid = (int)private;
+	unsigned int order = folio_order(src);
+	gfp_t gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
+
+	if (order)
+		gfp |= __GFP_COMP;
+
+	return __folio_alloc(gfp, order, nid, NULL);
+}
+
+static int cram_migrate_to(struct list_head *demote_folios, int to_nid,
+			   enum migrate_mode mode,
+			   enum migrate_reason reason,
+			   unsigned int *nr_succeeded)
+{
+	struct cram_node *cn;
+	unsigned int nr_success = 0;
+	int ret = 0;
+
+	cn = get_cram_node(to_nid);
+	if (!cn)
+		return -ENODEV;
+
+	if (cn->purged) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Block new demotions at maximum pressure */
+	if (READ_ONCE(cn->pressure) >= CRAM_PRESSURE_MAX) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	ret = migrate_pages(demote_folios, alloc_cram_folio, cram_put_new_folio,
+			    (unsigned long)to_nid, mode, reason,
+			    &nr_success);
+
+	/*
+	 * migrate_folio_move() calls folio_add_lru() for each migrated
+	 * folio, but that only adds the folio to a per-CPU batch, 
+	 * PG_lru is not set until the batch is drained.  Drain now so
+	 * that cram_fault() can isolate these folios immediately.
+	 *
+	 * Use lru_add_drain_all() because migrate_pages() may process
+	 * folios across CPUs, and the local drain might miss batches
+	 * filled on other CPUs.
+	 */
+	if (nr_success)
+		lru_add_drain_all();
+out:
+	put_cram_node(cn);
+	if (nr_succeeded)
+		*nr_succeeded = nr_success;
+	return ret;
+}
+
+static void cram_release_ptl(struct vm_fault *vmf, enum pgtable_level level)
+{
+	if (level == PGTABLE_LEVEL_PTE)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	else
+		spin_unlock(vmf->ptl);
+}
+
+static vm_fault_t cram_fault(struct folio *folio, struct vm_fault *vmf,
+			     enum pgtable_level level)
+{
+	struct folio *f, *f2;
+	struct cram_node *cn;
+	unsigned int nr_succeeded = 0;
+	int nid;
+	LIST_HEAD(folios);
+
+	nid = folio_nid(folio);
+
+	cn = get_cram_node(nid);
+	if (!cn) {
+		cram_release_ptl(vmf, level);
+		return 0;
+	}
+
+	/*
+	 * Isolate from LRU while holding PTL.  This serializes against
+	 * other CPUs faulting on the same folio: only one CPU can clear
+	 * PG_lru under the PTL, and it proceeds to migration.  Other
+	 * CPUs find the folio already isolated and bail out, preventing
+	 * the refcount pile-up that causes migrate_pages() to fail with
+	 * -EAGAIN.
+	 *
+	 * No explicit folio_get() is needed: the page table entry holds
+	 * a reference (we still hold PTL), and folio_isolate_lru() takes
+	 * its own reference.  This matches do_numa_page()'s pattern.
+	 *
+	 * PG_lru should already be set: cram_migrate_to() drains per-CPU
+	 * LRU batches after migration, and the failure path below
+	 * drains after putback.
+	 */
+	if (!folio_isolate_lru(folio)) {
+		put_cram_node(cn);
+		cram_release_ptl(vmf, level);
+		cond_resched();
+		return 0;
+	}
+
+	/* Folio isolated, release PTL, proceed to migration */
+	cram_release_ptl(vmf, level);
+
+	node_stat_mod_folio(folio,
+			    NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			    folio_nr_pages(folio));
+	list_add(&folio->lru, &folios);
+
+	migrate_pages(&folios, alloc_cram_promote_folio, NULL,
+		      (unsigned long)numa_node_id(),
+		      MIGRATE_SYNC, MR_NUMA_MISPLACED, &nr_succeeded);
+
+	/* Put failed folios back on LRU; retry on next fault */
+	list_for_each_entry_safe(f, f2, &folios, lru) {
+		list_del(&f->lru);
+		node_stat_mod_folio(f,
+				    NR_ISOLATED_ANON + folio_is_file_lru(f),
+				    -folio_nr_pages(f));
+		folio_putback_lru(f);
+	}
+
+	/*
+	 * If migration failed, folio_putback_lru() batched the folio
+	 * into this CPU's per-CPU LRU cache (PG_lru not yet set).
+	 * Drain now so the folio is immediately visible on the LRU,
+	 * the next fault can then isolate it without an IPI storm
+	 * via lru_add_drain_all().
+	 *
+	 * Return VM_FAULT_RETRY after releasing the fault lock so the
+	 * arch handler retries from scratch.  Without this, returning 0
+	 * causes a tight livelock: the process immediately re-faults on
+	 * the same write-protected entry, alloc fails again, and
+	 * VM_FAULT_OOM eventually leaks out through a stale path.
+	 * VM_FAULT_RETRY gives the system breathing room to reclaim.
+	 */
+	if (!nr_succeeded) {
+		lru_add_drain();
+		cond_resched();
+		put_cram_node(cn);
+		release_fault_lock(vmf);
+		return VM_FAULT_RETRY;
+	}
+
+	cond_resched();
+	put_cram_node(cn);
+	return 0;
+}
+
+static void cram_folio_migrate(struct folio *src, struct folio *dst)
+{
+}
+
+static void cram_reclaim_policy(int nid, struct node_reclaim_policy *policy)
+{
+	policy->may_swap = true;
+	policy->may_writepage = true;
+	policy->managed_watermarks = true;
+}
+
+static vm_fault_t cram_handle_fault(struct folio *folio, struct vm_fault *vmf,
+				    enum pgtable_level level)
+{
+	return cram_fault(folio, vmf, level);
+}
+
+static const struct node_private_ops cram_ops = {
+	.handle_fault		= cram_handle_fault,
+	.migrate_to		= cram_migrate_to,
+	.folio_migrate		= cram_folio_migrate,
+	.free_folio		= cram_free_folio_cb,
+	.reclaim_policy		= cram_reclaim_policy,
+	.flags			= NP_OPS_MIGRATION | NP_OPS_DEMOTION |
+				  NP_OPS_NUMA_BALANCING | NP_OPS_PROTECT_WRITE |
+				  NP_OPS_RECLAIM,
+};
+
+int cram_register_private_node(int nid, void *owner,
+			       cram_flush_cb_t flush_cb, void *flush_data)
+{
+	struct cram_node *cn;
+	int ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return -EINVAL;
+
+	mutex_lock(&cram_mutex);
+
+	cn = cram_nodes[nid];
+	if (cn) {
+		if (cn->owner != owner) {
+			mutex_unlock(&cram_mutex);
+			return -EBUSY;
+		}
+		mutex_unlock(&cram_mutex);
+		return 0;
+	}
+
+	cn = kzalloc(sizeof(*cn), GFP_KERNEL);
+	if (!cn) {
+		mutex_unlock(&cram_mutex);
+		return -ENOMEM;
+	}
+
+	cn->owner = owner;
+	cn->pressure = 0;
+	cn->flush_cb = flush_cb;
+	cn->flush_data = flush_data;
+	refcount_set(&cn->refcount, 1);
+
+	ret = node_private_set_ops(nid, &cram_ops);
+	if (ret) {
+		mutex_unlock(&cram_mutex);
+		kfree(cn);
+		return ret;
+	}
+
+	rcu_assign_pointer(cram_nodes[nid], cn);
+
+	/* Start kswapd on the private node for LRU aging and reclaim */
+	kswapd_run(nid);
+
+	mutex_unlock(&cram_mutex);
+
+	/* Now that ops->migrate_to is set, refresh demotion targets */
+	memory_tier_refresh_demotion();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cram_register_private_node);
+
+int cram_unregister_private_node(int nid)
+{
+	struct cram_node *cn;
+
+	if (!cram_valid_nid(nid))
+		return -EINVAL;
+
+	mutex_lock(&cram_mutex);
+
+	cn = cram_nodes[nid];
+	if (!cn) {
+		mutex_unlock(&cram_mutex);
+		return -ENODEV;
+	}
+
+	kswapd_stop(nid);
+
+	WARN_ON(node_private_clear_ops(nid, &cram_ops));
+	rcu_assign_pointer(cram_nodes[nid], NULL);
+	mutex_unlock(&cram_mutex);
+
+	/* ops->migrate_to cleared, refresh demotion targets */
+	memory_tier_refresh_demotion();
+
+	synchronize_rcu();
+	while (!refcount_dec_if_one(&cn->refcount))
+		cond_resched();
+	kfree(cn);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cram_unregister_private_node);
+
+int cram_unpurge(int nid)
+{
+	struct cram_node *cn;
+
+	if (!cram_valid_nid(nid))
+		return -EINVAL;
+
+	mutex_lock(&cram_mutex);
+
+	cn = cram_nodes[nid];
+	if (!cn) {
+		mutex_unlock(&cram_mutex);
+		return -ENODEV;
+	}
+
+	cn->purged = false;
+
+	mutex_unlock(&cram_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cram_unpurge);
+
+void cram_set_pressure(int nid, unsigned int pressure)
+{
+	struct cram_node *cn;
+	struct node_private *np;
+	struct zone *zone;
+	unsigned long managed, boost;
+
+	cn = get_cram_node(nid);
+	if (!cn)
+		return;
+
+	if (pressure > CRAM_PRESSURE_MAX)
+		pressure = CRAM_PRESSURE_MAX;
+
+	WRITE_ONCE(cn->pressure, pressure);
+
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	/* Block demotions only at maximum pressure */
+	if (np)
+		WRITE_ONCE(np->migration_blocked,
+			   pressure >= CRAM_PRESSURE_MAX);
+	rcu_read_unlock();
+
+	zone = NULL;
+	for (int i = 0; i < MAX_NR_ZONES; i++) {
+		struct zone *z = &NODE_DATA(nid)->node_zones[i];
+
+		if (zone_managed_pages(z) > 0) {
+			zone = z;
+			break;
+		}
+	}
+	if (!zone) {
+		put_cram_node(cn);
+		return;
+	}
+	managed = zone_managed_pages(zone);
+
+	/* Boost proportional to pressure. 0:no boost, 1000:full managed */
+	boost = (managed * (unsigned long)pressure) / CRAM_PRESSURE_MAX;
+	WRITE_ONCE(zone->watermark_boost, boost);
+
+	if (boost) {
+		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
+		wakeup_kswapd(zone, GFP_KERNEL, 0, ZONE_MOVABLE);
+	}
+
+	put_cram_node(cn);
+}
+EXPORT_SYMBOL_GPL(cram_set_pressure);
+
+void cram_clear_pressure(int nid)
+{
+	cram_set_pressure(nid, 0);
+}
+EXPORT_SYMBOL_GPL(cram_clear_pressure);
-- 
2.53.0


