Return-Path: <cgroups+bounces-3805-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9A9376A4
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 12:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2660B2819A7
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8F84A5C;
	Fri, 19 Jul 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k5swL/Mk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k5swL/Mk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85484039;
	Fri, 19 Jul 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384953; cv=none; b=J4BVR9bCXRfHYGuFbM3ckDcS3NTCGj8erRnXNQiCiEsB9fzISCFuP25Ik43I9ljiZigtj25mHFvMnzMSqMD6v4z6r9zwO9PkFipnMoJEmc1BEOas4pd2jWYVzjEerJfifS3gYBO6qNITougO27yX039kn7B7VKvBHrbxKqLmHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384953; c=relaxed/simple;
	bh=H9oNgYhjOzMnJYbqrWnJvEsFMz9GP7FMHBR7OcpaQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brfM5rW72Zt/2FVpKvqnnntrtRXO+k0pdCYlqlt5pGhnVGiB0n5yww9y7e/bX9AB3rQ+mRc59aV4uyLhO4I7j10GFCSBuxh+G7O2igT5AAGIvpAVE+6UCSa//xHr4QDc7scf9vA/pTB1xBpRBhQu3NxLHEoh+jI9viCjqYypPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k5swL/Mk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k5swL/Mk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD4A81F79D;
	Fri, 19 Jul 2024 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3EcZAi4vQxqy0nGMwVlJFTnfaXGD9fvU+gggCPP2PQ=;
	b=k5swL/MkcBozQOr+CmNrwz55vgkBMo56w49y7GuPx9f3QvRn5KtfViWi8NB5qc2RiUAphJ
	W7H0v/O2fQN+fkvo/zpdtKa8N5xU2moK/YzqnbXyCqbEltTF/cGUzwFP2N1Cf7BJnHAmfn
	uhWtnkp3TVj3JAIv3RolC7MtFJk46ek=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="k5swL/Mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3EcZAi4vQxqy0nGMwVlJFTnfaXGD9fvU+gggCPP2PQ=;
	b=k5swL/MkcBozQOr+CmNrwz55vgkBMo56w49y7GuPx9f3QvRn5KtfViWi8NB5qc2RiUAphJ
	W7H0v/O2fQN+fkvo/zpdtKa8N5xU2moK/YzqnbXyCqbEltTF/cGUzwFP2N1Cf7BJnHAmfn
	uhWtnkp3TVj3JAIv3RolC7MtFJk46ek=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C3A132CB;
	Fri, 19 Jul 2024 10:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPMACPI/mmb5WAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 10:29:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [PATCH v7 2/3] btrfs: always uses root memcgroup for filemap_add_folio()
Date: Fri, 19 Jul 2024 19:58:40 +0930
Message-ID: <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BD4A81F79D

[BACKGROUND]
The function filemap_add_folio() charges the memory cgroup,
as we assume all page caches are accessible by user space progresses
thus needs the cgroup accounting.

However btrfs is a special case, it has a very large metadata thanks to
its support of data csum (by default it's 4 bytes per 4K data, and can
be as large as 32 bytes per 4K data).
This means btrfs has to go page cache for its metadata pages, to take
advantage of both cache and reclaim ability of filemap.

This has a tiny problem, that all btrfs metadata pages have to go through
the memcgroup charge, even all those metadata pages are not
accessible by the user space, and doing the charging can introduce some
latency if there is a memory limits set.

Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
charge situation so that metadata pages won't really be limited by
memcgroup.

[ENHANCEMENT]
Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
memory cgroup to attach metadata pages.

With root memory cgroup, we directly skip the charging part, and only
rely on __GFP_NOFAIL for the real memory allocation part.

Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..cfeed7673009 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	struct mem_cgroup *old_memcg;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
 	int ret;
@@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ASSERT(eb->folios[i]);
 
 retry:
+	/*
+	 * Btree inode is a btrfs internal inode, and not exposed to any
+	 * user.
+	 * Furthermore we do not want any cgroup limits on this inode.
+	 * So we always use root_mem_cgroup as our active memcg when attaching
+	 * the folios.
+	 */
+	old_memcg = set_active_memcg(root_mem_cgroup);
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
+	set_active_memcg(old_memcg);
 	if (!ret)
 		goto finish;
 
-- 
2.45.2


