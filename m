Return-Path: <cgroups+bounces-8873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2733CB0E5F2
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457691726B4
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 22:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB2286412;
	Tue, 22 Jul 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYQzBHNv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBD2868BD
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221587; cv=none; b=MxYvol0IiD317CGhBLeSktqWwvuC4uvMaLlqoa9gWfFa2d2APQKPJVXMdGxYvROJWrt3h6EQcOblTFo60LOjig7GSXRIoQCrkLfvdhBmFUCgih/ANZqKLizSeCJ8WWiZZ1Cb88AgKgoU6IGO5Eh+bBsI3dlDusOlrz3dosMBJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221587; c=relaxed/simple;
	bh=YoMww1yB9xL7737rRls4KAJNoyTQPq+obet9oG8SrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olPYjYPzJoYCHd/oPEv8ubJBxxf+jYRimNoxzP2MZTSlAeBrfrmkDtvSXy4XVLlmg9qVMrh2cSQHoxuxQkJNNtdw1+Wu7r7OhqYVWtR+pEbxnKFwZrs8sWiw1ARTGt2zj+A90ugDQ6jqOHYGchSwmG7vMpb9AAhTTvCMx4fsLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYQzBHNv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31e076f714so258863a12.0
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221585; x=1753826385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LldVhMiyy8Uo7zeXym650NXpGCC96+eEkfNEoQyfQ7Q=;
        b=JYQzBHNvOBqbeCLLAs9bsTUKmWsjF8oop3r9ClFJJvUIttDfXTSKF4g9XYzfo8Uk8M
         gJdU+dmNuC0C5Bji4p1fQg+zxhkSmcP7TIm87rRpt+dPRu/M1VcH+99F9FkJhzNX2Spe
         NpmyL8pLdhfByVGaM40YKUv5e5OpAKZ7FwlP+dv75vM2tx5TGXrmTvQW97l+VpKI7d32
         yeJTrWIQxCjrWXGVe5RWsK620xqveYDVnb2I4b4ml8amfA/aD19pJhJ0CgrazkgqYBts
         MeBntAx1apR327GRTGcELa2K1a8tGmjCKaSXSvBLvP1yX4GCYSG6Ulg/PrSt5tvvNFx6
         7ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221585; x=1753826385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LldVhMiyy8Uo7zeXym650NXpGCC96+eEkfNEoQyfQ7Q=;
        b=R7oUz/gdAPrLKM5IZVMxM4XFbZ8SKkA00J0NI12HFCUC4THFVB5NKzhT1KsPlT0k50
         dN4hEvQ1oeoIsVTk52u6LWvHFGo5cIFV1V7NBZk9AURuh6//bXLVdvF9QiptvNI1FkD/
         qUE/25ok5aGkco7j/lxvVd/tO0Z0TzVS7SdVuWsxQsk1c5mHfC9K0Ry1UB07/p5HxMCW
         dp7NF+on0TC0MvjYdbstnFRu7dvyQ3UkB7w1P0HwMFP1OhoHfPTu9qKsC5dlXlyRQ0h+
         W49UqOg9AsWFJ2UBGpWWKsPVVQFzMP0JDjmAJijc/Q7VL6Oo9MsCxkBFU2zbMpkpjAke
         PWhg==
X-Forwarded-Encrypted: i=1; AJvYcCVftr2RXNKQr/gH1iEJmw6MQE/hHs7/a3FqIatJq0dIdztbDyDO4I41WIfBPUUinkn3GMjaeHKh@vger.kernel.org
X-Gm-Message-State: AOJu0Yya427AqYrxhy7XR98dpJjVF872aqyVFt2Rlf2AWYjrd/f4XCAG
	4Vg+f3DgCRIrjewCe+aDslRWFZz9HM6tYm8J9VTJ4fxKbwfPzjBTH0UfmbVMnPFC13GaE4GGbru
	GDjqNexHsLiYMSQSGexyVjua9pX1cxswArBHkDWhV
X-Gm-Gg: ASbGncuP+ChOi0biTRqimNLORm5oI/RxL53ow6ru9VWvOw+A4LZ1YXrznOR4Brj/38i
	U69RsadVpK5z5ArAMQDRrl/IQhR0Xc+1K0hJz0/G6WmNvkjP3fVUJnIf4lpC3tG0HbsOKhRKjii
	jZbS+zehxhpIEXkFusNjabhbzQoxW77CXoJFbY9XwLK0n0N1pu6/cAMlrCI1V8rFoWzsZ8JXPZe
	dqiUHMb6cPbugynLYPGId7Z61mFR2yoC25Gow==
X-Google-Smtp-Source: AGHT+IFnCzaQCuLRDF3T0KDY0acjrNgQBMDeia5n8p9ebzIE1pRoGMSM83/YyDyRP/0W/eit+e8D1RvW/dQ4YjOCLbk=
X-Received: by 2002:a17:90b:4c4f:b0:313:d7ec:b7b7 with SMTP id
 98e67ed59e1d1-31e3e1f0b58mr7413618a91.13.1753221584666; Tue, 22 Jul 2025
 14:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com> <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
In-Reply-To: <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 14:59:33 -0700
X-Gm-Features: Ac12FXzmS2q9uiW4v2Mh3ddunncGvq7rXqTatxuc1vnyDKWf2gVdVrW60Nf_-Q8
Message-ID: <CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:56=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 12:03:48PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 11:48=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > > > >
> > > > > I expect this state of jobs with different network accounting con=
fig
> > > > > running concurrently is temporary while the migrationg from one t=
o other
> > > > > is happening. Please correct me if I am wrong.
> > > >
> > > > We need to migrate workload gradually and the system-wide config
> > > > does not work at all.  AFAIU, there are already years of effort spe=
nt
> > > > on the migration but it's not yet completed at Google.  So, I don't=
 think
> > > > the need is temporary.
> > > >
> > >
> > > From what I remembered shared borg had completely moved to memcg
> > > accounting of network memory (with sys container as an exception) yea=
rs
> > > ago. Did something change there?
> >
> > AFAICS, there are some workloads that opted out from memcg and
> > consumed too much tcp memory due to tcp_mem=3DUINT_MAX, triggering
> > OOM and disrupting other workloads.
> >
>
> What were the reasons behind opting out? We should fix those
> instead of a permanent opt-out option.
>
> > >
> > > > >
> > > > > My main concern with the memcg knob is that it is permanent and i=
t
> > > > > requires a hierarchical semantics. No need to add a permanent int=
erface
> > > > > for a temporary need and I don't see a clear hierarchical semanti=
c for
> > > > > this interface.
> > > >
> > > > I don't see merits of having hierarchical semantics for this knob.
> > > > Regardless of this knob, hierarchical semantics is guaranteed
> > > > by other knobs.  I think such semantics for this knob just complica=
tes
> > > > the code with no gain.
> > > >
> > >
> > > Cgroup interfaces are hierarchical and we want to keep it that way.
> > > Putting non-hierarchical interfaces just makes configuration and setu=
p
> > > hard to reason about.
> >
> > Actually, I tried that way in the initial draft version, but even if th=
e
> > parent's knob is 1 and child one is 0, a harmful scenario didn't come
> > to my mind.
> >
>
> It is not just about harmful scenario but more about clear semantics.
> Check memory.zswap.writeback semantics.

zswap checks all parent cgroups when evaluating the knob, but
this is not an option for the networking fast path as we cannot
check them for every skb, which will degrade the performance.

Also, we don't track which sockets were created with the knob
enabled and how many such sockets are still left under the cgroup,
there is no way to keep options consistent throughout the hierarchy
and no need to try hard to make the option pretend to be consistent
if there's no real issue.


>
> >
> > >
> > > >
> > > > >
> > > > > I am wondering if alternative approches for per-workload settings=
 are
> > > > > explore starting with BPF.
> > > > >
> > >
> > > Any response on the above? Any alternative approaches explored?
> >
> > Do you mean flagging each socket by BPF at cgroup hook ?
>
> Not sure. Will it not be very similar to your current approach? Each
> socket is associated with a memcg and the at the place where you need to
> check which accounting method to use, just check that memcg setting in
> bpf and you can cache the result in socket as well.

The socket pointer is not writable by default, thus we need to add
a bpf helper or kfunc just for flipping a single bit.  As said, this is
overkill, and per-memcg knob is much simpler.


>
> >
> > I think it's overkill and we don't need such finer granularity.
> >
> > Also it sounds way too hacky to use BPF to correct the weird
> > behaviour from day0.
>
> What weird behavior? Two accounting mechanisms. Yes I agree but memcgs
> with different accounting mechanisms concurrently is also weird.

Not that weird given the root cgroup does not allocate sk->sk_memcg
and are subject to the global tcp memory accounting.  We already have
a mixed set of memcgs.

Also, not every cgroup sets memory limits.  systemd puts some
processes to a non-root cgroup by default without setting memory.max.
In such a case we definitely want the global memory accounting to take
place.

Having to set memory.max to every non-root cgroup is less flexible
and too restricted.

