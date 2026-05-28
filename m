Return-Path: <cgroups+bounces-16406-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PbQOfmzGGr9mAgAu9opvQ
	(envelope-from <cgroups+bounces-16406-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD25FA6A0
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BE0C3028F02
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A883624D7;
	Thu, 28 May 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMXGI6YE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484617745
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003810; cv=none; b=p2swc7jbE2NGrTob0RwjOPo6a0c1j2F9OkiLzpWi/N3PLaeRQwEBWGj2POiUMboDOCYq5nJ2gyuSkZHEa2wWPsE2F926h3+NqbH3dgcQqj+6YMynREEa1uwXalyG+5OyFGDuG+hQDlyyZz+aOjK7Wkvv7ttktxf3AYUgFAebvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003810; c=relaxed/simple;
	bh=jiqdTPG4am84a711SHTa1ilvl5OD893KyijxO1MvI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFTFUV+6a8Wfd/5pxWRCqhbUtE6n5tgrG1Hsy8hvn0SgoHwaIZwZ97HJzy0XaWsYGccKY6kIPD1UZ/v/1CeOZeyj8QpeeXOmB7JWRdS3fvEGV5J9nfHJzQ6EnSkaS/dnKCuY5OvNLF3dMQPPIolE0tjLhz57Vl8/QNV/pZDewDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMXGI6YE; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e61f8d3cbfso2987083a34.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003806; x=1780608606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4CJlSs8AXl7ZfYRtAD893brHtGG85Zp/rm/ajAW6HQ=;
        b=LMXGI6YEeF0agqyES1/hpONwDszZp689VQZspTvH3yimMD9MIvK2saNzK4shirMYrW
         Q9iwtiKkXTG9cctkw2AE0Kt0/1e8lhO6x2g0csSBBVzCxXuA8vhcy6VTQ635WOm33PzS
         HLd09AuzuypPVkkUbv9ri+KKmgsZXLHJsdNakqfew/PZZBgVlsuX/GAr+LUvHFPuvii3
         RQh4Fs8lzEYHHsa/F0qS7KFpgBaW6VmRKp4GNndic4Z5qauuNvMfPlslFN7Glv3FHej8
         /Y9ev4XI0R6EGVX263hL7QGEHgEkg8UPYLkrZTqzvt1mdHFU87P2wk9zJtfB/C/8mobq
         f1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003806; x=1780608606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4CJlSs8AXl7ZfYRtAD893brHtGG85Zp/rm/ajAW6HQ=;
        b=o4Q0qRLImzqC/8NXVSlqu8oPb4+ZWbRvHLdly+G15/njOJ9yEER2tHgOx2o1QnBU/s
         AKKEtZXmiNv5FQ1UkwM5Y/S4aB/QF6dagtO4eb/sLWI41K7UHCe8/dNM9VchVmvucy5c
         CKBwG3gP2TkBNVRC1eQQgtyhsmf0STAb+r/CWSArMWsfU3l/U4cycmvmOgw77xWNt1M/
         0PrVBpkVfOhTKbx+/6rH6JhluDz/9v8S+NimF2hG/C5QEm0r0ITnJ00rUUiqmIRIwq9p
         uYRrTXAkS6F6M6v5dua9l76Gw0EZOLIhM+GJ9LBHEt+Dweth8SZhcSszC/S9RbdvPG2J
         x0qg==
X-Forwarded-Encrypted: i=1; AFNElJ//1bthD8Y8gPWF4Y3J9Hd0QQCaI/ihoyXodyDpRz3XgT8gyareo+9ZcwRrTWq7tKIQAiflXmqN@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsMVqvsD/RZXzZHxZ29fejJLSCqKP8hVn1n4jPRQzODveyNSz
	7WaDRIY5vgpEEZIu/B61c3lAhAqL5B5pYiZInc3jN6RDdmmyq7JU85yS
X-Gm-Gg: Acq92OFn0Oo525vhwQrKKwEZp3lVMJT5gInglitLPURbBAVf/3p7mGCPUAt1ZZBicaY
	0W6TqCJtZu2NNIyGm/rb3OoT3ZHzrE8JerFbzepTg9a6EWLnX4ZSJvRBzbGc5Knuh3IQJOv0CCV
	+rjfJ0LznxUyW2LwUGZrK63PK/yBXTl3aHozV1M4oLJxIm8cT1Z/tkZSLoH0U9G7aIj9PeBP0CA
	wt534F6jkHtg/rI96Zff0Wa3NtGCFYr06RWE+HFrFG010/qQd1EPLuAegPTH8pgO6TPQq685LMx
	htU8k88Q5w5oaDwCHdF3BF2AlIaGJ4y1BaqY3GudLonWNovyGLBj6Ic3AOjjs5pH5CyNqfeg+hT
	1H5NFqoKjgzReDZpRevwhMD2A/ab4NGs1jVYuR0EeMwFxhkETgLhooyRsSlP+0N8WCE5MSVdtiB
	en5NNsMXW7UJHivSG9VRXyyP0VGNBHy8fET66GNr0SPPLlOHgTogVew9VQ
X-Received: by 2002:a05:6830:6314:b0:7dc:2f4f:17b4 with SMTP id 46e09a7af769-7e694fbdd5bmr187572a34.21.1780003806180;
        Thu, 28 May 2026 14:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6952991c2sm135613a34.26.2026.05.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:30:05 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [RFC PATCH 5/5] mm, swap: add debugfs counters for vswap
Date: Thu, 28 May 2026 14:29:29 -0700
Message-ID: <20260528212955.1912856-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16406-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D5CD25FA6A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add /sys/kernel/debug/vswap/ with two counters:

- used: number of virtual swap slots currently allocated
- alloc_reject: cumulative count of failed vswap allocations

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index be901fb741e5..3740ab764405 100644
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
@@ -1993,11 +1997,13 @@ static bool vswap_alloc(struct folio *folio)
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
@@ -2554,8 +2560,10 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 
 	VM_WARN_ON(ci->count < nr_pages);
 
-	if (is_vswap)
+	if (is_vswap) {
 		vswap_release_backing(ci, ci_start, nr_pages);
+		atomic_sub(nr_pages, &vswap_used);
+	}
 
 	ci->count -= nr_pages;
 	do {
@@ -4793,6 +4801,7 @@ struct swap_info_struct *vswap_si;
 static int __init vswap_init(void)
 {
 	struct swap_info_struct *si;
+	struct dentry *root;
 	unsigned long maxpages;
 	int err;
 
@@ -4819,6 +4828,11 @@ static int __init vswap_init(void)
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


