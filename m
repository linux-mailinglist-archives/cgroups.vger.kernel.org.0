Return-Path: <cgroups+bounces-3806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DC9376A6
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B5D1C21606
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61B83CD5;
	Fri, 19 Jul 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sJgHGrEr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SItvW/vw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230127BB0A;
	Fri, 19 Jul 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384958; cv=none; b=uhIZpz83dy7N++6nCdP2pSLVO1d3mbPUhfHlKyqgL+FXn5SKLBucbA+73jk+FixNHhqCDkrstZbb4H9mFuSYUUstjiWhMex7AfosH05cZ1k0z5/eMGl4FFnqmE/99rGpZbfYWnTorFrnLQ6HCxgk+PovIV4O3WXsw8hEvpFNc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384958; c=relaxed/simple;
	bh=utqa96LlNzGJ6LO7YmBtLNDuSXIr53lGcbUICcbiVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q958BNMw2xiq7LeSMPDV7cqHhrbYENFMjyZUk76th8lP3BWC7WFIgtIFtm8VNDyWCVJvNwtsOMIRmwNVn+HYxe+l7xcE6O91JeJfbcRjK4PEGF34+S0mtkOeCW3P8uL0iKizQRUeo2RbKHZ1JOQFK1sztEjuXnxK9bqW2Y8lQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sJgHGrEr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SItvW/vw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 195A821B1B;
	Fri, 19 Jul 2024 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYLTpU+TQ80VryXSHafsvunreYjyK5cGZvwUB+lRbyk=;
	b=sJgHGrErSUkCNmegVCv8Nv3I8txbJS7QSW/dASLQv9HjXW+uCgEfHWsYYc7XUR4+Gn+qIB
	RFThsR/JnPngChHiKxKLOkRqXQZ86yXlCKMxpsa/hiBcrqKsL/Y/kSTaAD/BMPGuTzUZN6
	enr/YyqSgKe6JjxxIEE4wdb8CnlX9Tw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="SItvW/vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYLTpU+TQ80VryXSHafsvunreYjyK5cGZvwUB+lRbyk=;
	b=SItvW/vweK12TcejIEbLKVFTwvY1n3NwFGDzT6iq/rQhSP1+Xc0jQln8VhbxdG1j26GmF1
	Jiz9aFaVxMX19V9tX2V8QCcmlcIHWtNmiSehtQIXJh0BGtNuGYM2qc3rntStywfXoAtoH4
	QsfvDPQFnGImlpCkv6eSJp4x4e+G7fo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BEAE132CB;
	Fri, 19 Jul 2024 10:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wPEFAvY/mmb5WAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 10:29:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7 3/3] btrfs: prefer to allocate larger folio for metadata
Date: Fri, 19 Jul 2024 19:58:41 +0930
Message-ID: <fbcf1e6d824b6e6093b3d27d7b7897626417b922.1721384771.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721384771.git.wqu@suse.com>
References: <cover.1721384771.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 195A821B1B

For btrfs metadata, the high order folios are only utilized when all the
following conditions are met:

- The extent buffer start is aligned to nodesize
  This should be the common case for any btrfs in the last 5 years.

- The nodesize is larger than page size
  Or there is no need to use larger folios at all.

- MM layer can fulfill our folio allocation request

- The larger folio must exactly cover the extent buffer
  No longer no smaller, must be an exact fit.

  This is to make extent buffer accessors much easier.
  They only need to check the first slot in eb->folios[], to determine
  their access unit (need per-page handling or a large folio covering
  the whole eb).

There is another small blockage, filemap APIs can not guarantee the
folio size.
For example, by default we go 16K nodesize on x86_64, meaning a larger
folio we expect would be with order 2 (size 16K).
We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order 0
(page sized) folios.

So here we go a different workaround, allocate a order 2 folio first,
then attach them to the filemap of metadata.

Thus here comes several results related to the attach attempt of eb
folios:

1) We can attach the pre-allocated eb folio to filemap
   This is the most simple and hot path, we just continue our work
   setting up the extent buffer.

2) There is an existing folio in the filemap

   2.0) Subpage case
        We would reuse the folio no matter what, subpage is doing a
	different way handling folio->private (a bitmap other than a
	pointer to an existing eb).

   2.1) There is already a live extent buffer attached to the filemap
        folio
	This should be more or less hot path, we grab the existing eb
	and free the current one.

   2.2) No live eb.
   2.2.1) The filemap folio is larger than eb folio
          This is a better case, we can reuse the filemap folio, but
	  we need to cleanup all the pre-allocated folios of the
	  new eb before reusing.
	  Later code should take the folio size change into
	  consideration.

   2.2.2) The filemap folio is the same size of eb folio
          We just free the current folio, and reuse the filemap one.
	  No other special handling needed.

   2.2.3) The filemap folio is smaller than eb folio
          This is the most tricky corner case, we can not easily replace
	  the folio in filemap using our eb folio.

	  Thus here we return -EAGAIN, to inform our caller to re-try
	  with order 0 (of course with our larger folio freed).

Otherwise all the needed infrastructure is already here, we only need to
try allocate larger folio as our first try in alloc_eb_folio_array().

For now, the higher order allocation is only a preferable attempt for
debug build, before we had enough test coverage and push it to end
users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 102 ++++++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cfeed7673009..d7824644d593 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -719,12 +719,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
  *
  * For now, the folios populated are always in order 0 (aka, single page).
  */
-static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
+static int alloc_eb_folio_array(struct extent_buffer *eb, int order,
+				bool nofail)
 {
 	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
 	int num_pages = num_extent_pages(eb);
 	int ret;
 
+	if (order) {
+		gfp_t gfp;
+
+		if (order > 0)
+			gfp = GFP_NOFS | __GFP_NORETRY | __GFP_NOWARN;
+		else
+			gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
+		eb->folios[0] = folio_alloc(gfp, order);
+		if (likely(eb->folios[0])) {
+			eb->folio_size = folio_size(eb->folios[0]);
+			eb->folio_shift = folio_shift(eb->folios[0]);
+			return 0;
+		}
+		/* Fallback to 0 order (single page) allocation. */
+	}
 	ret = btrfs_alloc_page_array(num_pages, page_array, nofail);
 	if (ret < 0)
 		return ret;
@@ -2707,7 +2723,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	 */
 	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
 
-	ret = alloc_eb_folio_array(new, false);
+	ret = alloc_eb_folio_array(new, 0, false);
 	if (ret) {
 		btrfs_release_extent_buffer(new);
 		return NULL;
@@ -2740,7 +2756,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!eb)
 		return NULL;
 
-	ret = alloc_eb_folio_array(eb, false);
+	ret = alloc_eb_folio_array(eb, 0, false);
 	if (ret)
 		goto err;
 
@@ -2955,6 +2971,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 	return 0;
 }
 
+static void free_all_eb_folios(struct extent_buffer *eb)
+{
+	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
+		if (eb->folios[i])
+			folio_put(eb->folios[i]);
+		eb->folios[i] = NULL;
+	}
+}
 
 /*
  * Return 0 if eb->folios[i] is attached to btree inode successfully.
@@ -2974,6 +2998,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct mem_cgroup *old_memcg;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	const int eb_order = folio_order(eb->folios[0]);
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -3003,15 +3028,6 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		goto retry;
 	}
 
-	/* For now, we should only have single-page folios for btree inode. */
-	ASSERT(folio_nr_pages(existing_folio) == 1);
-
-	if (folio_size(existing_folio) != eb->folio_size) {
-		folio_unlock(existing_folio);
-		folio_put(existing_folio);
-		return -EAGAIN;
-	}
-
 finish:
 	spin_lock(&mapping->i_private_lock);
 	if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
@@ -3020,6 +3036,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		eb->folios[i] = existing_folio;
 	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
+		int existing_order = folio_order(existing_folio);
 
 		existing_eb = grab_extent_buffer(fs_info,
 						 folio_page(existing_folio, 0));
@@ -3031,9 +3048,34 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 			folio_put(existing_folio);
 			return 1;
 		}
-		/* The extent buffer no longer exists, we can reuse the folio. */
-		__free_page(folio_page(eb->folios[i], 0));
-		eb->folios[i] = existing_folio;
+		if (existing_order > eb_order) {
+			/*
+			 * The existing one has higher order, we need to drop
+			 * all eb folios before resuing it.
+			 * And this should only happen for the first folio.
+			 */
+			ASSERT(i == 0);
+			free_all_eb_folios(eb);
+			eb->folios[i] = existing_folio;
+		} else if (existing_order == eb_order) {
+			/*
+			 * Can safely reuse the filemap folio, just
+			 * release the eb one.
+			 */
+			folio_put(eb->folios[i]);
+			eb->folios[i] = existing_folio;
+		} else {
+			/*
+			 * The existing one has lower order.
+			 *
+			 * Just retry and fallback to order 0.
+			 */
+			ASSERT(i == 0);
+			folio_unlock(existing_folio);
+			folio_put(existing_folio);
+			spin_unlock(&mapping->i_private_lock);
+			return -EAGAIN;
+		}
 	}
 	eb->folio_size = folio_size(eb->folios[i]);
 	eb->folio_shift = folio_shift(eb->folios[i]);
@@ -3066,6 +3108,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
 	int uptodate = 1;
+	int order = 0;
 	int ret;
 
 	if (check_eb_alignment(fs_info, start))
@@ -3082,6 +3125,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) && fs_info->nodesize > PAGE_SIZE &&
+	    IS_ALIGNED(start, fs_info->nodesize))
+		order = ilog2(fs_info->nodesize >> PAGE_SHIFT);
+
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -3116,7 +3163,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 reallocate:
 	/* Allocate all pages first. */
-	ret = alloc_eb_folio_array(eb, true);
+	ret = alloc_eb_folio_array(eb, order, true);
 	if (ret < 0) {
 		btrfs_free_subpage(prealloc);
 		goto out;
@@ -3134,26 +3181,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		}
 
 		/*
-		 * TODO: Special handling for a corner case where the order of
-		 * folios mismatch between the new eb and filemap.
-		 *
-		 * This happens when:
-		 *
-		 * - the new eb is using higher order folio
-		 *
-		 * - the filemap is still using 0-order folios for the range
-		 *   This can happen at the previous eb allocation, and we don't
-		 *   have higher order folio for the call.
-		 *
-		 * - the existing eb has already been freed
-		 *
-		 * In this case, we have to free the existing folios first, and
-		 * re-allocate using the same order.
-		 * Thankfully this is not going to happen yet, as we're still
-		 * using 0-order folios.
+		 * Got a corner case where the existing folio is lower order,
+		 * fallback to 0 order and retry.
 		 */
 		if (unlikely(ret == -EAGAIN)) {
-			ASSERT(0);
+			order = 0;
+			free_all_eb_folios(eb);
 			goto reallocate;
 		}
 		attached++;
@@ -3164,6 +3197,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
+		num_folios = num_extent_folios(eb);
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
-- 
2.45.2


