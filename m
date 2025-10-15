Return-Path: <cgroups+bounces-10784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D2BE028B
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653B250746D
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48478338F3C;
	Wed, 15 Oct 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36T6dWCz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0230146E
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552492; cv=none; b=HjvZKDsj4N9nzgRoGt1CPdzYazCvU52qMlPa9c2fiLDffUFHs9wpZLotTU9uxxvQf09KkuNVbcZ1/IqgaR2ZfkX+hfk+liTE0u9Ef9FuwrHPpCaYrJFiuYBxkPp+29UzzbbCGhJUQBSUjNyFCD14QO5MzBd76/wfdMNDOp+Tr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552492; c=relaxed/simple;
	bh=C0nOezS2FMCaT4DVtnnr9AOurg/IbNXn/jE+p0KcmD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVSo3mLSJL8VaPQyzhjqCRBRelbe91yIZ+RTEHq5wr9B1VNUf7wyDzesxDN23PeqxaC8p40HJtru+oTXmUeiBYBbXw0CtsvbUSqKSf6TB0jq2U0ZNGEMcnBAJut5CmYxSpZCkMSuiX1qESF19/EFsk2wsKt1Gp/MlOA1JecU6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36T6dWCz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso4228203a12.0
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760552490; x=1761157290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp64OOTDMMU/j1+qMmwGSQ8xybomTCKVWDp1nxfRYIs=;
        b=36T6dWCztMeQ3knrvabAIpZUQkvh5x6KBid3Mwe2PBwVApisvODQ63vf5JDnYG7fpd
         FDxbbzOBc9ut9/rOVdtxy+1uqPibtSdxeBnqD4C99uom2SVbEsk8hYelM2JM2i51Fk0j
         RBowlr5cJo1dtpjEOR5vNiBdCzMlKJg8sd3b8KOKvz0iMPqlgdh6muim1KDlU5JnluN2
         MY4a0puuPE8gIkbJhoWJVwA/NcXj9AJQgKXQ5syU/dmRVAav6EYgIM1FbmSKQaXGoXuN
         jfF6w9zNB2E5FsXoHrdAkkKAN04HxpZxwT9GZYmH1Ncuj7lggbZUl+3U+pA6yEC2aMEx
         ClwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552490; x=1761157290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp64OOTDMMU/j1+qMmwGSQ8xybomTCKVWDp1nxfRYIs=;
        b=Op+1ygkCie7kxWZ7xnL5TYhRq9SX1yJtuHA7/W7kUDrTiUXQh8XXa63Hofxxr1Bvyq
         uu9pK9aJv0n28HcHK6nmFdzhFmnc0eZcvrf8JkX9pI6xDW7WESTSKVortXGyVwq+liru
         JlEL6y1EnL9ku0EQukB8OY1Kk5s+OODzpZsWV+itKkkZJJLt0s6IAoymph+4H+jJbPem
         c8izKkUfxqta98dIwcznYWMPcakdJOlpfUNqctXUkXLYHK9AeuTl4bWGkhWNlQUVun6L
         WqkoMm35mZFI6DEx6LRcc42LWJTIABsOKuEobYQ6Xgg+8avT/Rpzgitlrdh7xu5fb1Q8
         0Gjg==
X-Forwarded-Encrypted: i=1; AJvYcCVIezOFYSgtuS/Hf89sN8hto23pCi6i0BJXW1U002esn1OjUBddtPb2WtBiEHBLOcz/YhT4kd8q@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpyropf3bCod+RdBM2FTz8MqG+sgxhEjomo6NEnV3iZ3g2lMa
	m6Ese5wu/J2p+/MyxwAP0DXj0t9n45B9YgjtVOeG3lU9izZwcKiRLf56mmh6UUbFsW/Yp9XtRmM
	Qvp4DOoEvH9GTGSlr3n9ip4A4IL9DaasocSyLYnMT
X-Gm-Gg: ASbGnctCAf70h0enVO8a/HWAwIIAi81oO7HNT1fSpBUb6zatcub2uebgIpfb8xsf/u3
	lhykq4/vaFJG4GEII1bPwpPzCvv1AZEW9yDCuS//IsTd4eCFSWivv5RjoU+w6AkWcI4RWTWPeiY
	cMRsgHBFRQr2NUysHcLvUV6J0vxUfyP16e6YgGTmTqp2Bqy5Wm4XrozRP72PTiT3wtcuVyLobd5
	IyOGBOJyXUyhy9VOBytjJ6jMrX3pspowVk4TbvNw2Wy67nsk2JDmhchY0YEpWdwy8IhYGnH5w==
X-Google-Smtp-Source: AGHT+IFv6ZDTbnlyEa7PGKtiy3BHZqh5Atg4snl51qJOvPQs/NM5tOMV7CkHZGYdvUsd7R4gGq+3ZXyx9BwkDCSqhj0=
X-Received: by 2002:a17:902:e841:b0:273:59ef:4c30 with SMTP id
 d9443c01a7336-2902723a7ffmr425859825ad.15.1760552489053; Wed, 15 Oct 2025
 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
 <87qzvdqkyh.fsf@linux.dev> <13b5aeb6-ee0a-4b5b-a33a-e1d1d6f7f60e@cdn77.com>
 <87o6qgnl9w.fsf@linux.dev> <tr7hsmxqqwpwconofyr2a6czorimltte5zp34sp6tasept3t4j@ij7acnr6dpjp>
 <87a5205544.fsf@linux.dev> <qdblzbalf3xqohvw2az3iogevzvgn3c3k64nsmyv2hsxyhw7r4@oo7yrgsume2h>
 <875xcn526v.fsf@linux.dev> <89618dcb-7fe3-4f15-931b-17929287c323@cdn77.com> <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
In-Reply-To: <6ras4hgv32qkkbh6e6btnnwfh2xnpmoftanw4xlbfrekhskpkk@frz4uyuh64eq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 11:21:17 -0700
X-Gm-Features: AS18NWBl8DBuSyVQ5CvtXUGkTQXtnvm6oLLrRN_Q_tBNBRmemTwaIbj89yQ-PKI
Message-ID: <CAAVpQUDWKaB6jH3Ouyx35z5eUb9GKfgHS0H7ngcPEFeBdtPjRw@mail.gmail.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Oct 13, 2025 at 04:30:53PM +0200, Daniel Sedlak wrote:
> [...]
> > > > > > How about we track the actions taken by the callers of
> > > > > > mem_cgroup_sk_under_memory_pressure()? Basically if network sta=
ck
> > > > > > reduces the buffer size or whatever the other actions it may ta=
ke when
> > > > > > mem_cgroup_sk_under_memory_pressure() returns, tracking those a=
ctions
> > > > > > is what I think is needed here, at least for the debugging use-=
case.
> >
> > I am not against it, but I feel that conveying those tracked actions (o=
r how
> > to represent them) to the user will be much harder. Are there already
> > existing APIs to push this information to the user?
> >
>
> I discussed with Wei Wang and she suggested we should start tracking the
> calls to tcp_adjust_rcv_ssthresh() first. So, something like the
> following. I would like feedback frm networking folks as well:

I think we could simply put memcg_memory_event() in
mem_cgroup_sk_under_memory_pressure() when it returns
true.

Other than tcp_adjust_rcv_ssthresh(), if tcp_under_memory_pressure()
returns true, it indicates something bad will happen, failure to expand
rcvbuf and sndbuf, need to prune out-of-order queue more aggressively,
FIN deferred to a retransmitted packet.

Also, we could cover mptcp and sctp too.



>
>
> From 54bd2bf6681c1c694295646532f2a62a205ee41a Mon Sep 17 00:00:00 2001
> From: Shakeel Butt <shakeel.butt@linux.dev>
> Date: Tue, 14 Oct 2025 13:27:36 -0700
> Subject: [PATCH] memcg: track network throttling due to memcg memory pres=
sure
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 1 +
>  mm/memcontrol.c            | 2 ++
>  net/ipv4/tcp_input.c       | 5 ++++-
>  net/ipv4/tcp_output.c      | 8 ++++++--
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..5fe254813123 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -52,6 +52,7 @@ enum memcg_memory_event {
>         MEMCG_SWAP_HIGH,
>         MEMCG_SWAP_MAX,
>         MEMCG_SWAP_FAIL,
> +       MEMCG_SOCK_THROTTLED,
>         MEMCG_NR_MEMORY_EVENTS,
>  };
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..9207bba34e2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4463,6 +4463,8 @@ static void __memory_events_show(struct seq_file *m=
, atomic_long_t *events)
>                    atomic_long_read(&events[MEMCG_OOM_KILL]));
>         seq_printf(m, "oom_group_kill %lu\n",
>                    atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
> +       seq_printf(m, "sock_throttled %lu\n",
> +                  atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
>  }
>
>  static int memory_events_show(struct seq_file *m, void *v)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 31ea5af49f2d..2206968fb505 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -713,6 +713,7 @@ static void tcp_grow_window(struct sock *sk, const st=
ruct sk_buff *skb,
>                  * Adjust rcv_ssthresh according to reserved mem
>                  */
>                 tcp_adjust_rcv_ssthresh(sk);
> +               memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
>         }
>  }
>
> @@ -5764,8 +5765,10 @@ static int tcp_prune_queue(struct sock *sk, const =
struct sk_buff *in_skb)
>
>         if (!tcp_can_ingest(sk, in_skb))
>                 tcp_clamp_window(sk);
> -       else if (tcp_under_memory_pressure(sk))
> +       else if (tcp_under_memory_pressure(sk)) {
>                 tcp_adjust_rcv_ssthresh(sk);
> +               memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROTTLED);
> +       }
>
>         if (tcp_can_ingest(sk, in_skb))
>                 return 0;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index bb3576ac0ad7..8fe8d973d7ac 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3275,8 +3275,10 @@ u32 __tcp_select_window(struct sock *sk)
>         if (free_space < (full_space >> 1)) {
>                 icsk->icsk_ack.quick =3D 0;
>
> -               if (tcp_under_memory_pressure(sk))
> +               if (tcp_under_memory_pressure(sk)) {
>                         tcp_adjust_rcv_ssthresh(sk);
> +                       memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROT=
TLED);
> +               }
>
>                 /* free_space might become our new window, make sure we d=
on't
>                  * increase it due to wscale.
> @@ -3334,8 +3336,10 @@ u32 __tcp_select_window(struct sock *sk)
>         if (free_space < (full_space >> 1)) {
>                 icsk->icsk_ack.quick =3D 0;
>
> -               if (tcp_under_memory_pressure(sk))
> +               if (tcp_under_memory_pressure(sk)) {
>                         tcp_adjust_rcv_ssthresh(sk);
> +                       memcg_memory_event(sk->sk_memcg, MEMCG_SOCK_THROT=
TLED);
> +               }
>
>                 /* if free space is too low, return a zero window */
>                 if (free_space < (allowed_space >> 4) || free_space < mss=
 ||
> --
> 2.47.3
>

