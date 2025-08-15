Return-Path: <cgroups+bounces-9194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA3B27354
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1624F1CC6EAF
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8C634;
	Fri, 15 Aug 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKL/aaLq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3915A8
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216370; cv=none; b=DcpsoXGbiKYgEFQxAztmp02xbjFIIX8VpbkXWmuCn4A+bgGwZ4T3mZ7/WTzh+NgCV4SZoPosb96r9aY1wGMNBVNsLUu7WNzPVsFgSw3C42hoqQlIMXZoTmx9N3Tq49gJtAAMukwyq4KDigY3P/KlY0yQvGwsL7OPV94tRjjEFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216370; c=relaxed/simple;
	bh=tOOWispR6Ea6ciZ3YMCAEhq3ARekCONZh3ZONXZA0hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+9QKWs0aTxYQrJ8Vuomi/7M632P1D9eHGGDKlOBaNcw5oRENCNM734OKZ8+jQuNs86oHYqpcHg++DyhjcHObkbNQMaVcP47kdewM+zYxzU7BNNpDAuScP3T1zJEV7XMDXTufvOZDYwewn8e6PgIJ2vUezPxWkgCXTe6zt44opI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKL/aaLq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47173a7e50so1203529a12.1
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216368; x=1755821168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3g7azcGA34tDaaYjObSrLKH+WoZLGsOWxePbsNLSk8=;
        b=TKL/aaLqf8MbDQZkl37c1wQDFshng1E744minxa1ATSZWWttYtbrMO+vHZEfORz2j2
         jhCDAT0WJY8p65E31Upv1sjNFnW2BBLpQDhmT8vJEXvLunvmf0XpuJPtnSouEyDtkj6t
         1jpXoRO6BVs9YPDiXoldhigLt0ulqirpAzVGGblYV/fDBaXLjPoDpWh77rylbPEBe6nn
         +7xblQRtqC225LjlI6p/MizKZ78eEI+vlII1rMf9/VKUgtGwScI355UB2HiPFl436AyP
         dxtNR/8DGuKppJ1cTr+11oCrybMWKUXb6S+bHiIbDF+fb24OrhQJxwlRwZYNYvH1yTCS
         1slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216368; x=1755821168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3g7azcGA34tDaaYjObSrLKH+WoZLGsOWxePbsNLSk8=;
        b=gUR3eZFPk/yKky78a1PsyZIhfFJYI6mZ2BSUbhhdjHQcUO7VMRvkKsqyp1xHVAFrQa
         dZTOLAVkKTKjtZnq5JZAYq0fMPG7P0fXy996QKE33AQGlJ8Ja8l+X/1RHVTohCaWVcB9
         5ZIQwSjGHbxqs+IonR/ejyf97TtcJf8Vp9YdXodTyJITHAPAwIWkIUVpOO07BZc9ANDF
         mCVD1GxqUSTUeNDdyiMVzr9g6hq0dnFsGIy/7FtSiWgGiUFGDPTo09HYhaTGLOnQbVf8
         9rxf/0fwFE8zTUWIhOLqY79C3Lq8c7uFBl5nhn3dJJA0RE+nE2bR9YOIDUHKI5jNg7Y4
         tJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCX+vzVhPEMKBfSa4rkp8i5/PV8jTk+zbmBXuvvnP740ZiNX83CUMw3E6w9YncnT/Nmf/hAXCF/I@vger.kernel.org
X-Gm-Message-State: AOJu0YwReh0YVH0WiMvSN96TcTZGpOX16EEOW+CWlLVteVUgwgKy8+ty
	33spDx4UvXbcFNQGG4CdUIsKj7filXRZ2s+SqT+IYIfP9O0F7VFjI/+Xur6jZbKYR54qqxSfHXl
	g1UFdRXiFCrSSII1lCfvpcNn6iE8lAu42pDK5sd1o
X-Gm-Gg: ASbGnctUQyoZjxxpsVLexFLiP6WoOAGV9vFrB0nBuHhafBinoelMgOznas4F3glGvXt
	mrda43lqsKOwb12szmJlJexbYELbmJpAzPv/QRhT/uXs7dHKVWSz6UBmug63RePjkG8kwC3mZTh
	LlBjcutDIAzpHje5KQIsoDxYtVQBZmX5hZcQ0yEmPgzciczxUfnNLpYtDHjzht867eB6nD7GFve
	JFvcx1Prak11h8bm3ySzmmmyyO24RrwKO4PFgOiNwaWoX86Escabyou
X-Google-Smtp-Source: AGHT+IEFX5W+lUoDE7ZvmQhutvrW9vD5G/rFOFnR+zH+RlJzruuwGalQl9EbNrgSF6pYF7LAALbUj/uy+KXE1fNSEc8=
X-Received: by 2002:a17:902:dac1:b0:234:d778:13fa with SMTP id
 d9443c01a7336-2446d866269mr1258465ad.26.1755216368013; Thu, 14 Aug 2025
 17:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com> <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
In-Reply-To: <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 17:05:56 -0700
X-Gm-Features: Ac12FXwONNleDf8vaBVKCNkrBAioUhawdr6ixCRQttfFCFdFsOrwwMIEvBAgFfE
Message-ID: <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > > sk->sk_memcg based on the current task.
> > > >
> > > > MPTCP subflow socket creation is triggered from userspace or
> > > > an in-kernel worker.
> > > >
> > > > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup(=
).
> > > >
> > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > >
> > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > > > correctly.
> > > >
> > > > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > > > using the parent sk->sk_memcg.
> > > >
> > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgrou=
p")
> > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > >  mm/memcontrol.c     |  5 ++++-
> > > >  net/mptcp/subflow.c | 11 +++--------
> > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> > > >       if (!in_task())
> > > >               return;
> > > >
> > > > +     memcg =3D current->active_memcg;
> > > > +
> > >
> > > Use active_memcg() instead of current->active_memcg and do before the
> > > !in_task() check.
> >
> > Why not reuse the !in_task() check here ?
> > We never use int_active_memcg for socket and also
> > know int_active_memcg is always NULL here.
> >
>
> If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> infra then make it work for both in_task() and !in_task() contexts.

Considering e876ecc67db80, then I think we should add
set_active_memcg_in_task() and active_memcg_in_task().

or at least we need WARN_ON() if we want to place active_memcg()
before the in_task() check, but this looks ugly.

        memcg =3D active_memcg();
        if (!in_task() && !memcg)
                return;
        DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))

