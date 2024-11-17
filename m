Return-Path: <cgroups+bounces-5601-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03229D01E7
	for <lists+cgroups@lfdr.de>; Sun, 17 Nov 2024 03:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016FC285FEF
	for <lists+cgroups@lfdr.de>; Sun, 17 Nov 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC07D529;
	Sun, 17 Nov 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAITLlaK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1E2F32;
	Sun, 17 Nov 2024 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731812222; cv=none; b=uMQNvlZECFlYcmOMYsrr6TPfyDm/jCDmA6nx+74CebArZgwEJsD61xtJb7zwi/5TPwVfBmXqapWmJlreRo0oErSlX0aZqWPSTNL9mbkauGWeVoquPFzWrCoOGBj36fCp5SDv8ZC/WqCv9n7FPuIm+W/Hk5UQrDTgaVZz7T9JA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731812222; c=relaxed/simple;
	bh=LZXiDYwgJQWymN6RFSecU98xmLZmOHuM26niW1Qps5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7zvId8Tp9zIgelejjq3jKI6HJibu7i7lG9/nz4MpFMYgo3VrzHzvk3JrnWn30hEILbqf++t0I6Kh5rff8uh4w9lCOIHqMIQxiQYCWO4WsyHFw0CpJiM6zj+HOdutbuchK97SFiD1V7YSPX9qAiWbSH4ZLKQYvvloh1vZFY0AS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAITLlaK; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d41c87aec0so1807796d6.0;
        Sat, 16 Nov 2024 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731812219; x=1732417019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXce7LBnGp/mxnNvTStq2N96jIon3J5rcs8YDFa0gxY=;
        b=gAITLlaKcsLAACwo9BE47/vTxOaXsMdduIfsVtOPOkvDQgFTzNHnEVBmdFOFZ3Yxk+
         QLSYHWk9dnMu4W81asnC/7QK6U+23gRBJe6SJkFhBuKticBbclxp2cI2+wSRJxHwr1e8
         yhMS5rzxsw/LrNzYNDwTW8SYRlvmAnGLelSkpBAqU2JzYAGqjqzxMsHcpXpKxrfmvyX3
         Xwhiv6yqBchklLmgtGgdhCNXGNk9mJc6IdoHoNjk8iGyIJV9gmh3e4GgxSejhkIyvFT3
         2QDn5/hUO3TiMvqEju2oUZ/HydrRTWJ4NHhHw9lAH+SY7623V7SiGw1if3IC3PpHrLEx
         IlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731812219; x=1732417019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXce7LBnGp/mxnNvTStq2N96jIon3J5rcs8YDFa0gxY=;
        b=FSc0dRv9SMV8wgZq3B4tPkahmSNAWxO+p1FqjD1hssE8rqWj+OEGPAayjb104vuqNI
         DCp5b5mZy1cX69OpAQofsl2bH9WsFnItKSOSAfwDK0Gg6MZCYesR32GLd2Z5WyXzmXOL
         61nDnE26rWPajXawCne8I0NM5WYzEIrejQbCbNGt2OWDtueuzhFnuZJJ3lk7sWn5j0vO
         nMgehADEI64GH2oRWBYtvj18wIWDWMGu8M23UNvrNgNA5hz98AFaM4u+kIG3+QFGmz9V
         sokyoFuerrlKsLGAh+37/F/X45Llq8q16m+nxTI+JnOGv3IahujHkQwIPAJyJ9X65Yp8
         Ow8Q==
X-Forwarded-Encrypted: i=1; AJvYcCULHGOgco8otdGAk+tfgSeMURnxAtGsBL8j4aTT1dcWRcV9avmMPbHxaFSvdxUaRTGcIwjeKIMOe8PjUMNl@vger.kernel.org, AJvYcCXkK7ByEClopbdIVGY19RGvB54bneMdg9Y4AVxt5Igalk+t4Qn6m0yxvJB3Ckq7go7hChTrGHN9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcB21nwzlOM+e+5tCg/BUwnk9VrPLcSSBGnBVsMP46GVlIhQs
	A4lxGfOYxCYlahSAr2Phs8gZkrDa2u7V0Pd3j4LVpEe3Hj0IMrRkernHOuFephLUK3xiqTcljGE
	8s64enZCSkHWAcSeCyBpYIXEwAS8=
X-Google-Smtp-Source: AGHT+IGrlf03xFwrrJsqCuzmveo5teRS/VlUmv5/NdN7uiJUv4+7nMvpcQ82bR2uphxBPJF9YwYgpMY77weQg1CiJFo=
X-Received: by 2002:a05:6214:570a:b0:6cc:378f:f7fb with SMTP id
 6a1803df08f44-6d3fb88beb2mr116071526d6.35.1731812217596; Sat, 16 Nov 2024
 18:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108132904.6932-1-laoar.shao@gmail.com> <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
In-Reply-To: <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 17 Nov 2024 10:56:21 +0800
Message-ID: <CALOAHbC54QZ6ZrRBHHKKz8F79C1J8fYcA1q59iwotuBBKtFGmA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] sched: Fix missing irq time when
 CONFIG_IRQ_TIME_ACCOUNTING is enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:41=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello Yafang.
>
> On Fri, Nov 08, 2024 at 09:29:00PM GMT, Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
> > container environment, we encountered several user-visible behavioral
> > changes:
> >
> > - Interrupted IRQ/softirq time is excluded in the cpuacct cgroup
> >
> >   This breaks userspace applications that rely on CPU usage data from
> >   cgroups to monitor CPU pressure. This patchset resolves the issue by
> >   ensuring that IRQ/softirq time is included in the cgroup of the
> >   interrupted tasks.
> >
> > - getrusage(2) does not include time interrupted by IRQ/softirq
> >
> >   Some services use getrusage(2) to check if workloads are experiencing=
 CPU
> >   pressure. Since IRQ/softirq time is no longer included in task runtim=
e,
> >   getrusage(2) can no longer reflect the CPU pressure caused by heavy
> >   interrupts.
>
> I understand that IRQ/softirq time is difficult to attribute to an
> "accountable" entity and it's technically simplest to attribute it
> everyone/noone, i.e. to root cgroup (or through a global stat w/out
> cgroups).

This issue is not about deciding which IRQ/softIRQ events should be
accounted for. Instead, it focuses on reflecting the interrupted
runtime of a task or a cgroup. I might be misunderstanding the
distinction between *charge* and *account*=E2=80=94or perhaps there is no
difference between them=E2=80=94but PATCH #4 captures exactly what I mean.
While IRQ/softIRQ time should not be attributed to the interrupted
task, it is crucial to have a metric that reflects this interrupted
runtime in CPU utilization.

The purpose of this patchset is to address this issue, conceptually
represented as:

   |<----Runtime---->|<----Interrupted time---->|<----Runtime---->|<---Slee=
p-->|

Without reflecting the *interrupted time* in CPU utilization, a gap=E2=80=
=94or
hole=E2=80=94is created:

    |<----Runtime---->|<----HOLE---->|<----Runtime---->|<---Sleep-->|

This gap will misleadingly appear as sleep time to the user:

  |<----Runtime---->|<----Sleep---->|<----Runtime---->|<---Sleep-->|

As a result, users may interpret this as underutilized CPU time and
attempt to increase their workloads to raise CPU runtime. However,
these efforts will be futile, as the observed runtime cannot increase
due to the missing metric for interrupted time.

>
> > This patchset addresses the first issue, which is relatively
> > straightforward. Once this solution is accepted, I will address the sec=
ond
> > issue in a follow-up patchset.
>
> Is the first issue about cpuacct data or irq.pressure?

The data in question is from cpu.stat. Below is the cpu.stat file for cgrou=
p2:

  $ cat cpu.stat
  usage_usec 0
  user_usec 0
  system_usec 0                            <<<< We should reflect the
interrupted time here.
  core_sched.force_idle_usec 0
  nr_periods 0
  nr_throttled 0
  throttled_usec 0
  nr_bursts 0
  burst_usec 0

>
> It sounds kind of both and I noticed the docs for irq.pressure is
> lacking in Documentation/accounting/psi.rst. When you're touching this,
> could you please add a paragraph or sentence explaining what does this
> value represent?

I believe I have explained this clearly in the comments above.
However, if anything remains unclear, please feel free to ask for
further clarification.

>
> (Also, there is same change both for cpuacct and
> cgroup_base_stat_cputime_show(), right?)
>
> >                    ----------------
> >                    | Load Balancer|
> >                    ----------------
> >                 /    |      |        \
> >                /     |      |         \
> >           Server1 Server2 Server3 ... ServerN
> >
> > Although the load balancer's algorithm is complex, it follows some core
> > principles:
> >
> > - When server CPU utilization increases, it adds more servers and deplo=
ys
> >   additional instances to meet SLA requirements.
> > - When server CPU utilization decreases, it scales down by decommission=
ing
> >   servers and reducing the number of instances to save on costs.
>
> A server here references to a whole node (whole kernel) or to a cgroup
> (i.e. more servers on top of one kernel)?

It is, in fact, a cgroup. These cgroups may be deployed across
different servers.

>
> > The load balancer is malfunctioning due to the exclusion of IRQ time fr=
om
> > CPU utilization calculations.
>
> Could this be fixed by subtracting (global) IRQ time from (presumed
> total) system capacity that the balancer uses for its decisions? (i.e.
> without exact per-cgroup breakdown of IRQ time)

The issue here is that the global IRQ time may include the interrupted
time of tasks outside the target cgroup. As a result, I don't believe
it's possible to find a reliable solution without modifying the
kernel.

--
Regards
Yafang

