Return-Path: <cgroups+bounces-3798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269FD937591
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07931F231E3
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800317D3F1;
	Fri, 19 Jul 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dEqB+J7v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dEqB+J7v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495235914C;
	Fri, 19 Jul 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380644; cv=none; b=i8vwntLsMpB0dLJCqej0ma0N0XezYA8OjnYSMbH1lbjpZ6JkMGXgy8sDhaGkcN2n6h17zzIRfiGNu6qoMDMUrQ2kve+Qqo0aHOBi0QQjt9Ref9XPOvx4CXBOQO3RHDl5uLT12DpYrXziyeinrugjbgEgyQOa3j/Y2nT2PYGo7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380644; c=relaxed/simple;
	bh=FhwKcc2Ny1LY92UGSeJvP1jQzdeG+cs2LYy4paOmxd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsBYAEyoN3/t6mbE1QoYftkrQ2kWnVIEoTArEro0XsMLoYT9kyCD7KhwpfKYTOkZlisIqE+TBbMunEys92m610pdWSmUoZQyU6zuVOMc+NbLy4zTbsmzTm7XbKsHVxmR1SjhG5Vu+OCpj5ILTrl2qsRR+HjISoqvhbXECeYMSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dEqB+J7v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dEqB+J7v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51E5F2193C;
	Fri, 19 Jul 2024 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+9zOBKmiMiyox+b82YU9nto9KW7INaT88iuJAGyfj/I=;
	b=dEqB+J7vOzvAb4vRwsmrn/rwpeizHUNnrNdgvMk0qN0650JFjH1loMuyU3XdnTkVfJl1Wt
	J9OXjW3ndp9MyMQm9CLnIWBml8GpM5pjTiEQXwDNNf1fOZ96nCIk7UpmBleqPovQhEmUN8
	Is9KGr5O4dFe0Cx4t8DdTbLeOjhLk5g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dEqB+J7v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721380640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+9zOBKmiMiyox+b82YU9nto9KW7INaT88iuJAGyfj/I=;
	b=dEqB+J7vOzvAb4vRwsmrn/rwpeizHUNnrNdgvMk0qN0650JFjH1loMuyU3XdnTkVfJl1Wt
	J9OXjW3ndp9MyMQm9CLnIWBml8GpM5pjTiEQXwDNNf1fOZ96nCIk7UpmBleqPovQhEmUN8
	Is9KGr5O4dFe0Cx4t8DdTbLeOjhLk5g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84FAF136F7;
	Fri, 19 Jul 2024 09:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zFj8Dx0vmmZPRAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 09:17:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v6 0/3] btrfs: try to allocate larger folios for metadata
Date: Fri, 19 Jul 2024 18:46:56 +0930
Message-ID: <cover.1721380449.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51E5F2193C
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

[CHANGELOG]
v6:
- Add a new root_mem_cgroup definition for CONFIG_MEMCG=n cases
  So that users of root_mem_cgroup no longer needs to check
  CONFIG_MEMCG.
  This is to fix the compile error for CONFIG_MEMCG=n cases.

- Slight rewording of the 2nd patch

v5:
- Use root memcgroup to attach folios to btree inode filemap
- Only try higher order folio once without NOFAIL nor extra retry

v4:
- Hide the feature behind CONFIG_BTRFS_DEBUG
  So that end users won't be affected (aka, still per-page based
  allocation) meanwhile we can do more testing on this new behavior.

v3:
- Rebased to the latest for-next branch
- Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
- Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
  and high order allocation"
  This allows us to use NOFAIL up to 32K nodesize, and makes sure for
  default 16K nodesize, all metadata would go 16K folios

v2:
- Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"

This is the latest update on the attempt to utilize larger folios for
btrfs metadata.

The previous version exposed a reproducibe hang at btrfs/187, where we
hang at filemap_add_folio() around its memcgroup charge code.

Even without the problem, I still believe for btree inode we do not
really need all the memcgroup charge, nor using __GFP_NOFAIL to work
around the possible memcgroup limits.

So in this update, suggested by the memcgroup people from SUSE, there is
a new patch to make btree inode filemap folio attaching to use the root
memcgroup, so that we won't be limited by the memcgroup.

Then for the patch enabling the larger folio, I reverted back to the old
behavior that we only try larger folio once without extra retry, just to
be extra safe.


Qu Wenruo (3):
  memcontrol: define root_mem_cgroup for CONFIG_MEMCG=n cases
  btrfs: always uses root memcgroup for filemap_add_folio()
  btrfs: prefer to allocate larger folio for metadata

 fs/btrfs/extent_io.c       | 112 ++++++++++++++++++++++++++-----------
 include/linux/memcontrol.h |   8 ++-
 2 files changed, 84 insertions(+), 36 deletions(-)

-- 
2.45.2


