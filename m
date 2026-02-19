Return-Path: <cgroups+bounces-14027-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKlTGNOfl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14027-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E716395D
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978CB3025A57
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C064732AAC5;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFXvPCuF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F039318BAC;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544527; cv=none; b=Fw1w/0ju0qYaBGN8egrqkyTh95pUnt+mt/b+abgBYbj54srFN7D4gGnMRohWIil0DEATz4wYHue7kaMWUSuPMaS2s5MMHUSV3gjz3RUjLIp3pwcKb2WKL50YJsfZHycTprzkpSPbvHefv2vIIDuF18Eer26PRrP85ftnRLVl4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544527; c=relaxed/simple;
	bh=WSo3skmLSrebPHHPF6qNxghI6awr0lM5qgwbnMJhTJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQlv6VVqTyumqNQnMfBs43FfVA4JqudMZS4HTyEC6syJIBCmAmG6tvL8auxO3hKZNk2svFmi6qgmGva/Nzz9+xdqoMQHXFc6vCyljMLJ7dgShMwC63BsX1JDnN1WWpmIJIIrFbYyvA7N/84eKMw8q0PmDkwAoXouZAjEru1hiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFXvPCuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55FA9C19424;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=WSo3skmLSrebPHHPF6qNxghI6awr0lM5qgwbnMJhTJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VFXvPCuF/nFHG4CnQmBgxAzX0WavcFlKpayccYoFpNvlmlr/wDxM390ScxIPDw5cE
	 G4eIy5QNLNoncH59IZhtYkzpyDAep36Ox4c8lbgWjVIAh/otAcZp3MleL8iI4BPd5f
	 uPURcb37dfXpMKGvM8non1GZ5Ntww1seUbgE11QXxJh4qGASLGDlO4Y5TktKwoHz/0
	 JR1m8gvalduWPdKkJivQnvXxtgdgMuuQEtXNSUiyfIy+gQ3ijhtMgtpy9vkmKwXxgy
	 D2CGhiUe//3Z2fPXChgIpzEsdE3B/ZmQcDf5YhuhIwnGSGbc4deN2xkHW09XWcpClv
	 XZbTUmznSrKUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A5C531EC;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:04 +0800
Subject: [PATCH RFC 03/15] mm, swap: move conflict checking logic of out
 swap cache adding
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-3-104795d19815@tencent.com>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=2479;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=rqW0brukQP1nLveDT5lSrI7q5RqloSsXptUI4qjvbG0=;
 b=baKnG1/Gi7wFMKTzje7SnEgg9EDLUa44x9RAZMPl9v/vf3/tXIL//YuczgbEESSIT40UR2HUU
 O82G6iejjPfADkB7eXmmU+PTBDK4/16jjf74zjEuJmZ1qNRnyE7B6fM
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14027-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: D11E716395D
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

No feature change, make later commits easier to review.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 55 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 53fa95059012..1e340faea9ac 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -137,6 +137,28 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
+static int __swap_cache_add_check(struct swap_cluster_info *ci,
+				  unsigned int ci_off, unsigned int nr,
+				  void **shadow)
+{
+	unsigned int ci_end = ci_off + nr;
+	unsigned long old_tb;
+
+	if (unlikely(!ci->table))
+		return -ENOENT;
+	do {
+		old_tb = __swap_table_get(ci, ci_off);
+		if (unlikely(swp_tb_is_folio(old_tb)))
+			return -EEXIST;
+		if (unlikely(!__swp_tb_get_count(old_tb)))
+			return -ENOENT;
+		if (swp_tb_is_shadow(old_tb))
+			*shadow = swp_tb_to_shadow(old_tb);
+	} while (++ci_off < ci_end);
+
+	return 0;
+}
+
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry)
 {
@@ -179,43 +201,26 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 {
 	int err;
 	void *shadow = NULL;
-	unsigned long old_tb;
+	unsigned int ci_off;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
-	unsigned int ci_start, ci_off, ci_end;
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	si = __swap_entry_to_info(entry);
-	ci_start = swp_cluster_offset(entry);
-	ci_end = ci_start + nr_pages;
-	ci_off = ci_start;
 	ci = swap_cluster_lock(si, swp_offset(entry));
-	if (unlikely(!ci->table)) {
-		err = -ENOENT;
-		goto failed;
+	ci_off = swp_cluster_offset(entry);
+	err = __swap_cache_add_check(ci, ci_off, nr_pages, &shadow);
+	if (err) {
+		swap_cluster_unlock(ci);
+		return err;
 	}
-	do {
-		old_tb = __swap_table_get(ci, ci_off);
-		if (unlikely(swp_tb_is_folio(old_tb))) {
-			err = -EEXIST;
-			goto failed;
-		}
-		if (unlikely(!__swp_tb_get_count(old_tb))) {
-			err = -ENOENT;
-			goto failed;
-		}
-		if (swp_tb_is_shadow(old_tb))
-			shadow = swp_tb_to_shadow(old_tb);
-	} while (++ci_off < ci_end);
+
 	__swap_cache_add_folio(ci, folio, entry);
 	swap_cluster_unlock(ci);
 	if (shadowp)
 		*shadowp = shadow;
-	return 0;
 
-failed:
-	swap_cluster_unlock(ci);
-	return err;
+	return 0;
 }
 
 /**

-- 
2.53.0



