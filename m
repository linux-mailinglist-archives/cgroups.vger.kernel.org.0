Return-Path: <cgroups+bounces-13788-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHa8G3gHiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13788-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:00:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443C10A541
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0846E30065D2
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E036F401;
	Sun,  8 Feb 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc+40F81"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72036EA82
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587956; cv=none; b=Bm+mPwqiC42Q3W6K5vUCc25IUjqx76dj3+7zvVqQ8ak829MYp+FQalZmUyZa0fy8/GQsCxOF/Fd1qucMgRgIUrikiqI6/x485p1a3/8tAUAtnwLDzR36htklIg3v9ZeyxCQWBnIAvJhzT8d7yIGo+TFubG0nk/wecA5Ke3ZBYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587956; c=relaxed/simple;
	bh=ivEurp8BxVVC73UF2YIA0sGKcn4Rvv3bpTlATH+RAvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQLPf993TaCUR8DmoeO3Fz4xHRVlttsGmPkr/xCxyUVaqAtC9SQMmxJw3ZOvidMT/5SSWrmoyHAfv7xnj9mi5E9s9BWzzSCgUMDla+r0lxKEIr1/Sr+OsKhi3ahDMkk/cuc0YVZEgyLysxDegzcmCUorDeRjBiGK1J3/PgEs6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc+40F81; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f171cb842so2677480b6e.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587955; x=1771192755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcq3gcBJps8FZtjddhB+nxOnBeH87BfFsdWVB5x664k=;
        b=dc+40F81wBkKVyu/C1B8+cc6caEzLYJpuLJ5W1W7TCSfYcL1XO+XOyilRv9LlWonXn
         35OOuT+QXQwaq/ALiu5BGgNmHiH4aHE1ssRQ/wuGyDbuYl8OjY7NbztQKhaua5sfltdo
         nmO6h++U9Ff/Bh4Vz4432XeartFzGtpqOWE5AILXz9GTAHyY96PfJHcp/pbPa5W7R3we
         bepL9sYvx5RYKRzzm3zfgHPmkK2NSfPGLr15A/g4gPdNT+0qMSaxtuLX2Bo57nZWLgLg
         0kA67K/WKPLEY6Oys0CBHHMbmT3EwDh3UQXzktcSbFe+ZSwRMVDQlHH5sGZw+JYExWfU
         lpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587955; x=1771192755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcq3gcBJps8FZtjddhB+nxOnBeH87BfFsdWVB5x664k=;
        b=Cat7sqm5jGDI8dssMzsg2ooHYTZygyILFRp98o59sno+GVRKX7jZ/Qe3mzmxeRIAGT
         lu+wCjhVWTMabqfVwobAmg3pF8Z+kidgsZv/JsrTrqd7BqNNs51/jJsEuy79dJQVeiSN
         Jmxc++0FyCW6Wgkrbh97pDfnmCXwOh4bsqlkgJFRQxAQIiIMOqqTQ1YtmtAsONks5zT4
         wADPYQhUWJVHawIM69ap6lr2q7j/KKhEcoEc8j95fSE54gTQV56Rs8cWv52Q3X9m8Iuq
         VVOqArOGwPmoqSYsFkpEm193FE5dDTE3irhWJCLuKg3Sf6WaW1j215Z0DYJMVJsewneJ
         6uQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8dLCud0evrgG/l1MZv3Llqw9AWVYmYxocJKwhfQtawUdh0nB73GPb/Xzy1YuN22wirnFsoVZg@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdviYjHLgNEkRFUR9uboO+0BfvD42exekMT5w+bj9ecHeZ5AV
	p2eS9f/auIU+YjkPt7c2mYmEgHiOZ5TpBrEBsLEoXtlsWXRODW2aoXwm
X-Gm-Gg: AZuq6aJPaY4G79W2bgkQah5uyBBfLwpeTYnPr357svDNmN1D7ef/TaDnRPRExgxrebm
	siTN/ccC4v4CEX+sRbE3fZubL+tJQQxQv9UlSVQGckHHLTECv1jYy6FGRsoPQRvBEFobEp2p97h
	7JDAkDtKAZ7s5O9gR34Ry0fgbHEPPenf3bYOTAJ9Mn3xTAEowSIcMdJsaInYw35bsvwrxmuyh2k
	75KO+cdP/GGL30HadRTltdIZKowgACBdWl42iNaLCwTNFuN0n1nD90TAlmFy2u9Xbqip878wqBB
	yazxBSe4rllfgzxYd06l9U27E8lTVtvFHZhFArBN+SK712PWTUhCOyEKNFMBIG/k67Russ9gfwq
	koEYGLdq+xi/KcBUxU/fl3ztYO7hZqW6Bj7rkaqBLaUTtGUiq+rH7ioLVa7mgLcZNV4uG5Mw6i/
	DAbyiWfG7tpExX6YzmCqA8VL5zs0uwsXL7
X-Received: by 2002:a05:6808:2220:b0:45f:103c:2483 with SMTP id 5614622812f47-462fcbe429bmr4183659b6e.23.1770587955253;
        Sun, 08 Feb 2026 13:59:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12f5sm5510710b6e.5.2026.02.08.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:14 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 16/20] swap: do not unnecesarily pin readahead swap entries
Date: Sun,  8 Feb 2026 13:58:29 -0800
Message-ID: <20260208215839.87595-17-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13788-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1443C10A541
X-Rspamd-Action: no action

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d41e6a0e70753..08a6369a6dfad 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -213,6 +213,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ad80bf098b63f..e8e0905c7723f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index fb6179ce3ace7..7563107eb8eee 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1503,6 +1503,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct percpu_vswap_cluster *percpu_cluster;
-- 
2.47.3


