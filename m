Return-Path: <cgroups+bounces-16424-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIsKIBiGGWouxQgAu9opvQ
	(envelope-from <cgroups+bounces-16424-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:27:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40656023EF
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CE43087E57
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C93E0C44;
	Fri, 29 May 2026 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BzvFiQIv"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F23BA24F;
	Fri, 29 May 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057183; cv=none; b=sHbj+GWvHy3H844dRZwrRI+sjKeALAa1fKU2sZLGRr5MwkpiKcv1AkFAoa3Z6ZZJJHQZA2ahwVRO7LNBUeod0Zx97XYuAObVS9FSjkhYwjOgLbwmjje2XyAOuFL/1UMfyN3tYL3zf5uJELBl0Fqfd2cUHGiiL2yIV+ptAZtKQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057183; c=relaxed/simple;
	bh=UsDJ1SlBWLJpayBtQ4Q84psXrtlnhwGU8Oh1yWXjOXE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CBRHiWA/8r7fTcg6UsDvsMggdg0t+/luyZcuGhc+87XGtotLAX+4ZFmtGuIRvfHgBt97B9d+dS7geQeoybgt3IQ8Y+MJFhExQmKbxatI44wrWJ6q7TgGJWdlAGUkPdznv2mNcqqoVFVYvzblXHGKGG1vy93aUK9j7DlG2lAy338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BzvFiQIv; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780057173; bh=6upOtVdcSMEiWQj/LoAhI+cSqrQul/bXobDwKNZi3uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzvFiQIvEF5lRfApXuRIxXloyfW601cGekF8ReFj0UlHXWD9RHUFiEFDrLk7GXs1J
	 7at9eI/Y2ppncPSORnYgaR+zy2U5HhUJ6SEq4ztojqt0LsG3nv10NrU73s7W6HLBiQ
	 UPA5LeF5x9NJmz9dXdOA+uSBXx+lGhzGX1PXPY9c=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4DC10017; Fri, 29 May 2026 20:19:28 +0800
X-QQ-mid: xmsmtpt1780057170tklm0azzd
Message-ID: <tencent_930D3FD72B2ECF2379248F7CDE48587C700A@qq.com>
X-QQ-XMAILINFO: OOyEews/EdUgGrC4kGz6V3LDdcHDMeu94hgH5yaIgtByJKumzwq6uB/LtnUX5R
	 NhmcZbGtYlmURp2oM1N69k54MXOemCKwW531GwD9CHAQzgSkdUfQ+G51ao2t9n0h/ek1cueUGZjv
	 oGf/2fN8/9HbK/4I7fQiyEx8TguKH2lXJAqD5ocJy0zjJndYW1p3bgE+aGbYgGe0+2e8w8vW48PQ
	 rRQZVsbVSa0bCZbTax1zSG7ZZchB0vywtSbJ6tG/A3/vYjfJDm+89dV+PmTkiLLqaUDv07/yeUmn
	 0/5BKilNIWIrY5caenuAr1qohxZjapyNZ4QcShN7K/ILv8ed0HZFwNMDh1YQBBg3TlI7sbOk39yX
	 J9rrE97T7IMgYlE7UFzBAjsHGUH2opi9VGznwyWyG/nI4Ju+6CrOJwt71y+wlKAaCB2noNv+cdfC
	 BL/Yw0pSDCNLsShxYtCEZXadUKNPMjD//CTiHS8I17KAZdhrCno6NX8i+3NWo3pe5vYwGWsRzEvr
	 aAK4L3zS9JQiEVCcbzT+z0QcWKEcmYP1e7vuaWrWKg6Y+Glkam4raxVypRdI9qQJ6CV1VWRa0+ir
	 wxbY1ByjmCzt5I2poqyT13EiBvgoSUcFuLKlTmvfVai43SZ8MDefdUrtZGTI8qme/WsA5xHIyMYC
	 zYIUFPT0vCMiZp2sPWJHdDAq9r0sPFCp4bnfd98UkPA1m2MiGpokbzj1oxVrz4f4YR59fn3VAccP
	 VYzyHyoORAeyGMnUahdrRLTbiZfyC3vlXlOMFzPrKTJ6qL3qS70aHdxHzO3sJE7TQrwcNTOAZLzy
	 Inbj/ucF6w9UcFL3ZN2YqZbCsnkMRIJe5GiBw1SVfjxF+Jizz1UDAJ2NW2mEeBbat2GprN4ATd2P
	 MHAV1jsF1QK1QVY92ZzgvKj8vKvqjDuFl8NjIcw+y9b+yxM0gxI1/N7lXLPHXZUuVJmjOGH7wEge
	 VcobaFqn0REtwLVTc/GIFIHaW3Jni9Q9p4irGdaGOerWpqZJDNEnPhVaDf47gaxpibaSO/frPnma
	 Aoj/hz08eLwq61sqEVp+hh2pCt0nkXSjZ93AvWh1h+CN5Dd7Dw
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: fujunjie <fujunjie1@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@meta.com>,
	Kairui Song <kasong@tencent.com>,
	Usama Arif <usamaarif642@gmail.com>
Cc: Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 2/9] mm: let swap_read_folio() report retryable zswap races
Date: Fri, 29 May 2026 12:19:21 +0000
X-OQ-MSGID: <20260529121928.4115683-2-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16424-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,gmail.com,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: D40656023EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Large zswap loads need a way to ask the caller to drop a speculative large
swapcache folio and retry order-0. A void swap_read_folio() cannot express
that without turning a backend race into an IO failure.

Return int from swap_read_folio() and reserve -EAGAIN for retryable large
zswap races. Existing order-0 paths keep treating the read as before; the
synchronous swapin path only warns for now. A later patch will consume
-EAGAIN and retry order-0.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/page_io.c    | 19 +++++++++++++++++--
 mm/swap.h       |  5 +++--
 mm/swap_state.c | 13 +++++++++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index f2d8fe7fd057..16724bdfb400 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -653,13 +653,21 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
+/*
+ * Return -EAGAIN only when a locked large swapcache folio hit a retryable
+ * zswap backend race. The caller owns that still-locked folio and must drop or
+ * retry it. Other zswap errors are still reported through the usual folio
+ * state: the folio is unlocked without PG_uptodate and the fault path will
+ * turn that into an I/O error.
+ */
+int swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
 	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
+	int ret = 0;
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -681,8 +689,14 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		goto finish;
 	}
 
-	if (zswap_load(folio) != -ENOENT)
+	ret = zswap_load(folio);
+	if (ret == -EAGAIN) {
+		VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
 		goto finish;
+	}
+	if (ret != -ENOENT)
+		goto finish;
+	ret = 0;
 
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
@@ -701,6 +715,7 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 		psi_memstall_leave(&pflags);
 	}
 	delayacct_swapin_end();
+	return ret;
 }
 
 void __swap_read_unplug(struct swap_iocb *sio)
diff --git a/mm/swap.h b/mm/swap.h
index 77d2d14eda42..ea7e1f3c4410 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -241,7 +241,7 @@ extern void __swap_cluster_free_entries(struct swap_info_struct *si,
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-void swap_read_folio(struct folio *folio, struct swap_iocb **plug);
+int swap_read_folio(struct folio *folio, struct swap_iocb **plug);
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -381,8 +381,9 @@ static inline void folio_put_swap(struct folio *folio, struct page *page)
 {
 }
 
-static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
+static inline int swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
+	return 0;
 }
 
 static inline void swap_write_unplug(struct swap_iocb *sio)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 04f5ce992401..d37097913b30 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -628,6 +628,7 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 					   struct swap_iocb **plug, bool readahead)
 {
 	struct folio *folio;
+	int ret;
 
 	do {
 		folio = swap_cache_get_folio(entry);
@@ -639,7 +640,13 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 	if (IS_ERR_OR_NULL(folio))
 		return NULL;
 
-	swap_read_folio(folio, plug);
+	ret = swap_read_folio(folio, plug);
+	/*
+	 * Swap readahead allocates order-0 folios. -EAGAIN is reserved for
+	 * retryable large zswap backend races and must be handled by the
+	 * synchronous common swapin path.
+	 */
+	VM_WARN_ON_ONCE(ret == -EAGAIN);
 	if (readahead) {
 		folio_set_readahead(folio);
 		count_vm_event(SWAP_RA);
@@ -668,6 +675,7 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
 			   struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
+	int ret;
 
 	do {
 		folio = swap_cache_get_folio(entry);
@@ -679,7 +687,8 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
 	if (IS_ERR(folio))
 		return folio;
 
-	swap_read_folio(folio, NULL);
+	ret = swap_read_folio(folio, NULL);
+	VM_WARN_ON_ONCE(ret == -EAGAIN);
 	return folio;
 }
 
-- 
2.34.1


