Return-Path: <cgroups+bounces-3120-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3498FF0DC
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F8AB2AAFD
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60966198824;
	Thu,  6 Jun 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQxB4xYn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aVlpbnyK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFD197510;
	Thu,  6 Jun 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687373; cv=none; b=lu2VNYx2Ft78UwPFJ26dd308hvxGTDartkUCW8HnAaMjrM2IXnnsKfiyeBzWHfz/5BkHYtHUvmQglNoD4grQf/yOoDndOH+FAf2aOpmSMhxkzYWCGjdL+DI0f8emKRHnwiVp1D1msRzJMe4NuOjGAUTjb6GPly5iVXgbBt2F0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687373; c=relaxed/simple;
	bh=CQ5kV5X5nrlQfyWCXXdBvRSRxELqnYqw18SORIHe3UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je4GOqD57+PIsNEA6IUR81SnPCNzSktE6T4PlbkoxbjUQml1owBxDTOJDZQHej/0fmM1XUypL+Eq0or0xHnrbYbEiBv9bQXVcivvXNJMypEUyCXWUahJiMms2BvCE40XWVzkoMdL+gfSuCPv8nktna0AKDcF3QsJ4YJ8v/HtvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQxB4xYn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aVlpbnyK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA8721F8D7;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5CJatTeD21yKGIUJTDlFh+ocnDWoH1DBubszi9zcsQ=;
	b=BQxB4xYncgHBg7CFyGBNxGNf3U0Nzbm4D1ja0Yd4OeyVvGC1XxjEkjIXrlxwOmCv7vrLmd
	te4p0pHWGsX5ginj03huzP7ibP2aBsFSjSqlrt/yQ2kvvseuvBxUHKvCB/R16LUrRaiL7/
	VdjYdKiiEkcZWUID1GbtY4N5+QWtvS8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aVlpbnyK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5CJatTeD21yKGIUJTDlFh+ocnDWoH1DBubszi9zcsQ=;
	b=aVlpbnyKESZ9aMiNPzz0Sit5DrguUMJbMFg7aNVKokIlBxORZABlAGMMMA4RB35v3aKsJY
	hTBDUBw0TPK4ZU0qWIyrXw5mSyJ3I+PX4c8+oTXyuXG/6kLzU4bp64Bkrhk5tsooahiEF5
	hBeMO7elzrTLaX//Rh5CPWTEeCec934=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4FD513A96;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uM74L0HUYWbGbwAAD6G6ig
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
Subject: [RFC PATCH v5 1/3] memcg: Add memory.max.effective attribute
Date: Thu,  6 Jun 2024 17:22:30 +0200
Message-ID: <20240606152232.20253-2-mkoutny@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA8721F8D7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

Some applications use memory cgroup limits to scale their own memory
needs. Reading of the immediate membership cgroup's memory.max is not
sufficient because of possible ancestral limits. The application could
traverse upwards to figure out the tightest limit but this would not
work in cgroup namespace where the view of cgroup hierarchy is
incomplete and the limit may apply from outer world.

(cgroup v1 used memory.stat:hierarchical_memory_limit to report the
value but there's no such counterpart in cgroup v2 memory.stat.)

Introduce a new memcg attribute file that contains the effective value
of memory limit for given cgroup (following cpuset.cpus.effective
pattern).

Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>
[ mkoutny: rewrite commit message, split out memory.swap.max]
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 mm/memcontrol.c                         | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fbb0519d556..988f26264054 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1293,6 +1293,12 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+  memory.max.effective
+	A read-only file that provides effective value of cgroup's hard usage
+	limit.  It incorporates limits of all ancestors, even those not visible
+	in cgroupns. The value change in this file generates a file modified
+	event.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7fad15b2290c..86bcec84fe7b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7065,6 +7065,19 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long memory;
+	struct mem_cgroup *mi;
+
+	/* Hierarchical information */
+	memory = PAGE_COUNTER_MAX;
+	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
+		memory = min(memory, READ_ONCE(mi->memory.max));
+
+	return seq_puts_memcg_tunable(m, memory);
+}
+
 /*
  * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
  * if any new events become available.
@@ -7259,6 +7272,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_max_effective_show,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.45.1


