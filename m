Return-Path: <cgroups+bounces-17327-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +zGbBk5lPmoRFQkAu9opvQ
	(envelope-from <cgroups+bounces-17327-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 13:41:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3A6CC91A
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 13:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b="h+0H4/ug";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17327-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17327-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625413017007
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1473E023E;
	Fri, 26 Jun 2026 11:40:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1C274FD1;
	Fri, 26 Jun 2026 11:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474042; cv=none; b=sP2OnKkh9EBY163bf12JoBtuLT9qmt0rI4+p9L+PZ2ZDhHVLfJDHfKhNSEPFRW7gxTUBSEBRLqknnsJoR8AqEic3iR6dJdvw8hsNDWKe1Q5JiqJrK4YoAMALCaAugFalhgwiMZyfrxtxJxr1cJWZ59Wtcdqwn3usPkRMQTevM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474042; c=relaxed/simple;
	bh=x4r8gpp5fPgbBPhyKnTfjv8q2gHPEHBzvn9Rm/Llo/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VghPh9yqf+NkII90v9fKRLJclIyk4Nq7lq0JCfEpSq3ELxBSU6mJvFdHlJeA8F6G3w9KdG++PDH1eX6CanB+Jz9quR3XpPr7RcFhNeCChzIVcxEkEu8I+4X+DfN3QHF+4q7IFYY3d/nnbm/789Imkn0r6GYX5WYG3v916vV/0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h+0H4/ug; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ekXy61ni8/qG7IPaPTiYAhfgPZgX1m8oEJ9GDwzIQaQ=; b=h+0H4/uglo08ffMH/cq4O7g2JP
	5KexDZ0uxnR279j6ziIUx5ga7mKj6Aj6RZ+Y5NeDmn2ajsLfbh1HNh0SJ9ftwbz5cDWZ47swjfIEg
	DpZUZQGvuqfgx4TRzi5gXTRVg+EkMzOUOLpAQ3ax2MZfy09cQMKwFP09AqbTxTdOIll5FSmQIBu4I
	N8DVIGTnuyRzE6VvGXivsbFeJOdLa3uyNJKjHkiK4vmHYRwO8U9FsZ0JRzlMCnxxd0BDU2idcckCi
	TdyDk/+taAPW+jDly5x4oY2KvfVBJ05x3PtodqNU7OZTf+zsW4EUyRB/8z2K7Fhq4MGF4lpG5Z4Ji
	X/YcwA7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wd4ux-00000004n6a-1XIk;
	Fri, 26 Jun 2026 11:40:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A30C3004F8; Fri, 26 Jun 2026 13:40:17 +0200 (CEST)
Date: Fri, 26 Jun 2026 13:40:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: longman@redhat.com, chenridong@huaweicloud.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io, mingo@kernel.org
Subject: Re: [PATCH v3 7/7] sched/eevdf: Move to a single runqueue
Message-ID: <20260626114016.GZ42921@noisy.programming.kicks-ass.net>
References: <20260605105513.354837583@infradead.org>
 <20260605124052.227463677@infradead.org>
 <a22eea2b-4c4a-4623-9a44-d7b18c0c91c8@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22eea2b-4c4a-4623-9a44-d7b18c0c91c8@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17327-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yu.c.chen@intel.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,m:mingo@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32C3A6CC91A

On Sat, Jun 20, 2026 at 11:54:22AM +0800, Chen, Yu C wrote:

> A divide-by-zero crash is observed when running hackbench:
> 
>   [14697.488452] CPU: 112 UID: 0 PID: 124791 Comm: hackbench Not tainted
> 7.1.0-rc2+
>   [14697.492627] RIP: 0010:propagate_entity_load_avg+0x35f/0x3e0
>   [14697.506799]  <TASK>
>   [14697.507411]  __dequeue_task+0x2b4/0xc70
>   [14697.508677]  dequeue_task_fair+0x36/0x370
>   [14697.509047]  dequeue_task+0x101/0x2f0
>   [14697.509426]  __schedule+0x1b1/0x1a00
>   [14697.510868]  anon_pipe_read+0x3da/0x450
>   [14697.511400]  vfs_read+0x361/0x390
>   [14697.512053]  __x64_sys_read+0x19/0x30
> 
> The divide-by-zero happens here:
> 
> if (scale_load_down(gcfs_rq->load.weight)) {
>         load_sum = div_u64(gcfs_rq->avg.load_sum,
>                 scale_load_down(gcfs_rq->load.weight));
> }
> 
> gcfs_rq->load.weight is an insane large value and is truncated
> to the lower 32 bits by div_u64, which happen to be 0.
> 
> Using AI for investigation, the cause is a u32 overflow in
> update_tg_cfs_runnable(), and flat pickup became a victim when using
> tg_tasks():
> 
>   u32 new_sum, divider;
>   ...
>   new_sum = se->avg.runnable_avg * divider; <-- boom
> 
> The following sequence shows how this triggers the crash:
> 
>   propagate_entity_load_avg()
>     update_tg_cfs_runnable()     # u32 overflow corrupts runnable_sum
> 
>   __update_load_avg_cfs_rq()
>     ___update_load_avg()         # computes insane runnable_avg
>   update_tg_load_avg()           # propagates to tg->runnable_avg
> 
>   update_cfs_group()
>     calc_concur_shares()
>       tg_tasks()                 # long-to-int truncation, negative nr
>     reweight_entity()            # corrupted se->load.weight
>       update_load_add()          # corrupted cfs_rq->load.weight
> 
>   propagate_entity_load_avg()
>     update_tg_cfs_load()
>       div_u64()                  # divide-by-zero
> 
> Fix by widening new_sum from u32 to u64(no need to force tg_tasks()
> to return unsigned long after this fix)
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d991ea85873a..99ea51448981 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5305,7 +5305,8 @@ static inline void
>  update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
>  	long delta_sum, delta_avg = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> -	u32 new_sum, divider;
> +	u64 new_sum;
> +	u32 divider;
> 
>  	/* Nothing to update */
>  	if (!delta_avg)
> @@ -5319,7 +5320,7 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
> 
>  	/* Set new sched_entity's runnable */
>  	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
> -	new_sum = se->avg.runnable_avg * divider;
> +	new_sum = (u64)se->avg.runnable_avg * divider;
>  	delta_sum = (long)new_sum - (long)se->avg.runnable_sum;
>  	se->avg.runnable_sum = new_sum;

Hmm, nice one. This makes sense because sched_avg::runnable_sum is a u64
itself, so having the delta be one is only sensible.

I do wonder though, this doesn't actually look to be specific to flat,
it just managed to trip it somehow.

I'll stick this on as a separate fix.

