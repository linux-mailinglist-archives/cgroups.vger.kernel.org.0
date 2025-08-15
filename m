Return-Path: <cgroups+bounces-9199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B58B2761F
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF213BB833
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B352BE02F;
	Fri, 15 Aug 2025 02:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+KKpxQe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571762BDC2F
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225082; cv=none; b=qFmnbRFBN5bkHGu36+V1ZoJAG8WzAF6P4UHoQbdNSI3HSYSiw+H9oR0O8/M3JOcfP/DdFGakRQ3vkA0AIiHeQycjjEegEUoCusMQ3xD0adxZ116pB30XBLW/hg2zFrMC7of+nTaIaqsx+N3JTXa6xpEqXPBoF2N1A49JO71i70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225082; c=relaxed/simple;
	bh=qT2uL3TSbpLxV1OGxvbcmHAxQOjkb9fdYhdqFdG7X4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2Tb/dMrIzOQ5Xl9B7a0YCBT30zimYE3sIhFEOkIi6RARhCoB+wHZF7QNTAiB8A/0iExeYPjamLNFRTht1waayv1b1yFYRJUiB8q32ndOsaKv2GCMhCgEKTs4QqhfmRkBJmIoUu+BaVyzMzEKv2H6FKoERipNg3arSNB56DhYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+KKpxQe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47173a7e52so1013003a12.1
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755225079; x=1755829879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwJrICMvn5YZZg5OvFRoWR/jD5Y72+/VemdMMNlTNAY=;
        b=B+KKpxQejrUUIy63BbmogRDYfWhkJAtZSpXmKHhzFdT007fsD4nJZN8gqeCIFTByz4
         iJ0x7AALH43YCUMh8OxPl1gIeXww+UmZ0L9P8jWKgcLfNRUUhKFq25LjTRISmLOOVoBs
         J9n4PDEwhvYUrhdPS+t8twp8nqsnp8AzsjlO7J2upHLrRqebyab9l1MFrF0ZChv8ZP51
         r6996MGj8XfFTKRoH2yMfxsgP/4sBmZjCAYvP25bi6Xl7vxg6eXhmFNjcoO70aronZ7a
         QTMxwtv+qcuDp2HcV1eL/gDoxNVbAzlqmCNQoZRwY8t6fX2gfGRdRs9LYEwHWYPR0SOl
         2XfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755225079; x=1755829879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwJrICMvn5YZZg5OvFRoWR/jD5Y72+/VemdMMNlTNAY=;
        b=jHtajP+UAz9HZRWNRPhQ1b9UJA7Ytqd+DAjskeyti4wD/GSkfMXvr5VwVDGTgpE5N1
         xidj6QkfNJQNGk5UcRF0EPdlnzmNeK/bxovBiZ0OEIxVCkwBL2keo1yvU8LY/WGQSQG4
         w5JdCZDrAAPA15NJj+5UtZLJXN1gh8nUwB65FPJQTSNu4K/P5Gz7bjDm2zK7zGt/qq1u
         TWJU29reBBcSIMFpB8PRVbl2A/vY2YEC9+fdqraF4vyiRy3rGewJOltPBrYYPFRzl+AD
         VKW6wLfDcZ/zv8ZgUEuDVKzhHjmzF0Q8q4uLFdHkHokEPl0DwlW7RBeaHeQV83vuCqtB
         JxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAUAx+B+SdNDKOm93Pqtp1zSvg89uIgYdG0a3qKGY3Cs+lV3gxkzAZs7gcJpZJ8+GcnJl5DmLZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNk3ET489aP54b1D0WwNMX2VWgELxubRo1ivrQxj2DSuTCe6X/
	Cpi+WVzDqRZZfICX2Qc43+MPGzTrZ8i+iS4hXWYNSVbXJ53l+unX7mkGzDPDHalFBbLhpGDcaVN
	vC8pA4r6oBOkCt8yJoVbOo7bfyJsddEw4ge21rDE6
X-Gm-Gg: ASbGncvi7VdJM234vAin7azJOXUcR4GFBa8xWtPBgaqc8+pJZF4E9gQ8aLsfLIHcpba
	NbWSfGrBMmLCO/bjoECKSxRk7nIa2ryAh9zt8/K7XdzGqgQBdGNELvlZsdZS3RW9G5uLekssDV3
	K1/Up63rgChIR48fa8uj8OceOSFNPkEfvvDVunQ6pZbfrSOok+V5Bb05Icok9kMoAIZypveaG7y
	kk6FVijld5ynp3LOHPTFa4M0s/Vz7X8Uu4n8gQFe3k8mYrIxZVljKqn
X-Google-Smtp-Source: AGHT+IEwYQ5eDN0UwWpz8ZWif2tlMoHHE0vvfDGyA+lewx7O9B0FGbBkW3rn66Hd2jfvfyy3r38VK778LZowgwK8wBM=
X-Received: by 2002:a17:902:cec4:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-2446d71ea77mr6091625ad.13.1755225079199; Thu, 14 Aug 2025
 19:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com> <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
In-Reply-To: <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 19:31:08 -0700
X-Gm-Features: Ac12FXx0oP3F9dx8jnlPn8DV0XXtg4bMkD2eiCckKKtAFl_RyUY4z0YgVFHXtPQ
Message-ID: <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 6:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 05:05:56PM -0700, Kuniyuki Iwashima wrote:
> > On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > > > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > > >
> > > > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote=
:
> > > > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > > > > > sk->sk_memcg based on the current task.
> > > > > >
> > > > > > MPTCP subflow socket creation is triggered from userspace or
> > > > > > an in-kernel worker.
> > > > > >
> > > > > > In the latter case, sk->sk_memcg is not what we want.  So, we f=
ix
> > > > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgr=
oup().
> > > > > >
> > > > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is bu=
ried
> > > > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > > > >
> > > > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled wit=
hout
> > > > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not char=
ged
> > > > > > correctly.
> > > > > >
> > > > > > Let's wrap sock_create_kern() for subflow with set_active_memcg=
()
> > > > > > using the parent sk->sk_memcg.
> > > > > >
> > > > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent c=
group")
> > > > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > >  mm/memcontrol.c     |  5 ++++-
> > > > > >  net/mptcp/subflow.c | 11 +++--------
> > > > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk=
)
> > > > > >       if (!in_task())
> > > > > >               return;
> > > > > >
> > > > > > +     memcg =3D current->active_memcg;
> > > > > > +
> > > > >
> > > > > Use active_memcg() instead of current->active_memcg and do before=
 the
> > > > > !in_task() check.
> > > >
> > > > Why not reuse the !in_task() check here ?
> > > > We never use int_active_memcg for socket and also
> > > > know int_active_memcg is always NULL here.
> > > >
> > >
> > > If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> > > infra then make it work for both in_task() and !in_task() contexts.
> >
> > Considering e876ecc67db80, then I think we should add
> > set_active_memcg_in_task() and active_memcg_in_task().
> >
> > or at least we need WARN_ON() if we want to place active_memcg()
> > before the in_task() check, but this looks ugly.
> >
> >         memcg =3D active_memcg();
> >         if (!in_task() && !memcg)
> >                 return;
> >         DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))
>
> You don't have to use the code as is. It is just an example. Basically I
> am asking if in future someone does the following:
>
>         // in !in_task() context
>         old_memcg =3D set_active_memcg(new_memcg);
>         sk =3D sk_alloc();
>         set_active_memcg(old_memcg);
>
> mem_cgroup_sk_alloc() should work and associate the sk with the
> new_memcg.
>
> You can manually inline active_memcg() function to avoid multiple
> in_task() checks like below:

Will do so, thanks!


>
> void mem_cgroup_sk_alloc(struct sock *sk)
> {
>         struct mem_cgroup *memcg;
>
>         if (!mem_cgroup_sockets_enabled)
>                 return;
>
>         if (!in_task()) {
>                 memcg =3D this_cpu_read(int_active_memcg);
>
>                 /*
>                  * Do not associate the sock with unrelated interrupted
>                  * task's memcg.
>                  */
>                 if (!memcg)
>                         return;
>         } else {
>                 memcg =3D current->active_memcg;
>         }
>
>         rcu_read_lock();
>         if (likely(!memcg))
>                 memcg =3D mem_cgroup_from_task(current);
>         if (mem_cgroup_is_root(memcg))
>                 goto out;
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_a=
ctive(memcg))
>                 goto out;
>         if (css_tryget(&memcg->css))
>                 sk->sk_memcg =3D memcg;
> out:
>         rcu_read_unlock();
> }
>

