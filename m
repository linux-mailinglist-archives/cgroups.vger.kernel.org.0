Return-Path: <cgroups+bounces-14121-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJIWLaLEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14121-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:56:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401B16EBAF
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 577B930BC1C1
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793A25DB0D;
	Sun, 22 Feb 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AMgGTcyf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655923C4FF
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750213; cv=none; b=WauBxBwurXREHWDLhr9cCJeJ9bG+NNLtQaqC+4aGtql9sk4EPtvgjSV9Og6pNeHAp8/hGnsQINoz6R1QLJKWS2JcnLwHgVO8GacSQ6NCLOsnVFUpP1N4MKcvKGzSaEH6ExokzsfHpCFAMqkG8r8vNBqtJ6ZToGNUDtnwqqcGy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750213; c=relaxed/simple;
	bh=FN4ZcFBXmxL8uNXxIrtPiA8q89iYFsEg9AGsn3itCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu3aljgtXPdoPRgCiJVneDf4quFBBmP84JQw9j0lnfDqj5QQfF8B/X/m3Cel2l2FNB98Ydsm7WFPuUL5XOCoBTK732TWm9avtp4Gqno4uINBrLHjK1LatjEgWvUCCRI0L7DWjOa0GjKqy3ElLGp2GBpaZ62H4viIuGP3laSl8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AMgGTcyf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50698970941so37365841cf.0
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750211; x=1772355011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=AMgGTcyfQf9iv055uiUbmo2/DT9ZzIlRdOWsoEXzGa4+dLTnjjAPBqH+bKkLciHrPo
         MCjf1nrpUeLkvrPoJAQeJZk4JbA5qaWd7LElyh3Hpj1+xiho2eydUOjGL26lEjb2oJ9b
         tltNFOtLr3Z4mB8k6hJQR4Vo1KoGEqXzqFd1Di39RBotgcEjavbAemGUUeHOXMeT+S7w
         PXAf43ug6v0b193VQTxW7RzYJxAUDIw6coy7fcC8n0Y+rdccyO+CpMA3sdCNJb1RUJPX
         WWFwFtv8teBXDON0TOvLtVyWcsUDwcrIj83hYFlM/Eo0aDVp2Ehoc7SigIvBomwHcKTf
         X0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750211; x=1772355011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=kia0xg9Pw06Y4usX6+UyzBGsb0mFJb+b7kxae0zqfl/uKz2f3PTpdjYOMWhTOixmGD
         dWxTLFs+vhbunTRBYLD+37Nb/V7SHjPzdjJ812QQGJyW/RhdF8nK7QrMijUgiWUVLTkX
         qA26Dez1yYEEW2MyMMIEnx4nGVg6tZklnziLoGJ8joCY2PMAqO8dezay4M+HcAIVG3PY
         iscKKJ2xCNe3fO1bDASeLBQ1Tr1dw3+to9UB0okkn4oEE/5MsBgZlJcyvgAwUGueP9Wk
         TyhdPO8gIniDg1wHWj5/8/3+v7w5PHuNsz2fpQxxA74y8Hl6LkHOHFoj8FyMHauswzNq
         7Bqw==
X-Forwarded-Encrypted: i=1; AJvYcCV9iOSIm/bHejkr1xPU4I5Cwn/qn4t+4QwtbfjldGu7Wp4+uQ6u2Q00p7y7QkGL+OasxPLTgYOb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1f8XLfPdtP579PS4Plm/YcNWqAmaZLGFtrz0X5XSrxM39X6yJ
	yl4EPUDfvSbCPKiMuk2SmGN2tajPlYu+HsxUIQ2uQqFnPgDZshcLglIeHXw438sxBDA=
X-Gm-Gg: AZuq6aLJ7WPeoHkEh/aZOBAxJEOG3S92fAzb7E2/yT5uoW8FH9T/M0JID378SkmHipx
	Gf60w7b+K9MFrbbHM0lMcnFAtnqa6xB0Py+zPgRWQAAPSMpHNcPu+u0Rfttwg0hY5zJGB/zmwfT
	6IwLkMRZwKd5ZMffU8w2tN2a4UkjOWjaZ+WAlnrVgmUKuyO2mLpOOo62Ze4hiAyY7lLpp4QK36e
	tnveLp4hqOJOYfWEBp6gW8ZXOqhY8GA2vD5zgyvG1toTvyHm+Ku/Pw6D6Wt5mdSHccVwF+ROGmX
	s1Tt+DzqubF/woQl5+XqltDr7Ahd9xTcC8ww0K5JGvedpJxbO3JJFMGc9+JJ819MV4yDrJk+61W
	7DNYRwCSu+OnKeo9sYXwZTt2yrnihWiYidma3Z+0RpWlsJ4/3oSpQOdqAPmYnTHcxEbptW2xdYP
	YxYNJZ572WZzUA4LU1HAf4QAVyaGHWprHirsYuo8hrNesVmo0dJ23qXlrUbVnarud4fnGv1w4zx
	d+6MAV9/2jZfwEf1Tu2+2k6Bg==
X-Received: by 2002:a05:622a:1789:b0:4ed:ddd9:1402 with SMTP id d75a77b69052e-5070bbddc75mr66100291cf.24.1771750210655;
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
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
Subject: [RFC PATCH v4 20/27] mm/gup: NP_OPS_LONGTERM_PIN - private node longterm pin support
Date: Sun, 22 Feb 2026 03:48:35 -0500
Message-ID: <20260222084842.1824063-21-gourry@gourry.net>
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
	TAGGED_FROM(0.00)[bounces-14121-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 3401B16EBAF
X-Rspamd-Action: no action

Private node folios should not be longterm-pinnable by default.
A pinned folio is frozen in place, no migration, compaction, or
reclaim, so the service loses control for the duration of the pin.

Some services may depend on hot-unplugability and must disallow
longterm pinning.  Others (accelerators with shared CPU-device state)
need pinning to work.

Add NP_OPS_LONGTERM_PIN flag for services to opt in with. Hook into
folio_is_longterm_pinnable() in mm.h, which all GUP callers
out-of-line helper, node_private_allows_longterm_pin(),  called
only for N_MEMORY_PRIVATE nodes.

Without the flag: folio_is_longterm_pinnable() returns false, migration
fails (no __GFP_PRIVATE in GFP mask) and pin_user_pages(FOLL_LONGTERM)
returns -ENOMEM.

With the flag: pin succeeds and the folio stays on the private node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          | 15 +++++++++++++++
 include/linux/mm.h           | 22 ++++++++++++++++++++++
 include/linux/node_private.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index da523aca18fa..5d2487fd54f4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -866,6 +866,21 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 static DEFINE_MUTEX(node_private_lock);
 static bool node_private_initialized;
 
+/**
+ * node_private_allows_longterm_pin - Check if a private node allows longterm pinning
+ * @nid: Node identifier
+ *
+ * Out-of-line helper for folio_is_longterm_pinnable() since mm.h cannot
+ * include node_private.h (circular dependency).
+ *
+ * Returns true if the node has NP_OPS_LONGTERM_PIN set.
+ */
+bool node_private_allows_longterm_pin(int nid)
+{
+	return node_private_has_flag(nid, NP_OPS_LONGTERM_PIN);
+}
+EXPORT_SYMBOL_GPL(node_private_allows_longterm_pin);
+
 /**
  * node_private_register - Register a private node
  * @nid: Node identifier
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb1819ad42c3..9088fd08aeb9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2192,6 +2192,13 @@ static inline bool is_zero_folio(const struct folio *folio)
 
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
+
+#ifdef CONFIG_NUMA
+bool node_private_allows_longterm_pin(int nid);
+#else
+static inline bool node_private_allows_longterm_pin(int nid) { return false; }
+#endif
+
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 #ifdef CONFIG_CMA
@@ -2215,6 +2222,21 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_fsdax(folio))
 		return false;
 
+	/*
+	 * Private node folios are not longterm pinnable by default.
+	 * Services that support pinning opt in via NP_OPS_LONGTERM_PIN.
+	 * node_private_allows_longterm_pin() is out-of-line because
+	 * node_private.h includes mm.h (circular dependency).
+	 *
+	 * Guarded by CONFIG_NUMA because on !CONFIG_NUMA the single-node
+	 * node_state() stub returns true for node 0, which would make
+	 * all folios non-pinnable via the false-returning stub.
+	 */
+#ifdef CONFIG_NUMA
+	if (node_state(folio_nid(folio), N_MEMORY_PRIVATE))
+		return node_private_allows_longterm_pin(folio_nid(folio));
+#endif
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index fe0336773ddb..7a7438fb9eda 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -144,6 +144,8 @@ struct node_private_ops {
 #define NP_OPS_NUMA_BALANCING		BIT(5)
 /* Allow compaction to run on the node.  Service must start kcompactd. */
 #define NP_OPS_COMPACTION		BIT(6)
+/* Allow longterm DMA pinning (RDMA, VFIO, etc.) of folios on this node */
+#define NP_OPS_LONGTERM_PIN		BIT(7)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
-- 
2.53.0


