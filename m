Return-Path: <cgroups+bounces-3735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C9934021
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A451EB220D2
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022317FACE;
	Wed, 17 Jul 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQ0thuGq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873A1D69E
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232355; cv=none; b=mwGdTVA9jaV/c3r8lMbsgVLsOh+SDfeWq8ZQSB8ryFcfemZCeQHcFMSZAcLOPhQy7wdM0GibJkB+AhTskVuyiCBRt39SggezPz6yM/UBoKdb9Xd0G44ftxI7QD5y8OfZQCANiFDbRuV8NFoXe6bL7yVWgX1XLw5jCyWjRKVRN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232355; c=relaxed/simple;
	bh=YcjsHP54RpwUKtiYpkm/nJMYQg9aJFKhLDJMn31KcwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMlQk7G2LPVAv2jh/ML75aCxNCPfCdCUya2vD6kGQtscosbYIz4o691/2GOGhmJJ1NKrgNAINNTWl/Rlluh2pqJ6Gz1ykoABpIPySPGP8gsKPZtO07kz9OkV12Kpiy5Pjx1K2EiBsoyjwomlNaFc+lm2oN6DGLIRoN9ewVQP81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQ0thuGq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fd513f18bso737700066b.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721232352; x=1721837152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XzbkbJcXikIhEb+ZP9zYLgNCMH4osHfm1Sg9VEiM7Q=;
        b=xQ0thuGqB7hpZsxBYTT+o0e8j8k+TlRqVXirqALZ47HjLSMi98klJpUkYYI+mhImf6
         BYfZu8NdvUozBKsQ6DC5bfBgJYEu83w4ETPBMYRrhr149KymWaojk2cx5ts1Bvnx1Kpn
         FrxrpbFgc+ek0e4KBQMYdlkp3Bj3ueQwTJDoUwfQJaZOUeehHZM/ao8aAkJhQ2rSaDKA
         rSwZ7EfGi7pdF16tmvBuKMvWt+MAQbKreIp4VKJLmogF5RgQL0zoSoxc/s9w2TNqTCdw
         pkVFeq6KpKBbQPg8XIAy8xknUbIg5o4qXFnr7ueYUHsDVdCwQQtTfEFRqZ6yQwFVfe0M
         vh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721232352; x=1721837152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XzbkbJcXikIhEb+ZP9zYLgNCMH4osHfm1Sg9VEiM7Q=;
        b=gXZhJXSbsvrgJqeOV+V6I8sBsWYbOR1TLUbVP/rK/AY/Y+AvFz3G8H51INethxUElD
         BXmyncI/Xh2u1H1P3MmhKwUTj9c7aZjhFZZMoejZ7tYSbNXUUQRTmg67HmP69annbq3p
         S0yMOtlC3LuoygUYKvoQVIr1yZe7YG1ZEF53vVzwz5jm6OIxlYXyhUzBWxV9zJxdRbr9
         o5+f2EBQ7V3OzXKcKsg1NK9mQ+ZHiRm0DSj0Wsn7PHk2IyTXcnBBBjpCfB0L0pnHBA09
         WCH+l8FVw4TkCuh94GKtZ1T+6E67V7jzSHGIE6Ayo+eOKFUee/JG5mB0XtFltNNguOGI
         zzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwQPnCRyslYy3MbtWU3TgoKAZ9d8iKD5KLj0w8IVQun+6ugr1oV2Bk32W4p3C34pir3CkL50WfL8UGb6+DB/Q+SeoScZABDw==
X-Gm-Message-State: AOJu0YxIqAGe5E+HqH6y+raCCoRyGsYDS44yn7qD+Ry9Ac+CBoAT8RHL
	KNgnZlytV5ZENgwzPTveIQaiOqAgpELmrmkWf05Hg+vy7yzOlpXOYFvpuhyDoO4AVd+IMnRwKBA
	63XApgoDmaAvdLdvQZENX55NsNpn5zPXeWSqB
X-Google-Smtp-Source: AGHT+IF612kZUE8JtTrcOb7CBHDJfT/vFSLwBjbycByRk2UQLAz14lfAY2/3C531BxfWpFzgaaEvnI7pwI9M7gPPalQ=
X-Received: by 2002:a17:906:1444:b0:a6f:e456:4207 with SMTP id
 a640c23a62f3a-a7a01352c5fmr121415666b.61.1721232351397; Wed, 17 Jul 2024
 09:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com>
In-Reply-To: <623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:05:15 -0700
Message-ID: <CAJD7tkZ6WOtbtiMy_2nemLQnHgO_tC0cfH1tJF-vD-Lb8PoUuA@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Waiman Long <longman@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:00=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 7/16/24 20:35, Yosry Ahmed wrote:
> > [..]
> >>
> >> This is a clean (meaning no cadvisor interference) example of kswapd
> >> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
> >> hit the race (which is handled in V6 and V7).
> >>
> >> The BPF "cnt" maps are getting cleared every second, so this
> >> approximates per sec numbers.  This patch reduce pressure on the lock,
> >> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
> >> flushes approx 37 per sec (every 27 ms). On the positive side
> >> ongoing_flusher mitigation stopped 98 per sec of these.
> >>
> >> In this clean kswapd case the patch removes the lock contention issue
> >> for kswapd. The lock_contended cases 27 seems to be all related to
> >> handled_race cases 27.
> >>
> >> The remaning high flush rate should also be addressed, and we should
> >> also work on aproaches to limit this like my ealier proposal[1].
> > I honestly don't think a high number of flushes is a problem on its
> > own as long as we are not spending too much time flushing, especially
> > when we have magnitude-based thresholding so we know there is
> > something to flush (although it may not be relevant to what we are
> > doing).
> >
> > If we keep observing a lot of lock contention, one thing that I
> > thought about is to have a variant of spin_lock with a timeout. This
> > limits the flushing latency, instead of limiting the number of flushes
> > (which I believe is the wrong metric to optimize).
>
> Except for semaphore, none of our locking primitives allow for a timeout
> parameter. For sleeping locks, I don't think it is hard to add variants
> with timeout parameter, but not the spinning locks.

Thanks for pointing this out. I am assuming a mutex with a timeout
will also address the priority inversion problem that Shakeel was
talking about AFAICT.

