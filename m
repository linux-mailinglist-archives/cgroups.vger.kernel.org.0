Return-Path: <cgroups+bounces-7148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABAEA685AB
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 08:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A2D17AEAF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1A211463;
	Wed, 19 Mar 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nWVAFCY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABE1991CD
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368673; cv=none; b=k0/aGf6k7XAgMYSHU6jGlW5tIcPYO5zwY2FmrH7FsMikWYprSUoKr2BDFrA4iCLSxNL74byNyYDcSfGxJmrL/Cq5S19cxqyFQ5pBaTpXrnyZJ6z56gq7IQlFdLFSecSjM7vNyK5qQSESp1Lopac88u3lOtXWPf3o8q/0afWEppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368673; c=relaxed/simple;
	bh=vt44rzjhWVgeITUyhaSgN8a16HAn/tFr/x+0In0XnmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbzYo6Df3uVOihud3cPh7QiPvt5uN1VklhFoGD1NL71tPs8lYzhvawM7Lg4MEqXrQ6hDhx/nS8KF/jQiJU1sxhUbJn/2aC8cYgYr6tWHpnaAk42RWgiAmjyP13JnIWlhk89ToNJKDg6Lm93UZ31PoGZaiexH/eRBJaKCaRaHpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nWVAFCY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549924bc82aso3638e87.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742368669; x=1742973469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KU9HnwjDebldqtBx4QeCjTCYcgz8DT96ZzxqdTu8Q8=;
        b=4nWVAFCYBT8W3ahM18NLv8yevFG7gMVE2FpuGJKEL1WItFjed1Cp8tXnTlqAu6DpcS
         KTlGCGtN9R1VamTka+d7dRppjVA04MdIHpU1+gDrXZmsDRnjUqEE8v1e27xFi6UvBM/R
         EZuXjkF04cioLt0X/uVPG5G/XRlzsUyHFNrfFmq+vUtv6/R5TYLsEt84V6xANIlgRZh0
         nZ7iuOX3TT5WvoWquBmNUDJFxR/zEfzkNPo6dWP2naHmRn/SJxeI3BnbS9Hhp5IpyPAW
         xi8xGIZPok03BvOGVleuiJ3CLHxgJyESe10/lPipujfdTBxo99hrkblowrI6cMDYz3U5
         qO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742368669; x=1742973469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KU9HnwjDebldqtBx4QeCjTCYcgz8DT96ZzxqdTu8Q8=;
        b=MoBZ+dnguqENU1EE8qBVjHsVWdulOFFPZ3dfd7YL0kf5l6DkW8BR7kkHBs52OfKu2I
         j7KSO4qhi4qqFzBC0gt6RLN3hWFyqyh98KWIGpHDif7CFXXXDkak5/7uZrdFeXFxmkit
         ia0r38yaohs5J1fg6GYJGgc33WujCUG7I1g++liYsg+0pznRK7Q1NtwqvjCkbc980S0G
         je/oRjKLdFfv0xw9eH4rVuUK8J8l/u8W6bwC5V06yIuLV1jfRlrF51Htaef7XcUKCaM7
         GlaayVgrhx6EXjOj5K36mL+nkmHP4okq6yJLOcES+0PCxoODARXK/OSakLX/bZOBL/GS
         GG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6T5uV0Nql41PuZG8fGjeu8BOfDSmha3kt7Bzr5iuwCuhh69t8GEsA+3IfBoBWATEFPVhoS/zU@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR6xWs9zMPLnfVbLbbrHnOstie67ADLI12oFNocYykYYUdnGI
	3Zba0Be8LvmozVtVd7tks2TRSHytXhQGhMVzER2SiePCJ2R5ZnykQdlKTm0v7fhPQLrzu6vtEb3
	z5TDT4f1E1ID9ICr2M+nWbicLQsnR0VBqh0I6
X-Gm-Gg: ASbGnct30aTjYdva7jvvTaBLPUVh7HV1emck/y2+tjifSGH4pPOpvJBmCkPiaQ69Zl8
	dIqPgw2EDVSGOOWeLdYGjhgUxl4PapjuVt824XgMpAL5NmnNRbPwKqKXn/H+wAXCF8VKp//TJHh
	BLqBircTTsb47iHfkz4jmniHdftw==
X-Google-Smtp-Source: AGHT+IGAuYELn1G87/xbGf4nJJAc6yxKnaHo9lkXX2pHo7+K5xnrKuihHzBJgwOlUA+gTl6bWjvlUKKpgs3k02Bbgoc=
X-Received: by 2002:a05:6512:3da7:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-54acafe30e4mr153843e87.3.1742368668855; Wed, 19 Mar 2025
 00:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com>
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 19 Mar 2025 00:17:12 -0700
X-Gm-Features: AQ5f1JoP9xcA4Ytb0_6iu1s5e84MKlmwW3vfsv1tKFtcMFfXXevba6DA_ParSgI
Message-ID: <CAHH2K0Yief2sdxnWHjqFz3NomEzZOsyy0y57fYH9f_wCAmKH+A@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(fix mistyped CC address to Eric)

On Wed, Mar 19, 2025 at 12:13=E2=80=AFAM Greg Thelen <gthelen@google.com> w=
rote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
>
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
>
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
>
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  =3D> started at: _raw_spin_lock_irq
>   #  =3D> ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=3D> CPU#
>   #                   / _-----=3D> irqs-off/BH-disabled
>   #                  | / _----=3D> need-resched
>   #                  || / _---=3D> hardirq/softirq
>   #                  ||| / _--=3D> preempt-depth
>   #                  |||| / _-=3D> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_f=
lush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    =3D> memcg1_stat_format
>    =3D> memory_stat_format
>    =3D> memory_stat_show
>    =3D> seq_read_iter
>    =3D> vfs_read
>    =3D> ksys_read
>    =3D> do_syscall_64
>    =3D> entry_SYSCALL_64_after_hwframe
>
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
>
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses =3D> 12.7M accesses
> -    with memory hogs: 9.46M accesses =3D> 11.1M accesses
> The throughput of memory.stat access improves.
>
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec =3D> 16 usec
> -    with memory hogs: 64 usec =3D>  8 usec
> The memory.stat latency improves.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>
> ---
>  kernel/cgroup/rstat.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index aac91466279f..976c24b3671a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup=
 *cgrp)
>                         rcu_read_unlock();
>                 }
>
> -               /* play nice and yield if necessary */
> -               if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
> -                       __cgroup_rstat_unlock(cgrp, cpu);
> -                       if (!cond_resched())
> -                               cpu_relax();
> -                       __cgroup_rstat_lock(cgrp, cpu);
> -               }
> +               /* play nice and avoid disabling interrupts for a long ti=
me */
> +               __cgroup_rstat_unlock(cgrp, cpu);
> +               if (!cond_resched())
> +                       cpu_relax();
> +               __cgroup_rstat_lock(cgrp, cpu);
>         }
>  }
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>

