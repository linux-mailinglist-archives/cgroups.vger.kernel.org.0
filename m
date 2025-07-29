Return-Path: <cgroups+bounces-8922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89415B153B6
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912993A4755
	for <lists+cgroups@lfdr.de>; Tue, 29 Jul 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A1156CA;
	Tue, 29 Jul 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5lT8P+9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36B1FBCAF
	for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818075; cv=none; b=jCb5wqechH3mT92UEbZI+GDk6bBLOoWigFhO8akeXtacJiXLAS6ekMZLrnFl7becndVB/b91ttfKWaw2YM/vWbOmdcB+VuWZPIBxX9cVB6qclW8uZngxN9rRIFYPJ5k7luZJ4c0TnrgtHzFZWkATLSpTBLdHDJOhwIlEXAEJXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818075; c=relaxed/simple;
	bh=8ILIxFhPqV6sWJ6sNqcz7HYLvW2rtv0z1EwnknIclp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6dt8Dui1V+DVEA3dx/nyTkTcN6lQKIDmE0sKekyqUXXrYW5aERhwxa0asZTlPaTrIH49wEea1qKwip2lqVcrAmCdmXVY/6Oa6ie9NUkHxfT+c2knf6cp6Z4Lv/KKZvwbCI6CP9li6h1QbHFosvir22wn80bIVr2PNJUA6biWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5lT8P+9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso1656473a91.1
        for <cgroups@vger.kernel.org>; Tue, 29 Jul 2025 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753818073; x=1754422873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=Z5lT8P+9wUX8+PQ/BqQLkslgwt5uXHgGhF6i+E9j8iRuqlSXmeMfLZ9lPX5tqbqIJT
         +gqxJYUJ+/G6BA7RhzOcE4gJxTOW7bD8afS13Q3XIANzgz88MSwZnokro7BMveERKjrv
         Luaypo47FQDlichoqwGCLUq5NJP59zRsr8wecIDm4GZSLKKyQjQXqwyLyL2kRRpYZ9sK
         LdJE0axNrRvWcI0+JI+OHgGywrwxxjslmd8sFNLxwISbmt3KrswQWGqvVQywqLfK0S86
         UwmCjarYmZzrt5gy8871/dlDmqFZkILTWaDM/cyj45fwHaFn2frv/ZROC92ujCOGfkbh
         FiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753818073; x=1754422873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m37FqMDYXmj2Dv7ygO9Vcvff4CeQGMY//ilXkgwqiPk=;
        b=LBy0EZTwh8Y6xtaWkaOhZN2r4jXY0U0QnZ3cEtDa3diDvDiZuX71C4T/TSXj+abi1k
         +C4NiDTuAb+p/oud9jXu3hLgnaqHdmQZclm0suiSqEddYwOA8Y05Jv08KB0Z5v+h4ana
         dtlsU9F3PXVo+1fj1qt/e9P1+xMu6rasHXL1wNWMMNVMMOTvrj4Yfws6WryolEf/vPVA
         HTZFqsgZ5XMENGGpUtMOQXuhzqGft9w8yO1kc74TCYfczXsaQ6hIWvTFuTiRu9TU6Cw0
         mMb7wOmE+SUNxCSwdnTkFLsvWVC+Alr5MiadZPAYXbyS1gtCPbqG/z7fIws/WV9wPikU
         85OA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ovU6cGMty1vDsCZvXeGTv+eeyAgikT37/eGMl/CSZk2Y9kOEauIkOSxQLriBPgMknA3JQuXe@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCWtQUn1aE+6pygA0024r/gvkIIzKKcqK+0bt6I67cFfMgg59
	Zu+8nKZbWXWoPKrUM++wWnbSyJhs/G9g2fJUjqev+aNl6yU8idrnw86xoy3UlMMK/NWRCXj5WON
	jIaSDHUQc5AW80lRSNFLhO+MjE0Sk45cY4bciMTi3
X-Gm-Gg: ASbGncsg4aOAUYI3cmPChyVynwcftG4ewhv4PNUFjPkIk3NxZzE7ND1w+uupPK+GhYI
	Zvbb49ixH6b92KjRoHlCkRH8TBqUQjtTQxnXd94fDDZBr9TWqEHlhkn9h0iybG6nQPdlSh0P046
	YZ+xSO9WKnnYdDefU0bQITc42AR1pTQXj02S4VOUs1CgJrfkRUESs/dHLSqJcbaHXtUwteKBmRw
	O6KJrOjuWnas408rnIt3Xl71JkVw3SjiMy21w==
X-Google-Smtp-Source: AGHT+IFHi+K2rngfQJNaDXh6Q/65dPesMfdw/U4rG+5b3JOuqTwCXpXEA1k+tUMK8fVxHUmx8u+LcYENLMSlBCx6eI4=
X-Received: by 2002:a17:90b:3c8c:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31f5de7ba65mr947421a91.33.1753818073104; Tue, 29 Jul 2025
 12:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <20250728160737.GE54289@cmpxchg.org> <CAAVpQUBYsRGkYsvf2JMTD+0t8OH41oZxmw46WTfPhEprTaS+Pw@mail.gmail.com>
 <20250729142246.GF54289@cmpxchg.org>
In-Reply-To: <20250729142246.GF54289@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 29 Jul 2025 12:41:01 -0700
X-Gm-Features: Ac12FXzISgl-tZJ7iKnC87dk4hDowx1goc7Bk3yppQBdjG6RkAfnE8zuKgCifMo
Message-ID: <CAAVpQUDRccLyZyaz1iKABHNaw5rHfTBHtrOypmHheOJSaVORLQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 7:22=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 28, 2025 at 02:41:38PM -0700, Kuniyuki Iwashima wrote:
> > On Mon, Jul 28, 2025 at 9:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> > > > Some protocols (e.g., TCP, UDP) implement memory accounting for soc=
ket
> > > > buffers and charge memory to per-protocol global counters pointed t=
o by
> > > > sk->sk_proto->memory_allocated.
> > > >
> > > > When running under a non-root cgroup, this memory is also charged t=
o the
> > > > memcg as sock in memory.stat.
> > > >
> > > > Even when memory usage is controlled by memcg, sockets using such p=
rotocols
> > > > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_me=
m).
> > > >
> > > > This makes it difficult to accurately estimate and configure approp=
riate
> > > > global limits, especially in multi-tenant environments.
> > > >
> > > > If all workloads were guaranteed to be controlled under memcg, the =
issue
> > > > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> > > >
> > > > In reality, this assumption does not always hold, and a single work=
load
> > > > that opts out of memcg can consume memory up to the global limit,
> > > > becoming a noisy neighbour.
> > >
> > > Yes, an uncontrolled cgroup can consume all of a shared resource and
> > > thereby become a noisy neighbor. Why is network memory special?
> > >
> > > I assume you have some other mechanisms for curbing things like
> > > filesystem caches, anon memory, swap etc. of such otherwise
> > > uncontrolled groups, and this just happens to be your missing piece.
> >
> > I think that's the tcp_mem[] knob, limiting tcp mem globally for
> > the "uncontrolled" cgroup.  But we can't use it because the
> > "controlled" cgroup is also limited by this knob.
>
> No, I was really asking what you do about other types of memory
> consumed by such uncontrolled cgroups.
>
> You can't have uncontrolled groups and complain about their resource
> consumption.

Only 10% of physical memory is allowed to be used globally for TCP.
How is it supposed to work if we don't enforce limits on uncontrolled
cgroups ?

