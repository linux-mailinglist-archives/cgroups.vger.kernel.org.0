Return-Path: <cgroups+bounces-2595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04448AA42A
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 22:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDDC1F22126
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE0190690;
	Thu, 18 Apr 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nys+YJQS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3E190674
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472742; cv=none; b=tn3JN+B7qXSIyX67GsTD80lxBxIaT31v+yieSHnVMSrpnNJ9G8G1XnvE4xrTCk0nDY+NpI9CLfkcRz/hDkYlobn3XqkvExYfKRSiC0Md8UuXPIcKYGSdzawIe0ocemN6ch6tpUnLdH3NHxbpkcbGZodcS5jJEtptL9kfMPT4Gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472742; c=relaxed/simple;
	bh=EQjWnSkdAXaSrCFiO96RSYAuq6uV5rmr2APeMYWUk2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8gRbixw9JPHEXvEU/nWtPEliXR9PropdO/yF9c3gAXT65BoYKyYqfZrcgGVXOPDkjBsS7G+WJBwD5t9cmIiZn98dAmUNCTQ76nVw7AHJgFcDjGMGsmuEuuyB1i6ef6FFffIVr78xCsHfqdJ0Nml7PFZkhQUr9jbY7VJBOyJFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nys+YJQS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso131970566b.2
        for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472739; x=1714077539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB9PcMjE0hVVpql+JbzqFJwr2b8GY15J6ZW7aMEdH3Q=;
        b=nys+YJQSD+bVtq0Co48PcXIVYeRGNykKREGFF+/QL7SEkPdariZrDfXd8UjgV9BdM9
         55fBydZ6jx3w7G/PF8bIt8fNamPQhrryGrVEDJS6NWAw62Lwkn/5fSo1BBKJKk53QZh4
         BH7sWmiD8hoiapl75oSTrDtFyI5zIkHFbO9nAeIHbkAEUtRQHiHJQaEiwDcE5PO0byrF
         qRmkulUB0Wds/AIJm6zVHiKSna9HC+C+M8qk25X5RO7OBya28nTikrSc21gtRJEwWnKt
         R16rJxEnTMjw6iK1jPla0z2LbRo6cQuirj207jiLAxcdgfwHupq33ZCN7GXWEj2Gv3df
         K8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472739; x=1714077539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB9PcMjE0hVVpql+JbzqFJwr2b8GY15J6ZW7aMEdH3Q=;
        b=dh+UaRVVgqm6ELcRpOoXkCCucUXWMvPOBvQzJnuO+v5T7ki9hSYgXEk21/7fB/1iiA
         q3mifkL3Av1Zkjan/oG580hxlmMKi96vw5NcPvcCWUeVeOLEYCzsdZF0Ur14lB7tRt9Y
         g2NeSz9W8XMNaVVzgBQqOGTdQrfzbrY6u+C90K6LIdmTYDwfls5Xy8i1AeGQEvaBbb4b
         qQaYwkJBvZKaJlBO0UpuQB+aQ01AHG2wQEsNeXILZTtFrXdgO4BBTTCDI9ODCROQRVML
         krpteshXRxaBuX5Ng49zpSvxVdKBfSCvBRd5fw2iPjplSpsONaHBIkfDgIBzjhtZekZT
         dKHw==
X-Forwarded-Encrypted: i=1; AJvYcCVr/tjdy8d0GNMyo2HzGhixvP/XYLUCyR8sB4N/klXyMJKBx3O5KfIEKszcil/ku1CBANuv9FPQ7qjIaauqYz5+Ywyf51eVeg==
X-Gm-Message-State: AOJu0YxA73F+pH8hzZ1WxqiHGI5Lm0G1qAiILZkDAD/bd/jLIR8zkoBW
	YzERUjrUT4ID0c+I08zFfGjCdaT9yEBUlbNwKUT0891xS3BVqqWUqYbJsCB87gX0hrlbnj+zAkx
	39YJm2+0I8y6YUYSDzHdbKtYNTUSSmis2tcv8
X-Google-Smtp-Source: AGHT+IE5WBFPkQE1UYAhvIFf0d5mnAUdlsEGWrhC2zVPDjA0RfuTTaSKcmUw73ewun1AK1uASHQuPihQ9bZCIaT/BJw=
X-Received: by 2002:a17:906:a24c:b0:a55:59e6:13f5 with SMTP id
 bi12-20020a170906a24c00b00a5559e613f5mr170031ejb.26.1713472738744; Thu, 18
 Apr 2024 13:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
In-Reply-To: <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 13:38:20 -0700
Message-ID: <CAJD7tkbU1PB6ocRUVM0mw_q-c6kq1r9WsgkZwe1ppNkZG8KdQA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:02=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 18/04/2024 04.19, Yosry Ahmed wrote:
> > On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> >>
> >> Since kernel v4.18, cgroup_rstat_lock has been an IRQ-disabling spinlo=
ck,
> >> as introduced by commit 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mu=
tex
> >> with a spinlock").
> >>
> >> Despite efforts in cgroup_rstat_flush_locked() to yield the lock when
> >> necessary during the collection of per-CPU stats, this approach has le=
d
> >> to several scaling issues observed in production environments. Holding
> >> this IRQ lock has caused starvation of other critical kernel functions=
,
> >> such as softirq (e.g., timers and netstack). Although kernel v6.8
> >> introduced optimizations in this area, we continue to observe instance=
s
> >> where the spin_lock is held for 64-128 ms in production.
> >>
> >> This patch converts cgroup_rstat_lock back to being a mutex lock. This
> >> change is made possible thanks to the significant effort by Yosry Ahme=
d
> >> to eliminate all atomic context use-cases through multiple commits,
> >> ending in 0a2dc6ac3329 ("cgroup: removecgroup_rstat_flush_atomic()"),
> >> included in kernel v6.5.
> >>
> >> After this patch lock contention will be less obvious, as converting t=
his
> >> to a mutex avoids multiple CPUs spinning while waiting for the lock, b=
ut
> >> it doesn't remove the lock contention. It is recommended to use the
> >> tracepoints to diagnose this.
> >
> > I will keep the high-level conversation about using the mutex here in
> > the cover letter thread, but I am wondering why we are keeping the
> > lock dropping logic here with the mutex?
> >
>
> I agree that yielding the mutex in the loop makes less sense.
> Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> will be a preemption point for my softirq.   But I kept it because, we
> are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> there was no sched point for other userspace processes while holding the
> mutex, but I don't fully know the sched implication when holding a mutex.

I guess dropping the lock before rescheduling could be more preferable
in this case since we do not need to keep holding the lock for
correctness.

>
> > If this is to reduce lock contention, why does it depend on
> > need_resched()? spin_needbreak() is a good indicator for lock
> > contention, but need_resched() isn't, right?
> >
>
> As I said, I'm unsure of the semantics of holding a mutex.
>
>
> > Also, how was this tested?
> >
>
> I tested this in a testlab, prior to posting upstream, with parallel
> reader of the stat files.

I believe high concurrency is a key point here. CC'ing Wei who
reported regressions on previous attempts of mine before to address
the lock contention from userspace.

> As I said in other mail, I plan to experiment
> with these patches(2+3) in production, as micro-benchmarking will not
> reveal the corner cases we care about.

Right, but micro-benchmarking should give us a signal about
regressions. It was very useful for me when working with this code
before to use synthetic benchmarks with high concurrency of userspace
reads and/or kernel flushers.

