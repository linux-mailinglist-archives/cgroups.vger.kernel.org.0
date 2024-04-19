Return-Path: <cgroups+bounces-2629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492988AB58D
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 21:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0777B282CB5
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 19:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674913C908;
	Fri, 19 Apr 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgzeKJG/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93D13C69B
	for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554774; cv=none; b=svZrL25Fr9OE6aXoN9vWaO4Mq9TYMCToawUB3M9a9u+6Mwz57oUTdPMnttBWwCpc0kmcr3/fb+S+KNpSLhBMo0TL1kXnmG7D720m22/0OLp6cNuXY4uSx/hyuRtuMD3GwV+qycYVQhroh4KTe6nCVb/jWUr3UKxYC1l0RY0mnBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554774; c=relaxed/simple;
	bh=EdC0cGkPp/KdKeI1Kb/6RwCL6y1AT+p3suMsbxZCaso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXyNOEHqBXTLbJN5brXK/iWD5EsDAAP6exetrFLVqT8Ufwjv/ybPa77XHVAqB1XVC0aRSWjjRVtN+oRUe+O2ohxvCjwfNnigDeQMcjJ2ErCuYW/k/keYtp+7N9rn3yZ5uupUIBhwmwtI/d7+mbBX9vEAaHNTNl2EHmkcsKHlc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgzeKJG/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3884207e87.2
        for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713554771; x=1714159571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jD0EhyCifuBQLkCgtTMY21veWhe8WpFtZANsrLOqmw=;
        b=KgzeKJG/+ttl3iKp6CTfLXe4CISeZ3XMk77y75QIa825gBnZx6oo9jVu5uvE9F7tut
         MIiUb8VLbClGl/VcyzAO0bZzNmthe3/0fvTN766Kq/Cgg2TTnt2gvBUIKnLiT1SgaMAG
         pmGM7yr7wBS+uXkSYYD8gtjfK5G2sB65AtKEeTRxJ949mxH2UDApL7iSaxW2JU6XufEW
         50Or1Pjg0fl5hwbe9zNJSG+kHotU0efDJ9IQg8fevGkdyUSJvmSHxNfB4CfgyvoYR1AC
         sVtLoAztoKhHZscOhowrCMFFoVKB5+/XvnbzfMt6HEFkuTJG78XX7rPEoSI8btUraBoS
         v8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554771; x=1714159571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jD0EhyCifuBQLkCgtTMY21veWhe8WpFtZANsrLOqmw=;
        b=KD5I5gmN5JcrSpdf7Ye+tNFWWDddCcWtEGLAA0T1H+Jl2v3MFOZnQn3g1U6bRqVFih
         j/DIXMQ3BjIECeQuD0+dUhA1XB8CYbm+wGN8kfJ7gV/8qDIhdtnqrAdl4wym6P2E/MR7
         WS7q8Yl8H3UlHvyJ5+OgyjYnOTmtVMJrz3xh7p7UQAvfAsuppXQdRQtCpgk3pxkAZfqV
         3uKcLw5ltR8HG5SEoYkAnT3e5i8ElVHO1z9LtMzp99NdG3QkV3aKQyLKcURe4Qys1mrO
         sUtLHN5jAdxLmR4VUk66r0oKq12dexjdXZ+GQNAEk0QqGD3RaQllas5I57Rv/PLZrRLe
         yhkw==
X-Forwarded-Encrypted: i=1; AJvYcCXjk7k3TK4nrVVYEISGskBVCjcqfY8TpxltFQtZ5btd9yHwzyIrhENpdu4CK9+ypo9EPU5hwHKBQ8rqyioNf/xmZSsuwqWAMQ==
X-Gm-Message-State: AOJu0YwbVoXJUYhSTcBdVrgkUp+SAWwb36Rzjn8coIOcF6uvGtoxTXkr
	8imWKQKKS/eHbfmDcCI/r9IEjcb+ra8u2HxYlg3Qs8AJULGbZgKDhi8/7lFzSkbGLuPlOVdCcCr
	2kZw5OaQHClXr9xmKRcKbo+2tVzo2k+CMlNHE
X-Google-Smtp-Source: AGHT+IG7VL6KZ/P5UdQBTbJCd+VjQRvtNpyhd38tP7Or3vQWzXSTZExyuSTBKhBZU9qfTY773qr5ITgLc3HCzj5YcEo=
X-Received: by 2002:a05:6512:3f18:b0:51a:dee1:d41e with SMTP id
 y24-20020a0565123f1800b0051adee1d41emr294169lfa.61.1713554771092; Fri, 19 Apr
 2024 12:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org> <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
 <33295077-e969-427a-badb-3e29698f5cfb@kernel.org>
In-Reply-To: <33295077-e969-427a-badb-3e29698f5cfb@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:25:32 -0700
Message-ID: <CAJD7tkbXgd1jHA2OYppdyfPnMR5aBtee0KxSHLBsZ=78eGG73w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:17=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
> On 18/04/2024 23.00, Yosry Ahmed wrote:
> > On Thu, Apr 18, 2024 at 4:00=E2=80=AFAM Jesper Dangaard Brouer<hawk@ker=
nel.org>  wrote:
> >> On 18/04/2024 04.21, Yosry Ahmed wrote:
> >>> On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer<hawk@=
kernel.org>  wrote:
> >>>> This patch aims to reduce userspace-triggered pressure on the global
> >>>> cgroup_rstat_lock by introducing a mechanism to limit how often read=
ing
> >>>> stat files causes cgroup rstat flushing.
> >>>>
> [...]
>
> > Taking a step back, I think this series is trying to address two
> > issues in one go: interrupt handling latency and lock contention.
>
> Yes, patch 2 and 3 are essentially independent and address two different
> aspects.
>
> > While both are related because reducing flushing reduces irq
> > disablement, I think it would be better if we can fix that issue
> > separately with a more fundamental solution (e.g. using a mutex or
> > dropping the lock at each CPU boundary).
> >
> > After that, we can more clearly evaluate the lock contention problem
> > with data purely about flushing latency, without taking into
> > consideration the irq handling problem.
> >
> > Does this make sense to you?
>
> Yes, make sense.
>
> So, you are suggesting we start with the mutex change? (patch 2)
> (which still needs some adjustments/tuning)

Yes. Let's focus on (what I assume to be) the more important problem,
IRQ serving latency. Once this is fixed, let's consider the tradeoffs
for improving lock contention separately.

Thanks!

>
> This make sense to me, as there are likely many solutions to reducing
> the pressure on the lock.
>
> With the tracepoint patch in-place, I/we can measure the pressure on the
> lock, and I plan to do this across our CF fleet.  Then we can slowly
> work on improving lock contention and evaluate this on our fleets.
>
> --Jesper
> p.s.
> Setting expectations:
>   - Going on vacation today, so will resume work after 29th April.

