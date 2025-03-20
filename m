Return-Path: <cgroups+bounces-7198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B7A6A8D9
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 15:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CDA88318B
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C791DED46;
	Thu, 20 Mar 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXVQ3wIn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF41E1A05
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481830; cv=none; b=Dd45jSMmp32MLbbOyqGo8Ls+qiah6BfTO5hU+Zf7OJZ8btTpyGZ6B2ZrbJF3nYJzNuX03Z1c3SnJTCKgg7G/sqDRp6DdsywyQ/fyj7buRWaZKxCCPYhGKlaO7Y0AmOjdQA3Jzq4LsAKkeBHueuVtQwlK7wZ11z2KsNJ64vOv79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481830; c=relaxed/simple;
	bh=TDBstvy7iYERI525OcEsjDYW1OgYXktNJP3vh6zOuxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB071bjo3t3pR8G4J78MCbLklHoaBpRwaZtUUfXERAy8fMMCkV7s+U94forQ1y0kJZ5dPfUDDHSSctjVwdWUETlXB2BTm42NPMuehIbOH3eT8fbueJeDjG4ikIsT5EsKH+B3IKVt676QuPj+yYHhk9wDJUMqovzoGN5ugOG30So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXVQ3wIn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so9188a12.1
        for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742481827; x=1743086627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGT8HOddMLQhY6sBbkKYQxOTAVe3/AEazyhK+vDdPHw=;
        b=zXVQ3wInbS5RlofjJMiyPdmahmrA80YEy7y3JkY9rDbkJk5EBQKBegdiZ75zOhNeT6
         s3l7qjOno5ceiZh2Lc8g7RFVVkHksqfsIbY0w7cIyE608Hqu+h7z9KYqM2D+E5AGhXKB
         WL0H5E0XrjJeK4AIKT9qbenFvbtxf8dl1IJE5FJe91TdC7kCMIZA2Dkdh7YPjQaVOlJ5
         pHzFAiA8s8eagJgj99pm8Amv0B5x5XcwwWOZZwC7ZPFQaNhDACSx7ELgwkxA+4oWlSLE
         aYLb80LRJiTJGVXcD/7rFeaqMJchDWtbmKVySuCa0pnN/4zmDbkrCD/Ue8UdR9e1+BCI
         B+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481827; x=1743086627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGT8HOddMLQhY6sBbkKYQxOTAVe3/AEazyhK+vDdPHw=;
        b=X56tmlBjg5fYWRdWtfP29CPLytllC9uasHpf06+zPoSq6NjUVujuEPUhU3HeNfFjin
         DNIjaSow0JSaC/VboMAI9kD4nrLrkl4hwauppyM5etoa/RApzpYKexWV+xOLYxvd+Z+m
         nsMoyeGqu5p4NMVCuu0ZPaRk9I4BK/Odr6jdtJs7sS2Zzn22D/ItuSfPEFHB44L4KshF
         MSePfPVmXy5OFJQcWbejiByvpU+X9i6MIoMfcLQKam8UqOXGd8RjMcX3OujSVITDjkqA
         ipqOcNC/K8BsDUNYFwKVgmkAqBa151XtflGmAOFVkp+xt63slmpG3s0NBcUcOlp8+v7l
         HmoA==
X-Forwarded-Encrypted: i=1; AJvYcCWXodcSolCZyl0e0R50C3UA5JU7VnCa2Ppl8tBANA9gnNBtH8uDphqDURT0OTy0UIGzDMCqpXms@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxwo0JSP5xw5CmvL54XBQ6JwPph6f4oatq/rUdiUdZql1ADsa
	gYYLUPHHZ0Z/BZJ90RRT51dPVVPnXTubgxn2NCrDexMxx/ZKhCDds2tP45IsO0aSkke2Qb+yi5U
	zof4bD6hkCOuy58yQVQDPoFpSMrEuLzHxTWLw
X-Gm-Gg: ASbGncttfLJ886KRXQ2zhQ1NHzVJntdk07CFtp84ZOGzCCehoOmME/NJNbE0mvZuzBU
	LsdqPnHASGDyzWnA4QNGnEKS9Ng+EHR+c4mDFxpW7GRGTe2zWU4bslXmNcTeSS5vyBfe4vxqZYh
	tIXOqelJvkk+PiHeA2dRBTuRS5qQ==
X-Google-Smtp-Source: AGHT+IEIfxBJfgkvCqN7KZ1CjD2eqOP4kW0Od3M1A1rjOEVGB9a1+cYgt4BZRw48lCPJb9JyIB8HqibtwXhdyhauBk4=
X-Received: by 2002:a50:cd93:0:b0:5de:bcd9:4aa with SMTP id
 4fb4d7f45d1cf-5ebb557340amr77436a12.3.1742481826376; Thu, 20 Mar 2025
 07:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com> <54wer7lbgg4mgxv7ky5zzsgjv2vi4diu7clvcklxgmrp2u4gvn@tr2twe5xdtgt>
In-Reply-To: <54wer7lbgg4mgxv7ky5zzsgjv2vi4diu7clvcklxgmrp2u4gvn@tr2twe5xdtgt>
From: Greg Thelen <gthelen@google.com>
Date: Thu, 20 Mar 2025 07:43:10 -0700
X-Gm-Features: AQ5f1JrsBCAzWz7lOGHe9DRZZeo48XSMPjuZ3fiimpdEWqFCeYJ39zulqPDioKA
Message-ID: <CAHH2K0ax2M+nXhVDSUvhagmFW+qEgGawSbkw6pAzYR+BAH6UuQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumzaet@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:53=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> > iterating all possible cpus. It only drops the lock if there is
> > scheduler or spin lock contention. If neither, then interrupts can be
> > disabled for a long time. On large machines this can disable interrupts
> > for a long enough time to drop network packets. On 400+ CPU machines
> > I've seen interrupt disabled for over 40 msec.
>
> Which kernel was this observed on in production?
>
> >
> > Prevent rstat from disabling interrupts while processing all possible
> > cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu.
>
> Doing for each cpu might be too extreme. Have you tried with some
> batching?
>
> > This
> > approach was previously discussed in
> > https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> > though this was in the context of an non-irq rstat spin lock.
> >
> > Benchmark this change with:
> > 1) a single stat_reader process with 400 threads, each reading a test
> >    memcg's memory.stat repeatedly for 10 seconds.
> > 2) 400 memory hog processes running in the test memcg and repeatedly
> >    charging memory until oom killed. Then they repeat charging and oom
> >    killing.
> >
>
> Though this benchmark seems too extreme but userspace holding off irqs
> for that long time is bad. BTW are these memory hoggers, creating anon
> memory or file memory? Is [z]swap enabled?

The memory hoggers were anon, without any form of swap.

I think the other questions were answered in other replies, but feel free t=
o
re-ask and I'll provide details.


> For the long term, I think we can use make this work without disabling
> irqs, similar to how networking manages sock lock.
>
> > v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> > interrupts are disabled by rstat for 45341 usec:
> >   #  =3D> started at: _raw_spin_lock_irq
> >   #  =3D> ended at:   cgroup_rstat_flush
> >   #
> >   #
> >   #                    _------=3D> CPU#
> >   #                   / _-----=3D> irqs-off/BH-disabled
> >   #                  | / _----=3D> need-resched
> >   #                  || / _---=3D> hardirq/softirq
> >   #                  ||| / _--=3D> preempt-depth
> >   #                  |||| / _-=3D> migrate-disable
> >   #                  ||||| /     delay
> >   #  cmd     pid     |||||| time  |   caller
> >   #     \   /        ||||||  \    |    /
> >   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
> >   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
> >   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat=
_flush
> >   stat_rea-96532    52d.... 45343us : <stack trace>
> >    =3D> memcg1_stat_format
> >    =3D> memory_stat_format
> >    =3D> memory_stat_show
> >    =3D> seq_read_iter
> >    =3D> vfs_read
> >    =3D> ksys_read
> >    =3D> do_syscall_64
> >    =3D> entry_SYSCALL_64_after_hwframe
> >
> > With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> > longest holder. The longest irqs-off holder has irqs disabled for
> > 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> >
> > Running stat_reader memory.stat reader for 10 seconds:
> > - without memory hogs: 9.84M accesses =3D> 12.7M accesses
> > -    with memory hogs: 9.46M accesses =3D> 11.1M accesses
> > The throughput of memory.stat access improves.
> >
> > The mode of memory.stat access latency after grouping by of 2 buckets:
> > - without memory hogs: 64 usec =3D> 16 usec
> > -    with memory hogs: 64 usec =3D>  8 usec
> > The memory.stat latency improves.
>
> So, things are improving even without batching. I wonder if there are
> less readers then how will this look like. Can you try with single
> reader as well?
>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > Tested-by: Greg Thelen <gthelen@google.com>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>

