Return-Path: <cgroups+bounces-17728-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VpwSEssDVWqsiwAAu9opvQ
	(envelope-from <cgroups+bounces-17728-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:27:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF674D058
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:27:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=LBwS5OCo;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17728-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17728-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 801F1302B22C
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972538A73B;
	Mon, 13 Jul 2026 15:19:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677903914E0
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:19:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955989; cv=pass; b=J8vorC+b3WCLCfodvVt+E0KjgfJctFxLRtfjQwDDZtXxZYsAJi5+JO6s1JKOmuZwAZ/tdNmxaJpbDqBHcPVtL/ZAjdyGjWGeOtMs0b4o4oJjGvYjmRlzWmWPZ56HYpxJRMAWp+EJF1YRvY0prBfviW97CotuoRReQIE2KvBbDVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955989; c=relaxed/simple;
	bh=cztgTTQFKjXX5TAy7SRyfnZPJ0Acz6gWoCC/Gtf5ItY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Odwk6Pz9nNzbxsGuPsfNYtzNpsHWkYyLGV4N2Dd7bkvNiS0a3H6ip4NKI5owTl+IO9x6xsOUlAxcZ4sse95owW9A4TCqwS9Bfl1lVH0zgqpCeQtJWvo79j0AGiAAFIYj+QJnkgj++t+MKLHJrU5HNngPIvHhX1yMCKN6PuRtp7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBwS5OCo; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so5849a12.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955986; cv=none;
        d=google.com; s=arc-20260327;
        b=hUCIfb934sq4snUky9f6EhcWtPltxz/uMntKdof4S7ppWqYJzPi/8ZmFfCiXfcTAbQ
         sBtVWrrEIStyaaSRH4OiggFqDv97l9TfoE3iviCdWENvfRiNjhVAKKPYTA44yaroh/SU
         Jh/+rczjsACQVOIU8fX2nN0LPFU2PsSOY3XSFuk5pRg+GxhHbu4op1OxA43W9I5UR2SB
         KrMwf2K8sEOf74VWQEZ0EZGtSStJL9xhnc/7LDpixrGm1OvCSDtp1+amBecRFcIOZPc6
         yV6DskX/cIWsNNNUsfMf5iz7+s+RE61jrxZJiC0MrEZ7mCFGaaJkT9vQBPVTz3awW3aD
         c+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        fh=YkFbBCIHkpT+dFqcJX1us8v2VHjW13adrfuobAhRfbY=;
        b=n0c79p2GHjyMZjj6mShAkczP3ANn0Ris0CpUX32j8eZV2sL+Rl4HGauVn947Yc53Mt
         vB0wE8bOJQCCJZ8YM4LqjZeqVbCMoHyJAVWElDO9xR7cb5vgD1xUIm6cSQCAJqX80Hw4
         Knwm9P02VdUbI+t3P9LZl7UawfBt5VdPJMm1ZfcHCwcjA99YTPdHX/bxevUpoDKxYWjp
         GHi4HlriCP0JS9dpSDXuG7s/N8RaOKg+sCjfx7Va7mfjJDYKcEpKEesOCdyYT4DLqPta
         X2wg/q/ga5L0kUnem3YrXQpVR1YXO31WMkex+rEJtS1xgFty2Z/76tg/bK5uzqiNV3eY
         YLJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955986; x=1784560786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=LBwS5OCo3puiW5rivqXv/7ys44bNuZhyUlnN6Laz//4m0lMkDCD4gyq+1lXuUVmbdJ
         SjRXAG0DEuU1fzH6OpArc46H3QywTpVhpVpmlln1eDL30dO/VZuQgDzCE0qBXgpO9hV8
         Awil/+H3LbE/If8WQzQ8RGVob8n5U79GAJvwIEtYVIDlchOrhIXI/PmQLTOYjUkcBT3f
         FXdbT12QTAD/cO21GNSy4zN3zA60u+Xdx+nWSanuH/pTTAOvTSvORstDEM5sE/c7+Ii/
         qFJnYKUmXy3MxaV1AiRgFcjnD2iy4+J+AEKEcZQ2M4HroOJ4TattRlGhOcD3HabrgnMC
         lFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955986; x=1784560786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=Zr38peQCzcLVrxABlBCahJXRlhO510HADLT+ucNq/TRrtNigoe6l+8HK8v98wPpsu1
         dXmIx/alE/dsNPG2Mb7rpPHuI/52j4enrCrxoNwJg4Ypm5LBc2fmIzZgHE7LauLRBoA8
         fsLY3Gy2z3aIh3BnSSriQZDDITE2Dtp3WuLhbwAW45vd8QVw+nIX2bhJ8dio5YKw/Pne
         mFx0S3KCVBJREBl8QVT97aI/MrnGc26uvvsQjoDisk73p6PNvNcAkIhh9bnJEp2tgdbn
         kcUulwHt4YyrfXO/aLx884BlMeUtAoPewhxrwRKhIsPlI86BYlfEKuFMC89JV7joWjiF
         WdSA==
X-Forwarded-Encrypted: i=1; AHgh+RoTmhQplpuy5Jp6XIyS0wIbTxkVBEsRKNdQJj/KLue4Yujbsc8rOVddMnZoW3kOEeIMPTHekz8H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6vfOT1RcrRLdd71pnzr46DiyQ8PP7AV7Zja+qzvcpVmA456N
	MKYozjjyxq2kC9yrtsHk7bJxsrj4vC8GAgevlO0qnxPQ59eLTwYTbv/eD9kpS9wwoF1T0FFk4sC
	4wJuajRu1Y+65rzjq0YMUOu1bPj0NhM3KzXLY7Eqv
X-Gm-Gg: AfdE7cnw/yzDn07LjUjGECefmcQsy067gt/i0CECNFGqWT6ucMDlei3CqgVUbJtfPMX
	WEmBJAxyJV0vRqOolIwuthMsHPvhl9nbNbaUxE6BNHJzDBGdkqZsk66e1t6ipmhEZfXVGV0YQMv
	rjEw5j/w248ZOhrQ4iI+IgvbNb7GDURky/qZaTFSatgpAMZm4IQagS/aaoJj9ysEME6GHNCNn0Y
	WgV7cKgQ7jSyZmKE1otVxN/Emi6Xjgadl+4UDgNdv9KehKBW3lVW5//+HR8048sNTXmlew=
X-Received: by 2002:a05:6402:14da:b0:69c:3005:12aa with SMTP id
 4fb4d7f45d1cf-69ccf0cfb26mr24416a12.6.1783955985293; Mon, 13 Jul 2026
 08:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org> <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
In-Reply-To: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:32 -0700
X-Gm-Features: AUfX_mxGk_ykJQVoQ6GijNCWPdkmagBjFjBbdAci75lut8r9PEZbC2gUZjRpWQw
Message-ID: <CAJuCfpFcqmWnaUe4d8q1UNRpww6QLh40MX-C3-ajgDRjzBLM9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Matt Fleming <matt@readmodwrite.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:tj@kernel.org,m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17728-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,readmodwrite.com,manifault.com,nvidia.com,igalia.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33CF674D058

On Mon, Jul 13, 2026 at 7:07=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > > psi_schedule_rtpoll_work() is called locklessly from the scheduler ho=
tpath
> > > and can race psi_trigger_destroy() taking down the last rtpoll trigge=
r under
> > > rtpoll_trigger_lock:
> > >
> > >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> > >
> > >   rcu_read_lock();
> > >   task =3D rcu_dereference(rtpoll_task);
> > >                                     rcu_assign_pointer(rtpoll_task, N=
ULL);
> > >                                     timer_delete(&rtpoll_timer);
> > >   mod_timer(&rtpoll_timer, ...);
> > >   rcu_read_unlock();
> > >                                     synchronize_rcu();
> > >                                     kthread_stop(task_to_destroy);
> > >
> > > The group can then be freed with the re-armed timer still pending, an=
d
> > > poll_timer_fn() runs on freed memory.
> > >
> > > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedul=
ing
> > > mechanism") deleted the timer synchronously after the synchronize_rcu=
(),
> > > which prevented this but raced trigger creation instead: the deletion=
 could
> > > cancel the timer that a new trigger set armed during the grace period=
 and,
> > > as creation also reinitialized the timer at the time, corrupt it.
> > > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") mov=
ed the
> > > initialization into group_init() and the deletion into the locked sec=
tion,
> > > trading the creation races for the window above.
> > >
> > > Neither placement in the destruction path works. A pending timer firi=
ng
> > > while the group is alive is harmless though. poll_timer_fn() just wak=
es the
> > > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the gro=
up's
> > > lifetime instead and shut it down in psi_cgroup_free(). Nothing can a=
rm it
> > > by then. timer_shutdown_sync() because the timer is never armed again=
.
> > >
> > > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destro=
y")
> > > Cc: stable@vger.kernel.org # v5.10+
> > > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.=
kernel.org/
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>


> >
> > Both these patches look good to me, but Suren can you please also take
> > a look?
>
> Yes, I'm on it. Need some time to remind myself of all the details of
> the implementation.

