Return-Path: <cgroups+bounces-989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB081B280
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 10:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8031C23BE9
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC1446A2;
	Thu, 21 Dec 2023 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AgAxTj55";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AgAxTj55"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420D4F8B4;
	Thu, 21 Dec 2023 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AA9F1FB5E;
	Thu, 21 Dec 2023 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703151000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4HSDhkn3mbzmn+HYU4/3nbaXxmpHuloAKvKi9O9PuU=;
	b=AgAxTj55I08NGUtiw7xFFRpCJA9QY9GYswORVLiK6V8E/0xB8HJFqZg7nkUOPXh+xTjrtF
	itfvWm1l5RiV7Yp/cQ0k17lUCDF+jZh9y1zcEZsDNVwHBRFx0Qp4yApRMvZXqkpK1CabC7
	JuC/t2PNhuMfCWcaCH3mDiJgqGnZyo0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703151000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4HSDhkn3mbzmn+HYU4/3nbaXxmpHuloAKvKi9O9PuU=;
	b=AgAxTj55I08NGUtiw7xFFRpCJA9QY9GYswORVLiK6V8E/0xB8HJFqZg7nkUOPXh+xTjrtF
	itfvWm1l5RiV7Yp/cQ0k17lUCDF+jZh9y1zcEZsDNVwHBRFx0Qp4yApRMvZXqkpK1CabC7
	JuC/t2PNhuMfCWcaCH3mDiJgqGnZyo0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC01213725;
	Thu, 21 Dec 2023 09:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MaiZNpcFhGU2MgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 21 Dec 2023 09:29:59 +0000
Date: Thu, 21 Dec 2023 10:29:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZYQFlynE7CU_Fjoc@tiehlicka>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220152653.3273778-3-schatzberg.dan@gmail.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLsgd6kpfonsu388crrfsk7e3y)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,google.com,vivo.com,vger.kernel.org,kvack.org,kernel.org,bytedance.com,lwn.net,linux-foundation.org,huawei.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AgAxTj55
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: 3AA9F1FB5E

On Wed 20-12-23 07:26:51, Dan Schatzberg wrote:
> Allow proactive reclaimers to submit an additional swappiness=<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
> 
> For example:
> 
> echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
> 
> Userspace proactive reclaimers use the memory.reclaim interface to
> trigger reclaim. The memory.reclaim interface does not allow for any way
> to effect the balance of file vs anon during proactive reclaim. The only
> approach is to adjust the vm.swappiness setting. However, there are a
> few reasons we look to control the balance of file vs anon during
> proactive reclaim, separately from reactive reclaim:
> 
> * Swapout should be limited to manage SSD write endurance. In near-OOM
> situations we are fine with lots of swap-out to avoid OOMs. As these are
> typically rare events, they have relatively little impact on write
> endurance. However, proactive reclaim runs continuously and so its
> impact on SSD write endurance is more significant. Therefore it is
> desireable to control swap-out for proactive reclaim separately from
> reactive reclaim
> 
> * Some userspace OOM killers like systemd-oomd[1] support OOM killing on
> swap exhaustion. This makes sense if the swap exhaustion is triggered
> due to reactive reclaim but less so if it is triggered due to proactive
> reclaim (e.g. one could see OOMs when free memory is ample but anon is
> just particularly cold). Therefore, it's desireable to have proactive
> reclaim reduce or stop swap-out before the threshold at which OOM
> killing occurs.
> 
> In the case of Meta's Senpai proactive reclaimer, we adjust
> vm.swappiness before writes to memory.reclaim[2]. This has been in
> production for nearly two years and has addressed our needs to control
> proactive vs reactive reclaim behavior but is still not ideal for a
> number of reasons:
> 
> * vm.swappiness is a global setting, adjusting it can race/interfere
> with other system administration that wishes to control vm.swappiness.
> In our case, we need to disable Senpai before adjusting vm.swappiness.
> 
> * vm.swappiness is stateful - so a crash or restart of Senpai can leave
> a misconfigured setting. This requires some additional management to
> record the "desired" setting and ensure Senpai always adjusts to it.
> 
> With this patch, we avoid these downsides of adjusting vm.swappiness
> globally.

Thank you for extending the changelog with usecases!

> [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/Senpai.cpp#L585-L598
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 18 ++++----
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 56 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 13 +++++-
>  4 files changed, 69 insertions(+), 21 deletions(-)

LGTM
Acked-by: Michal Hocko <mhocko@suse.com.

Just one minor thing. It would be really great to prevent from potential
incorrect use of mem_cgroup_swappiness. This should be internal function
to memcg. Now, having scan_control internal to vmscan.c makes that
harder and moving it out to swap.h or internal.h sounds overreaching.

We could do this at least to reduce those mistakes. I can make it a
proper patch if this seems reasonable or you can fold it into your patch
directly.
--- 

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f98dff23b758..5f3a182e9515 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -92,8 +92,10 @@ struct scan_control {
 	unsigned long	anon_cost;
 	unsigned long	file_cost;
 
-	/* Swappiness value for reclaim. NULL will fall back to per-memcg/global value */
+#ifdef CONFIG_MEMCG
+	/* Swappiness value for reclaim. Always use sc_swappiness()! */
 	int *swappiness;
+#endif
 
 	/* Can active folios be deactivated as part of reclaim? */
 #define DEACTIVATE_ANON 1
@@ -230,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #endif
 	return false;
 }
+
+static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
+{
+	if (sc->swappiness)
+		return *sc->swappiness;
+	return mem_cgroup_swappiness(memcg);
+}
 #else
 static bool cgroup_reclaim(struct scan_control *sc)
 {
@@ -245,6 +254,10 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
 }
+static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
+{
+	return READ_ONCE(vm_swappiness);
+}
 #endif
 
 static void set_task_reclaim_state(struct task_struct *task,
@@ -2330,8 +2343,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
-	int swappiness = sc->swappiness ?
-		*sc->swappiness : mem_cgroup_swappiness(memcg);
+	int swappiness = sc_swappiness(sc, memcg);
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -2612,10 +2624,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
-	if (sc->swappiness)
-		return *sc->swappiness;
-
-	return mem_cgroup_swappiness(memcg);
+	return sc_swappiness(sc, memcg);
 }
 
 static int get_nr_gens(struct lruvec *lruvec, int type)
-- 
Michal Hocko
SUSE Labs

