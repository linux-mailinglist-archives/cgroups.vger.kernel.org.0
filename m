Return-Path: <cgroups+bounces-14519-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG6WK1K8pWnNFQAAu9opvQ
	(envelope-from <cgroups+bounces-14519-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:35:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB721DCF6F
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 294783087185
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3241C0B6;
	Mon,  2 Mar 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YG01ILjL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378641C0A3;
	Mon,  2 Mar 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468057; cv=none; b=EdFeiU2WbXQ14X+NwmKito/MBK+K7QIE0JQwmzKfjZmNe+p1j8sP0x6tFAOgX9kk2lH72+1gghoAVdQwe/PJomdSRaPkcczEMPIVxkKDaQzDUc+p9RKNZd1J3tVVeFVzIdzS+BTiyyTsO//Jy3M/lJ5/vfs/RC9S0FBb6ksEcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468057; c=relaxed/simple;
	bh=YI1rAxGkTWrOMsOCcvJkmb0xR/cuc9o+Z4PTFycl9PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD4CYRNHLgWL2T7I+H31JYTZJ1jD7WgwSzcd6SzotipID56W7b3mSIsBoFVpF+4ItmbHUVBcafTYOQQXi22Lb11tH1uIv6WSR86mAGITFkvv1pVQhSS5jMDwRHrEnyPriiKY+b+9mR0K5Hvx3dA6OHgrfPh1RcPUB7X6yFtld7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YG01ILjL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Mar 2026 08:14:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772468053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLL8CQedq0WsIHC423sVIgR4mj4t68qiQx4HMXd9uDE=;
	b=YG01ILjLYI0dk46V+QncPZZT1q3hBjoc84PeXOZJVUm0yLSx284+Q4kliCpzftFLybp+5L
	kpTVPFxfUITqsKaMqQAgDHi5QNKoE5mvAK0ecsIL/CeH8tWyYKJTYft+DRokoxgqFSwbBG
	1ptqeewLBnfoxD5xDpCIAv4liTj8Y2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Daniel Sedlak <daniel.sedlak@cdn77.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 2/3] cgroup: add lockless fast-path checks to
 cgroup_file_notify()
Message-ID: <aaW2feETIF7I65i1@linux.dev>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
 <20260228142018.3178529-3-shakeel.butt@linux.dev>
 <40c77bba-0862-4422-b23e-2a10cd01c728@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c77bba-0862-4422-b23e-2a10cd01c728@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8BB721DCF6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14519-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Chen, thanks for taking a look.

On Mon, Mar 02, 2026 at 09:50:53AM +0800, Chen Ridong wrote:
> 
> Hi Shakeel,
> 
> Good series to move away from the global lock.
> 
> On 2026/2/28 22:20, Shakeel Butt wrote:
> > Add two lockless checks before acquiring the lock:
> > 
> > 1. READ_ONCE(cfile->kn) NULL check to skip torn-down files.
> > 2. READ_ONCE(cfile->notified_at) check to skip when within the
> >    rate-limit window (~10ms).
> > 
> > Both checks have safe error directions -- a stale read can only cause
> > unnecessary lock acquisition, never a missed notification.  Annotate
> > all write sites with WRITE_ONCE() to pair with the lockless readers.
> > 
> > The trade-off is that trailing timer_reduce() calls during bursts are
> > skipped, so the deferred notification that delivers the final state
> > may be lost.  This is acceptable for the primary callers like
> > __memcg_memory_event() where events keep arriving.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  kernel/cgroup/cgroup.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 33282c7d71e4..5473ebd0f6c1 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -1749,7 +1749,7 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
> >  		struct cgroup_file *cfile = (void *)css + cft->file_offset;
> >  
> >  		spin_lock_irq(&cgroup_file_kn_lock);
> > -		cfile->kn = NULL;
> > +		WRITE_ONCE(cfile->kn, NULL);
> >  		spin_unlock_irq(&cgroup_file_kn_lock);
> >  
> >  		timer_delete_sync(&cfile->notify_timer);
> > @@ -4430,7 +4430,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
> >  		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
> >  
> >  		spin_lock_irq(&cgroup_file_kn_lock);
> > -		cfile->kn = kn;
> > +		WRITE_ONCE(cfile->kn, kn);
> >  		spin_unlock_irq(&cgroup_file_kn_lock);
> >  	}
> >  
> > @@ -4686,20 +4686,27 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
> >   */
> >  void cgroup_file_notify(struct cgroup_file *cfile)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, last, next;
> >  	struct kernfs_node *kn = NULL;
> >  
> > +	if (!READ_ONCE(cfile->kn))
> > +		return;
> > +
> > +	last = READ_ONCE(cfile->notified_at);
> > +	if (time_before_eq(jiffies, last + CGROUP_FILE_NOTIFY_MIN_INTV))
> > +		return;
> > +
> 
> Previously, if a notification arrived within the rate-limit window, we would
> still call timer_reduce(&cfile->notify_timer, next) to schedule a deferred
> notification.
> 
> With this change, returning early here bypasses that timer scheduling entirely.
> Does this risk missing notifications that would have been delivered by the timer?
> 

You are indeed right that this can cause missed notifications. After giving some
thought I think the lockless check-and-return can be pretty much simplified to
timer_pending() check. If timer is active, just do nothing and the notification
will be delivered eventually.

I will send the updated version soon. Any comments on the other two patches?


