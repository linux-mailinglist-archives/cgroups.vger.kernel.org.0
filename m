Return-Path: <cgroups+bounces-3804-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1D9376A1
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0BB22E9A
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F784A32;
	Fri, 19 Jul 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V+IUSZEQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZbQJrqhV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBE84039;
	Fri, 19 Jul 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384950; cv=none; b=WbNdFC+2EOWkY/2/S8/xufMiSQiJIw8xV2D/CDq9dFbPDnfYQl2b9ue6vEkcz1ckFpS+WYDdY7wH3KhzRk31el7GYtnMMBaPdcVs5upQpj1ZVEdD4DDyOPmacq3YbMn6NtPVOSAZWMWwW/1izf/tH0YUhKFK+7fcqiAvk40vwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384950; c=relaxed/simple;
	bh=QJXm2HxSYDOumoerBzVpb9qxFoGROpfAG/Hyp3CIsOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjBpu+b/WqcQfhEVYhdBTl5VrqhGoItlrkAYk4YadB2PFF+zfhJAGqMKV0BoZl3NDYx81uDrMvkYWwLltZtOJCISXTT6yh+rGHBPGVViSzf6ccxWOlM5EzMh/e8i6VB5l8wYewrqYwNqa3pNOZi82bafuva+ty3MMQ4vr0bYwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V+IUSZEQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZbQJrqhV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D57D721B36;
	Fri, 19 Jul 2024 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCb4hBwueKHgs5zAbBKeIF4mFjfNu0oH5bRUKJriLuE=;
	b=V+IUSZEQJ4MYRrnLifgbdIUzRgc8y/KMZSPNFbNUaBGyy/8meNC8E8Lz7mJZriO3NJFkBk
	iI6514FDCkKcStGKgBfADAtqriRv4uRsNkhIoNWt+A+78LlXp3YVOgXk20cfHiPZ+OBHgG
	vJ8uTncoAINjZ6wulsM0dbp+qo97ev8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZbQJrqhV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721384945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCb4hBwueKHgs5zAbBKeIF4mFjfNu0oH5bRUKJriLuE=;
	b=ZbQJrqhVESIcngQJArxsc/or77qC05ONkiZYpqs22KgoEuCGMkyXRsG7fMhX/VyPtaZhrA
	4Hbe4PpROZiCogNRiVSzShQ1Q6BWKxEzP4JPoRj9XUc2Ni+Y0uLZjWukpv4am7X2ntY2uc
	dljKXwJ7mHRv++c+ar7UkBXOG1C9cHo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD0213808;
	Fri, 19 Jul 2024 10:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iPirLe4/mmb5WAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 10:29:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v7 1/3] memcontrol: define root_mem_cgroup for CONFIG_MEMCG=n cases
Date: Fri, 19 Jul 2024 19:58:39 +0930
Message-ID: <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: D57D721B36
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
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

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
 include/linux/memcontrol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..ae5c78719454 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -346,6 +346,12 @@ enum page_memcg_data_flags {
 
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


