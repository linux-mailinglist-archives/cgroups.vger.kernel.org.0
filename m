Return-Path: <cgroups+bounces-9010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A0B1CF7A
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 01:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A3D16AC26
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 23:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124D277C9A;
	Wed,  6 Aug 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbHqmesG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051327703E
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523659; cv=none; b=eIsy+sTMXnpCzZkwZmriy6mZMQ0E6HoILbFyVmSUkKNCOX3fL3ep5EYL1EDWsZdbIYY6mET66858mLBKWmVttbrjDXnda0V87nWqAq+yslBats9uij6HSVuV4GMlO0nOJVHSJLO1nOR7+tOBp/O7j5z6de2IwKl4WSyBYfWgVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523659; c=relaxed/simple;
	bh=tcWhGqSA7cZWpc5I4rzP0LAuqLWX8NoNnBwUWYwAA2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKh7tin/6TsDKvnWtQHQyvCBpX/zPW3pspaFu27PUthY9SKr6gN/XqVZ4TDHEwNgV3hSnzKZpvL7scOTQI7OK0TIaeHnE1H03hKzaaO4McBO1xEGb2WvRO1/FIA9TuDokXD6LZScZDhXgTyQKnwJRPmEp4qFaOUbfLHbaKVKRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbHqmesG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2403c13cac3so11511395ad.0
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754523657; x=1755128457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+V5MD6/KwNXDMRDn89IDlWGyGIpIEfb7ohjgwGr06Y=;
        b=TbHqmesGA/40B8T57HAYHzklvTIGqlbC8a8eMH4LQaHMyc5urt/JRR4p8fk1PmNFPG
         Wbd0NXLRckUeEJHOs+rIEGT/iQvLGpClaOmYZNjjD/wgmzL7PCN3vJRc6xAZj2p+8fGh
         +YMOv2DyFMDjp0BUdhL4SuNltoWVUmZWpq/1/fH72w5+x1wX6IxW6EZYL1HTpM5Z2WK9
         JUeDEWRDHB6CILf4htSmjkc8hE9LuV9K5NxS5gDHTxNdsFNUGyDXp+WWXYQm/XS9Gn5y
         3kg5EP3G16qh1//7cgcR6wz5ZgjoVuH8cACjXWYYb5OeA5oW5/JqCtu8YHZ1cTHksGG9
         0zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523657; x=1755128457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+V5MD6/KwNXDMRDn89IDlWGyGIpIEfb7ohjgwGr06Y=;
        b=GzMPEijkbgHN+X+FM0RTYrVz5QYTalK/fCU7r1OJXQ3sg/tHKCNNVMgme5u5wwItHO
         4NGHeWx5M+Xwl5ua6hUBRBiK//XdlEU+JRSDDOypYme3zki8Lh8yyRFzhIAhTebA2avr
         dsU0XCeBewimszIbBOk1HmXK8agjDY69U5Ae7ZN2NRjb/51zPlGAC4/jKjh9I4LLdvee
         DzfcZFOBxViZc6pvjpQmauOR7yn5DQxgKzqqAz1e2KuOCQh3WcGuZ/cNZBcJi5Y0WEcY
         wmq+WN3JVTPrdp2a8C3MX9EQKT3UX4FOzAdXy/48Jn9ECLvAQOC5+W4RTP+U34BF3vqT
         onbw==
X-Forwarded-Encrypted: i=1; AJvYcCVWLIPl7UldIfIhMf3HavA/PJA1PQEHvzJGtL+f4MaQ8dO4ah/wKbULt5hADw4eLIo6WVfui3Y/@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8okAmbFwqs+SQGGUkKAYaZyvlqflMOJIjimstk2wRH3Sb5n1
	fJpvROW8RYsis7k26ZYj+8BfVPJhYlY70rfVY6uAJQ8qn5oV6fxV1tpdz1bSvYQ4fWRRhxjR9i/
	i1Uu0l6wkNmuFw4ULFqtmn7xyKlQ0UKkDzCHZXcKA
X-Gm-Gg: ASbGncuriW1HsD+X4Xi7wr31WTAM+H5f7sZdoj59txgoHQBl4Fd5LMUi8AQYxkR8BG5
	iT4vInb/SjKjXshK6IHapvJ1hbSoycjF9SlnSsai5sEuUkftDr1jTooKaroQtlQRzsu15hsnMsB
	pQ9NqhYWCnyvN73v6DQ3TZKDlY7Et59yYQ/HUfMXePk26sE1VrK2YJCQqu9N2pkYrWm0/pmpeRo
	6xDjDJat4GqeLeHPgqvxHtMjfqJcppHW3os2w==
X-Google-Smtp-Source: AGHT+IE9xx0BslmXdh3PX3583hJLYwZKiRHlhcVZuar+6J/aRROEdJOAGMwU1KyNvxPLk9ne8tw/T2xezEOaTvSGSQY=
X-Received: by 2002:a17:903:28f:b0:234:325:500b with SMTP id
 d9443c01a7336-242b075c43amr21436795ad.22.1754523657123; Wed, 06 Aug 2025
 16:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com>
 <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
 <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com> <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
In-Reply-To: <chb7znbpkbsf7pftnzdzkum63gt7cajft2lqiqqfx7zol3ftre@7cdg4czr5k4j>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 Aug 2025 16:40:45 -0700
X-Gm-Features: Ac12FXyPFTWmf4LzgmzsB_A4EJ6yxnsuvE00MbfxXyp9hRdFCTtZYOCeXLJDM_E
Message-ID: <CAAVpQUB_aEcbOJR==z=KbfC1FtWi2NM_wNm_p+9vL1xqfw7cEQ@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 4:34=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, Aug 06, 2025 at 03:01:44PM -0700, Kuniyuki Iwashima wrote:
> > On Wed, Aug 6, 2025 at 2:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffie=
s + HZ);
> > > > > > +                     socket_pressure =3D jiffies + HZ;
> > > > > > +
> > > > > > +                     jiffies_diff =3D min(socket_pressure - RE=
AD_ONCE(memcg->socket_pressure), HZ);
> > > > > > +                     memcg->socket_pressure_duration +=3D jiff=
ies_to_usecs(jiffies_diff);
> > > > >
> > > > > KCSAN will complain about this. I think we can use atomic_long_ad=
d() and
> > > > > don't need the one with strict ordering.
> > > >
> > > > Assuming from atomic_ that vmpressure() could be called concurrentl=
y
> > > > for the same memcg, should we protect socket_pressure and duration
> > > > within the same lock instead of mixing WRITE/READ_ONCE() and
> > > > atomic?  Otherwise jiffies_diff could be incorrect (the error is sm=
aller
> > > > than HZ though).
> > > >
> > >
> > > Yeah good point. Also this field needs to be hierarchical. So, with l=
ock
> > > something like following is needed:
> > >
> > >         if (!spin_trylock(memcg->net_pressure_lock))
> > >                 return;
> > >
> > >         socket_pressure =3D jiffies + HZ;
> > >         diff =3D min(socket_pressure - READ_ONCE(memcg->socket_pressu=
re), HZ);
> >
> > READ_ONCE() should be unnecessary here.
> >
> > >
> > >         if (diff) {
> > >                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
> > >                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
> > >                 // OR
> > >                 // while (memcg) {
> > >                 //      memcg->sk_pressure_duration +=3D diff;
> > >                 //      memcg =3D parent_mem_cgroup(memcg);
> >
> > The parents' sk_pressure_duration is not protected by the lock
> > taken by trylock.  Maybe we need another global mutex if we want
> > the hierarchy ?
>
> We don't really need lock protection for sk_pressure_duration. The lock
> is only giving us consistent value of diff. Once we have computed the
> diff, we can add it to sk_pressure_duration of a memcg and all of its
> ancestor without lock.

Maybe I'm wrong but I was assuming two vmpressure() called
concurrently for cgroup-C and cgroup-D, and one updates
cgroup-C's duration and another updates C&D duration.

cgroup-A -> cgroup-B -> cgroup-C -> cgroup-D

Could that happen ?  Even if it's yes, we could use atomic ops.

