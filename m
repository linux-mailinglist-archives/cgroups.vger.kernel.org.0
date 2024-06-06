Return-Path: <cgroups+bounces-3118-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8F8FF08A
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9571F22207
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F4197554;
	Thu,  6 Jun 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HEBOZkbD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HEBOZkbD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D44197511;
	Thu,  6 Jun 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687371; cv=none; b=P0u9VgeEKKfynFKwl8kbnPHO0hLYCFThoyRBGlJzYTsaCGLXvK2p77w0SLjV8esUZ+8mQ1WpAfu04VwAOw2pHMBbzatKoYaL1R1lLGrzw+ubigbpJrC2HjKWpOMsABK3s0wzvCS0NLzXJ1QkrQPamxl8BusY2RSePSnvPKDP/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687371; c=relaxed/simple;
	bh=5X6i5YJwK+jQB7PuduPkzuTtnC15SQWqQq4DC5e8bnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpI/hT6Yx5Db7o6Zlc2f42Q//xq0O2AuifaF4fW/jm3UsXzchYp6IPRyAdIWQkl/ucLJLZJMuNPPXhsTvRPIsHeSxgSVAZwvUCRy1ItFR0wKeO0fjFuV6ZQf+JbIFqu+5npDa7WJvRAujrp4kpatS45xNlZ5zOagtNGzMgOsqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HEBOZkbD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HEBOZkbD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2EBA1FB3A;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETytyPpyO/ne7SCX3Wq9PF58dUOe/pCqU+w54NHSJZY=;
	b=HEBOZkbDPKcmXI4zASPz2S6DI/nP7AL3FnDRJbLlPWsYAT1l+8WVlXcFRqoCM2DMBtHA0t
	Sp99OGabVzlFxnuI7rqsGABXYYKdja4X+tmblQnS5s4pVn/QkXrgi3C6Ojr/08g83xt2yX
	T8eJREiDDsTpL6uYmDn2b3a1Qg5TKNo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HEBOZkbD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETytyPpyO/ne7SCX3Wq9PF58dUOe/pCqU+w54NHSJZY=;
	b=HEBOZkbDPKcmXI4zASPz2S6DI/nP7AL3FnDRJbLlPWsYAT1l+8WVlXcFRqoCM2DMBtHA0t
	Sp99OGabVzlFxnuI7rqsGABXYYKdja4X+tmblQnS5s4pVn/QkXrgi3C6Ojr/08g83xt2yX
	T8eJREiDDsTpL6uYmDn2b3a1Qg5TKNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01E313A9E;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IGGYNkHUYWbGbwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 06 Jun 2024 15:22:41 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Subject: [RFC PATCH v5 3/3] memcg: Notify on memory.max.effective changes
Date: Thu,  6 Jun 2024 17:22:32 +0200
Message-ID: <20240606152232.20253-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606152232.20253-1-mkoutny@suse.com>
References: <20240606152232.20253-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.21 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.70)[83.30%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RL5prnn869rbm1x4t47t486h7c)];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F2EBA1FB3A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.21

When users are interested in cgroup's effective limit, they typically
respond to the value somehow and therefore they should be notified when
the value changes. Use the standard menchanism of triggering a
modification of respective cgroup file.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..79ecbbd87c4c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -232,6 +232,8 @@ struct mem_cgroup {
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
 	struct cgroup_file events_local_file;
+	/* memory.max.effective */
+	struct cgroup_file mem_max_file;
 
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a889385f6033..72c8e4693506 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7022,6 +7022,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *iter;
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
@@ -7061,6 +7062,14 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 			break;
 	}
 
+	/*
+	 * Notification about limit tightening, not about coming OOMs, so it
+	 * can be after reclaim.
+	 */
+	for_each_mem_cgroup_tree(iter, memcg) {
+		cgroup_file_notify(&iter->mem_max_file);
+	}
+
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
@@ -7275,6 +7284,7 @@ static struct cftype memory_files[] = {
 	{
 		.name = "max.effective",
 		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct mem_cgroup, mem_max_file),
 		.seq_show = memory_max_effective_show,
 	},
 	{
-- 
2.45.1


