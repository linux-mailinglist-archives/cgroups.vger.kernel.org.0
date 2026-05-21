Return-Path: <cgroups+bounces-16152-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCpKI73kDmopDAYAu9opvQ
	(envelope-from <cgroups+bounces-16152-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:55:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD985A3A89
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC26431EC0A8
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FD39B493;
	Thu, 21 May 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPPjAQIa"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F433A1A4D;
	Thu, 21 May 2026 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359504; cv=none; b=VoO0ogU+yRH9FgLnGtoRb3gw0KzpLPa/rhG3KefQamqwhXEdm4mG7CjBFIuYlntdW9IQfx+m0ZrDyEOyhBW52BU3SEHv8yKxsHgagDIH8vMu5Cjh/K6yVDL0pL7e0cyEPmpyN8uVa1IimGnbve+3ZrjkHaSlXWwDVbSSSXzKbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359504; c=relaxed/simple;
	bh=9rmqMAY9smzBv9VFCGO++u7r4H5upcIbhIw2e2Zg1zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO2RBs00aoplUgALxD+EdID33Fx5WyDNSpabkA1nAouCQ47T8VWUa2h9KF6au+rzO/Ho0XkBxoHWzboU4ni8EIIa8LjCvJnEenT+cVWy8ob5kocU3qEColImkLaeeQHObCQeZfytjAn+3PBHEZ1U6PjQpyrYMIOPcl/fCrsLxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HPPjAQIa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=POa54ZUPuQQ+RSTm0iQoxJLNSNTmWXzoR636lBjZO8U=; b=HPPjAQIaZhRdzG53AubA4IONX+
	WDRLyVvXd0G/7OBkH+hBSQwPbqxwubJPsr8HEi9s6plk8jxLP2jz72EwYG5VPj1ruFPQriFnOgdLe
	ygKSKG1AKPILFySYbaUOdgLCBz9gZaW2l/upA1UXqpYJLf0yYd0BSGa7QpgieSCXTgeV77VYLcCCu
	2UH2/teA8a/KQG3sDC4h5OBkGYW/uXqE/Xa4puHDiPv/AuFZpy/ByOqsbfH8Y5pci/Y1xEwacJHPy
	SwmzYgltiuP92FqGHKbQx2Moar0IQ4b6gdp+MAgjx0gxywnAa3xGD1Efz8Ptaio0Wx5l5Ak+UDj//
	f7Q7hH4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ0gQ-00000008OYi-0Mc1;
	Thu, 21 May 2026 10:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81C31300446; Thu, 21 May 2026 12:31:17 +0200 (CEST)
Date: Thu, 21 May 2026 12:31:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3iC-jH6HPoWKGo@vingu-cube>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16152-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ECD985A3A89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:32:11PM +0200, Vincent Guittot wrote:

> I finally fount the root cause of regression: the update of entity lag happened
> after the task has been dequeued which screwed update_entity_lag():
> 
> update_entity_lag must be called after updating curr and cfs_rd and before 
> clearing on_rq
> 
> With the fix below I'm back to original hackbench figures and maybe even a bit better.
> I haven't checked shceduling latency yet
> 
> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77d0e1937f2c..32fe57004f27 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5753,6 +5753,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  	update_stats_dequeue_fair(cfs_rq, se, flags);
>  
> +	if (entity_is_task(se))
> +		update_entity_lag(&rq_of(cfs_rq)->cfs, se);
> +
>  	se->on_rq = 0;
>  	account_entity_dequeue(cfs_rq, se);
>  
> @@ -7423,6 +7426,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  		if (sched_feat(DELAY_DEQUEUE) && delay &&
>  		    !entity_eligible(cfs_rq, se)) {
>  			update_load_avg(cfs_rq_of(se), se, 0);
> +			update_entity_lag(cfs_rq, se);
>  			set_delayed(se);
>  			return false;
>  		}
> @@ -7430,7 +7434,6 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  
>  	dequeue_hierarchy(p, flags);
>  
> -	update_entity_lag(cfs_rq, se);
>  	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
>  		se->deadline -= se->vruntime;
>  		se->rel_deadline = 1;

Argh!!! Thank you! I've gone blind staring at all this :/

Would it not be simpler to just move the update_entity_lag() call up a
bit, like so?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
 
 	clear_buddies(cfs_rq, se);
 
+	update_curr(cfs_rq);
+	update_entity_lag(cfs_rq, se);
+
 	if (flags & DEQUEUE_DELAYED) {
 		WARN_ON_ONCE(!se->sched_delayed);
 	} else {
@@ -8022,7 +8025,6 @@ static bool __dequeue_task(struct rq *rq
 
 	dequeue_hierarchy(p, flags);
 
-	update_entity_lag(cfs_rq, se);
 	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;

