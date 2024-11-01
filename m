Return-Path: <cgroups+bounces-5373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E849B90BF
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908D91F22B3F
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBC19CC17;
	Fri,  1 Nov 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWQFYSgc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A319B5AC;
	Fri,  1 Nov 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462139; cv=none; b=Ly4OrK4Vp2DmYO0Jk3Let3GafE+h3kAKcwQrkenag6zpOB6so4Rc/89o4E1V7xpVuN4Uf/Yozc7cZuzuXHLVQpCpcJn7eAunsVO0Kyykggo/1hxN4iBXxCwCH0DVKuwuOwCE/sBEEetqRo3A0UptG1jtqWnt/tI2GhVfxi2WDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462139; c=relaxed/simple;
	bh=9Ylq0p3hXYbuQxs7GCkS0Vlv1jdDLlPQvnTyCIoxY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClP9NG+veoLS4hZjIxypjacMhPMWw94qjTBKnRNsJKSV56fFltkgteFJLsl/XQezo6WA/WuCIUcLhoRWA+qyo7AAY/ft/MaOS00jfsJtberniUb9NgyCWIBCQG56ZwuqvOFzWtxfVPNeBUvWuUUGOvvVb4LetTOcrLRiJSz20oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWQFYSgc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea5f68e17aso14499227b3.3;
        Fri, 01 Nov 2024 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730462137; x=1731066937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnYuFt1DD8rn3W96RMdwI5f7csrcu+bi2efGBPMVZh4=;
        b=dWQFYSgcoagisO7Y5evhYRnc8iiIO/c+vwIW2QujgRZFpJStguQWTj5uoe6ElnEKDO
         hIjQavSzZtB4EVLWv2rafKcxHLA9XomS+rwrSvLL8tQM/LCvisHd03AtVia2yFkjW1H5
         Hz4YdW4+duk1F3UdCRzu+2sAoptxyVYcI1Ow6GjhB5JMdcsL2sYiNpqGi2I2QBRnJHMI
         z/XleZ/gx5DSQzpfBMeSD1Jm46sFVRtLj2uDk2C7aB2ggAJbW8mVTJ9moazxmt0iryJQ
         iFerRWnekZ94PBat/UvoP4ImaZLpuyyeFMeSClStlyqTFY33NNbYty3DsIJtQGGcdk85
         ksTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462137; x=1731066937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnYuFt1DD8rn3W96RMdwI5f7csrcu+bi2efGBPMVZh4=;
        b=f1Bt750Ynpy+yBhC02Myya/jDLZKnQLY9QERGE/6IoQIRXvgST2rUAUd29cmAlGMmd
         jiLvkBLPWFMSJNNXDPIKFQCq/SGK1kzEQJNS+iW5PUIQqZIfT7nzGsNn7D0pNov54E1f
         /dlY+mmZOV5BlUSf0fGvQavBGPx1vuJOS4R3rdMiR3fulOkqzw93I5Ie09lDiNV0J/R1
         zJd138caaNgTsEgFypZcJfY0UxNdaXhkwz6eHKJ2FDRtH+nbnTWvx+6hcxGmgNM5cPRY
         4RGwmR66ZrsF9DHgY6byn0nVyexfG3M6W/U6+YEBEGB8mdSiG4rHXr4+C1fPAcWmH85O
         vkrg==
X-Forwarded-Encrypted: i=1; AJvYcCUSRl+ckAFpzpLjDHhFokJ9V9ZM/YR6T8jiRH2dK8PxOgdyvL+duUjgCNcSRp1R3JQbcJCSbeJhGR62ZpSm@vger.kernel.org, AJvYcCXRwLKuUFvqGSzyGKr1gcayAk6lxVBzmq7n6+SulwzIHmIXYUT08HvIYX7/nYlpSvmZKFTcZVx/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz878NQnA90bSri7SfUcjivJPRAOBb/m7bKpeKNgqv85qZLlGD3
	3bP537ZC5PdcKyFCbcYXNprKoNVXeq/cR1AuoqBD3+pOAxyoiUEc3ZOyfpyVft3jec4pZutEdKh
	yuyYcVNVyO6ACzml+/RSWuPHyYKg=
X-Google-Smtp-Source: AGHT+IH7mjDxM9PZhB13mf1xekSj/BwHCeaXuQtqxIhZ8iBq4BsIPuJS5lRcnhEbwmqlfguKjPZc5nwQKS+bcZfXbZ8=
X-Received: by 2002:a05:690c:62c3:b0:6e9:d33f:eafc with SMTP id
 00721157ae682-6e9d88d09a4mr235388357b3.8.1730462136919; Fri, 01 Nov 2024
 04:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101031750.1471-1-laoar.shao@gmail.com> <20241101031750.1471-2-laoar.shao@gmail.com>
 <20241101100617.GV14555@noisy.programming.kicks-ass.net>
In-Reply-To: <20241101100617.GV14555@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 1 Nov 2024 19:55:00 +0800
Message-ID: <CALOAHbC3h5QyOyCB99xyBwiw+NW7BEqcRDoRwfvTc3id1NM4=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] sched: Define sched_clock_irqtime as static key
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, surenb@google.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:06=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 01, 2024 at 11:17:47AM +0800, Yafang Shao wrote:
> > Since CPU time accounting is a performance-critical path, let's define
> > sched_clock_irqtime as a static key to minimize potential overhead.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/sched/cputime.c | 16 +++++++---------
> >  kernel/sched/sched.h   |  1 +
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 0bed0fa1acd9..d0b6ea737d04 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -7,6 +7,8 @@
> >   #include <asm/cputime.h>
> >  #endif
> >
> > +DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
> > +
> >  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> >
> >  /*
> > @@ -22,16 +24,14 @@
> >   */
> >  DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
> >
> > -static int sched_clock_irqtime;
> > -
> >  void enable_sched_clock_irqtime(void)
> >  {
> > -     sched_clock_irqtime =3D 1;
> > +     static_branch_enable(&sched_clock_irqtime);
> >  }
> >
> >  void disable_sched_clock_irqtime(void)
> >  {
> > -     sched_clock_irqtime =3D 0;
> > +     static_branch_disable(&sched_clock_irqtime);
> >  }
> >
> >  static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
> > @@ -57,7 +57,7 @@ void irqtime_account_irq(struct task_struct *curr, un=
signed int offset)
> >       s64 delta;
> >       int cpu;
> >
> > -     if (!sched_clock_irqtime)
> > +     if (!static_branch_likely(&sched_clock_irqtime))
> >               return;
> >
> >       cpu =3D smp_processor_id();
> > @@ -90,8 +90,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
> >
> >  #else /* CONFIG_IRQ_TIME_ACCOUNTING */
> >
> > -#define sched_clock_irqtime  (0)
> > -
> >  static u64 irqtime_tick_accounted(u64 dummy)
> >  {
> >       return 0;
>
> This makes no sense... in the IRQ_TIME_ACCOUNTING=3Dn case you shouldn't
> be using the static key.

will change it.

--=20
Regards
Yafang

