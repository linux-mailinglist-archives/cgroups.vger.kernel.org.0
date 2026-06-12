Return-Path: <cgroups+bounces-16878-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOySNvJsK2pb9QMAu9opvQ
	(envelope-from <cgroups+bounces-16878-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 04:20:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627D676427
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 04:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=KUOXC9kB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16878-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16878-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42C831984E9
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 02:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A743812EA;
	Fri, 12 Jun 2026 02:20:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3693803C0
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 02:20:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230805; cv=none; b=Kzqxj57bYmYWveHBPvWOWk/EtOraTUljIq9aPmRxq+JQIQ1I5SNnspIX2gz4E4K7F8k2sXCEPWmCuI+68FWdciYciT1tjCDHxUYkWLzrPwAggmotWE/hhP20Zqium2/ydsgQtKXadGjXTiOO0mjLP/44KQevzfmNNsUmDOK6YB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230805; c=relaxed/simple;
	bh=B13Zu6hwKikiAJTfKxLnIVtkYrvcjxjvlRqoioRKlco=;
	h=To:Date:Message-Id:Mime-Version:Subject:References:
	 Content-Disposition:In-Reply-To:Cc:From:Content-Type; b=CKI78GvurU4BUAwljOaDyVtFfReP2lo+WjxEbIBXYWBrQnNg3OCB+kyU0YIzPn8wZ9NFAS7KZaXo/+GzGvRC1lc8i+zSP5yJZwttFMGx0eR5DrJUwtqW9sdcrnAJZF3Z0hNNkoJylMoat/sD6FsDltHxt/EHV911jdmvEhXkmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KUOXC9kB; arc=none smtp.client-ip=209.127.230.111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781230797; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WtjGJKpS2uRnIM7fgA/fkrkLzM5ulmaNMDMUp+8agkQ=;
 b=KUOXC9kBbmBbBXf5hBPV2gi5frKcwnOzF8BBh/6/mK+wmSmCgnkqTJFc0pCy+9CbJh8pEy
 DAk1b+DjAVXWfmX5Dd5ijTtEBxgVadCE4OBw3SaeqPJOEZFRJf4cI5Qx3JWcCmpsTnM7o7
 zZZFznmFuTVUvsPi6Sh+nX5hg4Qm3Sk3SrVR9LiMs8YhA7P592Pt7LyO7tYVO5EEvXBPMX
 ikKm6B8UHRh0mLZNWkag9ky7IEd+gW0iAepZ+Rtd/lYuwIxZ59tvZ+5e8hE+MhNF0Zvxuw
 k1o6rgBBIcPUq2MKSHstlVQmcvAiNjAWUZl1IYkU39pN0ZFdvYtdDRahnuxIdQ==
To: "Peter Zijlstra" <peterz@infradead.org>
Date: Fri, 12 Jun 2026 10:19:21 +0800
Message-Id: <20260612021921.GA2551535@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 08/10] sched/fair: Add newidle balance to pick_task_fair()
References: <20260511113104.563854162@infradead.org> <20260511120627.944705718@infradead.org> <20260603095108.GA1684319@bytedance.com> <20260611113219.GG187714@noisy.programming.kicks-ass.net>
Content-Disposition: inline
In-Reply-To: <20260611113219.GG187714@noisy.programming.kicks-ass.net>
Cc: <mingo@kernel.org>, <longman@redhat.com>, <chenridong@huaweicloud.com>, 
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>, 
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>, 
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>, 
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, 
	<kprateek.nayak@amd.com>, <qyousef@layalina.io>, <svens@linux.ibm.com>
From: "Aaron Lu" <ziqianlu@bytedance.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a2b6ccb+ada8ef+vger.kernel.org+ziqianlu@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ziqianlu@bytedance.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,m:svens@linux.ibm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16878-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziqianlu@bytedance.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bytedance.com:dkim,bytedance.com:mid,bytedance.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3627D676427

Hi Peter,

On Thu, Jun 11, 2026 at 01:32:19PM +0200, Peter Zijlstra wrote:
> 
> Aaron,
> 
> Sorry I failed to notice this email earlier.
> 

Never mind.

> On Wed, Jun 03, 2026 at 05:51:08PM +0800, Aaron Lu wrote:
> 
> > I applied below diff and the problem is gone:
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5f48af700fd44..942a543af3e54 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9897,6 +9897,9 @@ static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
> >  	return p;
> >  
> >  idle:
> > +	if (sched_core_enabled(rq))
> > +		return NULL;
> > +
> >  	new_tasks = sched_balance_newidle(rq, rf);
> >  	if (new_tasks < 0)
> >  		return RETRY_TASK;
> > 
> 
> Right, this is the safe patch and restores pick_task_fair() to its
> previous status (for core-sched).
> 
> Since people are hitting this problem, I'm going to merge it as below.
> I've presumed your SoB, please let me know if that's a problem.

No problem.

> 
> I think I'm going to try and move newidle into sched_class::balance /
> balance_fair(), but I'll do that next cycle.

I'll surely test it then.

Best regards,
Aaron

