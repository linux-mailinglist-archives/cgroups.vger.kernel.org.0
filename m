Return-Path: <cgroups+bounces-9217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F2B284E0
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 19:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA8C7AA565
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8422356D2;
	Fri, 15 Aug 2025 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WRSypKfE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E82F9C3A
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278666; cv=none; b=vFT8ebHv8iKJazT6TKn9tpTC5xxpuWSv+SZRfSMkySpnTXK5BWkUb76x5e5vNYwg+yLuYdFGqbCiFR94XnP1g2V62nm2pjonnqErXmWyvSKLs/QUuBLZG1jslTSkYr54iI1M551dG7Njei0hfoifKN6/N3/I287RBw9B4XMCvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278666; c=relaxed/simple;
	bh=XFrsjxpUzi5bhqpSZjf9YfTwjoxZtx6DnQQB4JvLOJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpUvoqusg5FQQFh8r10RtVZp9KBzdyESXlLDuEPl4c/G45id3EUBXja1N1r5S5qgK+I6Kgbb7XJ8GwCMeikPG2VZycYs9iZYBzye7izAp4AtBlyG78Zp702CoyVRbtxmPAeREfRHs0zv6htNyn27GP+DY8NT7M/95TQjcOJUqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WRSypKfE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4717554c29so1462260a12.3
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755278664; x=1755883464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzg1sXt30P5Z9/BfPnmiaFGjEcn/JQQ0ZCMOCPQMKE4=;
        b=WRSypKfEdyZ8+hV3WZzHyjQZtxAxeEdD1lD2Rgv6+WBWoj5U1wytsEfyq309nAAPXh
         MUeV6u1hYeNj/5VFIB/FkF3lzRoFTVCF/MBDdc1NSBcm5P0AwHTupQUBqeKN+ZNN7jfs
         lVpvR4qplkXDmnGBO6BKMl1IKPcFJx4RHatUx4K8BcELqBZzFpUmnjrJkgIJ2NiMiHp2
         tMo+CRzR7aWLASK7CcKmCDX9NmNe+cLP32dLChPGFpCcYFtyW7dHpQJZWQygq+v/RmkA
         yuhhExUQxPUhXpsAm4pBn/8/2/Tuv8T71AffIlKDD4pPYpVo6pLufnxg2VQPgr2szNr3
         EudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278664; x=1755883464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzg1sXt30P5Z9/BfPnmiaFGjEcn/JQQ0ZCMOCPQMKE4=;
        b=kTRWo4wHdzj46zxhRsBqZwHogr3Q9TKPhYLlXJ/TFPG3Y8x6zgHUuSwaqj1YgWBqn0
         DqlxmvlZnWzjfd9TQuqaskKDN9BxJlBwrm0QBB1yf/LS3R/jwqQKyYzQdQHsh9t49Opo
         cuRJB8bO3to4A+8MMwVGlbHBgoQOvwgGX7Jg/sE3VNgjt1YliFj8OBg3rT6UA3cIYg6c
         uGLU00++L6UuBbbwGSAKHJhwd0I2LfRsQ5vWUc/kk8D09DoidUxxPdPQ61dg6d64qYrO
         1BO6xSoBgTf2NU+OU/FpDRLxhi3B4nXKDYFSvUdFb0mpwOllhsTaxoCR4o6CIMm02wA9
         FecQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROzyqy2qKZcMZD7hhIHSMiopM0k0jrvZedeCy/MgRhujFvW5wtIucGkP2XBQ2vLS6PWshpBu+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5H3FT5+iuru4qfjo+efdG+T+JnEpcBfv+LxW03CKzZ9I0vLN
	Var9Wwp66x41r9R0mkFlwgYj6BARWKSM70nUlIPs6kufCd/3123RQ/H72xT739wTBqqEbjFSsFH
	YtsS5H6wlNtg1Rpn8dsh342Gqm5NwG9wBlFdaWI6X
X-Gm-Gg: ASbGncuuSBFZhsokqCIuDT2U9j3DaVqXRpy7O/FB87i79Ero2E4fZ7vHKxo/RZ++Mos
	Iw4ZFpfTsgJiBsh5p1GdA0Z+E+WLq8sgpX+0ZiEUv3vuVJ59Hw+ix0D40zuWGDF7n6TAeNUJuJL
	vB8oR8Uahep96hbT4NEEoyNKFQYXXiDtDh3XVuVdFtUlUN0YLxc599D2YbO9jeSH76ZNfiVfFSF
	zM5URqmPfrIn04/zyWQUfrnzPyWaXd9HY/DqvIBosAKsHuhU7m6qNLnjg==
X-Google-Smtp-Source: AGHT+IGOeHzguq0H49KnfwRNBN4KHk/rEdxFjz1gBmVI9CUvhaLBILRetMCU8KSgGN+j2f2hFkx+G5OoFKZhh3FV0pc=
X-Received: by 2002:a17:90a:d00c:b0:321:7528:ab43 with SMTP id
 98e67ed59e1d1-32342159927mr4699112a91.24.1755278663907; Fri, 15 Aug 2025
 10:24:23 -0700 (PDT)
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
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
 <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f> <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
In-Reply-To: <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 15 Aug 2025 10:24:12 -0700
X-Gm-Features: Ac12FXwIRxgeuD6PT09lmdII8NjN1ufyiLIBuu7fCCCW8-jhnwo582zSPLhZK3E
Message-ID: <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 7:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Aug 14, 2025 at 6:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Thu, Aug 14, 2025 at 05:05:56PM -0700, Kuniyuki Iwashima wrote:
> > > On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Thu, Aug 14, 2025 at 04:27:31PM -0700, Kuniyuki Iwashima wrote:
> > > > > On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.but=
t@linux.dev> wrote:
> > > > > >
> > > > > > On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wro=
te:
> > > > > > > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() set=
s
> > > > > > > sk->sk_memcg based on the current task.
> > > > > > >
> > > > > > > MPTCP subflow socket creation is triggered from userspace or
> > > > > > > an in-kernel worker.
> > > > > > >
> > > > > > > In the latter case, sk->sk_memcg is not what we want.  So, we=
 fix
> > > > > > > it up from the parent socket's sk->sk_memcg in mptcp_attach_c=
group().
> > > > > > >
> > > > > > > Although the code is placed under #ifdef CONFIG_MEMCG, it is =
buried
> > > > > > > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> > > > > > >
> > > > > > > The two configs are orthogonal.  If CONFIG_MEMCG is enabled w=
ithout
> > > > > > > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not ch=
arged
> > > > > > > correctly.
> > > > > > >
> > > > > > > Let's wrap sock_create_kern() for subflow with set_active_mem=
cg()
> > > > > > > using the parent sk->sk_memcg.
> > > > > > >
> > > > > > > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent=
 cgroup")
> > > > > > > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > ---
> > > > > > >  mm/memcontrol.c     |  5 ++++-
> > > > > > >  net/mptcp/subflow.c | 11 +++--------
> > > > > > >  2 files changed, 7 insertions(+), 9 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > > index 8dd7fbed5a94..450862e7fd7a 100644
> > > > > > > --- a/mm/memcontrol.c
> > > > > > > +++ b/mm/memcontrol.c
> > > > > > > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *=
sk)
> > > > > > >       if (!in_task())
> > > > > > >               return;
> > > > > > >
> > > > > > > +     memcg =3D current->active_memcg;
> > > > > > > +
> > > > > >
> > > > > > Use active_memcg() instead of current->active_memcg and do befo=
re the
> > > > > > !in_task() check.
> > > > >
> > > > > Why not reuse the !in_task() check here ?
> > > > > We never use int_active_memcg for socket and also
> > > > > know int_active_memcg is always NULL here.
> > > > >
> > > >
> > > > If we are making mem_cgroup_sk_alloc() work with set_active_memcg()
> > > > infra then make it work for both in_task() and !in_task() contexts.
> > >
> > > Considering e876ecc67db80, then I think we should add
> > > set_active_memcg_in_task() and active_memcg_in_task().
> > >
> > > or at least we need WARN_ON() if we want to place active_memcg()
> > > before the in_task() check, but this looks ugly.
> > >
> > >         memcg =3D active_memcg();
> > >         if (!in_task() && !memcg)
> > >                 return;
> > >         DEBUG_NET_WARN_ON_ONCE(!in_task() && memcg))
> >
> > You don't have to use the code as is. It is just an example. Basically =
I
> > am asking if in future someone does the following:
> >
> >         // in !in_task() context
> >         old_memcg =3D set_active_memcg(new_memcg);
> >         sk =3D sk_alloc();
> >         set_active_memcg(old_memcg);
> >
> > mem_cgroup_sk_alloc() should work and associate the sk with the
> > new_memcg.
> >
> > You can manually inline active_memcg() function to avoid multiple
> > in_task() checks like below:
>
> Will do so, thanks!

I noticed this won't work with the bpf approach as the
hook is only called for !sk_kern socket (MPTCP subflow
is sk_kern =3D=3D 1) and we need to manually copy the
memcg anyway.. so I'll use the original patch 1 in the
next version.


> >
> > void mem_cgroup_sk_alloc(struct sock *sk)
> > {
> >         struct mem_cgroup *memcg;
> >
> >         if (!mem_cgroup_sockets_enabled)
> >                 return;
> >
> >         if (!in_task()) {
> >                 memcg =3D this_cpu_read(int_active_memcg);
> >
> >                 /*
> >                  * Do not associate the sock with unrelated interrupted
> >                  * task's memcg.
> >                  */
> >                 if (!memcg)
> >                         return;
> >         } else {
> >                 memcg =3D current->active_memcg;
> >         }
> >
> >         rcu_read_lock();
> >         if (likely(!memcg))
> >                 memcg =3D mem_cgroup_from_task(current);
> >         if (mem_cgroup_is_root(memcg))
> >                 goto out;
> >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem=
_active(memcg))
> >                 goto out;
> >         if (css_tryget(&memcg->css))
> >                 sk->sk_memcg =3D memcg;
> > out:
> >         rcu_read_unlock();
> > }
> >

