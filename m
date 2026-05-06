Return-Path: <cgroups+bounces-15635-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ0CH1At+2npXAMAu9opvQ
	(envelope-from <cgroups+bounces-15635-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:00:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF934D9EBC
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1691230215B8
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6443E48E;
	Wed,  6 May 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XW/qXrnb"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176A43E4A4;
	Wed,  6 May 2026 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068807; cv=none; b=SKFtNQFdhS/0+blUFhL/i/eayYy3TxKtz0aSyD7BddDJ9EqF1ZKvVQcFk41MPYSFnMnXWxGA2ifJQMiny0bDsoMAVXn9R94Nueb3f8EwR3O+UVWIy+/DRxBH0qc3BxcRLUg7px21bUZ/lNnPy55Sa2AWd50xbwR2qgMHimagFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068807; c=relaxed/simple;
	bh=JLcLtkHLbLHPvJx0jdz/tg8gMNET2TtHppQ1Ooh70Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXwrYhdkuafm4htQ3+Ek/vrQSa8+qolHiDG0IQB98rh+Lgwab5II0sehUuxdgWGpF/UyYkq9v820b7vUoMR0fPMqL3fgSxO345yxwjrimdahbJSL/MEIzHwdc5Vz2MBi+fuO8wfsYG3he6Wf46w6uNcBVjnWVZ8zCiotV203UDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XW/qXrnb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+geGgtC29tPii/y0xORPdzxzZcUtJ2/stRBH9k/cNK8=; b=XW/qXrnb4pX3o9W+wGI0W1ifJ0
	NfQ+n+ZFMHfs6VA1ESmzMbKmE1LhTwYO6E5ioKclh1JV02ZMIgaDzq0GWDQGBY0gzF5M76ylnTxrC
	7E83xUP/BpozMsICavLB6ZnfU1OU6LKx0Wj5aunbLpYvtUEeeieIU3m/Gz6cMFp6EOwENrODXCbf3
	qOAhjJFrqtO3TTo1KdntZRMNWjDxPaXQbODeZrPCu7vO2kJTzJ2xG5HwK+Qr7Tfm/0zWjMzI9lyRr
	zfNSZ+lTmJAiOm3aESaWQv9TqyHj0lqJt/pwBZdfMkgX0LhFpjXGu24OPdJYs3yC349aEQjU01NgC
	TXGtBmgw==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wKav4-006sxt-Ta; Wed, 06 May 2026 14:00:02 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 06 May 2026 08:58:24 -0300
Subject: [PATCH 1/2] mm/page_counter: decouple peak_reset from peak_write
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dmem_peak-v1-1-8d803eb3449c@igalia.com>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
In-Reply-To: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
X-Rspamd-Queue-Id: EFF934D9EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15635-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Create a new function of_peak_reset that resets the page_counter peak for a
given writer. This should allow it to be reused by other cgroups.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/cgroup-defs.h |  6 ++++++
 kernel/cgroup/cgroup.c      | 32 ++++++++++++++++++++++++++++++++
 mm/memcontrol.c             | 42 ++++++++----------------------------------
 3 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f42563739d2e..a85044cb0553 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
 #include <linux/psi_types.h>
+#include <linux/page_counter.h>
 
 #ifdef CONFIG_CGROUPS
 
@@ -868,11 +869,16 @@ struct cgroup_subsys {
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
 extern bool cgroup_enable_per_threadgroup_rwsem;
 
+#define OFP_PEAK_UNSET (((-1UL)))
+
 struct cgroup_of_peak {
 	unsigned long		value;
 	struct list_head	list;
 };
 
+void of_peak_reset(struct cgroup_of_peak *ofp, struct page_counter *pc,
+		   struct list_head *watchers);
+
 /**
  * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
  * @tsk: target task
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 45c0b1ed687a..9b98a5cccf0e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1981,6 +1981,38 @@ struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
 	return &ctx->peak;
 }
 
+/**
+ * of_peak_reset - reset peak
+ * @ofp: open file context
+ * @pc: counter
+ * @watchers: list of other open file contexts
+ *
+ * This function updates all contexts in @watchers to the new usage of @pc.
+ * If @ofp is not in the list yet, that is, if its value is
+ * %OFP_PEAK_UNSET, it is added to @watchers list.
+ *
+ * A lock must be used to protect @watchers.
+ */
+void of_peak_reset(struct cgroup_of_peak *ofp, struct page_counter *pc,
+		   struct list_head *watchers)
+{
+	unsigned long usage;
+	struct cgroup_of_peak *peer_ctx;
+
+	usage = page_counter_read(pc);
+	WRITE_ONCE(pc->local_watermark, usage);
+
+	list_for_each_entry(peer_ctx, watchers, list)
+		if (usage > peer_ctx->value)
+			WRITE_ONCE(peer_ctx->value, usage);
+
+	/* initial write, register watcher */
+	if (ofp->value == OFP_PEAK_UNSET)
+		list_add(&ofp->list, watchers);
+
+	WRITE_ONCE(ofp->value, usage);
+}
+
 static void apply_cgroup_root_flags(unsigned int root_flags)
 {
 	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466..8754927070d3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4517,8 +4517,6 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
-#define OFP_PEAK_UNSET (((-1UL)))
-
 static int peak_show(struct seq_file *sf, void *v, struct page_counter *pc)
 {
 	struct cgroup_of_peak *ofp = of_peak(sf->private);
@@ -4563,45 +4561,18 @@ static void peak_release(struct kernfs_open_file *of)
 	spin_unlock(&memcg->peaks_lock);
 }
 
-static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
-			  loff_t off, struct page_counter *pc,
-			  struct list_head *watchers)
+static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
 {
-	unsigned long usage;
-	struct cgroup_of_peak *peer_ctx;
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	struct cgroup_of_peak *ofp = of_peak(of);
 
 	spin_lock(&memcg->peaks_lock);
-
-	usage = page_counter_read(pc);
-	WRITE_ONCE(pc->local_watermark, usage);
-
-	list_for_each_entry(peer_ctx, watchers, list)
-		if (usage > peer_ctx->value)
-			WRITE_ONCE(peer_ctx->value, usage);
-
-	/* initial write, register watcher */
-	if (ofp->value == OFP_PEAK_UNSET)
-		list_add(&ofp->list, watchers);
-
-	WRITE_ONCE(ofp->value, usage);
+	of_peak_reset(ofp, &memcg->memory, &memcg->memory_peaks);
 	spin_unlock(&memcg->peaks_lock);
-
 	return nbytes;
 }
 
-static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
-				 size_t nbytes, loff_t off)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-
-	return peak_write(of, buf, nbytes, off, &memcg->memory,
-			  &memcg->memory_peaks);
-}
-
-#undef OFP_PEAK_UNSET
-
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -5611,9 +5582,12 @@ static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct cgroup_of_peak *ofp = of_peak(of);
 
-	return peak_write(of, buf, nbytes, off, &memcg->swap,
-			  &memcg->swap_peaks);
+	spin_lock(&memcg->peaks_lock);
+	of_peak_reset(ofp, &memcg->swap, &memcg->swap_peaks);
+	spin_unlock(&memcg->peaks_lock);
+	return nbytes;
 }
 
 static int swap_high_show(struct seq_file *m, void *v)

-- 
2.47.3


