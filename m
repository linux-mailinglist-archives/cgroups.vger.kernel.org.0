Return-Path: <cgroups+bounces-15415-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNm6GukW52ll3wEAu9opvQ
	(envelope-from <cgroups+bounces-15415-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:19:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C2436D86
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6B853040C50
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 06:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694F438F250;
	Tue, 21 Apr 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyXGjPUq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE96386C10;
	Tue, 21 Apr 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752214; cv=none; b=igZkuGz0lfw6gdcLDebh/bdT9qnRSvT8Fx98lFJxXzZHCRrXu3eLrSfKA+0bIXnhbR1aYgqUPYRQtgGMbXZIBZxG27mNtEuM0Xh9+oFzkBnNDjrShUh0EYZFjmG8RUQQ/uUIKofTPhCWn7T3vx+ejpd3unhbSdsy/bDHkFD8NLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752214; c=relaxed/simple;
	bh=Apc9Gc6RbHUejQ0QZ/J+CpG/qcB05eyHenvm22YITWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnfjtbItvEHvAIJORPMbfgmtQop6CKFEs2EmL/KZjwqgNiiiXIgKt7mhYV3etl+XesLM7XHpUASzlr5k4AvL/i3K9BPtETrOWKEDZLCsLqUWZCPivSUrCqjgcaidnr94v7hFPP2xa25Q8/U4cuZRqbEMESIlswOuzK7hvSQV4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyXGjPUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C825C2BD05;
	Tue, 21 Apr 2026 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776752214;
	bh=Apc9Gc6RbHUejQ0QZ/J+CpG/qcB05eyHenvm22YITWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IyXGjPUqYtVLWe317We7sO0uw7Qsc4bHLU9xAGMnrcS44N3v3747zDxWBOn/pcvvO
	 QUFOmq7pWJkmk9fQOryOMMLvDMD00rr3o/hh16ZAxLBgnGuonB6tIB/a4jFo1hBZBJ
	 jukE/Eoj/g4PgdHtKbJ/wv3ETVrXULb/BnZmpaQ19pi1jorrXf709LCTaAllsww4rF
	 P03a4bjbHGAzilnhG+4YoEMtcJV3fz+bcqVhvxaJCBs6/0aM6yAXtVI8umXRk869yb
	 4paeWAhgYPYZqS2RS81izF8f14DFHdEkww6xBXlt+PTK6iecrukILldBRkJxCc7g0F
	 kueQqftcERIGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8295BF327A6;
	Tue, 21 Apr 2026 06:16:54 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 21 Apr 2026 14:16:51 +0800
Subject: [PATCH v3 07/12] mm, swap: support flexible batch freeing of slots
 in different memcgs
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-swap-table-p4-v3-7-2f23759a76bc@tencent.com>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776752211; l=2431;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=TF+4v7N3Y0fZu1fBTRYUKMMGHog+xsunCT0x6/UHUK8=;
 b=jKF0ucmqDotJQCko85mDlllnmWv+qK2so8CaITDB3VOptToZ8ErKzv7GTKqrb6flmdwtc/NBf
 Yajyzomm9HYDlRgerJnnpKVIJoHb3izF6/uzm34zTZR18PyobcZPRSq
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15415-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,tencent.com,arm.com,suse.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email,tencent.com:replyto,tencent.com:mid]
X-Rspamd-Queue-Id: 209C2436D86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Instead of requiring the caller to ensure all slots are in the same
memcg, make the function handle different memcgs at once.

This is both a micro optimization and required for removing the memcg
lookup in the page table layer, so it can be unified at the swap layer.

We are not removing the memcg lookup in the page table in this commit.
It has to be done after the memcg lookup is deferred to the swap layer.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e1ad77a69e54..8d3d22c463f3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1872,21 +1872,46 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 				 unsigned int ci_start, unsigned int nr_pages)
 {
 	unsigned long old_tb;
+	unsigned int type = si->type;
+	unsigned short id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
-	unsigned long offset = cluster_offset(si, ci) + ci_start;
+	unsigned long offset = cluster_offset(si, ci);
+	unsigned int ci_batch = ci_off;
+	swp_entry_t entry;
 
 	VM_WARN_ON(ci->count < nr_pages);
 
 	ci->count -= nr_pages;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
-		/* Release the last ref, or after swap cache is dropped */
+		/*
+		 * Freeing is done after release of the last swap count
+		 * ref, or after swap cache is dropped
+		 */
 		VM_WARN_ON(!swp_tb_is_shadow(old_tb) || __swp_tb_get_count(old_tb) > 1);
 		__swap_table_set(ci, ci_off, null_to_swp_tb());
+
+		/*
+		 * Uncharge swap slots by memcg in batches. Consecutive
+		 * slots with the same cgroup id are uncharged together.
+		 */
+		entry = swp_entry(type, offset + ci_off);
+		id_cur = lookup_swap_cgroup_id(entry);
+		if (id != id_cur) {
+			if (id)
+				mem_cgroup_uncharge_swap(swp_entry(type, offset + ci_batch),
+							 ci_off - ci_batch);
+			id = id_cur;
+			ci_batch = ci_off;
+		}
 	} while (++ci_off < ci_end);
 
-	mem_cgroup_uncharge_swap(swp_entry(si->type, offset), nr_pages);
-	swap_range_free(si, offset, nr_pages);
+	if (id) {
+		mem_cgroup_uncharge_swap(swp_entry(type, offset + ci_batch),
+					 ci_off - ci_batch);
+	}
+
+	swap_range_free(si, offset + ci_start, nr_pages);
 	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
 
 	if (!ci->count)

-- 
2.53.0



