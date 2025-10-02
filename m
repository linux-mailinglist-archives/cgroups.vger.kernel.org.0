Return-Path: <cgroups+bounces-10523-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00BBB4A1B
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 19:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066EF19E451E
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3122655B;
	Thu,  2 Oct 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiogSUAw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F292267B89
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425283; cv=none; b=pxQa+8gxZyvV2hU8fIHjfgK1wkG94BCEyKHIfNbkaOuk/Hi5x6faWlCXqy2T857nND9JE7MOKwCdnVCFlnF+lsV1mEmnmiMSFONYCpjuNKhCQe4ALYNokPo6EMn8273+T3Ryt3FUd5EXt767rXmS52PfN70DKz1Wm/xyKvkKq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425283; c=relaxed/simple;
	bh=PdMR2eXs8RPVLBGtWIlswMR7IDmtsOYvIQ4p+zqnFFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c88dVkeCs/wLlhzLeG6DgTsfRaTGr5yzY1452lGT4S5UJT53CBgA8qHV0mT3VDgAw4TRmX+NWoZrg3avFEtTFEOHU8nnx1IMypr40/2ta+y/IgUZ4punkM82cOHIOdrXkd4YNSSKy0YW582PgfGqfRFxbPJJwankcgNleDnuPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiogSUAw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28e7cd34047so12054975ad.2
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759425281; x=1760030081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dSS/bZVAi53nx7gSnHDBdozny8jZisgC0WMWJX21pw=;
        b=OiogSUAwj0ZMKzhwOgXaoJiJlCp+DtJXzgEAhgv4jNmW5LMtn7bUgLkvTxLO1xLM0k
         3RXF7SlRqh6AifVKxQF5Z9ItNpmOMHM5VrZyA+zs6N/viH4G6JO+dthxL+p6lYx8KI1n
         seuKGFMA2Zvh45JEj784D3E9Iwf9xK2yxAXgsaddCz8qMxiS7XKBhTwF36RguUma35WL
         4aX/v1weOENTstFq+uR+kLSHcKyVbD6xJfshUjEdfYijcuHvTKwjQDwGBITUQWpVNGWI
         6sJ8WsYj0RsfzLFMoplnbPxO72EjAAlw/KBZU59dfRAoeAqr0B584DEMOQUaffBo2tgK
         +eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425281; x=1760030081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dSS/bZVAi53nx7gSnHDBdozny8jZisgC0WMWJX21pw=;
        b=q5/eNxp/UdOAO9FXPpUrovuaa+8X8oIdn7YSW/ztCKUcXDxmyPMKVsV5Vts2zuNp33
         2ZA4amTqR2EVj9jDsVjL7sexFVrMWGOC5NaCCa8t9KUKtIgUUuqMYCBGPgnrfVvyDn6C
         9aldBkrfFR/eQxxUDqOcVkz3cKr/2naYNuvH4vYY0oYQxX8lWGC1EvnI4QlZRijYdwUS
         qtE+Q+MnUFkuyvwpAZI/dv0BUxvcTx9+TfpZIMZVL2pOmM6WHXPJtGWfxCQDPkd8DoAf
         z83ygXI8q673Qq27/u23WUOrGc54fPL6y7YcgVVb09iotkEmTE8mjnYv1T21Wwa34s7l
         THjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW/e8gQouFUacskx8StA1Gzy8PdSJlEh3qhdTMsbmV710QzDG42oiuUkmpfsLsLjIWSLZs6rfn@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAkqESM/czqRHaDQkUPUDFJACwjjUEh6eALLVc8S/1Qb73jbB
	aQoCb4rwkuphEkPnXOq+G5Pbh8k9wOLvrbhWCEtxoszSr9+hSH1OKLyqg1K/fX2SNT1gdFi8Q+z
	BAIhavijCmUr2M0gLgEEE8ojnetpWwgVZn15UgJda
X-Gm-Gg: ASbGncsvBTg3Y7YViNsQIRs8sxx8hU3K+KHVqKCWPC2T3OEeWlOep7ITwHMbXtoSy1K
	RK16vwVH/o45+QZ10uyGy7DzcrC2Pj4YdEuTQ61D3skcm7885ui2GtHzj/7WQWfl1Unf3V95dt0
	H9QRa4joPbPSEI+R2+dyVpr4pupysyj1BDOFT8VUj43QwJn2WAdiA/c5OPok9cB8v75tf6xkdrc
	Ob0AqF6lTSIkc3CWIodyaCNggHa2ihQ2HAGxvoFqlNBMeq18rWAmUrRtObPksup25XPQXI=
X-Google-Smtp-Source: AGHT+IHc05aSQyCBw6dhakriYJ2L2Wiy/hDAUqu1clJJuHsC8Udba2KlYPTUUDKNRMDIWvSTe1BcYdG7+CQRmdW8aC0=
X-Received: by 2002:a17:903:2f84:b0:270:ced4:911a with SMTP id
 d9443c01a7336-28e9a5133bbmr590985ad.9.1759425281248; Thu, 02 Oct 2025
 10:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002052215.1433055-1-kuniyu@google.com> <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
 <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com> <20251002165510.KtY3IT--@linutronix.de>
In-Reply-To: <20251002165510.KtY3IT--@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Oct 2025 10:14:29 -0700
X-Gm-Features: AS18NWAFADYSoIBdjVr-Osgzyiuj__dj-h9zRXB09yfJjsY3fsSQEj2RRBzos1Y
Message-ID: <CAAVpQUBK41P0Z3VRcD6jGrRxhRe7-03srLAiV8eUaEcFu-HRSQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:55=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-10-02 09:22:25 [-0700], Kuniyuki Iwashima wrote:
> > On Thu, Oct 2, 2025 at 1:28=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse=
.com> wrote:
> > >
> > > Hello.
> > >
> > > Thanks for looking into this Kuniyuki.
> > >
> > > On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> > > > The writer side is under spin_lock_irq(), but the section is still
> > > > preemptible with CONFIG_PREEMPT_RT=3Dy.
> > >
> > > I see similar construction in other places, e.g.
> > >         mems_allowed_seq in set_mems_allowed
> >
> > IIUC, local_irq_save() or local_irq_disable() is used
> > for the writer of mems_allowed_seq, so there should
> > be not preemptible.
>
> That local_irq_disable() looks odd.
> mems_allowed_seq is different, it is associated with
> task_struct::alloc_lock. This lock is acquired by set_mems_allowed() so
> it is enough. That local_irq_disable() is there because seqcount
> read side can be used from softirq.
>
> >
> > >         period_seqcount in ioc_start_period
> > >         pidmap_lock_seq in alloc_pid/pidfs_add_pid
> >
> > These two seem to have the same problem.
>
> Nope. period_seqcount is a seqcount_spinlock_t. So is pidmap_lock_seq.

Oh thanks, somehow I assumed all of them are seqcount,
-ENOCOFEE :p

>
> > > (where their outer lock becomes preemptible on PREEMPT_RT.)
> > >
> > > > Let's wrap the section with preempt_{disable,enable}_nested().
> > >
> > > Is it better to wrap them all (for CONFIG_PREEMPT_RT=3Dy) or should t=
hey
> > > become seqlock_t on CONFIG_PREEMPT_RT=3Dy?
> >
> > I think wrapping them would be better as the wrapper is just
> > an lockdep assertion when PREEMPT_RT=3Dn
>
> Now that I swap in in everything.
>
> If you have a "naked" seqcount_t then you need manually ensure that
> there can be only one writer. And then need to disable preemption on top
> of it in order to ensure that the writer makes always progress.
>
> In the freezer case, may I suggest the following instead:

Isn't it a bit redundant when PREEMPT_RT=3Dn as we take
spin_lock_irq() ?


>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 539c64eeef38f..933c4487a8462 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -435,7 +435,7 @@ struct cgroup_freezer_state {
>         int nr_frozen_tasks;
>
>         /* Freeze time data consistency protection */
> -       seqcount_t freeze_seq;
> +       seqcount_spinlock_t freeze_seq;
>
>         /*
>          * Most recent time the cgroup was requested to freeze.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index eb9fc7ae65b08..c0215e7de3666 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5813,7 +5813,7 @@ static struct cgroup *cgroup_create(struct cgroup *=
parent, const char *name,
>          * if the parent has to be frozen, the child has too.
>          */
>         cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
> -       seqcount_init(&cgrp->freezer.freeze_seq);
> +       seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
>         if (cgrp->freezer.e_freeze) {
>                 /*
>                  * Set the CGRP_FREEZE flag, so when a process will be
>
> While former works, too this is way nicer. Not sure if it compiles but
> it should.
>
> > Thanks!
>
> Sebastian

