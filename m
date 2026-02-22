Return-Path: <cgroups+bounces-14111-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBLcGQfEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14111-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F323116EB19
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A291830747B0
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD3223DD4;
	Sun, 22 Feb 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aKrpR0OV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2923643F
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750176; cv=none; b=AC2sPPQb/0rV53rj5ic9VffRBcrbHkfO4ynRQOTTG9PcBujIJtQp65EO0ujD1NU9ebTPchqMq2HdZe5RU6TJeP8LgxZi9kheD3lD0mQUaH+MKEIYDlgicAA39mqS6WsRl78mL7Kpxlbl/p9+nwl8pu3BvIQcfe+10QBBFn7Jcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750176; c=relaxed/simple;
	bh=Aefhw780FZYcBuGz8WT4CBUZ6IdM/Ont/+9yMbNMRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvenivHZL/Uu2A9TgzTaNN+QYs1zUfR5XWOQNYmnjKBFTEMXCxGT7Yg+7Q75zs0pqwS8WmLnnsZ3OBE1jiu4v4j2mieEBBFoPkbQGJxJpQa941kEDS5Wke/5PxQyMsmedhjeYGUjrSg/hiR0Rl0Jylk4MjDGWMc0BNEsJAFJ5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aKrpR0OV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506e287dd53so27494581cf.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750174; x=1772354974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV1BMLJRDB150NHPYMpWTJDZSx7tUpTBtDPGS7yRISs=;
        b=aKrpR0OVgjBkiQpAx1zP1rp3LyTnn9W4nwnchf95T1xfjihChVGz09JVeAx5MvG+Yn
         H5sYAO3ht1mGpchtZsW0cuWdmaFoQ+RKV2o43faVH0iDzwWEG4o8P2j33IJD6gJ3M8xe
         Va9FrBhHBtcOg1BVjjq+Qa6nOKCCL6mKnEssver606gWn2GXKbHt+3DIouktOdLrUe4V
         wMIOfdOb4MV8/6UH1st6eG6LcS9TDA012H4dC+XlNRD2uZ66VkUH+CScZbFcsBwdB20Y
         4tvsG7pLPETXPn5h8nOpu0gPwFBvxx8AO0ikzUPMfTkhp7ayNu5kRYbTVt8kLwcCfd0d
         fbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750174; x=1772354974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CV1BMLJRDB150NHPYMpWTJDZSx7tUpTBtDPGS7yRISs=;
        b=UlaBbhsrsBdBymBPCP9hOTS0gUEugjTJl7rCI/RAUuBlTOeR7YskVIaIKCULuWwtov
         ci/Y6vSmMjc4QnKERUYoF8jwxjTexeaPutRoHCEcfFdqtm3ZSfBcKT7eMutpieeqdJEY
         4Y6cD+/x2UuSInZhc+uf9U1ZGnOEtgaZSdWMHGbh6RPIGFRV6BOUDEjoODNNPMMzmrGF
         /7IN/2va02HHcVwN+k72u8A/ErushBlCeUxaJauzSS8adHNWAyO80Z7QjK/2d+DwGfDz
         FbL9rPRCNRwiPb2nXRh+zDsGnX0uDseRbRIfkOugwc1kb1Xvg1TxMx4oe6SMBrH18O/M
         R27Q==
X-Forwarded-Encrypted: i=1; AJvYcCUASXDujaTINAxkBxD0w+8bjBd18eaty+ble6AxhTlwJ0kDuSeUuErumGwdxuJKlTKJMZYW1UfH@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPYWPtK6s2RluUQBw/0hKyKEIF9/FoX/JR0xZJG03j8cOkZ7t
	2y9l4cUrrQi/kRQf2O/hCkK2B5zIIHhFAQL+n6q50XupHa4Ish1bP1CW/ULNCXvKUyY=
X-Gm-Gg: AZuq6aKmzjNaqIA6AxUhpUr6eHxA4cK6Vic9co9PzmlTibGH2w6REhQMqmZVFDr8r6L
	HXfPBerDbtRelfH55MuylJ0h67o6T5XqIan1sj4HqVd2Q2xl9T8xekDYDZrGP7KallvS8jfLXm/
	Tt4+gEZo+8HAa9yMFNGu6mErnQK8P/A5gtAtKuEw1TfdTxceHtqFlVyfuJadYyj5i/vmeKZw4+b
	0YcCcaREoXqQzEyJ+Vh0eqADkfdBHvm7CjnElkP5TjzNAv2QURxIb+btcoVR9T2utVuHUuqrmJ3
	gnz1mVXC5TadJyLUDpsmQEf4FHM9hjiEeoopLKBGh0/ReAeExxckJq/YNDOWTqmQZXXavd5SfYR
	lMXdc3DCTkopxrz4m4mRhIjSrs8TbWsHe7s7PqYfGgJ6uggALpg6ZTPDJDpCjO23EjBH3q/TZ8A
	5LeOGz31rIOCBM+Id9UzIOYAUqUGw9RNfs7GDQjY//hz3dsTrmjMOiUZH77TZ+TQcX3GrjZadRj
	kALvdGu2QMxIUA=
X-Received: by 2002:a05:622a:1903:b0:4ff:c884:31ad with SMTP id d75a77b69052e-5070bcb47ebmr73646721cf.53.1771750173883;
        Sun, 22 Feb 2026 00:49:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:33 -0800 (PST)
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
Subject: [RFC PATCH v4 10/27] mm/swap: add free_folio callback for folio release cleanup
Date: Sun, 22 Feb 2026 03:48:25 -0500
Message-ID: <20260222084842.1824063-11-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-14111-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,gourry.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F323116EB19
X-Rspamd-Action: no action

When a folio's refcount drops to zero, the service may need to perform
cleanup before the page returns to the buddy allocator (e.g. zeroing
pages to scrub stale compressed data / release compression ratio).

Add folio_managed_on_free() to wrap both zone_device and private node
semantics for this operation since they are the same.

One difference between zone_device and private node folios:
  - private nodes may choose to either take a reference and return true
    ("handled"), or return false to return it back to the buddy.

  - zone_device returns the page to the buddy (always returns true)

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h |  6 ++++++
 mm/internal.h                | 30 ++++++++++++++++++++++++++++++
 mm/swap.c                    | 21 ++++++++++-----------
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7687a4cf990c..09ea7c4cb13c 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -39,10 +39,16 @@ struct vm_fault;
  *   callback to prevent node_private from being freed.
  *   These callbacks MUST NOT sleep.
  *
+ * @free_folio: Called when a folio refcount drops to 0
+ *   [folio-referenced callback]
+ *   Returns: true if handled (skip return to buddy)
+ *            false if no op (return to buddy)
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
 struct node_private_ops {
+	bool (*free_folio)(struct folio *folio);
 	unsigned long flags;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 97023748e6a9..658da41cdb8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1412,6 +1412,36 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_folio(struct folio *folio);
 
+/**
+ * folio_managed_on_free - Notify managed-memory service that folio
+ *                         refcount reached zero.
+ * @folio: the folio being freed
+ *
+ * Returns true if the folio is fully handled (zone_device -- caller
+ * must return immediately).  Returns false if the callback ran but
+ * the folio should continue through the normal free path
+ * (private_node -- pages go back to buddy).
+ *
+ * Returns false for normal folios (no-op).
+ */
+static inline bool folio_managed_on_free(struct folio *folio)
+{
+	if (folio_is_zone_device(folio)) {
+		free_zone_device_folio(folio);
+		return true;
+	}
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->free_folio) {
+			if (ops->free_folio(folio))
+				return true;
+		}
+	}
+	return false;
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/swap.c b/mm/swap.c
index 2260dcd2775e..dca306e1ae6d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -96,10 +97,9 @@ static void page_cache_release(struct folio *folio)
 
 void __folio_put(struct folio *folio)
 {
-	if (unlikely(folio_is_zone_device(folio))) {
-		free_zone_device_folio(folio);
-		return;
-	}
+	if (unlikely(folio_is_private_managed(folio)))
+		if (folio_managed_on_free(folio))
+			return;
 
 	if (folio_test_hugetlb(folio)) {
 		free_huge_folio(folio);
@@ -961,19 +961,18 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		if (is_huge_zero_folio(folio))
 			continue;
 
-		if (folio_is_zone_device(folio)) {
+		if (!folio_ref_sub_and_test(folio, nr_refs))
+			continue;
+
+		if (unlikely(folio_is_private_managed(folio))) {
 			if (lruvec) {
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (folio_ref_sub_and_test(folio, nr_refs))
-				free_zone_device_folio(folio);
-			continue;
+			if (folio_managed_on_free(folio))
+				continue;
 		}
 
-		if (!folio_ref_sub_and_test(folio, nr_refs))
-			continue;
-
 		/* hugetlb has its own memcg */
 		if (folio_test_hugetlb(folio)) {
 			if (lruvec) {
-- 
2.53.0


