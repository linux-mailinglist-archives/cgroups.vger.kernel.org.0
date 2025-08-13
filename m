Return-Path: <cgroups+bounces-9119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F966B24035
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 07:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D91316D8B4
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 05:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E22BE05F;
	Wed, 13 Aug 2025 05:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lzlghcgv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E61266584
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063190; cv=none; b=VVdSmMZ83OPUaZx+20j96DW3/2H/t6Litb6FwbJPiBqXmGXX0lzRXrOWTVDUgenr0vcRlSsz3EMB82OAIOdYctHtOYVQJEokT82nQO6MoZWeVE+E87VhgQaKVQF2wBqJO+L3/yyxeDoLnMTVXKPXLgODnDFgoyNWZqsBNlwSi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063190; c=relaxed/simple;
	bh=IHOoxSB2XGC97/Fvbsx3+kWd5jPNAgc8qjq/viGFh94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDWLmueuMxSajAzSkslYy9D2awBZUgIBaDgx5XtBakuEKDYuqoPW1QFrYszW7d9alqyoknf/pFKmO4kDQz0KG9UDn7PNmZ0BJbr3QxfoGzoT+D2pfN6VIiGuKFuZB8NO/YZbW8oz+qgVr/ja7H7R24dtMFHQim9a+TaQ8IFdQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lzlghcgv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31ece02ad92so4713221a91.2
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755063188; x=1755667988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd5Hzu0+89GoFhfPNDsRG3A11ZVeQEs8/UJ+qwaOXUU=;
        b=Lzlghcgvy13Cvg7X6y7VJJe6EmT0BhYHB8QdWayuwCkeYTI6s/2qgH6to2MudMuWPP
         HN6dJb/vXDf41oF79K993QShVCLia3EjdS9BeBVEMDbOyJDOoUEIxRHPFUDuGD8BE0b6
         cllMxgdXuL7rVX4WeADLTvnG1S9FBG/z2cwBZxaOFonBEInwm90SUKSFQx+vEk9ACrda
         3eELiQfr+VCvIEkL6sd0DzqMEj03cUffhF38/3cOL60HmYxre+LlPJ4K10L4e7X3IefC
         KI50so4nd54oWe5AJK07VIRpVUARiPMPkGIjV9hdLaqowsp9livCO26hYOMobzAyVUtf
         1mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063188; x=1755667988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd5Hzu0+89GoFhfPNDsRG3A11ZVeQEs8/UJ+qwaOXUU=;
        b=nS07jnVZci1nfmTSBxNIAHGnY/6HUzCWNf+RhelduRooxQ8lsylwcKHOvdQGzm35Lr
         bsTAv28A9TYBp1xgbkRIcz6qbFk0iIjNggj1j0QeeUCr8KstDfZu0d/aw18P1OBG1f7p
         KE0Oi75imGDsJPCG+PPSPT1TVG6/a6Lxx9Saw25OAg6DnWNFVU+3rR8AaLnsHlbJxPK9
         w1IECwjaQW27RAZncK9Qy7mfL50ysE86KV7HSGdUqZm68W6dmfQxMK0TtSAOmA89NcJW
         yEaz+0gs9XxVIXVnjct3mJwtbxgLyorYQFLSTLFWR2NYC31LGhK5wTtxqAhphwc6RXCo
         GOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6BsHwmXpF2zDFr2T4q5c1HWQm6eDr+J2OPv1aTybIF8LElGhiVdEJrprcBqlXa6AvJG38Hq01@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uAnGtbweVvsH5wbE467svYlOIiJDi/q2kf403v1UFo7GR3qw
	JKb6Nzzf4hBco/7EEK2sK+vjSvyt8aCe/QaFEeAGou7eOs+euCNehAsflrEOMZqxxKWlvzm1qG/
	rLHiznB9dPdassTzHsuVucvSP9ihAPc9LGY4OvDyL
X-Gm-Gg: ASbGncsnmx4q6uiS2XmprcLqkwdLs6YVt/8jofl77Qu3TUYA9/pOCkxwG1TYIUNbCPb
	u2IAs35NiYi53TNG4xFqkPovVnoufzNXoTVOgFjv+D0tWb0kBB76I0Zv5GD+9npw+xACULaVkgS
	L06c5Dh3MDMVJdgTg/+zkx1GxnUyfj3uM0i4MUDu2597E7r9cmoHD3P8LCtB4e57ttUUezm4b6z
	LMcRp2N7XKCpfnxTHlyrke7poiyFoQ8X11Snj+hvbSMZNgtA80=
X-Google-Smtp-Source: AGHT+IH3Ow5heN5Ax2cYKZiN1J5uErCtHiipF//JGUZalAKyO1nKABn3UiGzqPqVAQOS02PYRiux0Wll/uHc1/Zh/PU=
X-Received: by 2002:a17:90b:3c08:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-321d0eb0f49mr2505895a91.29.1755063188104; Tue, 12 Aug 2025
 22:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <87ldnooue4.fsf@linux.dev>
In-Reply-To: <87ldnooue4.fsf@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 12 Aug 2025 22:32:56 -0700
X-Gm-Features: Ac12FXzONwUY1or--rg6Ax98ZVLm-UmE3bBgmXpdqTrH-hTrcJWYQJLYQ9n4lIg
Message-ID: <CAAVpQUDZ_8RN_VxQWH_wipRd_Ge++YZU5SQC9535CR8W6m-JnQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 6:58=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Kuniyuki Iwashima <kuniyu@google.com> writes:
>
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as "sock" in memory.stat.
> >
> > Even when a memcg controls memory usage, sockets of such protocols are
> > still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes that
> > belong to the root cgroup or opt out of memcg can consume memory up to
> > the global limit, becoming a noisy neighbour.
> >
> > Let's decouple memcg from the global per-protocol memory accounting if
> > it has a finite memory.max (!=3D "max").
>
> I think you can't make the new behavior as the new default, simple becaus=
e
> it might break existing setups. Basically anyone who is using memory.max
> will suddenly have their processes being opted out of the net memory
> accounting. Idk how many users are actually relying on the network
> memory accounting, but I believe way more than 0.
>
> So I guess a net sysctl/some other knob is warranted here, with the old
> behavior being the default.

I think we don't need a knob to change the behaviour because
the affected case must have a broken assumption.

There are 3 possible cases below.

1) memory.max =3D=3D "max"

2) memory.max !=3D "max" and tcp_mem does not suppress
   memory allocation

3) memory.max !=3D "max" and tcp_mem suppresses memory
   allocation

1) is not affected, and 2) is not affected too because decoupling
does not change the situation.

Then, for 3), this change will allow more memory than ever,
but it's still limited by memory.max, which is configured by
the sys admin.

If this could be a problem, then the total amount of all memcg's
memory.max should exceed the amount of system memory,
which is unlikely if configured properly.

Also, in the 3) case, TCP has quite bad performance and the
sys admin should have raised the tcp_mem limit and moved
to 2) like our unlimited tcp_mem setting.

What do you think ?

