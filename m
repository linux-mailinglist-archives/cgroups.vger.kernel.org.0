Return-Path: <cgroups+bounces-3119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E1A8FF08B
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EF01F255CC
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EA8197559;
	Thu,  6 Jun 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PYVS50ct";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gu9CsrXI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEC19752A;
	Thu,  6 Jun 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687371; cv=none; b=PPpnp3V5BukKCefxGS1W2r+PO7gXy6xtwYRl2LAMCyZ0KekMCI2EoK3IX0OzC61gKXNr3uws8PojKOk/W0CoKs2df6XOYqf3qZSZ9blYokCPlZNoaqKluo3k5gg708Ba2x2Is0laVaS7mCie4vZiJzGGiFHVJlohCiXgZ/lFDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687371; c=relaxed/simple;
	bh=oev64f11gR5KVQ+BPwWMF+7KFGNsE44oukuxyudDLaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoPDt2jPr0aEDL3TB9L/YZC5rSvb6+/OESJ2QsZLj1wUHIMGJJg3I4pQR28mLFnnThvlIEnULTHg12FW0rkRSSC/KyGUij56RYYMkVyNnwnBmmdfBrS+eSRQAUkMuGmLY00jKg69YrahK0TYBV/FCTELYpTn7ptZC9Zk64ryTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PYVS50ct; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gu9CsrXI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E56F51F911;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Kc8Bd03I/KnkB6dRr+g2P2M/m8COOx/mJJqEqwMus=;
	b=PYVS50ct27fZ1kFviVdI2+iaasghsghfsADIf6ykfOUJo1I3S/eUVwK+sM8FFPr9GlUr05
	OgXekOse/MmOmiV61qCtZkX/YYsGJKIQwuu65vR4kUPsvYykLkdDY4IFv6YnGnxAo6tdRc
	gzjNcNb+jiv9DLM/1aNmU6nR2j27N0k=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gu9CsrXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717687361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Kc8Bd03I/KnkB6dRr+g2P2M/m8COOx/mJJqEqwMus=;
	b=Gu9CsrXIVDQN/4p87XZxcHzZVpgZZghmoeVrajfUjsncBrYYZALOXtavU4d69nLIyeaEw7
	1upqOVOe6ahh0CGtZnKoUBO8i8trQiD0ZmjfhwrDgquqBEHYWDaTkRdP4eWmWJ7GuOaSRB
	Dg24BMzTwpRJGjEj4ckfD2sEe2RFLUk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D397D13A97;
	Thu,  6 Jun 2024 15:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AP2DM0HUYWbGbwAAD6G6ig
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
Subject: [RFC PATCH v5 2/3] memcg: Add memory.swap.max.effective like hierarchical_memsw_limit
Date: Thu,  6 Jun 2024 17:22:31 +0200
Message-ID: <20240606152232.20253-3-mkoutny@suse.com>
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
X-Spamd-Result: default: False [-4.18 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	BAYES_HAM(-1.67)[92.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E56F51F911
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.18

cgroup v1 used memory.stat:hierarchical_memsw_limit to report the value
of effecitve memsw limit. cgroup v2 has no combined charing but swap.max
limit, add a new memcg attribute file that contains the effective value
of memory limit for given cgroup (following cpuset.cpus.effective
pattern) for cases when whole hierarchy cannot be traversed up due to
cgroupns visibility.

Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>
[ mkoutny: rewrite commit message, only memory.swap.max change]
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 mm/memcontrol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86bcec84fe7b..a889385f6033 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -8279,6 +8279,19 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int swap_max_effective_show(struct seq_file *m, void *v)
+{
+	unsigned long swap;
+	struct mem_cgroup *mi;
+
+	/* Hierarchical information */
+	swap = PAGE_COUNTER_MAX;
+	for (mi = mem_cgroup_from_seq(m); mi; mi = parent_mem_cgroup(mi))
+		swap = min(swap, READ_ONCE(mi->swap.max));
+
+	return seq_puts_memcg_tunable(m, swap);
+}
+
 static int swap_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -8311,6 +8324,11 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_max_show,
 		.write = swap_max_write,
 	},
+	{
+		.name = "swap.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_max_effective_show,
+	},
 	{
 		.name = "swap.peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.45.1


