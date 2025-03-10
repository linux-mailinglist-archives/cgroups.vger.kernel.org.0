Return-Path: <cgroups+bounces-6925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1452A59073
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6842E3AD7D1
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D28225412;
	Mon, 10 Mar 2025 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yBPZMYdO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJSE25X3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dH4EcmQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Twmx8SX/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B4225414
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600557; cv=none; b=qzsT2K2T6DpzCFa6bd/YFXaNyHdffNo/0w278RWkkvC0DambcfPsGV16CHHU23N0y7eR7BJL0KL4eTiu15X3ojvuuPaLYsugWtv+bijdjIimBoZoVoA58vFdZjgz0hI+VfInjGN+5GzVe1T587VtxzGnxGXRWya7X6N7NQaPW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600557; c=relaxed/simple;
	bh=ZImaANMGLU5BUEevwj3L5VgckMQNpVg/4orWRPHeiWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYu5OuenSQ4gXie+jhtnUC5kykmGzBzl6aLGI1ym2LZT+prVjYauvyqqAEenYtXVElTOd3c1J/g8YNMAu20tjqfD3yqNhq/Gsc4lkA8gPvk+P3QKCrjWQhKKLu+2bT5aPnnXvlhgCOO1IerEbn+/z+X51+xxu0PLK3p40VZwnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yBPZMYdO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJSE25X3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dH4EcmQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Twmx8SX/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12C1221125;
	Mon, 10 Mar 2025 09:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741600553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AadC7J8N4hnEvErZNvYE4J9IHlLWXE5K1uV9vpayt2c=;
	b=yBPZMYdO1g/0e7fkvx4MUNisJjA2SpVJc9qf5zDaplbQ90U+Dorvcx7EOUH9MuRzRKQa8Z
	Je0dHBaEchRQz+OJYzrcgKD+3fiYXZqcMobzmQMs9Zi5yTBAHOYBhgVleN6i+Mn9snSmWC
	8O80+2+7RYxNxLjKygXVYEvteCTZb6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741600553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AadC7J8N4hnEvErZNvYE4J9IHlLWXE5K1uV9vpayt2c=;
	b=yJSE25X3i0OJtOH4IdJiJLq/qiCAJoCZy4GM10QuNOv1CNAfJFLBojxV+AK1an8QdEboBg
	J2ZLnSqpTRVS4iCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dH4EcmQA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Twmx8SX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741600552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AadC7J8N4hnEvErZNvYE4J9IHlLWXE5K1uV9vpayt2c=;
	b=dH4EcmQAirELPXUgdXFCrEt84PG1wNxsw9Z76cf68xGY0QYDteTSg94CvswaCp3JgUgKdX
	SL2t5re2kwn8LwcpY6qlv4k18mTK8/BpdoF+2Ll9fqrqysTp9sMH3YriTLtow1F4L0JjHx
	G2dLKAD9oqPzUFB6CDjN0Px642mClYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741600552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AadC7J8N4hnEvErZNvYE4J9IHlLWXE5K1uV9vpayt2c=;
	b=Twmx8SX/GMbPOWeANwqQLTVATEJGHDzPOUy0m7h28RATmGvhQLdz7BXyklXtbAPObjIQCt
	dQvjISuAYs0ArJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE5021399F;
	Mon, 10 Mar 2025 09:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /BhvOSe3zmc/XgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 09:55:51 +0000
Message-ID: <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
Date: Mon, 10 Mar 2025 10:55:51 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [memcg] 01d37228d3: netperf.Throughput_Mbps
 37.9% regression
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org
References: <202503101254.cfd454df-lkp@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202503101254.cfd454df-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12C1221125
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/10/25 06:50, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 37.9% regression of netperf.Throughput_Mbps on:

I assume this is some network receive context where gfpflags do not allow
blocking.
 
> commit: 01d37228d331047a0bbbd1026cec2ccabef6d88d ("memcg: Use trylock to access memcg stock_lock.")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 7ec162622e66a4ff886f8f28712ea1b13069e1aa]
> 
> testcase: netperf
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 50%
> 	cluster: cs-localhost
> 	test: TCP_MAERTS
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.mmapfork.ops_per_sec  63.5% regression                                        |

Hm interesting, this one at least from the name would be a GFP_KERNEL context?

> | test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory            |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | nr_threads=100%                                                                                    |
> |                  | test=mmapfork                                                                                      |
> |                  | testtime=60s                                                                                       |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | hackbench: hackbench.throughput  26.6% regression                                                  |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | ipc=socket                                                                                         |
> |                  | iterations=4                                                                                       |
> |                  | mode=threads                                                                                       |
> |                  | nr_threads=100%                                                                                    |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec  33.0% regression                               |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory        |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | mode=development                                                                                   |
> |                  | nr_threads=100%                                                                                    |
> |                  | test=TCP                                                                                           |
> |                  | test_memory_size=50%                                                                               |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | vm-scalability: vm-scalability.throughput  86.8% regression                                        |
> | test machine     | 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory            |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | runtime=300s                                                                                       |
> |                  | size=1T                                                                                            |
> |                  | test=lru-shm                                                                                       |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps 39.9% improvement                                                 |

An improvement? Weird.

> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
> | test parameters  | cluster=cs-localhost                                                                               |
> |                  | cpufreq_governor=performance                                                                       |
> |                  | ip=ipv4                                                                                            |
> |                  | nr_threads=200%                                                                                    |
> |                  | runtime=300s                                                                                       |
> |                  | test=TCP_MAERTS                                                                                    |
> +------------------+----------------------------------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops  68.8% regression                                      |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
> | test parameters  | cpufreq_governor=performance                                                                       |
> |                  | mode=thread                                                                                        |
> |                  | nr_task=100%                                                                                       |
> |                  | test=fallocate1                                                                                    |
> +------------------+----------------------------------------------------------------------------------------------------+

Some of those as well.

Anyway we should not be expecting the localtry_trylock_irqsave() itself be
failing and resulting in a slow path, as that woulre require an allocation
attempt from a nmi. So what else the commit does?

>       0.10 ±  4%     +11.3       11.43 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
>       0.00           +13.7       13.72 ±  2%  perf-profile.self.cycles-pp.page_counter_try_charge

This does suggest more time spent in try_charge_memcg() because consume_stock() has failed.

And I suspect this:

+       if (!gfpflags_allow_spinning(gfp_mask))
+               /* Avoid the refill and flush of the older stock */
+               batch = nr_pages;

because this will affect the refill even if consume_stock() fails not due to
a trylock failure (which should not be happening), but also just because the
stock was of a wrong memcg or depleted. So in the nowait context we deny the
refill even if we have the memory. Attached patch could be used to see if it
if fixes things. I'm not sure about the testcases where it doesn't look like
nowait context would be used though, let's see.

I've also found this:
https://lore.kernel.org/all/7s6fbpwsynadnzybhdqg3jwhls4pq2sptyxuyghxpaufhissj5@iadb6ibzscjj/

> 
> BTW after the done_restock tag in try_charge_memcg(), we will another
> gfpflags_allow_spinning() check to avoid schedule_work() and
> mem_cgroup_handle_over_high(). Maybe simply return early for
> gfpflags_allow_spinning() without checking high marks.

looks like a small possible optimization that was forgotten?
 ----8<----
From 29e7d18645577ce13d8a0140c0df050ce1ce0f95 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 10 Mar 2025 10:32:14 +0100
Subject: [PATCH] memcg: Avoid stock refill only if stock_lock can't be
 acquired

Since commit 01d37228d331 ("memcg: Use trylock to access memcg
stock_lock.") consume_stock() can fail if it can't obtain
memcg_stock.stock_lock. In that case try_charge_memcg() also avoids
refilling or flushing the stock when gfp flags indicate we are in the
context where obtaining the lock could fail.

However consume_stock() can also fail because the stock was depleted, or
belonged to a different memcg. Avoiding the stock refill then reduces
the caching efficiency, as the refill could still succeed with memory
available. This has caused various regressions to be reported by the
kernel test robot.

To fix this, make the decision to avoid stock refill more precise by
making consume_stock() return -EBUSY when it fails to obtain stock_lock,
and using that for the no-refill decision.

Fixes: 01d37228d331 ("memcg: Use trylock to access memcg stock_lock.")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 092cab99dec7..a8371a22c7f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1772,22 +1772,23 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * stock, and at least @nr_pages are available in that stock.  Failure to
  * service an allocation will refill the stock.
  *
- * returns true if successful, false otherwise.
+ * returns 0 if successful, -EBUSY if lock cannot be acquired, or -ENOMEM
+ * if the memcg does not match or there are not enough pages
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+static int consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 			  gfp_t gfp_mask)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
 	unsigned long flags;
-	bool ret = false;
+	bool ret = -ENOMEM;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
 	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		if (!gfpflags_allow_spinning(gfp_mask))
-			return ret;
+			return -EBUSY;
 		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 	}
 
@@ -1795,7 +1796,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	stock_pages = READ_ONCE(stock->nr_pages);
 	if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
 		WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
-		ret = true;
+		ret = 0;
 	}
 
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -2228,13 +2229,18 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
+	int consume_ret;
 
 retry:
-	if (consume_stock(memcg, nr_pages, gfp_mask))
+	consume_ret = consume_stock(memcg, nr_pages, gfp_mask);
+	if (!consume_ret)
 		return 0;
 
-	if (!gfpflags_allow_spinning(gfp_mask))
-		/* Avoid the refill and flush of the older stock */
+	/*
+	 * Avoid the refill and flush of the older stock if we failed to acquire
+	 * the stock_lock
+	 */
+	if (consume_ret == -EBUSY)
 		batch = nr_pages;
 
 	if (!do_memsw_account() ||
-- 
2.48.1



