Return-Path: <cgroups+bounces-3800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE5937595
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D014B1C20BE9
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30C823C3;
	Fri, 19 Jul 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mbTEsiXY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mbTEsiXY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14A5914C;
	Fri, 19 Jul 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380651; cv=none; b=ZLsy8NxvZs9jlvSr3DXoaeJwyKJWxzW/K9xyha5cC9ygLqVTIms6fvwCXduL4AmRiNIp6VCsJrgUszuFExKt6dPhagN0GFZYUmUQ4s61MDOr1NYswUA4+gJL1gWMmc1b0NBtK3F1JIr8Sviqmct8ki3XhDkKTD9AliyE3MDNl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380651; c=relaxed/simple;
	bh=H9oNgYhjOzMnJYbqrWnJvEsFMz9GP7FMHBR7OcpaQgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8ZCosYHj7pwxhCN21cFv3folafTPogMhGl10M/DGuH5HiaAETGRmAZmbq+44TCqQsLYZtVcoLiA11HdKR0Ki8EMOphxqRVL/KFyfeWFzd4t6IzLV8gjNvEShrtoDNoLBF35dQdcnmMMsIXON5gEVSkhcIfNuvKRamFrsBZn1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mbTEsiXY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mbTEsiXY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8649B1F79C;
	Fri, 19 Jul 2024 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3EcZAi4vQxqy0nGMwVlJFTnfaXGD9fvU+gggCPP2PQ=;
	b=mbTEsiXYw587yHmWA8OdqpXmG3VLkE9UPFrS6k5KpYe4ttNHWwohgXza1bgqEnzFhAOXl6
	n/1sWeLxL+SSsfVUohj3Z8SQmfhRhVl1X2ZecWizGOt8eGgI+Bqb3J2xMToW8scQt7xTx1
	l++YfCiWYu0ZZ2Xb8zoYVmZbR+HrxNM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3EcZAi4vQxqy0nGMwVlJFTnfaXGD9fvU+gggCPP2PQ=;
	b=mbTEsiXYw587yHmWA8OdqpXmG3VLkE9UPFrS6k5KpYe4ttNHWwohgXza1bgqEnzFhAOXl6
	n/1sWeLxL+SSsfVUohj3Z8SQmfhRhVl1X2ZecWizGOt8eGgI+Bqb3J2xMToW8scQt7xTx1
	l++YfCiWYu0ZZ2Xb8zoYVmZbR+HrxNM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 313D6136F7;
	Fri, 19 Jul 2024 09:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOMcNyMvmmZPRAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 09:17:23 +0000
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
Subject: [PATCH v6 2/3] btrfs: always uses root memcgroup for filemap_add_folio()
Date: Fri, 19 Jul 2024 18:46:58 +0930
Message-ID: <8a425904c03623790d2ffd2ff5ea4944cc6fe876.1721380449.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721380449.git.wqu@suse.com>
References: <cover.1721380449.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

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


