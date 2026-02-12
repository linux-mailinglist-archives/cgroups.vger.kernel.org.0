Return-Path: <cgroups+bounces-13871-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJwcJeMgjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13871-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A066128AD3
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF5AE3033AA7
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F6202C48;
	Thu, 12 Feb 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/lrk7XS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D091F12E0
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856654; cv=none; b=EJW3j+gKTkk6NOhkQ/GLtiKLm5pOlgPpGJlB3KsuSA751LX37ho1cGWSxHVqpvQef1sb6I07mC0eqyGH04zYNzwqCWlEUnbRjhDuORFdziyTsNb8+L/CZLhcQtFCd1rn6HQuce+QPk5Cx8Vc/UrW7xSwyWvq3FpCScVqbmomHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856654; c=relaxed/simple;
	bh=wa7pt8Z581mE1PPqr/ZpyRNRRdyNHYZow5FG+YQCcUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RR1iERdqIqC4giE45+xysUxyGmQFUM0k3JOKxxPxPoYgOsMhLfl3/RNHkA/7aC0XvoylyduQM3wJEu9Out+LV/6QY+mZpzop7nOympwNUB9u2vuFQFFScPZ7fNg1oynMyzpfd9VShOSmX5oDfGBKq7sDtGlqETGPg3ytK8RpSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/lrk7XS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562171b56dso5248038a91.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856653; x=1771461453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ertUY3NkBRFTSuB1WAHz0tc6nOs7Jytmk4LTXJXAt1E=;
        b=N/lrk7XS9UfDwHBS5UZ2UPgbKfK695n7pXcpAXH53ye2mVLgNdluT4jJsJFHbf569v
         0z49ty0BEkOlahMnstdAUpiAllz7T7dxuxCtpMVsR7KA8oexueu4OJKbFoTMO59BLPGb
         rxL4PGGXSruxtgKGAFstpPYtWHeRIas/Av0UfMO3difcjsPUnrMgIJ7B2TU2JkTBl7kD
         PCglzFZvb9T5Llyk6qVCb8sE9KWf0KvqbHcdMalj8WqUNssXJFG/rb3QtnNnrsdc7F5+
         6tAD9HxvKKBEKwoOn5uRv+eZxe/MmaJrpXVBb3bsungRr/yhrW6TVT+EVNhKDuhEGjn5
         bmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856653; x=1771461453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ertUY3NkBRFTSuB1WAHz0tc6nOs7Jytmk4LTXJXAt1E=;
        b=FZfG6IA9qy99KUVnBVuVpd7INsmOW1VxBuVZEQB+Ba330QHmHovtv8BrUxj8hbD0pg
         r/TLl8iHr8yrHldHzBo4MzLLQw7z0ouH+pUoGDZqaN31sLBNFIEQaZNOqpg9JPBTmcn2
         JbQyXYt+F6+bnY6Jphl/vpTKaaXDBvLC0NVFkOVE1pUGxdE4fHaiPG+GPx6Xrr6Lc0WA
         zTcTm3gLVmIInRmM/w2AgtLO8rTAZBWUsqfk8+2okGFrQJXGMwJBg/VA9LeEI5eMJfmk
         5NEugREgz8NlG4BAuTly6mAUMuHjAAaoJRU/h1KUub4KiT/UrbzxiFOUpq5I3YV6t7zw
         7YUg==
X-Forwarded-Encrypted: i=1; AJvYcCWzQRsjkSGna10pK8CmpOvAtBlRThj59UW8jWT751k22hWnpWzoWCdU7lA23qrs8ouWlGrHOzrw@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0XMsPI4Qwyx4jDJRDjpxmUaVnmvp61aYFzQeuQEfejkLF5LJ
	zHytSdTaJ7sVISGSOvtaB97ZsSmDm106QV0N/ABwt65TDkK/s3yeBlC92/XSYE5GunCrH8g+V5k
	AjwHCnjqyf4ORA+UEi3LVCn+AJw==
X-Received: from pgax34.prod.google.com ([2002:a05:6a02:2e62:b0:c65:c5fc:1707])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c702:b0:38e:9e77:c9e5 with SMTP id adf61e73a8af0-3944886d6f3mr806864637.72.1770856652565;
 Wed, 11 Feb 2026 16:37:32 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:15 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <24f2962dcbd369a2e01590aca0a365e5118778fe.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 4/7] Revert "memcg/hugetlb: remove memcg hugetlb
 try-commit-cancel protocol"
From: Ackerley Tng <ackerleytng@google.com>
To: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, mhocko@kernel.org, 
	michael.roth@amd.com, muchun.song@linux.dev, osalvador@suse.de, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterx@redhat.com, 
	pratyush@kernel.org, rick.p.edgecombe@intel.com, rientjes@google.com, 
	roman.gushchin@linux.dev, seanjc@google.com, shakeel.butt@linux.dev, 
	shivankg@amd.com, vannapurve@google.com, yan.y.zhao@intel.com
Cc: ackerleytng@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13871-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A066128AD3
X-Rspamd-Action: no action

This reverts commit 1d8f136a421f26747e58c01281cba5bffae8d289.

Restore try-commit-cancel protocol for memory charging for HugeTLB, to be
used in later patches.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/memcontrol.h | 22 +++++++++++++
 mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f29d4969c0c36..59eab4caa01fa 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -639,6 +639,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		page_counter_read(&memcg->memory);
 }
 
+void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
+
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
 /**
@@ -663,6 +665,9 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 	return __mem_cgroup_charge(folio, mm, gfp);
 }
 
+int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
+		long nr_pages);
+
 int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
@@ -691,6 +696,7 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	__mem_cgroup_uncharge_folios(folios);
 }
 
+void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
@@ -1135,12 +1141,23 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	return false;
 }
 
+static inline void mem_cgroup_commit_charge(struct folio *folio,
+		struct mem_cgroup *memcg)
+{
+}
+
 static inline int mem_cgroup_charge(struct folio *folio,
 		struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }
 
+static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
+		gfp_t gfp, long nr_pages)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
 {
         return 0;
@@ -1160,6 +1177,11 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 {
 }
 
+static inline void mem_cgroup_cancel_charge(struct mem_cgroup *memcg,
+		unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_replace_folio(struct folio *old,
 		struct folio *new)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36ab9897b61b2..70d762ba465b1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2561,6 +2561,21 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
+/**
+ * mem_cgroup_cancel_charge() - cancel an uncommitted try_charge() call.
+ * @memcg: memcg previously charged.
+ * @nr_pages: number of pages previously charged.
+ */
+void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
+
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
@@ -2574,6 +2589,18 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
+/**
+ * mem_cgroup_commit_charge - commit a previously successful try_charge().
+ * @folio: folio to commit the charge to.
+ * @memcg: memcg previously charged.
+ */
+void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+{
+	css_get(&memcg->css);
+	commit_charge(folio, memcg);
+	memcg1_commit_charge(folio, memcg);
+}
+
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
 static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
 					 struct pglist_data *pgdat,
@@ -4777,9 +4804,7 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	if (ret)
 		goto out;
 
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
-	memcg1_commit_charge(folio, memcg);
+	mem_cgroup_commit_charge(folio, memcg);
 out:
 	return ret;
 }
@@ -4796,6 +4821,40 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+/**
+ * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb folio
+ * @memcg: memcg to charge.
+ * @gfp: reclaim mode.
+ * @nr_pages: number of pages to charge.
+ *
+ * This function is called when allocating a huge page folio to determine if
+ * the memcg has the capacity for it. It does not commit the charge yet,
+ * as the hugetlb folio itself has not been obtained from the hugetlb pool.
+ *
+ * Once we have obtained the hugetlb folio, we can call
+ * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain the
+ * folio, we should instead call mem_cgroup_cancel_charge() to undo the effect
+ * of try_charge().
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
+			long nr_pages)
+{
+	/*
+	 * If hugetlb memcg charging is not enabled, do not fail hugetlb allocation,
+	 * but do not attempt to commit charge later (or cancel on error) either.
+	 */
+	if (mem_cgroup_disabled() || !memcg ||
+		!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accounts_hugetlb())
+		return -EOPNOTSUPP;
+
+	if (try_charge(memcg, gfp, nr_pages))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
-- 
2.53.0.310.g728cabbaf7-goog


