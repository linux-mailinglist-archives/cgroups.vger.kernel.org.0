Return-Path: <cgroups+bounces-13945-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EeFBg33jmnbGAEAu9opvQ
	(envelope-from <cgroups+bounces-13945-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 11:03:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71956134D5B
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA6E3025D37
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715434A775;
	Fri, 13 Feb 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFPGMLyr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD1312836
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977031; cv=none; b=PAPAfGqa4xB3RR8fz/GuBCEVdxZCJVdneRtDUSk+i0n5197VX2VpqjwbazA78AMoS21ZsCVBK1Q+WDUZmelUq4yeRlzJ9S1E/7iJ9LYv/aZ5OgL7T9cEO3IU6WVKXDkvjfkrykHGUF51WkFb+FJiduamZxZ9AX0HTtVIobV8tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977031; c=relaxed/simple;
	bh=Zs7QNHNf3ZiH09poIh8XMpwvw4NFTa+WNpDRkmMCPPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gWF0lflHamycEJOuEVQfttEf/yMYegVBh/LjxmbHl4U1Ae+rg7PPB1GF2vFlTmCksagYWBi+a5PgBBZ8i4hJZOuuz2Bu7a7q4yxxT9NapP3DBbZy3C+pvcG6ZfR+BnVi87CVK7JtTWxBvm0tjOr21qBmtcfIOmOVz5yoqlw+iLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFPGMLyr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82310b74496so477124b3a.3
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 02:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770977029; x=1771581829; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua28z24qUIwhHYuR3RexH1TybxsEtCTG1vVnJWGtDUc=;
        b=bFPGMLyrp8+kvBoAibO6aGdYwHXyce7Vv02mCGqZZ0lwW3VhXc+Dx+3MSDCLUdJ/bN
         zUKoZa3O7Qb69ePcXOl+G3vkXJ/HNIMlS2EkIVh4k97mwyyzvpnGIoE0hj+l1sjcU572
         uJbpXwfQtIHmvaNdGTZwMXkZsmUUdE7JXE4jpPNkYVxRanxW338Bky3/3EHxwFqeedAn
         3PMi5Snlf6hTa8CkdsdLqBMmB/OkBoG45Z5jm57GUVw5kh8ss/rxjGNlFag3dATpXZ/l
         /dZtGe7l1E04eF0odj8sAVxQuaLp/7/96NgCWjnLzMqPNHEXPIockO9puSSY6plWpb8O
         msUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977029; x=1771581829;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua28z24qUIwhHYuR3RexH1TybxsEtCTG1vVnJWGtDUc=;
        b=oWQmgud14z9DXPwPohbgYZ1RjXlfWSiTdgBbPVbRE081BR6MPYHX7k21s89Jy1dBDE
         O+tcCX7yw335W2b6sodZfHKI6qy8pSBAcMC+bU7/D42P02JF35XIBi+wlS/HRPo0+zBr
         uSeDP+YlLbJqBd9edEF2fD6e1F2M4SLU0r94V1TzdzSiseEXXOsO85IF/Bi/Zbtf5O6s
         6MWweUQlkUlrrhQQRDJg1WKeDNYNkdP9qTGMgv3UuW3w5ncdxnu4AXNA3FogMb1ZsHhx
         PQXQd5eqLxqD2tk+C7VcV1joqzSogm9ZclGKsMFj/lfbX+VrpYr8TOCNIksZtbErnwny
         m01Q==
X-Gm-Message-State: AOJu0YwsCrAHexYF1jEDQfAMlNrbkUnh6krByw2n7w+RZT6z7T6k0pd6
	g2jSEBArzOA5KrCy+gD3Q2CI6m+u+rC3sN5CmU0UgF2OaPi8/ISRseGk+/7U9w+pLT0=
X-Gm-Gg: AZuq6aKZD8iMn91j6d+SrJM5iqFIrNDw8eLy/lCXnnb1YHNdTTbXVnmhJkAnwO411kB
	Ktcm1w+mzMYo5QgZgJZHYoBfTp5zDgPvJ1CPe4nZmSOEtiOuCZpaUoW5vNznZBwR6wQmtDoFTGH
	mU+O/VVpAw3lM7CLge4ebKTGri6gP1p/8VHX78e+2FPtF4d0c3Rm1NDTRh1jGz3XrSSwhfsKK8a
	Xs5BTpmnlFVdbBt+Ioo6oPZ18kaz1/14w6DqIe1FJzaahKT8u4fD8rWCwVEHDk5cXhZbNaeOQyI
	QJTEfTeBGplAuFakltN94MttiMO87AWn+CgLg3zEP9/xI1RsW54JNgcgRMnb/k3f8I/LWYB8YzV
	Zmw8u+T8w1j2fKYF8jbVukzN34XzbBdKxacu8FvZGkMB69XbBJwKcDKPP2O+iT71SLXsXRu2yj7
	YYlmuUksvv7//jp4OjMyTB3SkD95Aduvii0ajDjQkgg+vELryhve0mKMYV3CPP9bJybLRR5w==
X-Received: by 2002:a05:6a00:9288:b0:7b9:8142:96f4 with SMTP id d2e1a72fcca58-824c94ab2eamr1348552b3a.21.1770977029363;
        Fri, 13 Feb 2026 02:03:49 -0800 (PST)
Received: from [127.0.0.1] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a627a5sm2473663b3a.27.2026.02.13.02.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:03:48 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 13 Feb 2026 18:03:32 +0800
Subject: [PATCH] memcg: consolidate private id refcount get/put helpers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0Nj3dzU3OR03YKizLLMFF2zpEQjc3PjJNPkRCMloJaCotS0zAqwcdG
 xtbUAcS/uOl4AAAA=
X-Change-ID: 20260213-memcg-privid-6ba2773b5ca2
To: cgroups@vger.kernel.org, linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770977026; l=5327;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=aaFj5J9A/PnGFEo2q9D27aps5NSieS+BOnpHHXp5Eqk=;
 b=NCr+8KXvWVTribPSok34ty4hUhLU2/EfjCEL+VahbxmDCkbQ5IkaoayDDK1+gfER+QaxYvFZJ
 gftXwyIzRAYCv2mzXrGBZ1ysQkQw9seQLFFImWE0V6EUqmzB4tcT1lI
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13945-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 71956134D5B
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

We currently have two different sets of helpers for getting or putting
the private IDs' refcount for order 0 and large folios. This is
redundant. Just use one and always acquire the refcount of the swapout
folio size unless it's zero, and put the refcount using the folio size
if the charge failed, since the folio size can't change. Then there is
no need to update the refcount for tail pages.

Same for freeing, then only one pair of get/put helper is needed now.

The performance might be slightly better, too: both "inc unless zero"
and "add unless zero" use the same cmpxchg implementation. For large
folios, we saved an atomic operation. And for both order 0 and large
folios, we saved a branch.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memcontrol-v1.c |  5 +----
 mm/memcontrol-v1.h |  4 ++--
 mm/memcontrol.c    | 29 +++++++----------------------
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 0e3d972fad33..c28a060abc64 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -635,11 +635,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	 * have an ID allocated to it anymore, charge the closest online
 	 * ancestor for the swap instead and transfer the memory+swap charge.
 	 */
-	swap_memcg = mem_cgroup_private_id_get_online(memcg);
 	nr_entries = folio_nr_pages(folio);
-	/* Get references for the tail pages, too */
-	if (nr_entries > 1)
-		mem_cgroup_private_id_get_many(swap_memcg, nr_entries - 1);
+	swap_memcg = mem_cgroup_private_id_get_online(memcg, nr_entries);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
 	swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), entry);
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 49933925b4ba..dbbd0e13d4ff 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -28,8 +28,8 @@ unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
-void mem_cgroup_private_id_get_many(struct mem_cgroup *memcg, unsigned int n);
-struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg);
+struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg,
+						    unsigned int n);
 
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 007413a53b45..4425ef51feae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3564,13 +3564,7 @@ static void mem_cgroup_private_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
-void __maybe_unused mem_cgroup_private_id_get_many(struct mem_cgroup *memcg,
-					   unsigned int n)
-{
-	refcount_add(n, &memcg->id.ref);
-}
-
-static void mem_cgroup_private_id_put_many(struct mem_cgroup *memcg, unsigned int n)
+static inline void mem_cgroup_private_id_put(struct mem_cgroup *memcg, unsigned int n)
 {
 	if (refcount_sub_and_test(n, &memcg->id.ref)) {
 		mem_cgroup_private_id_remove(memcg);
@@ -3580,14 +3574,9 @@ static void mem_cgroup_private_id_put_many(struct mem_cgroup *memcg, unsigned in
 	}
 }
 
-static inline void mem_cgroup_private_id_put(struct mem_cgroup *memcg)
+struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg, unsigned int n)
 {
-	mem_cgroup_private_id_put_many(memcg, 1);
-}
-
-struct mem_cgroup *mem_cgroup_private_id_get_online(struct mem_cgroup *memcg)
-{
-	while (!refcount_inc_not_zero(&memcg->id.ref)) {
+	while (!refcount_add_not_zero(n, &memcg->id.ref)) {
 		/*
 		 * The root cgroup cannot be destroyed, so it's refcount must
 		 * always be >= 1.
@@ -3888,7 +3877,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 
-	mem_cgroup_private_id_put(memcg);
+	mem_cgroup_private_id_put(memcg, 1);
 }
 
 static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
@@ -5170,19 +5159,15 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 		return 0;
 	}
 
-	memcg = mem_cgroup_private_id_get_online(memcg);
+	memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		mem_cgroup_private_id_put(memcg);
+		mem_cgroup_private_id_put(memcg, nr_pages);
 		return -ENOMEM;
 	}
-
-	/* Get references for the tail pages, too */
-	if (nr_pages > 1)
-		mem_cgroup_private_id_get_many(memcg, nr_pages - 1);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
 	swap_cgroup_record(folio, mem_cgroup_private_id(memcg), entry);
@@ -5211,7 +5196,7 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 				page_counter_uncharge(&memcg->swap, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_private_id_put_many(memcg, nr_pages);
+		mem_cgroup_private_id_put(memcg, nr_pages);
 	}
 	rcu_read_unlock();
 }

---
base-commit: 9fff1ab283e0982c2b8e73f1d2246fd38caf40c8
change-id: 20260213-memcg-privid-6ba2773b5ca2

Best regards,
-- 
Kairui Song <kasong@tencent.com>


