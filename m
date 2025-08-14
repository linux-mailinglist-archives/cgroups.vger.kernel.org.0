Return-Path: <cgroups+bounces-9192-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCEB272FF
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 01:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B714724D65
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357742877DE;
	Thu, 14 Aug 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JizPdMIT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BC28751D
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214066; cv=none; b=QuGJVfx1sAosNRwiUGGqpX+RGBtWbW78T9s36sJeqot5zIEm7ghx95Wpg3UPMUzMjARy+Asymof0mtxLwfUU8o9QciSOttNZhzH0Gu5DeLO4WavNgZLyeYWbKFpOhUujeg6rAAbWIR8Bn3ac5pJ3yCoFV0w2vGCkb0OXZIca1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214066; c=relaxed/simple;
	bh=cNrWzSWBbJ3DFgnD1h7xjqM4iq2jyeXReFXRG/RQUaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ0ByWSP7pk49rjwwX+ehWBSwU6Qgmc+QBGYi9esjskFjD9fzh+fTMV1X3JFe1PSuf8WjQnd3fifJE3xolbPaKThNCirT1zWYDsYs+JEjmx836+xyDweJfE16nyw/NYLs4KU6zPQazCqpi3qhlYeoAf1GW42BtDnPsS+h5QVuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JizPdMIT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b471738daabso1250328a12.1
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755214064; x=1755818864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJte4ardeN85Du6oFLbjV2pOyfXJ8yitINHiZm+Srao=;
        b=JizPdMIT+6XOlf//YLPQYOlcvMl1k4I+ulREEiAKA0rHAnIl5PKx72NibPNVUfGK/D
         kMNoY75AZhztWAqv1lZg8a2DuliQX0tEV2kOl0yYeOsqYn3FNLvwHttf5ixTed+0GUPc
         Is5b4FDeFlmxoUcd6rur/Fd6krmig2sXc4VQ9YhRKKr0FBeRm5xwFUB0WMujCuKwcsLh
         BT/zo+5hOcuGke2VNicTHc9yxIFOvlHR2QGP75ZwxnqIp+SSCHK96OVhD8wB05eApesQ
         6b9oD/nflbK24Myj6n+C7/mnL6lbprw/O/ZmG2WL1+jbli2UccRheoVPBIO3YSAhy43G
         owrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755214064; x=1755818864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJte4ardeN85Du6oFLbjV2pOyfXJ8yitINHiZm+Srao=;
        b=dr6aD8lPQECtKNmiTkLTdAdoEdkjJOp0F5esNzncYbCn4ddyT7iLuscVqQEJwTpnPr
         gsaLUm+r1GeFi+iaXuOcOlOKG9pfQ8wTUnDZWofwJwuXeUOYuRWA4+T/OlRzy2IloXlg
         TuE2xxPN8XOj5HgjncEx5G1wRWUnIc9kix5HDFuJ+QRaFlg3hhyDhhRZBy/PR5Oa9/hk
         mdDm7cPdMZzwyLu3dFwb675gLHcgU91uhUXdCsv4+IvqInaNktiQrv3/wVHFRlrZ/TRl
         6WzlYEdsf+9qemJlc2sDqEqgHQyK1Xa6/ItG846gQ3qH/Im4mrYdCY7Rv8Y60PEk+rVX
         m4QA==
X-Forwarded-Encrypted: i=1; AJvYcCWMG3jgZVK4wWUfLKJ+ispm34ap+bdKXQ9gHZI+Zfy+gSaiJxvhpLO2iO69UI8X0fOxMdn5c6T5@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpAmEDkNqwUXZpBt0rJVwmGsn+a3Mh3xg/9baFyyLsZr5nghv
	tNsHHG2zs+Iu0gYzf/Pf1aFDZgA2dDy7wg+Gx72FAAs0XlYQOgPnpF1DUcfxL7EboOnAFWWY/xc
	iehbNKpvVY2ChXqXksyCSr5yMTsxHJ+yDlAUAPzzl
X-Gm-Gg: ASbGncvuxlhm4dXp7OK3cvsOqtig05QDGuceUPsc71cYV+ZSsJVK3X7jzpKwo3oIjqQ
	3Alu1V8k4cC3ZwWU/F++5aJfFq21J9RLu4n2uhYZUkN4fD9OrhrS/72cpNZIMxOcbZxm/REKl4n
	vO+Fezx3vJt32sQWy/FkXMc4/LeeMZ3rhgOsxPnZVLASN6ho70j+n8z9He/TrBw2AwxVxm6yIeA
	WchOeJdftHCgcpmOE5RBVSwoJHarur9Np5HGH/9giF/1Q==
X-Google-Smtp-Source: AGHT+IEHit+6v/zQOrDIYEMP+S59QKYaphBAhA88+cWD0rCmrcxwlIgGARBzu1jGkGqvO/cZmUpqkxnAjxS8w/4Lc8g=
X-Received: by 2002:a17:902:e78e:b0:235:f078:4746 with SMTP id
 d9443c01a7336-244586dbef9mr70544725ad.42.1755214063557; Thu, 14 Aug 2025
 16:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
In-Reply-To: <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 16:27:31 -0700
X-Gm-Features: Ac12FXwI-hCJioucwxG326FRr7yD4nkwLO0ruxEaSqR9_-vI1XwEMNZdtXGsZVw
Message-ID: <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 08:08:33PM +0000, Kuniyuki Iwashima wrote:
> > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > sk->sk_memcg based on the current task.
> >
> > MPTCP subflow socket creation is triggered from userspace or
> > an in-kernel worker.
> >
> > In the latter case, sk->sk_memcg is not what we want.  So, we fix
> > it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> >
> > Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> > under #ifdef CONFIG_SOCK_CGROUP_DATA.
> >
> > The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> > CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> > correctly.
> >
> > Let's wrap sock_create_kern() for subflow with set_active_memcg()
> > using the parent sk->sk_memcg.
> >
> > Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> > Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  mm/memcontrol.c     |  5 ++++-
> >  net/mptcp/subflow.c | 11 +++--------
> >  2 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8dd7fbed5a94..450862e7fd7a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
> >       if (!in_task())
> >               return;
> >
> > +     memcg =3D current->active_memcg;
> > +
>
> Use active_memcg() instead of current->active_memcg and do before the
> !in_task() check.

Why not reuse the !in_task() check here ?
We never use int_active_memcg for socket and also
know int_active_memcg is always NULL here.


>
> Basically something like following:
>
>         memcg =3D active_memcg();
>         /* Do not associate the sock with unrelated interrupted task's me=
mcg. */
>         if (!in_task() && !memcg)
>                 return;

