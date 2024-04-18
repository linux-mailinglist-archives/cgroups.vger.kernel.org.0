Return-Path: <cgroups+bounces-2596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583448AA430
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB531F21E5B
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14674190696;
	Thu, 18 Apr 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GNTnUIY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0A190687
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472820; cv=none; b=tE5G+iL3Jj0Y2lmEX1zcb1mypwMS3wtRNK/BbG/fc8v0RPVUZyjRsGZBsxzXXaI9e9iQgvoS/uNHCO4om6G3lYhFUODFl7tS9FnQTKHkPMuML+gLD/EfN0Lphjpyu3We56b9Q+ZmLF+AqcUe/+YhYZN5q6FhUhkE9V2AKGjYfbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472820; c=relaxed/simple;
	bh=TvHDhStGMQ0UOSySjq/PFonA1j7hVWZ/FBuw6OxGTus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuNOUJxZaPKOWv1sO5PxhM0g71nHkF17FOHDrxZWISffrdSIAEqS8YM0PAgb47shuxADxsPjgB90sbXuS8kgZ1md9ypIR/hD8EtDWeqQtBua/Nta7X7g+VTn0djdw3xtFDveVgfyqBRnrTl3nSGHsiNh5wWBb7EBPHLNkNYP44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GNTnUIY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3465921600dso1148068f8f.3
        for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472818; x=1714077618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djyBKRlGRpWDdeJHGkQSaOnuWsBmFhDAvHccO4EOJ1k=;
        b=2GNTnUIYIcYY0TihbJJ8ApbXq88uLWKaHsADRuuYY4wQxj7MrJPT9yIM74u5G7B644
         nYSZQ9xFeecE9ile3y6+la2NK/42797hCwqbhsIWAp4zXv08ptietT2EbBVYBtauE1Jj
         sYccCLovgQeUOH4t9yOvWH5z6oqYBxPtBt46//IMQxG0iXdIcXVderYZFxXr8G0kbeZI
         LZLvKWiANt+0PFrYYce+jXUJvT9HqGO4Eh9h/yHB6Yp7aMIMiQVz/O9YOknvCfXMlbMy
         0mffzMIj826Cy2pvT7Ph/ODPZ8eisdSsP5toWEsEU2az+k8VRUQL2iiCCBBzAo3R6xMF
         zh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472818; x=1714077618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djyBKRlGRpWDdeJHGkQSaOnuWsBmFhDAvHccO4EOJ1k=;
        b=MM2GId454Zz8uXFTxc+Y/RAEICvLcX2RhndwziX156+A0Je+hv8OcLqYn0knrjXr2T
         toI0Wu2/Lc3uH1lX4Z5aOISW5g/fElMn5tckpqtkA1KZ515AoDgqQoBYt4ScBTZCaLJl
         vFjUiADX2b5sYAnkXBBNv3AkGGPTg6fHp3Bv9q/okEvXAHHo5C6gMI71YKDc18qjlTfz
         RY3gWDma3DE/ikEp9uryQ6fBABsFHsbsAy48cE8mgQEaN6NvpVUxfDRU6G0/QBJI+iLh
         1Ki2NPJ8rtzedaV83wOp1lOFK2vpkKygdkLl1a4hU27gbVAIlPXWbVtKn8EjFqPOflcZ
         n5cA==
X-Forwarded-Encrypted: i=1; AJvYcCU9B3SrO6FD5JU65ZarIZ1GOwBZSGYRSTElzd0CG2unNwFULwTmbGiQRZKQPt5hYPr17zwtCBtM4IdMc+wAALrtBi1ZDFz3dQ==
X-Gm-Message-State: AOJu0Yy9ZQSwQhC2YVUtWt+et/r8xCYKbQi81PF/C7Jaid2AV6xe1Ndp
	luL+gjQRF3roU0g3OEmKtjaW8pxpCcfAKUdRr+dlSseuBvuFZKe8WAd7Y3gOGClVCWJerzKMLV/
	MhYsCgkI01TF0skZ9yFwsNA3HlWAehPYwaHSr
X-Google-Smtp-Source: AGHT+IFo6JA2vkoE/3eFV5S2YO4dqACxa+eCURTAtQHQybTEc66uavOtkJHCgKt+OL7C5O/wtn3rtinJvDxEQsoIiOI=
X-Received: by 2002:a5d:6a07:0:b0:343:77f4:e663 with SMTP id
 m7-20020a5d6a07000000b0034377f4e663mr37716wru.18.1713472817454; Thu, 18 Apr
 2024 13:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org> <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
In-Reply-To: <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 13:39:41 -0700
Message-ID: <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 7:49=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Apr 18, 2024 at 11:02:06AM +0200, Jesper Dangaard Brouer wrote:
> >
> >
> > On 18/04/2024 04.19, Yosry Ahmed wrote:
> [...]
> > >
> > > I will keep the high-level conversation about using the mutex here in
> > > the cover letter thread, but I am wondering why we are keeping the
> > > lock dropping logic here with the mutex?
> > >
> >
> > I agree that yielding the mutex in the loop makes less sense.
> > Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> > will be a preemption point for my softirq.   But I kept it because, we
> > are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> > there was no sched point for other userspace processes while holding th=
e
> > mutex, but I don't fully know the sched implication when holding a mute=
x.
> >
>
> Are the softirqs you are interested in, raised from the same cpu or
> remote cpu? What about local_softirq_pending() check in addition to
> need_resched() and spin_needbreak() checks? If softirq can only be
> raised on local cpu then convert the spin_lock to non-irq one (Please
> correct me if I am wrong but on return from hard irq and not within bh
> or irq disabled spin_lock, the kernel will run the pending softirqs,
> right?). Did you get the chance to test these two changes or something
> similar in your prod environment?

I tried making the spinlock a non-irq lock before, but Tejun objected [1].

Perhaps we could experiment with always dropping the lock at CPU
boundaries instead?

[1]https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/

