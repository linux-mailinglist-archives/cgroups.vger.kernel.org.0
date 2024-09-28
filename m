Return-Path: <cgroups+bounces-4978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23479988DDB
	for <lists+cgroups@lfdr.de>; Sat, 28 Sep 2024 06:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FA1C21288
	for <lists+cgroups@lfdr.de>; Sat, 28 Sep 2024 04:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520B19A2A3;
	Sat, 28 Sep 2024 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cX4/qXw4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cX4/qXw4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2501C6A5;
	Sat, 28 Sep 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727498768; cv=none; b=i6TtF07/zq7N/asS0CpYMIzds5JxuxymiEpX4nNUO6AGuYCbQXj/0gzkHdp50wxouni28rOH+wpki5X6OV4drvIa4K6XS0aLv8thBcQoJznuYoI6aU6YuAEr/Mx+xzvdx8RNAeCt4aRFne72mLQ/j+B91E0upEngi+E218vMCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727498768; c=relaxed/simple;
	bh=swj22psNBjQ40hMTU03U/9naZS1ekdn6yU2+3M4hs5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqZPkrXThF4JD20Na96jK3xeaIvTXDi5kR2tSJs5MAUy5ZalJDLl2EPqCvqHD0KNDe+4dYqLXjaxhhLkvIhLm/joLT5axX1nlwt9920KurtuTgdClA8CD0sNJ9hjXaVqjZoRn3+gsgB4lPBRfUbfm0NM0O1jNr3e8eKN7l0cj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cX4/qXw4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cX4/qXw4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F20A31F8D7;
	Sat, 28 Sep 2024 04:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727498763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8rnCt/V46QSqAx330W1615tslS9zKGk6eFgRTHFjKk0=;
	b=cX4/qXw40cY2GcC3rqBQTQpi393Hfj51eqOCs1XiJZOVf0yVOrvna5ViG8Mu3AKuSttA18
	are3zTUlDRz/Y5BQ1e5WrexLmIgpY2GvFsMWeu4okw8M9UdJJDx1xg4Rn4Wcb5N8wQC8tz
	1L9uGZLSV9eeTUwwna2sG6iYaawcLn8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727498763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8rnCt/V46QSqAx330W1615tslS9zKGk6eFgRTHFjKk0=;
	b=cX4/qXw40cY2GcC3rqBQTQpi393Hfj51eqOCs1XiJZOVf0yVOrvna5ViG8Mu3AKuSttA18
	are3zTUlDRz/Y5BQ1e5WrexLmIgpY2GvFsMWeu4okw8M9UdJJDx1xg4Rn4Wcb5N8wQC8tz
	1L9uGZLSV9eeTUwwna2sG6iYaawcLn8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C885513A6E;
	Sat, 28 Sep 2024 04:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zzp2IgeK92ZyDQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 28 Sep 2024 04:45:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Date: Sat, 28 Sep 2024 14:15:56 +0930
Message-ID: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
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

Although this needs to export the symbol mem_root_cgroup for
CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.

With root memory cgroup, we directly skip the charging part, and only
rely on __GFP_NOFAIL for the real memory allocation part.

Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c       | 9 +++++++++
 include/linux/memcontrol.h | 2 ++
 mm/memcontrol.c            | 1 +
 3 files changed, 12 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9302fde9c464..a3a3fb825a47 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2919,6 +2919,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	struct mem_cgroup *old_memcg;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -2927,8 +2928,16 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ASSERT(eb->folios[i]);
 
 retry:
+	/*
+	 * Btree inode is a btrfs internal inode, and not exposed to any user.
+	 *
+	 * We do not want any cgroup limit on this inode, thus using
+	 * root_mem_cgroup for metadata filemap.
+	 */
+	old_memcg = set_active_memcg(root_mem_cgroup);
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
+	set_active_memcg(old_memcg);
 	if (!ret)
 		goto finish;
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0e5bf25d324f..efec74344a4d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1067,6 +1067,8 @@ void split_page_memcg(struct page *head, int old_order, int new_order);
 
 #define MEM_CGROUP_ID_SHIFT	0
 
+#define root_mem_cgroup		(NULL)
+
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d563fb515766..2dd1f286364d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -75,6 +75,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+EXPORT_SYMBOL(root_mem_cgroup);
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
-- 
2.46.1


