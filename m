Return-Path: <cgroups+bounces-15184-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEbSAtEb1Wli0wcAu9opvQ
	(envelope-from <cgroups+bounces-15184-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031E3B0834
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E665A307C7DF
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D133D515;
	Tue,  7 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKViqKdN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879D33CEA7;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573746; cv=none; b=OvFRM6hmX03otud3tOR6xIaJDTEVQBrlJPliozR8JYnETz1KQpcr9uR8r2T5lrHfBHeS/ao/L0OBFydcO9wDaD9ANjIMBSuuxhIzWrjwFB7un0qgbgA3rfjrYn+HN95TIGsLj04eakeAd5JCrJsYoCLEzcuos9oSve4RPk6iLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573746; c=relaxed/simple;
	bh=Fv9PtzN7xCSTNsq4ANj8AT1swf3W60piN2PSJ2CQe5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTZhJ7DA9yUJlrUmhhn06g2nlZIS7iS2qPK8Dfezwc0HXFKLrEWAZAlwHrrSelVdB0locGTKN5u1icQkF0m2g29QJysC6t7/1SxoNQzrz8KV7Q/9TUpVYy5xZXqSoK5sTOgkikbGniGromq+sn1d4nohKValPe98LDEo2xOg/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKViqKdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB0BDC2BCAF;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775573745;
	bh=Fv9PtzN7xCSTNsq4ANj8AT1swf3W60piN2PSJ2CQe5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qKViqKdNbUTPQihtHtm1YVs6+OE/BmF1bRVTdVUeBbqshZPcUsmBWB/POqBPmhTi4
	 Hz/pt9Xs46mhPrQ3ILw+Nm7UHZPtF6fjBoE1mNur97AaHB9X+yeoU8E7HhLuWM1EZM
	 ObA2ayE7aX6LpG3e5R8ewXHVNc3s3ADDCtqY7L5wz3+dq3vC4QGPQkJ+gh16zEC+QE
	 nVlGDc0sw9b2HPKiU8Rjq+WJ4te1fzZc9OsgegPqBAi8E7Usrr/wWs1rwIMOLRp5r4
	 XAeLqyow15dqL/rmw1LJoDYf37JzoOzwuT00PPRhlzoBTlsM5SkxQVh5g1+XJbeA/7
	 kUDZyuZ6CmiRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC60FEEF49;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 07 Apr 2026 22:55:42 +0800
Subject: [PATCH RFC 1/2] mm, swap: fix potential race of charging into the
 wrong memcg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-swap-memcg-fix-v1-1-a473ce2e5bb8@tencent.com>
References: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
In-Reply-To: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775573744; l=6871;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=8waYhVG/zmYZKbTD5LXs0veHtD/HsXryyRZUBo5GKyE=;
 b=irCjKZJcfH1APdFUGYgGW2UOdJ94anKzvDXlkVQVoeRoDu0PD7sDKOyFiX0KbC3RdeQzjyai6
 YgLFnp1vTe9BhgDMcWBN37tGPiBPT9o90xyn/zf486gb5TKWojQBGk5
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15184-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,lge.com,cmpxchg.org,ghiti.fr,oracle.com,google.com,suse.com,linux.alibaba.com,oppo.com,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7031E3B0834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Swapin folios are allocated and charged without adding to the swap
cache. So it is possible that the corresponding swap slot will
be freed, then get allocated again by another memory cgroup. By that
time, continuing to use the previously charged folio will be risky.

Usually, this won't cause an issue since the upper-level users of the
swap entry, the page table, or mapping, will change if the swap entry is
freed. But, it's possible the page table just happened to be reusing the
same swap entry too, and if that was used by another cgroup, then that's
a problem.

The chance is extremely low, previously this issue is limited to
SYNCHRONOUS_IO devices. But recent commit 9acbe135588e ("mm/swap:
fix swap cache memcg accounting") extended the same pattern,
charging the folio without adding the folio to swap cache first.
The chance is still extremely low, but in theory, it is more common.

So to fix that, keep the pattern introduced by commit 2732acda82c9 ("mm,
swap: use swap cache as the swap in synchronize layer"), always uses
swap cache as the synchronize layer first, and do the charge afterward.
And fix the issue that commit 9acbe135588e ("mm/swap: fix swap cache
memcg accounting") is trying to fix by separating the statistic part
out.

This commit only fixes the issue for non SYNCHRONOUS_IO devices. Another
separate fix is needed for these devices.

Fixes: 9acbe135588e ("mm/swap: fix swap cache memcg accounting")
Fixes: 2732acda82c9 ("mm, swap: use swap cache as the swap in synchronize layer")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 53 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1415a5c54a43..c53d16b87a98 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -137,8 +137,8 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-void __swap_cache_add_folio(struct swap_cluster_info *ci,
-			    struct folio *folio, swp_entry_t entry)
+static void __swap_cache_do_add_folio(struct swap_cluster_info *ci,
+				      struct folio *folio, swp_entry_t entry)
 {
 	unsigned int ci_off = swp_cluster_offset(entry), ci_end;
 	unsigned long nr_pages = folio_nr_pages(folio);
@@ -159,7 +159,14 @@ void __swap_cache_add_folio(struct swap_cluster_info *ci,
 	folio_ref_add(folio, nr_pages);
 	folio_set_swapcache(folio);
 	folio->swap = entry;
+}
+
+void __swap_cache_add_folio(struct swap_cluster_info *ci,
+			    struct folio *folio, swp_entry_t entry)
+{
+	unsigned long nr_pages = folio_nr_pages(folio);
 
+	__swap_cache_do_add_folio(ci, folio, entry);
 	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 }
@@ -207,7 +214,7 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 		if (swp_tb_is_shadow(old_tb))
 			shadow = swp_tb_to_shadow(old_tb);
 	} while (++ci_off < ci_end);
-	__swap_cache_add_folio(ci, folio, entry);
+	__swap_cache_do_add_folio(ci, folio, entry);
 	swap_cluster_unlock(ci);
 	if (shadowp)
 		*shadowp = shadow;
@@ -219,7 +226,7 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 }
 
 /**
- * __swap_cache_del_folio - Removes a folio from the swap cache.
+ * __swap_cache_do_del_folio - Removes a folio from the swap cache.
  * @ci: The locked swap cluster.
  * @folio: The folio.
  * @entry: The first swap entry that the folio corresponds to.
@@ -231,8 +238,9 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
  * Context: Caller must ensure the folio is locked and in the swap cache
  * using the index of @entry, and lock the cluster that holds the entries.
  */
-void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
-			    swp_entry_t entry, void *shadow)
+static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
+				      struct folio *folio,
+				      swp_entry_t entry, void *shadow)
 {
 	int count;
 	unsigned long old_tb;
@@ -265,8 +273,6 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
-	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
-	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
 
 	if (!folio_swapped) {
 		__swap_cluster_free_entries(si, ci, ci_start, nr_pages);
@@ -279,6 +285,16 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	}
 }
 
+void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
+			    swp_entry_t entry, void *shadow)
+{
+	unsigned long nr_pages = folio_nr_pages(folio);
+
+	__swap_cache_do_del_folio(ci, folio, entry, shadow);
+	node_stat_mod_folio(folio, NR_FILE_PAGES, -nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr_pages);
+}
+
 /**
  * swap_cache_del_folio - Removes a folio from the swap cache.
  * @folio: The folio.
@@ -452,7 +468,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  * __swap_cache_prepare_and_add - Prepare the folio and add it to swap cache.
  * @entry: swap entry to be bound to the folio.
  * @folio: folio to be added.
- * @gfp: memory allocation flags for charge, can be 0 if @charged if true.
+ * @gfp: memory allocation flags for charge, can be 0 if @charged is true.
  * @charged: if the folio is already charged.
  *
  * Update the swap_map and add folio as swap cache, typically before swapin.
@@ -466,16 +482,15 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 						  struct folio *folio,
 						  gfp_t gfp, bool charged)
 {
+	unsigned long nr_pages = folio_nr_pages(folio);
 	struct folio *swapcache = NULL;
+	struct swap_cluster_info *ci;
 	void *shadow;
 	int ret;
 
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
-	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry))
-		goto failed;
-
 	for (;;) {
 		ret = swap_cache_add_folio(folio, entry, &shadow);
 		if (!ret)
@@ -496,6 +511,20 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 			goto failed;
 	}
 
+	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
+		/* We might lose the shadow here, but that's fine */
+		ci = swap_cluster_get_and_lock(folio);
+		__swap_cache_do_del_folio(ci, folio, entry, NULL);
+		swap_cluster_unlock(ci);
+
+		/* __swap_cache_do_del_folio doesn't put the refs */
+		folio_ref_sub(folio, nr_pages);
+		goto failed;
+	}
+
+	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
+
 	memcg1_swapin(entry, folio_nr_pages(folio));
 	if (shadow)
 		workingset_refault(folio, shadow);

-- 
2.53.0



