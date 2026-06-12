Return-Path: <cgroups+bounces-16910-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K14DJbtgLGqiQAQAu9opvQ
	(envelope-from <cgroups+bounces-16910-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:40:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6667C1C4
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ncqo7to9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16910-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16910-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4871314C257
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A75395AE9;
	Fri, 12 Jun 2026 19:37:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B136A367
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293073; cv=none; b=qB5JurRceKuETvG5C0QgWwDmrDgSM0PL//GUA6KucbBJbpSdxbLJmtQY5o5oInN8o8JMJuG16rHbCeRE69XIhHzoc5eAcJ9lp9Q3dYg+xvPgV04taIirJPT0b2sp+SjR/Dq0XSMyIk4Uh6MdpK0qA9q8loRl5nAvRS2NzKutUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293073; c=relaxed/simple;
	bh=bL9nzPjIGHqbCpc7DGB3FMBSQo1ZQhp7GNkpAcqRBx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCn/T14sdkAyVTcNu25u7hmFrrW2AKRC2LfPG1YQ4q9mVxrM3BzxhexzpEMg8Mu54vHmtxx1o9gURGmpIDjcBbUTCuIAMsylL02Y02oeMJOY9bJ+TFSCPOfgsuNRvBfc0ldwsb4BqttGUgjP+mq4T5e5TjS1neJdrkQVRUphUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncqo7to9; arc=none smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e67e90ac4so751186eaf.0
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293070; x=1781897870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84IL4yIxjt9mfiZQCACEvBG+RvMClGpDo6n1a8FJs1k=;
        b=Ncqo7to9NxHY763peCht2b0m/iGDDQ9E94G1YLhKKLhVese7s0RGjkwFEpURgM9/qh
         LRXD2JsSAOd6rEwYncaY5rdQURm7d2qly3GAqmiLzPdC6YppNZWTArKyc5GvOyulktHO
         fB+5+yMS6/GG1vMOFu76s0yw9MCURDcdWiMBuWf/FpZBLVPw0fjcRN3zegHMN2WNEZcG
         38U7FEtqOxkW8+a47EppmWw6iH2ClT9ROH9VTvB9PHwzZ3ZpPnXy8J7fx1jzPhprzUPl
         SBhayoQRYvIOFNLq6j0/jrc8lEg5tSiHkRbmvD9NAu56SHv4rGjnzZoKPD+FaCkKf/dw
         YuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293070; x=1781897870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84IL4yIxjt9mfiZQCACEvBG+RvMClGpDo6n1a8FJs1k=;
        b=gvO0dcvFAzNpRW6dXm0yPu/LeHxtmfcx0gZMA4xh9ftw8u8Wuym8PLffpgju6ZLX25
         vBxK5VDJU2oPfQ66S0qYXDJoc41T9rXDMuu1P5zObXahtQhKUfwHkCoeSH3tBAOVGMSv
         42EAFHbGPsws+Yf9z+jjmLzK51E6y4y3I43IvlIQLjFKViDkzy1fuXobeNOy0sB40+tO
         +9Z3GpywzACren5hwzQFWURwQFvXALl3Xp0wyr+Cv+shaCurKS9BGZFQ1TjXYHJFIFXI
         kLBhjQHEH7YlgcptVxju1NyNoW3Lo4gDxfVkd1BLImHuIs3szzQi3j9yVG2kMJkQWv2p
         QhhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NUcGIsCTM6FuFZ2R8eTqlWwV+lcY3kshFkiRSa1M2SkWuvl7JK1okbj/oLlcX/BgvwnFBhXik@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0IxF1UojI0dsgxR52fHm5g37wRlA7/SlLeop6V2baPL6ELsg
	CzAjHYTffm/UUhFU0bJP3NIgJhAvR7hrJp5zyPWvHEwkjT8VXoLzEpGf
X-Gm-Gg: Acq92OFcziU/+JUIrwkr3GXLVgkRkiQZefqqPxSiVW6/1jiCM0R/d9JMxidQIc85vXH
	PsCv8ydo83DxVzUVCq1SkEIl0+SRx1F61NXFM5kSYuXJxI55giZfLxxdJSQCIpw+DktsWGfPmnO
	MGNLwjN6A16uUPrGvEYT7n4uElLP4grEghd3vesp9tdTWD+dfFO5JrpNJPW+iOJxkReriuMF5Tw
	Yp6nJJtsKKaM6d3wKYwSFZJmBra+kEO/pEZGVtWst1bLGWTMfUGWl8u7f/gmPT1CVMLCHK9HgnF
	76qhMUpUT6sTnktQUBgNwxrVz1gMoOhiWajzLv3dj0Gr3qBditti0bjGMwRFqo3JmzhgkSR/np0
	IOa2EtZJVnIdS5jkV9MQELpGJcWRPkmUVd99SiOyPTMxzptkYfneNQa3P3yjgI0mvlFlzqRnXjd
	1pr+by/7JJ140THo5x9sgRlPIjBDbUrxlfHKv3Q/5F0Inx
X-Received: by 2002:a05:6820:4b96:b0:69e:88f3:14ac with SMTP id 006d021491bc7-69eda882e3cmr2414315eaf.18.1781293070450;
        Fri, 12 Jun 2026 12:37:50 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426b278b13sm2579659fac.12.2026.06.12.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:49 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 5/7] mm, swap: add debugfs counters for vswap
Date: Fri, 12 Jun 2026 12:37:36 -0700
Message-ID: <20260612193738.2183968-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16910-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EA6667C1C4

Add /sys/kernel/debug/vswap/ with two counters:

* used: number of virtual swap slots currently allocated
* alloc_reject: cumulative count of failed vswap allocations

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index abf6414c01c9..afb118ab8179 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/blkdev.h>
+#include <linux/debugfs.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -132,6 +133,9 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.lock = INIT_LOCAL_LOCK(),
 };
 
+static atomic_t __maybe_unused vswap_used = ATOMIC_INIT(0);
+static atomic_t __maybe_unused vswap_alloc_reject = ATOMIC_INIT(0);
+
 #ifdef CONFIG_VSWAP
 struct percpu_vswap_cluster {
 	unsigned long offset[SWAP_NR_ORDERS];
@@ -2038,11 +2042,13 @@ static bool vswap_alloc(struct folio *folio)
 	if (folio_test_swapcache(folio)) {
 		/* alloc_swap_scan_cluster updated percpu offset already */
 		local_unlock(&percpu_vswap_cluster.lock);
+		atomic_add(folio_nr_pages(folio), &vswap_used);
 		return true;
 	}
 
 	this_cpu_write(percpu_vswap_cluster.offset[order], SWAP_ENTRY_INVALID);
 	local_unlock(&percpu_vswap_cluster.lock);
+	atomic_add(folio_nr_pages(folio), &vswap_alloc_reject);
 	return false;
 }
 #endif
@@ -2666,8 +2672,10 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 
 	VM_WARN_ON(ci->count < nr_pages);
 
-	if (is_vswap)
+	if (is_vswap) {
 		__vswap_release_backing(ci, ci_start, nr_pages);
+		atomic_sub(nr_pages, &vswap_used);
+	}
 
 	ci->count -= nr_pages;
 	do {
@@ -4849,6 +4857,7 @@ struct swap_info_struct *vswap_si;
 static int __init vswap_init(void)
 {
 	struct swap_info_struct *si;
+	struct dentry *root;
 	unsigned long maxpages;
 	int err;
 
@@ -4878,6 +4887,11 @@ static int __init vswap_init(void)
 	mutex_unlock(&swapon_mutex);
 
 	vswap_si = si;
+
+	root = debugfs_create_dir("vswap", NULL);
+	debugfs_create_atomic_t("used", 0444, root, &vswap_used);
+	debugfs_create_atomic_t("alloc_reject", 0444, root, &vswap_alloc_reject);
+
 	pr_info("vswap: created virtual swap device (%lu pages)\n", maxpages);
 	return 0;
 
-- 
2.53.0-Meta


