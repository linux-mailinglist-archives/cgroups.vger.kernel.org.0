Return-Path: <cgroups+bounces-15329-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMqWMkEs4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15329-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77967413CA3
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2482130B07B1
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C13833DEE1;
	Thu, 16 Apr 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc1Y4l13"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9A33859C;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364483; cv=none; b=Cl11Hysug1npX1bs+PjUnbsJ/7LlzF6s3pngZmmWRbkI+UZXadAKag5+qroSPSH23rq+TT43BabLO0nFWojFPx7vQTzB636zORhFJVf1qFyeLR1JsOVmwsZl4X6B5fvAP45UnSW42wLn2QgpgryG25GYbkW8ikU32S/NPTc6QGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364483; c=relaxed/simple;
	bh=vCN+jnm2KrIoq6Jh4QVagjJUQZD7cvPe58DqpVh71Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXCPklySaSy9aZOCxGPew1ab21lSnRcBjXJwJhZsBUDyNH0UvhhC3uL/YshyW/d4e2qE6b6TARCl7orJll4FnBNdJhbb6RKXexfJ4EbiHa57mtk06xwE991kHmrzGUBZNa8pSbGSDlfAy/s31eIyaJnFocDJkbW9Sj6GHB9Pf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc1Y4l13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AADBC2BCAF;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=vCN+jnm2KrIoq6Jh4QVagjJUQZD7cvPe58DqpVh71Qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kc1Y4l13jFM0uMz86aNc15rOvQCpQAijJYy3j+Et/5bhT+qSJdOX+kkZuwg6CsTM1
	 Ao0c7rxNBraNu7KubZBwq4WsGgnGn06uPww1iNXJEKD71AGhGsjjLMrmAOh6hz2f8F
	 MXEhkSwStoW23sdf+66XYKNxw530Ab/NnKteP9+MAnMm88HSPE57xcxDCulGStYpa4
	 9Ty5PQYOPuaWryqzxWFXe2/1kE7RDDCSziaN6GtT6xnzcbicUuF9TL4SdH7uReWo2P
	 CUofdULSdGYfxMeS6pLBZo2DXfTCrn3KpYf0Oxho9Xts4dCUh1/c2Nx2oeFUINOyVm
	 3e4HzSmaBnQkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711BDF8D767;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 17 Apr 2026 02:34:37 +0800
Subject: [PATCH v2 07/11] mm, swap: support flexible batch freeing of slots
 in different memcg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-swap-table-p4-v2-7-17f5d1015428@tencent.com>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
In-Reply-To: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
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
 Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=2138;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=YoaWnsRYGA8A2cEs47E+NMl/V2GjNEqDdJTVjYzFty8=;
 b=wj/6qOyQFBRTit1e7iKg9Wxj6FEpM7E7kz2L87NyATQVErv7WhyPAhQYL/Wj4Pcj+VE2iwp3l
 4oSUb0ynR6vCnDfMJOupRgYf8Xkijt82tPcuL3/ANXJ10HlJcuPBDCR
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15329-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,tencent.com,arm.com,suse.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77967413CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Instead of requiring the caller to ensure all slots are in the same
memcg, make the function handle different memcgs at once.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2211d290ae95..b0efae57b973 100644
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



