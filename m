Return-Path: <cgroups+bounces-13873-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJ2MzghjWmJzQAAu9opvQ
	(envelope-from <cgroups+bounces-13873-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:39:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31F128B15
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 01:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3813025F58
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA421CFFA;
	Thu, 12 Feb 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/FYOMuB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B361DD525
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856657; cv=none; b=rnDrKNBBqxtNZ9U8OZED9abwPbUc8QVv8VFpnFi1heJoh7fpvxqWowBp/Z5kOnxjt0yCQAioBB2mnSWcFwPtQG+NKE+TTgveLxpFPpLvqkN9L9lH6zKhD/AZe1CRVUY6tAnQgxlUm7eWu+r6OG4PSeDoFoNTuS7BbH23RDW63MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856657; c=relaxed/simple;
	bh=RqGxcJZMCajIzXX/cvMijNOKy/G5sjCpvWdZwU4g+HE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5i0FtalKv5vaP3evno7Pspk5x5ar0R0pQpsukrxpVq4qXSZiLojC6eWfgfcL7v9xQz9nyK8Kqpha7UBieENp3cC1bT1v2epYmmk8QQiD8Lk7WstghVyaD5XLoDl3KITWSlYG5aiqKBwrj2D9QpIRIJD3DfmKq7H1gG4941S1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/FYOMuB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a77040ede0so23879535ad.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 16:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770856656; x=1771461456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8YVk6TJ+SxHQqdzURW4gj7SpPw0Nw5yYajSbj7tT84=;
        b=x/FYOMuB5GDsbo57iSbAOXtFAC0qluTj8kubfQNweia5bAEHIJuYwOMKdvEqNq7DUm
         wp+6W1QEajixdBXFmFHvwQepmwg3JBJKxGpWc9pjP5N4aS4Zk9xYhdi2r1DFWGLEL1WP
         tpoTesl+y+voOzBBQ/Ei1/0YGomPC/DU4tX2FCe6VOmPTgxHSbs/xbRE9zSS+TYZZ91t
         meJKY7po7Z1BlF9Oxp+0Cw1hwJoCWM0QfxUJc3DRMSBZLCV1zhJb1xkvvd9VI8LGmqhn
         hSEILrJ9eWGqokoLWOfomclnoF+V+u/713YkUcQGgFsCO73V6HdKMInItBE/Q+otHFq1
         MjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770856656; x=1771461456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8YVk6TJ+SxHQqdzURW4gj7SpPw0Nw5yYajSbj7tT84=;
        b=eYk0zFFqfuMkNq0V5DZNc8q6r7t1aBnmObjIOUIHfOX0hAeG4Y55t1bIhCcBZa+c9x
         rw9+y1gAHpCFMdAV4c786nZxLnlXy1KjgcpskdzckusdjDkq596RXlYv1Ubd/D5kDKgu
         a4mo/5v5jiDftiUovinnwKrar532okn7VNBUzfJrHvOofTK1WF1gX/LGQyod4dPwRSpp
         xyxJ/VAwmLTK9U1AzGFLFxGJeqchGWGwNt/WaOoHPrV/x6Qh1CuXOieOC/3lj/J1NrU3
         gaXtRP1u6ONAMDNdGcJ9dhYAu8vYH3Lkk1R/XR2amsSMN+xp+Zf2lyYR0traaCnJ76sl
         GV0w==
X-Forwarded-Encrypted: i=1; AJvYcCUhmEJ3EuxwPOmwtPr15kQJGKpuD+53P/+1X2BLHXiSf1srUXk8Is9+qw+l8/IZg5+yc5rH38IK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aQtwp90dCBiQ23Jsvzjyq+5xSBxgkX6EJYgilHn8MgoYAd00
	khRQ38YOSCOpe0Ud/34yzj/UOdEgp4hgqj5I2dCBVK79/QLiq3r3pIaHhW7GjsgZX3D0zDZYdL/
	kgdNMYZqKjq84eA+k8K7haoTOuQ==
X-Received: from plok7.prod.google.com ([2002:a17:903:3bc7:b0:29f:2b44:973b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f788:b0:2ab:1eef:0 with SMTP id d9443c01a7336-2ab3b2accc3mr5208665ad.51.1770856655751;
 Wed, 11 Feb 2026 16:37:35 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:17 -0800
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <9b59772c1c06f6628d842d5d30f1f7777c621c90.1770854662.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 6/7] mm: memcontrol: Remove now-unused function mem_cgroup_charge_hugetlb
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13873-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A31F128B15
X-Rspamd-Action: no action

With the (re)introduction of the try-commit-cancel charging protocol for
HugeTLB's use, mem_cgroup_charge_hugetlb() is now redundant.

Remove the function's implementation from mm/memcontrol.c and its
declaration from include/linux/memcontrol.h

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/memcontrol.h |  7 -------
 mm/memcontrol.c            | 34 ----------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 59eab4caa01fa..572ad695afa40 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -668,8 +668,6 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
 int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 		long nr_pages);
 
-int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
-
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
@@ -1158,11 +1156,6 @@ static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg,
 	return 0;
 }
 
-static inline int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp)
-{
-        return 0;
-}
-
 static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70d762ba465b1..87d22db5a4bd3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4855,40 +4855,6 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
-/**
- * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
- * @folio: folio being charged
- * @gfp: reclaim mode
- *
- * This function is called when allocating a huge page folio, after the page has
- * already been obtained and charged to the appropriate hugetlb cgroup
- * controller (if it is enabled).
- *
- * Returns ENOMEM if the memcg is already full.
- * Returns 0 if either the charge was successful, or if we skip the charging.
- */
-int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
-{
-	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
-	int ret = 0;
-
-	/*
-	 * Even memcg does not account for hugetlb, we still want to update
-	 * system-level stats via lruvec_stat_mod_folio. Return 0, and skip
-	 * charging the memcg.
-	 */
-	if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
-		!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		goto out;
-
-	if (charge_memcg(folio, memcg, gfp))
-		ret = -ENOMEM;
-
-out:
-	mem_cgroup_put(memcg);
-	return ret;
-}
-
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
-- 
2.53.0.310.g728cabbaf7-goog


