Return-Path: <cgroups+bounces-17375-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJh9LHB+QmpE8gkAu9opvQ
	(envelope-from <cgroups+bounces-17375-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 16:17:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE056DBEBD
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 16:17:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=d2wt+1oO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17375-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17375-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3908E3003BED
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75235340414;
	Mon, 29 Jun 2026 14:03:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57933A9DB
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 14:03:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741792; cv=pass; b=MGT3Q64TUls4SBNdjTGIMGi7CIxoGRe/KRWhP/7yrXhgnAJs7cE2aRkl73QwoxdIvMDNOpFbpl5cK5fC62o4XK2X8XugdTKDCpIlX9XWQE8qtGE2lqVaWtVBlBqqon6vEc/fND1fKa5bTOaJwi5Hji715PrLi/2XwjHtOevtjF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741792; c=relaxed/simple;
	bh=I0DVMTPHlbhVGzqwtmOvWXeTArxOyicX4229rZf61yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXRfYqWHxF00lNMG0EQ3f7OKtlTE/UKY9AuBkYybuJbcwkpYJKJ4uka7bRmTZZuQJgZ6cfcnmwy1xiWPU2WiVTHNRfO643tviE+EjS0O7IR1Gfh7LNGBFEnvFJ4yoG1xuKFvRgNuR71h1toUl67jsIqiAUWXiEWF/SAY9y1a1bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d2wt+1oO; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697e96dd8d2so5335117a12.1
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 07:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741789; cv=none;
        d=google.com; s=arc-20260327;
        b=WNv35DXIMCSwgvbOS1F86Rc/PrsnpOLo0ocfmttkKTq6MOjPdJ2GgkN+rE5XOMIx6b
         pEHCiQwUvpjXSRklsAw2R1EMn0NgvrGm2ZAeoQi4YS38ImSk4ioEiV0JXak2WQQXstqV
         8Zy9/imKQyh8Psu8apgu38JG9V83QYTY05DHCYO4Gd8UOPZ6Lq5mMq5N+h+yTeOTDHEC
         Or3eYAPtF+tLexclFihubzCXrK5zWWuItgh4DBQ639sdLdKnZtkRs6Rd6q7stGXDo0S1
         MiVCNphCB/1SjeUg6eP2z3+GfHw0ZijSwwfrWfnRU51uo8JGJF9kq/B3D/+JXGR30nzJ
         pjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X2/ZOGaNUOhdhCdNpx5PmWbcZPqtoWnOZjnLOtfT4qM=;
        fh=Oh7jMegAg1X+MI5JA1uwkKwf7qSoTHZ9/j1d3IB1F7g=;
        b=SuSeXSCibv2y5GnCqeW7/ZPRhC5e/1f/q73QbrW53o5f3zoNNhMuKN3hW2EwhAPT/+
         VnCIhoS5olUCVO8FxycS8OqnZrEB+vs6f6tjQbe99rBCeIbeEHdA81OZowOfYrjhcBja
         LujvJcLsrEoO3N4v2OSra8G+a8a+lMlqQ2yUxRkE+twpiJEIJR6p7Q216Y24aUY2PVHm
         DfluoS/iflzZGzp8r0VtZ4A7zEnzKF1ahXqDagioIWjPjmTPOw9WeYUhRKIJWhkfjWqU
         oNrI0uzzcDKmYV2V7NdlYKZPjWAQXDA+zq+oCgGtY0R3OQAxkI7pfBMvnlUV9M68MHgm
         UV3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782741789; x=1783346589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X2/ZOGaNUOhdhCdNpx5PmWbcZPqtoWnOZjnLOtfT4qM=;
        b=d2wt+1oOxH/16VWD4nRieglZPLrXMM74VipiP/0WtItDb1D4GMBly2yXKXUFM85cNK
         Uf9Ew9GnzzuQ1co116GcmJb782b1wBX5XRFwlM6gj2GQjaaSwG1FCjQjH+Rr3SsE6+Bv
         JK/g8XMh2/b9mWBUX47orwGFIk3ob3b8zwv5+sMNemiD1qJ3uE3awGEmPf8oPskub8jD
         434UkhPhkj7+rqTtC/U2JMqM2msspLtCh54x6Mc2yTIClHZPizSTLhtOcXdur8Poz3kP
         TmfeHhppGcV7uJ2tDuA024joX9A05isP5/24jmVJZMiEE7rM0+Lvx+bmAuuC56t0rg3p
         1mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741789; x=1783346589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2/ZOGaNUOhdhCdNpx5PmWbcZPqtoWnOZjnLOtfT4qM=;
        b=NilHNwaaUYJbLdhaiNw+yIkZeHQJODf9mi76Tp3lx0Gwo1R/gjognhmUUdKQjZwnl6
         5rr2DbFkQX06dzBFqvBuSs1O6mOi5dSSB7ep0034QWEZoXQlqBnlM5/ofASq1JXdUSqK
         2EhYK65YJCY8ojoNB0tL/Fd+nfl+tUZoZ/NWGg/OYXk/qRD/y5gNz6po2hXK9GQ6Ls1z
         VznMG2aGtjCBU4wkLD2gnlQ5qZ+utCmYTW3Eh2zYlScQ7kN0zwXjSW5TMty5euGUszwh
         r26N+yNYPutM4oicblHKz6xn854dQcnc8uNMuQKX2+w4LXuXGYYocMZflfPPioiRDyYU
         1TEg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0BaxOAM3dpiYs9MnXzwpsi/v47M58iTm89q7ZtWC0Aw4gmYbG3AO8srBjjzYhIoO3tVr9sLWa@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZ7B+pOZw23AF2svIgkPGlLzLmtDOXUaFWACt4cut/N6aaUYh
	wn05krn8UMGV7EqYS8mP2YfZ2B49SXsEvO3b1V78zWhwt7NVPxqlNsC3aIcbXVZVyfx0TNt7aaB
	V8YR0RXLOmN93x7DAjVWmymc3H+7E2fXFDUjEd9IUNA==
X-Gm-Gg: AfdE7cmwnviK6XYthRcYqevChkQFszMj7nPmXMsEvb8mqO25qsTFsAcXVGVyKjGCgdS
	UR0xzuf5sFBX5XCuRZBXi1zWhaNnBUeE+OfoWJjF2RvQKtxUZQLAsZZ85btFPuYNuAXEV7vJaJk
	3vkxrLJA3vQR6LX/RsfwgMq/e90Bifkskbv7WCuNj2flvPexBYsF6qRVFNFIYqrnUgh09ZZkgVQ
	ZjGF/MjuJm1ug+Qsuj4DJJHUcmYnxdBS++iWDqIxt6OWYsggRUkvC2tlnpplaKE1EkyzFF5nPVz
	plT4wNWDtp7wC2tSkNtCejIcbufh3Fv4K5DV
X-Received: by 2002:a05:6402:210b:b0:698:462c:4d84 with SMTP id
 4fb4d7f45d1cf-698462c5635mr3994540a12.3.1782741788879; Mon, 29 Jun 2026
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605105513.354837583@infradead.org> <20260605124052.227463677@infradead.org>
 <a22eea2b-4c4a-4623-9a44-d7b18c0c91c8@intel.com> <20260626114016.GZ42921@noisy.programming.kicks-ass.net>
In-Reply-To: <20260626114016.GZ42921@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 29 Jun 2026 16:02:56 +0200
X-Gm-Features: AVVi8CczPbiWjbmDIgVU1b0DhcF9deVIQfufL65hG7QGP7CXSJ1EBYzBVjNKCS4
Message-ID: <CAKfTPtDqSOtMh9v8h1wCLx+UJ7mXAqSGdM_R9+HM4Vu+noa+3A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
	qyousef@layalina.io, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:yu.c.chen@intel.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,m:mingo@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-17375-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,linaro.org:dkim,linaro.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEE056DBEBD

On Fri, 26 Jun 2026 at 13:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Jun 20, 2026 at 11:54:22AM +0800, Chen, Yu C wrote:
>
> > A divide-by-zero crash is observed when running hackbench:
> >
> >   [14697.488452] CPU: 112 UID: 0 PID: 124791 Comm: hackbench Not tainted
> > 7.1.0-rc2+
> >   [14697.492627] RIP: 0010:propagate_entity_load_avg+0x35f/0x3e0
> >   [14697.506799]  <TASK>
> >   [14697.507411]  __dequeue_task+0x2b4/0xc70
> >   [14697.508677]  dequeue_task_fair+0x36/0x370
> >   [14697.509047]  dequeue_task+0x101/0x2f0
> >   [14697.509426]  __schedule+0x1b1/0x1a00
> >   [14697.510868]  anon_pipe_read+0x3da/0x450
> >   [14697.511400]  vfs_read+0x361/0x390
> >   [14697.512053]  __x64_sys_read+0x19/0x30
> >
> > The divide-by-zero happens here:
> >
> > if (scale_load_down(gcfs_rq->load.weight)) {
> >         load_sum = div_u64(gcfs_rq->avg.load_sum,
> >                 scale_load_down(gcfs_rq->load.weight));
> > }
> >
> > gcfs_rq->load.weight is an insane large value and is truncated
> > to the lower 32 bits by div_u64, which happen to be 0.
> >
> > Using AI for investigation, the cause is a u32 overflow in
> > update_tg_cfs_runnable(), and flat pickup became a victim when using
> > tg_tasks():
> >
> >   u32 new_sum, divider;
> >   ...
> >   new_sum = se->avg.runnable_avg * divider; <-- boom
> >
> > The following sequence shows how this triggers the crash:
> >
> >   propagate_entity_load_avg()
> >     update_tg_cfs_runnable()     # u32 overflow corrupts runnable_sum
> >
> >   __update_load_avg_cfs_rq()
> >     ___update_load_avg()         # computes insane runnable_avg
> >   update_tg_load_avg()           # propagates to tg->runnable_avg
> >
> >   update_cfs_group()
> >     calc_concur_shares()
> >       tg_tasks()                 # long-to-int truncation, negative nr
> >     reweight_entity()            # corrupted se->load.weight
> >       update_load_add()          # corrupted cfs_rq->load.weight
> >
> >   propagate_entity_load_avg()
> >     update_tg_cfs_load()
> >       div_u64()                  # divide-by-zero
> >
> > Fix by widening new_sum from u32 to u64(no need to force tg_tasks()
> > to return unsigned long after this fix)
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/fair.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d991ea85873a..99ea51448981 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5305,7 +5305,8 @@ static inline void
> >  update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> >       long delta_sum, delta_avg = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> > -     u32 new_sum, divider;
> > +     u64 new_sum;
> > +     u32 divider;
> >
> >       /* Nothing to update */
> >       if (!delta_avg)
> > @@ -5319,7 +5320,7 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
> >
> >       /* Set new sched_entity's runnable */
> >       se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
> > -     new_sum = se->avg.runnable_avg * divider;
> > +     new_sum = (u64)se->avg.runnable_avg * divider;
> >       delta_sum = (long)new_sum - (long)se->avg.runnable_sum;
> >       se->avg.runnable_sum = new_sum;
>
> Hmm, nice one. This makes sense because sched_avg::runnable_sum is a u64
> itself, so having the delta be one is only sensible.
>
> I do wonder though, this doesn't actually look to be specific to flat,
> it just managed to trip it somehow.

I think, it's specific to the new share policies introduced with flat.
Before flat we were using:
return clamp_t(long, shares, MIN_SHARES, tg_shares); where tg_shares
was clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));

With flat, we are using:
return clamp_t(long, shares, MIN_SHARES, shares_max); where shares_max can be:
    max(1, atomic_long_read(&tg->runnable_avg) >>
SCHED_CAPACITY_SHIFT) * clamp(shares, scale_load(MIN_SHARES),
scale_load(MAX_SHARES))





>
> I'll stick this on as a separate fix.

