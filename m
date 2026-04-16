Return-Path: <cgroups+bounces-15326-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMuJFSUs4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15326-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5D413C7E
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7A93084EB7
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D7133A029;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaEZ0XbJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20B325495;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364483; cv=none; b=GyZp8s9bvPBnBB6cC+s0iF28fr9Mii0rRDZo3coWV21SmeR6eCJIjdIkSFdr8QM6PFEHnN4+T/f3RIwfCaEQua+ZBuOkXmKgx5j3on49gu1o7Zoe25k6uhC4mf/1sHIe7NmEM4RKJeAw1isr45KVc6FPcdkis40l+t1fTRTKseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364483; c=relaxed/simple;
	bh=9uUJ5ZnhzVcRroGJtWh+PmTiaF0DxXOB9t/m6eZEc80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PndBM9+RF+6/bf/etDwWpBD6Mn4103eTcBwi4NbGkSXx1uTFjngnfYR5t+w5OgeII2X3r5lzZF1yx9vNkUgxaxikiteTxhuLdPY9akN6q7L2DLlpGuv03CmrQqbjGC6lddsHWGpP0ScV0Q8URf0vEFJR3WdfvppNdK43lZRDVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaEZ0XbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED60C2BCC9;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=9uUJ5ZnhzVcRroGJtWh+PmTiaF0DxXOB9t/m6eZEc80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZaEZ0XbJEumKLxVc1H9xC+yfsyN5xZ9bsT9w1O7wTJEoaO+fkKWsaQRFcpTp05Ip7
	 QhalfryuOXOcz6iD0FP9/Xr4pgCZ25AkQaQiYxtpKfycMTE5TngKyhoKiEgaJrBrme
	 a47A09XclA2REDH7r+86rmgCvfvoPm7niaf3cekAM/wdlmGRKmU1aexUq+cjSVXk8/
	 cX2Ir9eoM6QvxivW4Ah4eg5UBkQPZUTi+64eeKHvRLktx/OaoRWCQgD51Txw0cQwKQ
	 7IJbjDrzof2IxVMdd27izddIPxYGRO7VEWH0TCZ0rgpk//zbGWr2uDizPZcg6udAWk
	 MuxzWkQJeNRvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D52F8D762;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 17 Apr 2026 02:34:33 +0800
Subject: [PATCH v2 03/11] mm/huge_memory: move THP gfp limit helper into
 header
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-swap-table-p4-v2-3-17f5d1015428@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=4259;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=tNStPcbhu28x3vCRrCUXOyfb3dS9dfh2od9kzNLsOpI=;
 b=BS6cZ/T106dgH6DLMjDENOEw0SeMKv/MGI8DBrZ6Bb1kxRThc1p+xh2XD0Qhjh/RFU/UK23TP
 hXc7azdvKd5DNdWhiXOfcdnZL47jBOVZtmGTMhhOCD7DfU0ZN6m7V2X
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
	TAGGED_FROM(0.00)[bounces-15326-lists,cgroups=lfdr.de,kasong.tencent.com];
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
X-Rspamd-Queue-Id: E7F5D413C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Shmem has some special requirements for THP GFP and has to limit it in
certain zones or more lenient fallback.

We'll use this helper for generic swap THP allocation, which needs to
support shmem. For typical GFP_HIGHUSER_MOVABLE swap in this helper is
basically a noop but it's necessary for certain shmem users, mostly
drivers.

No feature change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/huge_mm.h | 30 ++++++++++++++++++++++++++++++
 mm/shmem.c              | 30 +++---------------------------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2949e5acff35..4c16e5d9756f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -237,6 +237,31 @@ static inline bool thp_vma_suitable_order(struct vm_area_struct *vma,
 	return true;
 }
 
+/*
+ * Make sure huge_gfp is always more limited than limit_gfp.
+ * Some shmem users want THP allocation to be done less aggresively
+ * and only in certain zone.
+ */
+static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
+{
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
+	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
+	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
+
+	/* Allow allocations only from the originally specified zones. */
+	result |= zoneflags;
+
+	/*
+	 * Minimize the result gfp by taking the union with the deny flags,
+	 * and the intersection of the allow flags.
+	 */
+	result |= (limit_gfp & denyflags);
+	result |= (huge_gfp & limit_gfp) & allowflags;
+
+	return result;
+}
+
 /*
  * Filter the bitfield of input orders to the ones suitable for use in the vma.
  * See thp_vma_suitable_order().
@@ -581,6 +606,11 @@ static inline bool thp_vma_suitable_order(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
+{
+	return huge_gfp;
+}
+
 static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long orders)
 {
diff --git a/mm/shmem.c b/mm/shmem.c
index 5aa43657886c..62473ec6928d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1788,30 +1788,6 @@ static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
 	return folio;
 }
 
-/*
- * Make sure huge_gfp is always more limited than limit_gfp.
- * Some of the flags set permissions, while others set limitations.
- */
-static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
-{
-	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
-	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
-	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
-	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
-
-	/* Allow allocations only from the originally specified zones. */
-	result |= zoneflags;
-
-	/*
-	 * Minimize the result gfp by taking the union with the deny flags,
-	 * and the intersection of the allow flags.
-	 */
-	result |= (limit_gfp & denyflags);
-	result |= (huge_gfp & limit_gfp) & allowflags;
-
-	return result;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 bool shmem_hpage_pmd_enabled(void)
 {
@@ -2062,7 +2038,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		     non_swapcache_batch(entry, nr_pages) != nr_pages)
 			goto fallback;
 
-		alloc_gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+		alloc_gfp = thp_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
 	}
 retry:
 	new = shmem_alloc_folio(alloc_gfp, order, info, index);
@@ -2138,7 +2114,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	if (nr_pages > 1) {
 		gfp_t huge_gfp = vma_thp_gfp_mask(vma);
 
-		gfp = limit_gfp_mask(huge_gfp, gfp);
+		gfp = thp_limit_gfp_mask(huge_gfp, gfp);
 	}
 #endif
 
@@ -2545,7 +2521,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		gfp_t huge_gfp;
 
 		huge_gfp = vma_thp_gfp_mask(vma);
-		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
+		huge_gfp = thp_limit_gfp_mask(huge_gfp, gfp);
 		folio = shmem_alloc_and_add_folio(vmf, huge_gfp,
 				inode, index, fault_mm, orders);
 		if (!IS_ERR(folio)) {

-- 
2.53.0



