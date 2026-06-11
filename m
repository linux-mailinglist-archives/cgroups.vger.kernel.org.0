Return-Path: <cgroups+bounces-16850-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1CiMRKdKmqPtgMAu9opvQ
	(envelope-from <cgroups+bounces-16850-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 13:33:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71C6715E3
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 13:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=XvV+UjyZ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16850-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16850-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C73530CF191
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C63E451A;
	Thu, 11 Jun 2026 11:32:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF20242D67;
	Thu, 11 Jun 2026 11:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177579; cv=none; b=a3vqfVXLkoWxtz723Tfub7LUq68VeWV8qeW8eVDAfYTu6tIarE2MlP5oW9S1Q5LcW+xI+xMdISdggNoBFHzwcSsPO9roxgtU6h/oA3im8+aDZ3BagmhT9dRs11R3xD1Um/ujv3RIdLBCkwaHGJ9OUtHB+WWcm00qfIrN8bZbzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177579; c=relaxed/simple;
	bh=JnCub/wPXxOc+l3B7e0zn/JahGylm17eGn665Awp8xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riKORVtJJOfdzon/vc9Z10DbCOMxnGXukovBlyxFImO0oXLJBuACXsAJSsShy3uzMSDSycMu+TaT4O0J24G5TJHAYSzkwCFdozTcfq3aiLZm+Wx6R2V/mr2mkzFqaT36a5POmOn+04K3CynxaGG1qeNmdEczFDEviiOl0NbeyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XvV+UjyZ; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zRU4ZE38yKLjcbcoPL7tdFV8bZE0iAIGaY9qks/tkzM=; b=XvV+UjyZxdi3/ZkayE2h0iSmpv
	GqW1ZtnPI4PAc+/Zy6F1STpzVnUxUPMYIMW3MZlWD/hiJVuOvX6qPjfcJsEE3kNX/yQDBtmvQZTu4
	7mNncviNE7vF6BgEhcoT9x0CkRvQ9ilwIEJ8Xs5tbO0598gSrvNSFfq/ubtURJAzvt8Ky0l9e4q7l
	Ev5ZqF8Qj763OH1iZTu46rDLmU3dJrkZC/khGNp0rBsHVGk3163x6sdnKh9Vu8Gh73AiHPPnR6Is+
	FnpcQPgpW5qe2vdMxdCjer9KhrjuCFkPSMCIRnfFZQZ3hLyoRsoF1OK3tmmXFlmc50FVi/C8PJ8MW
	gWUE1qZg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXde1-000000058P6-0qSd;
	Thu, 11 Jun 2026 11:32:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7DBC03002F0; Thu, 11 Jun 2026 13:32:19 +0200 (CEST)
Date: Thu, 11 Jun 2026 13:32:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io, svens@linux.ibm.com
Subject: Re: [PATCH v2 08/10] sched/fair: Add newidle balance to
 pick_task_fair()
Message-ID: <20260611113219.GG187714@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120627.944705718@infradead.org>
 <20260603095108.GA1684319@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603095108.GA1684319@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16850-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ziqianlu@bytedance.com,m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,m:svens@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F71C6715E3


Aaron,

Sorry I failed to notice this email earlier.

On Wed, Jun 03, 2026 at 05:51:08PM +0800, Aaron Lu wrote:

> I applied below diff and the problem is gone:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5f48af700fd44..942a543af3e54 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9897,6 +9897,9 @@ static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
>  	return p;
>  
>  idle:
> +	if (sched_core_enabled(rq))
> +		return NULL;
> +
>  	new_tasks = sched_balance_newidle(rq, rf);
>  	if (new_tasks < 0)
>  		return RETRY_TASK;
> 

Right, this is the safe patch and restores pick_task_fair() to its
previous status (for core-sched).

Since people are hitting this problem, I'm going to merge it as below.
I've presumed your SoB, please let me know if that's a problem.

I think I'm going to try and move newidle into sched_class::balance /
balance_fair(), but I'll do that next cycle.

Thanks!

---
Subject: sched/fair: Fix newidle vs core-sched
From: "Aaron Lu" <ziqianlu@bytedance.com>
Date: Wed, 3 Jun 2026 17:51:08 +0800

From: "Aaron Lu" <ziqianlu@bytedance.com>

While testing Prateek's throttle series, I noticed a panic issue when
coresched is enabled and bisected to this patch.

I fed the panic log and this patch to an agent and its analysis looks
correct to me(cpu56 and cpu57 are siblings in a VM):

       cpu57 (holds core-wide lock)

     pick_next_task() [core scheduling]
     for_each_cpu_wrap(i, smt_mask, 57):
       i=57: pick_task(rq_57)
             pick_task_fair(rq_57)
             -> picks task A
       rq_57->core_pick = task A
       // task_rq(A) == rq_57

       i=56: pick_task(rq_56)
             pick_task_fair(rq_56)
             cfs_rq->nr_queued == 0
             goto idle
             sched_balance_newidle(rq_56)
             raw_spin_rq_unlock(rq_56)
             // core-wide lock released
             newidle_balance() pulls
               task A: rq_57 -> rq_56
             // task_rq(A) == rq_56 now
             raw_spin_rq_lock(rq_56)
             // core-wide lock re-acquired
             return > 0
             goto again
             pick_task_fair(rq_56)
             -> picks task A
       rq_56->core_pick = task A

     // first loop done
     // rq_57->core_pick is still task A (set before lock release)
     // but task_rq(A) == rq_56 now
     next = rq_57->core_pick  // = task A

     put_prev_set_next_task(rq_57, prev, task A)
     __set_next_task_fair(rq_57, task A)
     hrtick_start_fair(rq_57, task A)
     WARN_ON_ONCE(task_rq(task A) != rq_57)
     // task_rq(A) == rq_56

IOW: by allowing pick_task_fair() to do newidle_balance and not returning
RETRY_TASK, it can end up selecting the same task on two CPUs. Restore the
previous state by never doing newidle when core scheduling is enabled.

Tested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: "Aaron Lu" <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260603095108.GA1684319@bytedance.com
---
 kernel/sched/fair.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9942,6 +9942,9 @@ struct task_struct *pick_task_fair(struc
 	return p;
 
 idle:
+	if (sched_core_enabled(rq))
+		return NULL;
+
 	new_tasks = sched_balance_newidle(rq, rf);
 	if (new_tasks < 0)
 		return RETRY_TASK;

