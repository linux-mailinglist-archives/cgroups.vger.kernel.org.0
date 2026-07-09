Return-Path: <cgroups+bounces-17627-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tVLFJYm3T2ronAIAu9opvQ
	(envelope-from <cgroups+bounces-17627-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:00:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E302732935
	for <lists+cgroups@lfdr.de>; Thu, 09 Jul 2026 17:00:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cYTI70ew;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17627-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17627-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281D3303BDE0
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2026 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2F3806DD;
	Thu,  9 Jul 2026 14:51:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C173274FD1
	for <cgroups@vger.kernel.org>; Thu,  9 Jul 2026 14:51:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608716; cv=none; b=ADsJ8N6savir07gPMZny9oXvDeOaD2bgDg/66opzoi5gA3IvNUqs6HHAhJWCCgneTHndSDFYb7EAVI1cnZ5QznAo8pGtu+ACCdFf/Bp7GBFt5y/Cbgv9o+UgX+fXECADpqpM8yGueA62KJPmZizkiycqVs/nJ1W5D2uhCtdO5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608716; c=relaxed/simple;
	bh=nOl1ICnq2j4uvWW1FRPCkY013HCwVhxAW7Cuq8ZBPVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLP003L9EuM92iJHJMPVSQNSRw0MgY4ftI6k3Fr4nNfHKuQgRb6ErAoKI0xHMUeecTCQv/hhjL43zq75ML/msuiHceAGjGD0LPUPoM4IuAqVWh1ohwMCv2gPecfew5sshYiLwTdBlN/J4nLRdFU+dTQpbHHAb5//BiP0gCxpwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYTI70ew; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so182456a91.2
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608713; x=1784213513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/9b7aaO69R2fNMLXh0/PKSXnUU+kkoQXOZs7b0+s748=;
        b=cYTI70ew7JYCR66h9CidFmbtGMCb8hv6Y6B2yIzh6xOgQUKXKUlkC6ZoYAUrfESvmG
         5w0bhIyZHxZmKswEE8Lw45hUvabiS4qe8BPdqcd8OOq9gWzcYBaQ9CGGB+aqzCiUK9SC
         FcgrLxssbXOGY2ooDCeYOrUPoYWtwaZkQAXVdxtICIY0JBJeGkEox+pzVhG912YFmM4H
         KZolgBRiLEcaMOQWd+DBaZFP78XldBqG1vr4fhLkf+eJMstUxBxGBPVMnNxRRuuxgjX2
         wQcVwUHy6f2/nXfoElajrtAFXsh3lZjdenRtjhOJIdzb2aw88q2JbLrUo8rccjXaE3aq
         kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608713; x=1784213513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/9b7aaO69R2fNMLXh0/PKSXnUU+kkoQXOZs7b0+s748=;
        b=lborkZUOch2MaQb5RpLdjS+MPFLoDxO+Apf15A1p4fl/0Xt7W23Q/gSeNsYkjAS3us
         Ujw9d4liA1MIaqUwvTc8AuQn2iT+MO4/hEYtkjLG8DNMeE6XVPQ6XG0JJuqLk7qDNLlN
         JQzrHoQA2wOpUBX4Z0FDnECv8cckmgbkh3PdVtxjHsYM58j/ktweMeqqos2ZXDHkXqya
         XXOofJ5+HMJa+nx4nziSsmA+E23m+OPvUynZ+fBijJeqP6C4Hb7f47eqvZeWpqRxHwIo
         t7nLgz9CQVloGJjDN4RDQnIt7oAhVIQq5s5otMtRDyGwS9q0+66pPkg+OKJ82kJ32cXr
         7Z9A==
X-Forwarded-Encrypted: i=1; AHgh+RoIh+hNWSCqaEksBMSKeewGaMLj8D0jwj3hQZNzAkBLTlpRV4vvIDaQAzXaiyS9up385Z2rQb2y@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOYTGK/dQpK1K4BXVz8wBBNngxtAsTadz7CFvTZWrjYE7obAz
	nzjdXdutgjwbVaZJPqzELRZrzyvtqLdrh37e2EknThebLdFtOkUMCxnA
X-Gm-Gg: AfdE7clVlvh/q9GFYZU7JSkqtantk56D8aX8nv9R0whd7pOyBGsPddPJOC4DzX2UWXI
	6IBO2uCSl03yyRKqUerJdQz3hMioTXtcNuXDfNv1Fcb//CO6/l2UheOzqlAObVtHTmoVfXMNZuW
	GXf5eLFNv6brNHxRI97SzcvgCKQYaN9mrC+1L9LHyC54inrRXGUXxEqZRBPgVxl59stjQhREsYk
	+VkXUrWa1Nad7hkQC29VcmrjZFfoDe3tCPxbOBecm4+5bafRQAT6ySy9wIpwuEHnT/5jh9a+TUC
	MguuMXKhrw8FlNFkpI91B0okQrnoguq0AzIi8oFmGbFXNMUISx6UrCcmGqWcMuxStBh8Hb1RPvI
	6VBwOMJg5AOUWH+/L5vUC3EqY2GKLmq757eKnazOZAwyKeGKItZJkr1RXb3oRdNwnyvMAtHFn4B
	/S9Cp655eurWXSO6o0AGfiDF7PadH/pOISmJZ1XnKOpiz3kpgXdrLWe4bcE9ZxXG2C8r4w2qahY
	g/xNg2Oo1Prr3X6kw==
X-Received: by 2002:a17:90b:554f:b0:381:96a2:14d8 with SMTP id 98e67ed59e1d1-38a21eddb43mr3429162a91.8.1783608713109;
        Thu, 09 Jul 2026 07:51:53 -0700 (PDT)
Received: from debian.lan ([240e:391:ea3:6910:38e7:894b:82e3:a58b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc5820sm1286917a91.10.2026.07.09.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:51:52 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [RFC PATCH v2 2/3] mm: distinguish large folio swap allocation failures
Date: Thu,  9 Jul 2026 22:51:23 +0800
Message-ID: <20260709145124.764807-3-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
References: <20260709145124.764807-1-xueyuan.chen21@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17627-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:baohua@kernel.org,m:zhaonanzhe@xiaomi.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:xueyuan.chen21@gmail.com,m:xueyuanchen21@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xiaomi.com,cmpxchg.org,linux.dev,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,infradead.org,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueyuanchen21@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E302732935

folio_alloc_swap() reports most allocation failures with a generic
negative error code. Reclaim cannot tell whether splitting a large folio
could make progress or whether there is no backing space at all.

Track the global free swap count around the allocation attempt and let the
memcg swap charge path cap it by the remaining hierarchical swap margin.
Return -E2BIG for large folios when a smaller allocation might still fit,
-ENOSPC when no swap space is available, and -ENOMEM when the failure is
not helped by splitting.

This only refines folio_alloc_swap() return codes. The reclaim caller is
updated separately.

Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
 include/linux/swap.h | 10 ++++++----
 mm/memcontrol.c      | 15 ++++++++++-----
 mm/swapfile.c        | 21 +++++++++++++++------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7a09df6977a5..0695ac56457f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -571,13 +571,14 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 #endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
+int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry,
+				 long *nr_swap_pages);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-		swp_entry_t entry)
+		swp_entry_t entry, long *nr_swap_pages)
 {
 	if (mem_cgroup_disabled())
 		return 0;
-	return __mem_cgroup_try_charge_swap(folio, entry);
+	return __mem_cgroup_try_charge_swap(folio, entry, nr_swap_pages);
 }
 
 extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
@@ -592,7 +593,8 @@ extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-					     swp_entry_t entry)
+					     swp_entry_t entry,
+					     long *nr_swap_pages)
 {
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 177732fef010..71600d41958e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5472,12 +5472,14 @@ int __init mem_cgroup_init(void)
  * __mem_cgroup_try_charge_swap - try charging swap space for a folio
  * @folio: folio being added to swap
  * @entry: swap entry to charge
+ * @nr_swap_pages: optional swap availability to cap by memcg margin
  *
  * Try to charge @folio's memcg for the swap space at @entry.
  *
  * Returns 0 on success, -ENOMEM on failure.
  */
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
+int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry,
+				 long *nr_swap_pages)
 {
 	unsigned int nr_pages = folio_nr_pages(folio);
 	struct page_counter *counter;
@@ -5495,6 +5497,9 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	if (!entry.val) {
+		if (nr_swap_pages && !mem_cgroup_is_root(memcg))
+			*nr_swap_pages = min(*nr_swap_pages,
+					     page_counter_margin(&memcg->swap));
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		rcu_read_unlock();
 		return 0;
@@ -5509,6 +5514,9 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_private_id_put(memcg, nr_pages);
+		if (nr_swap_pages)
+			*nr_swap_pages = min(*nr_swap_pages,
+					     page_counter_margin(counter));
 		return -ENOMEM;
 	}
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
@@ -5550,10 +5558,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
-		nr_swap_pages = min_t(long, nr_swap_pages,
-				      READ_ONCE(memcg->swap.max) -
-				      page_counter_read(&memcg->swap));
+	nr_swap_pages = min(nr_swap_pages, page_counter_margin(&memcg->swap));
 	return nr_swap_pages;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9174f1eeffb0..53a921ca099a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1690,12 +1690,14 @@ static int swap_dup_entries_cluster(struct swap_info_struct *si,
  * swap cache.
  *
  * Context: Caller needs to hold the folio lock.
- * Return: Whether the folio was added to the swap cache.
+ * Return: 0 on success, -E2BIG if splitting the folio might allow swapout,
+ * or another negative error code if splitting would not help.
  */
 int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
+	long nr_swap_pages;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
@@ -1706,7 +1708,7 @@ int folio_alloc_swap(struct folio *folio)
 		 * the caller should split the folio and try again.
 		 */
 		if (!IS_ENABLED(CONFIG_THP_SWAP))
-			return -EAGAIN;
+			return -E2BIG;
 
 		/*
 		 * Allocation size should never exceed cluster size
@@ -1714,10 +1716,12 @@ int folio_alloc_swap(struct folio *folio)
 		 */
 		if (size > SWAPFILE_CLUSTER) {
 			VM_WARN_ON_ONCE(1);
-			return -EINVAL;
+			return -E2BIG;
 		}
 	}
 
+	nr_swap_pages = get_nr_swap_pages();
+
 again:
 	local_lock(&percpu_swap_cluster.lock);
 	if (!swap_alloc_fast(folio))
@@ -1730,11 +1734,16 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (unlikely(mem_cgroup_try_charge_swap(folio, folio->swap)))
+	if (unlikely(mem_cgroup_try_charge_swap(folio, folio->swap,
+						&nr_swap_pages))) {
 		swap_cache_del_folio(folio);
+		return order && nr_swap_pages > 0 ? -E2BIG : -ENOMEM;
+	}
 
-	if (unlikely(!folio_test_swapcache(folio)))
-		return -ENOMEM;
+	if (unlikely(!folio_test_swapcache(folio))) {
+		nr_swap_pages = get_nr_swap_pages();
+		return order && nr_swap_pages > 0 ? -E2BIG : -ENOSPC;
+	}
 
 	return 0;
 }
-- 
2.47.3


