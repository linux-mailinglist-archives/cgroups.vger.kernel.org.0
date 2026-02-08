Return-Path: <cgroups+bounces-13776-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP3gJV0HiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13776-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 22:59:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A010A51C
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 22:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B879C3034E01
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893223587A9;
	Sun,  8 Feb 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG9qI0kY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F234FF5A
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587932; cv=none; b=nFOF6pma5qF4GkHgrakPqQhHNOjpMGCO0z3EYZ8LXavupUSOlbCQUiZO9pnhIPAF54euIblO2wtU3QVeTJ322SAo/tC/o44C8rLJ8hQb9DZ4Y0EUnaAdHFPNEHP/RzCRZWaZIJnquOotyuoHlOB8THy6SjV14l+pOtENfC7uhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587932; c=relaxed/simple;
	bh=ODJpTK6yx8sL3Yjx3SR46wf2FGw+h0vJmlVT0y2AyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5DoWipOp/bDGa0Yq0G4YGdHqXwBCQ54NHtJ30GsdZptD3tQUQcHzrATtABvL7gDD5QPTTvBqlaKYt4tqgShbW8q4xRHENq2VNWV1KAVT9EIApcZO/BeYhoyeR5M/UFZgpTPityMn9oQN4Xhg88noJ4xVSsi4Gefm5AL661GM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG9qI0kY; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfcb46ffc9so2705433a34.0
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587931; x=1771192731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpwswEDlCandEKSEcjjhsX6vu11jfmhgbFRVqdS0y6A=;
        b=dG9qI0kYQmhW6JNCk95pxW7PPQil8zbjJFz87Ku7Nkh86EZVGIPPfNKoiPpKUmt7ah
         Ca/uVBL1FGUlsicpkOLBKVBeF8Tm6yKbgdvfnUokxsG2Jwl0ef/NyQXx2j9P4TrIDzYQ
         +hAZaq5nvpUYgyR3rDhRKvq/tpfPLSaLXoa3qfqak/nQGQwtpqJUL34fGjOXlW2V5v8E
         OfF4NhluWoIili8uqIAamc0ElWDSY4pF9uaYeCuv36FG7XyWD1YlHXboNTxwbZ/CfZ0q
         R8EKETELmcXLN8hUii6EH7dj+Z/os38EJ6fiUWe+uTIzESMFDTcEh+te/nqiVJyE429D
         7Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587931; x=1771192731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpwswEDlCandEKSEcjjhsX6vu11jfmhgbFRVqdS0y6A=;
        b=e/rH//1poZ+hN20uZ3kE68jeMu8bgrqxIFmSGa9BBtgRCzc+hX1/ChhI6JZkE6D9zG
         OaMW2zI9oj4LAyJ3wbxeBdZ+TQ4zVkRjrWwc+2Flel+pP0Kkm+3pfP0C/7S3NUcww5do
         fyQ+u6zDYlIWm5GeMbQYYZSg9S1SyP5tykUBxzKOQJwHWULA5OPSD3VCJCXyr6eu+0ny
         ULxcYzDLV6ND8bdKW1H8UqObOGj5zi3ouu7Q+h6VN8k0rzz2AdAzlw8KQh90sh4SsC83
         K72qslTF0QEwDPnTo5XN1XtjlChHNoWtI9Av6N8yw74ig7VaseX+dTYF7luWbhThTWk0
         X61A==
X-Forwarded-Encrypted: i=1; AJvYcCWF8tb4tWjT6yzU+/rQq6AevS8lGXvHX3V/uwBakYLxeVhNb0b+IwJ0Hw5q238L6reE/GiKrijD@vger.kernel.org
X-Gm-Message-State: AOJu0YxKiF94kYAyP0rbUG6o16mv4+R8gA90TQK3T+7hzAzqvrbMOp21
	bpUCSNm10uQGXV6/dzxZ5D8meIc4TqcExYM72EB/MvD96Am/49HfAIoS
X-Gm-Gg: AZuq6aInJ0aZL8DnBBsBaPnJ+hktZ5Vjn1ESUa3nt+eGqG2nssoTgQHlfqtoCl8uKJT
	6oQC7j2UGIP3zeEqDyVQ4eVn6LYFkz88/5m5k4cC9oEJBJ2mBT0OnS4vwl5sOWsRDo2nWN1Ydzl
	ROQCvIH8RHaautofSSafg2RSc/ynkaxryP773ppkn+hifLYbDh6kNbm9X87xYaWGOp29uUwPgrr
	sdvJgD3I1cEy7zOeijhDQdVJdGVfooz5P3CbUn50knyJWu8OzQEUtjq4eBMm9vIBn+dK1rslIBV
	vtesso9/cETIdh5q/uOxaThHytNQopwQGqsBXFU93J31se8ni5ehOx79YUkoczcwyq3wa411nfn
	tV/r8kTUAq8AVuiD0ItN7QeTGved1Q/FAwH0+pSSImYTRFyoU02ieBulhLX4S73eXI/JxBhUoWe
	IH+7LWd+yrk4KdWEcLHETShQ9pNkSGGaxdbg==
X-Received: by 2002:a05:6830:828c:b0:7d1:93ea:5bc0 with SMTP id 46e09a7af769-7d4633df66dmr5296308a34.9.1770587931097;
        Sun, 08 Feb 2026 13:58:51 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4646fb89fsm6346653a34.1.2026.02.08.13.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:58:50 -0800 (PST)
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
Subject: [PATCH v3 04/20] zswap: add new helpers for zswap entry operations
Date: Sun,  8 Feb 2026 13:58:17 -0800
Message-ID: <20260208215839.87595-5-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13776-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F36A010A51C
X-Rspamd-Action: no action

Add new helper functions to abstract away zswap entry operations, in
order to facilitate re-implementing these functions when swap is
virtualized.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 59 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 315e4d0d08311..a5a3f068bd1a6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -234,6 +234,38 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 		>> ZSWAP_ADDRESS_SPACE_SHIFT];
 }
 
+static inline void *zswap_entry_store(swp_entry_t swpentry,
+		struct zswap_entry *entry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_store(tree, offset, entry, GFP_KERNEL);
+}
+
+static inline void *zswap_entry_load(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_load(tree, offset);
+}
+
+static inline void *zswap_entry_erase(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+	pgoff_t offset = swp_offset(swpentry);
+
+	return xa_erase(tree, offset);
+}
+
+static inline bool zswap_empty(swp_entry_t swpentry)
+{
+	struct xarray *tree = swap_zswap_tree(swpentry);
+
+	return xa_empty(tree);
+}
+
 #define zswap_pool_debug(msg, p)			\
 	pr_debug("%s pool %s\n", msg, (p)->tfm_name)
 
@@ -1000,8 +1032,6 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 swp_entry_t swpentry)
 {
-	struct xarray *tree;
-	pgoff_t offset = swp_offset(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
@@ -1040,8 +1070,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * old compressed data. Only when this is successful can the entry
 	 * be dereferenced.
 	 */
-	tree = swap_zswap_tree(swpentry);
-	if (entry != xa_load(tree, offset)) {
+	if (entry != zswap_entry_load(swpentry)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1051,7 +1080,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		goto out;
 	}
 
-	xa_erase(tree, offset);
+	zswap_entry_erase(swpentry);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1427,9 +1456,7 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = xa_store(swap_zswap_tree(page_swpentry),
-		       swp_offset(page_swpentry),
-		       entry, GFP_KERNEL);
+	old = zswap_entry_store(page_swpentry, entry);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
 
@@ -1563,11 +1590,9 @@ bool zswap_store(struct folio *folio)
 		unsigned type = swp_type(swp);
 		pgoff_t offset = swp_offset(swp);
 		struct zswap_entry *entry;
-		struct xarray *tree;
 
 		for (index = 0; index < nr_pages; ++index) {
-			tree = swap_zswap_tree(swp_entry(type, offset + index));
-			entry = xa_erase(tree, offset + index);
+			entry = zswap_entry_erase(swp_entry(type, offset + index));
 			if (entry)
 				zswap_entry_free(entry);
 		}
@@ -1599,9 +1624,7 @@ bool zswap_store(struct folio *folio)
 int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-	pgoff_t offset = swp_offset(swp);
 	bool swapcache = folio_test_swapcache(folio);
-	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1619,7 +1642,7 @@ int zswap_load(struct folio *folio)
 		return -EINVAL;
 	}
 
-	entry = xa_load(tree, offset);
+	entry = zswap_entry_load(swp);
 	if (!entry)
 		return -ENOENT;
 
@@ -1648,7 +1671,7 @@ int zswap_load(struct folio *folio)
 	 */
 	if (swapcache) {
 		folio_mark_dirty(folio);
-		xa_erase(tree, offset);
+		zswap_entry_erase(swp);
 		zswap_entry_free(entry);
 	}
 
@@ -1658,14 +1681,12 @@ int zswap_load(struct folio *folio)
 
 void zswap_invalidate(swp_entry_t swp)
 {
-	pgoff_t offset = swp_offset(swp);
-	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
-	if (xa_empty(tree))
+	if (zswap_empty(swp))
 		return;
 
-	entry = xa_erase(tree, offset);
+	entry = zswap_entry_erase(swp);
 	if (entry)
 		zswap_entry_free(entry);
 }
-- 
2.47.3


