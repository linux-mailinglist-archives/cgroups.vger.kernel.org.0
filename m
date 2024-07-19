Return-Path: <cgroups+bounces-3799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D697F937593
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 11:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7FFB21E9F
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D681749;
	Fri, 19 Jul 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NykYiRAA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NykYiRAA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED35914C;
	Fri, 19 Jul 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380647; cv=none; b=sZ9yrWsv4FL8qDlyIFvUt1WYgpZjqrufOozd036WAZgsOkSzFYef5i8NO1U6yfCL2mxruw3XKTjQYDQZC7XDwf7n8B6prgPfUmNdn7N0mEeoeP6amw2WLzXmJK4TuXrcBUcyKs/okRkU4qneSqmImhzPfd/FqI8QFzJ/R5XAYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380647; c=relaxed/simple;
	bh=xidryI+yp4ZpricJSG/8SiJC2/8/ljWhn5wEWDj8YE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXIFp95yySC+TA/xftf2uFqI3/cm2Aqx/MB5ho+vgx0m4Ipredc4oJZDPl/TITdRXtavHI9rzslstLZk/eO0R9hkvVrgXig2wRJ+rW9xiMf2MhPk1skx8UaXpxgVAooiAyxBfbFv17jSeTujthIu2nJWEpoNjZg2KrOD2gIjwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NykYiRAA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NykYiRAA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ADDB01F79B;
	Fri, 19 Jul 2024 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmyu5jbhji4elkLqRwur2P37OFeRBcl+AErISbo0FHE=;
	b=NykYiRAAxu7CsxrlNeU2oyqWd3jlozTIsGR11G4SkfqRlbI0mqPsl3e6Wb1hTNnODc9YrV
	UgOwGz8b95Bc0JBCiUCqZU3qPFb6PdG+AQkB6mSRNthtOZkH6SUVQLQqHXjjLlolivIcUf
	WY6pLkbue+RduN6RYvcivFlX4Mm7cwc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmyu5jbhji4elkLqRwur2P37OFeRBcl+AErISbo0FHE=;
	b=NykYiRAAxu7CsxrlNeU2oyqWd3jlozTIsGR11G4SkfqRlbI0mqPsl3e6Wb1hTNnODc9YrV
	UgOwGz8b95Bc0JBCiUCqZU3qPFb6PdG+AQkB6mSRNthtOZkH6SUVQLQqHXjjLlolivIcUf
	WY6pLkbue+RduN6RYvcivFlX4Mm7cwc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E30136F7;
	Fri, 19 Jul 2024 09:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YLdvIyAvmmZPRAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 09:17:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v6 1/3] memcontrol: define root_mem_cgroup for CONFIG_MEMCG=n cases
Date: Fri, 19 Jul 2024 18:46:57 +0930
Message-ID: <299298648bc5689b2f163c7876936179338301ba.1721380449.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There is an incoming btrfs patchset, which will use @root_mem_cgroup as
the active cgroup to attach metadata folios to its internal btree
inode, so that btrfs can skip the possibly costly charge for the
internal inode which is only accessible by btrfs itself.

However @root_mem_cgroup is not always defined (not defined for
CONFIG_MEMCG=n case), thus all such callers need to do the extra
handling for different CONFIG_MEMCG settings.

So here we add a special macro definition of root_mem_cgroup, making it
to always be NULL.

The advantage of this, other than pulling the pointer definition out,
is that we will avoid wasting global data section space for such
pointer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/memcontrol.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..a268585babdc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -329,8 +329,6 @@ struct mem_cgroup {
  */
 #define MEMCG_CHARGE_BATCH 64U
 
-extern struct mem_cgroup *root_mem_cgroup;
-
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an slabobj_ext vector */
 	MEMCG_DATA_OBJEXTS = (1UL << 0),
@@ -346,6 +344,12 @@ enum page_memcg_data_flags {
 
 #define __FIRST_OBJEXT_FLAG	(1UL << 0)
 
+/*
+ * For CONFIG_MEMCG=n case, still define a root_mem_cgroup, but that will
+ * always be NULL and not taking any global data section space.
+ */
+#define root_mem_cgroup		(NULL)
+
 #endif /* CONFIG_MEMCG */
 
 enum objext_flags {
-- 
2.45.2


