Return-Path: <cgroups+bounces-7245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD27A73CB2
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F55D189B796
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DE1AD3E0;
	Thu, 27 Mar 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk6iKQWa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D719433B1;
	Thu, 27 Mar 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097693; cv=none; b=kb/ez5Udsbhm4gaSnpwK3EFxrqbtg9WcXrebbLIGYKrPNKe7oBUiEiG3BJx+z5pRGzODuaqalLc2sbWyLdDUs7Bg6AyoVUH6ic/PUEOgPTfpMOBJGeWWXHzG0HLwI7mzTm/Id9Q3M6hr/cIB5JAKBEGFxICIA3rCh8+UNhfEpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097693; c=relaxed/simple;
	bh=9e8h+C2pdlvCU+8CMtrRPLcUHm9spPtbCKdoxLV65hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qz6yZCYbpfLgyhJdsat6mtNyP8LvO9zX8CxTR955bKhjAkYoevuYrHv/vXeyzEhHCzTW7uKX1TMKe5bu6UKIGGp2BjEvVJkBRgpTDBy84AKsmLDC1LTlUyZdAo7jHTEABHeFN7d0ppHrkuOPRDuiYo8dFshnSaop6nBUq8pw4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk6iKQWa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so1991046a12.2;
        Thu, 27 Mar 2025 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743097689; x=1743702489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHz+Ccq4y4In5QM8QHHqPDgkxTMlvKloGXrTWL6Om+g=;
        b=Hk6iKQWasj1aaFYVPtmTur08ATVOIDjxtq4aPfhxMLudmRqT6/oKA4eKTt5achA4k5
         bIuD+CjfRyl8P+DYcCQ8UZfeLRtMzBcSno7kgkcEI64O2MJnjpjAwz/Tf3PqRDqSRUON
         N0OVb0uHh33Q7wlZ+SnERYvzHUDaZW5oZWHp+aGOtcdzAM20yfXfcCm2IkVylRLLFBZd
         u8cL9enXWr3+H/0RUbiRA2Zqhr9kG4TfD2dXAmLrlTBbrxFx4hdwjTqJjTpZFdldWbMa
         g10geMS11D218gPiqIVCXyI0I6MLdNVburuI6pupRRpSYiNY6QezPKEA+U7aUhA4NMgU
         MUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743097689; x=1743702489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHz+Ccq4y4In5QM8QHHqPDgkxTMlvKloGXrTWL6Om+g=;
        b=ko4hzQ17zFDB8zvwtA9wyXmx7Hcytheif6XC3Rgj/deBbB8ZoSKBDAB8cfJPnlzBR0
         GotlTMo1lY3WoXPVxNZW7UajxxAON7qPGR7brQu3+3I4MapPoCr0B8rGocQdzzPEAA8X
         QXG2nh8+V6doL+RGgFmOe+ZEqQRlrLO/UKzKnBniTPqExD2shtIG5+DpZS0vaFhtuhzJ
         8Lffob0CNyql4ou1M3qW1f+gRxBXXA6W/NFyLT6BtbR7FMIVG3PdfXKF4yGOIGS1H63n
         laeAbaRzE4x9aY14sKh3dxUvjrVxMHjgVfzBdx94m3b7jY1NeLseHk9/tpievkr4HGji
         BWeg==
X-Forwarded-Encrypted: i=1; AJvYcCUCJX+nmMcXD94BfRhnZITFx4zHJ6VGchlmj8wAp9HUpjbbJ9geCuaUPi23jYKEddpSFmnHT8Z2Fh8tVrIW@vger.kernel.org, AJvYcCWUB4oUUtU00ouMZsu6WXZ4xz7xhjdTwvqAm0sa9NMTmO7Xxv1aEZznMYn/EPkr2QJDHbNhDChT@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoUFC1qRXQemrjoQxI90QSIEBrmA4Lu9q30Eh7ILknTHf8Aw2
	IJUeB93GVbi0AE8Z/DeG7rvUoseNCFsrmCLVcaYmW8nBVfZglJnT6eLLiKiZYs2Fe5S+qxIQk1t
	SrZR0f9eojddowAWNO6PlG53u+hs=
X-Gm-Gg: ASbGncsQq8NRl3faJrX8Hm6BzsBKYzTHmCSBJ7J2mrPzeQ5ivOf6Wa1Fj0sUsRCnMY7
	OSZPEurMICSEWxESfRvODhrbKLdBCc0Jx/ZZdlUe9AY4JJOQY/Igz6ESI6lNdaNl6PRyVCkSOGf
	TDSLxyfLzFIMCzvGja9znOXMMhehHsZvftq6Y=
X-Google-Smtp-Source: AGHT+IHLz7Hd7zwr8CdH3MUmiQ27N1XbY21K7o2Ht6T9pVr9uanxh8tkVxriW4wUWJJi1IrGKk7/tBQ/Dwyel4aAsZI=
X-Received: by 2002:a05:6402:278a:b0:5e7:f707:d7c4 with SMTP id
 4fb4d7f45d1cf-5ed8f902a81mr3792714a12.31.1743097688940; Thu, 27 Mar 2025
 10:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com> <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com> <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
 <Z-WIDWP1o4g-N5mg@google.com>
In-Reply-To: <Z-WIDWP1o4g-N5mg@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 27 Mar 2025 18:47:56 +0100
X-Gm-Features: AQ5f1JrXAHRzHRyquIDDNJZAWzDXofV8J8rFba84g_qbEzkzCrXyFGy0GURok_Y
Message-ID: <CAGudoHHgMOQuvi5SJwNQ58XB=tDasy_-5SULPykWXOca6b=sDQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 6:17=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Thu, Mar 27, 2025 at 03:38:50PM +0100, Mateusz Guzik wrote:
> > On Wed, Mar 19, 2025 at 05:18:05PM +0000, Yosry Ahmed wrote:
> > > On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> > > > Is not this going a little too far?
> > > >
> > > > the lock + irq trip is quite expensive in its own right and now is
> > > > going to be paid for each cpu, as in the total time spent executing
> > > > cgroup_rstat_flush_locked is going to go up.
> > > >
> > > > Would your problem go away toggling this every -- say -- 8 cpus?
> > >
> > > I was concerned about this too, and about more lock bouncing, but the
> > > testing suggests that this actually overall improves the latency of
> > > cgroup_rstat_flush_locked() (at least on tested HW).
> > >
> > > So I don't think we need to do something like this unless a regressio=
n
> > > is observed.
> > >
> >
> > To my reading it reduces max time spent with irq disabled, which of
> > course it does -- after all it toggles it for every CPU.
> >
> > Per my other e-mail in the thread the irq + lock trips remain not cheap
> > at least on Sapphire Rapids.
> >
> > In my testing outlined below I see 11% increase in total execution time
> > with the irq + lock trip for every CPU in a 24-way vm.
> >
> > So I stand by instead doing this every n CPUs, call it 8 or whatever.
> >
> > How to repro:
> >
> > I employed a poor-man's profiler like so:
> >
> > bpftrace -e 'kprobe:cgroup_rstat_flush_locked { @start[tid] =3D nsecs; =
} kretprobe:cgroup_rstat_flush_locked /@start[tid]/ { print(nsecs - @start[=
tid]); delete(@start[tid]); } interval:s:60 { exit(); }'
> >
> > This patch or not, execution time varies wildly even while the box is i=
dle.
> >
> > The above runs for a minute, collecting 23 samples (you may get
> > "lucky" and get one extra, in that case remove it for comparison).
> >
> > A sysctl was added to toggle the new behavior vs old one. Patch at the
> > end.
> >
> > "enabled"(1) means new behavior, "disabled"(0) means the old one.
> >
> > Sum of nsecs (results piped to: awk '{ sum +=3D $1 } END { print sum }'=
):
> > disabled:     903610
> > enabled:      1006833 (+11.4%)
>
> IIUC this calculates the amount of elapsed time between start and
> finish, not necessarily the function's own execution time. Is it
> possible that the increase in time is due to more interrupts arriving
> during the function execution (which is what we want), rather than more
> time being spent on disabling/enabling IRQs?

I can agree irq handlers have more opportunities to execute in the
toggling case and that the time accounted in the way above will
include them. I don't think explains it, but why not, let's test
without this problem.

I feel compelled to note atomics on x86-64 were expensive for as long
as the architecture was around so I'm confused what's up with the
resistance to the notion that they remain costly even with modern
uarchs. If anything, imo claims that they are cheap require strong
evidence.

That said, I modified the patch to add a section which issues
conditional relock if needed and smp_mb otherwise -- irqs remain
disabled, but we are still paying for a full fence. smp_mb is a lock
add $0 on the stack pointer. Note this has less work to do than what
was added in your patch.

It looks like this:
switch (READ_ONCE(magic_tunable)) {
case 1:
        __cgroup_rstat_unlock(cgrp, cpu);
        if (!cond_resched())
                cpu_relax();
        __cgroup_rstat_lock(cgrp, cpu);
        break;
case 2:
        if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
                __cgroup_rstat_unlock(cgrp, cpu);
                if (!cond_resched())
                        cpu_relax();
                __cgroup_rstat_lock(cgrp, cpu);
        } else {
                smp_mb();
        }
        break;
default:
        if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
                __cgroup_rstat_unlock(cgrp, cpu);
                if (!cond_resched())
                        cpu_relax();
                __cgroup_rstat_lock(cgrp, cpu);
        }
        break;
}

With this in place I'm seeing about 4% increase in execution time
measured the same way, so irq handlers sneaking in don't explain it.
Note smp_mb() alone is a smaller cost than the locked instruction +
func calls + irq trips. I also state I'm running this in a VM
(24-way), where paravirt spinlocks also issue a lock-prefixed
instruction to release the lock. I would say this very much justifies
the original claim of 11% with the patch as proposed.

--=20
Mateusz Guzik <mjguzik gmail.com>

