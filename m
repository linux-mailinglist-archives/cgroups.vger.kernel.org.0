Return-Path: <cgroups+bounces-10310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3984B8CC51
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830471BC2649
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB222236E8;
	Sat, 20 Sep 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2+N4XCv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39762AE90
	for <cgroups@vger.kernel.org>; Sat, 20 Sep 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383689; cv=none; b=QsPjrzOfs/duQan1o9iCLxBIbViG26dcvlIFzTKexAzyQa7DCJTrCibjdJCG+xURZIkw8TqJfIywoLYFaNVyHB0OAN64a1NpexxYq/C9qkrzUFUM097fqJctrPE38pFSqfFGl5TO3Dvtnkpy+xYLWS0XBInbeURAOtFISf1pByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383689; c=relaxed/simple;
	bh=hfAsZRGtQxjHaSqZBdycaABnPajls0rryhOYAO/rtVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKcDcfo0qlX+YSE19cwhrSJsgcGx7qvFd7lFJ5vVu69izkpDLHkeu54j8OZYix3Y0FCFKtylZULzCusx4bJoVydEekWKdmrxIA/HvREZDYyAFheCFHdMqEhH43Hxf8zOi0DP+eupK/Zg00kVLTTZKVoVJ0T50NktXnkEdi3a2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2+N4XCv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso1672898f8f.1
        for <cgroups@vger.kernel.org>; Sat, 20 Sep 2025 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758383686; x=1758988486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmL4fKaZHfu9Rove6sJqAWTVy87f5w83yGb6oPzqQsA=;
        b=E2+N4XCvwiNd5ASDO6TlAyD5DmG/mn3l+j6aGgKQDWMVqUJD8wOydA6eHIR2aWr2Gf
         kc1shBe7jfkeOGLdqmt5kcBuEKm4FtrjWAl/MMy3UVCfajq7PKXqPymEcDqAYfWy2mYP
         cGqYIJ9J6+oXKmMemI9KzUi+wrBU6XyQiH6QS6OiUhcQjEsydAa8wVdGg+R+0I9UMZvA
         x52smszhOkg5lEixmVVIfcXar8kqlQgMaKF7Z2PGkMFPpXk6pQQM4sypHfa8wFGbyFj9
         +o/dEM9nS//A64Li5/wAjEcv8DxgJfENmbayqw0Mf6T1jmyQ/tR2v9qsDlbU4BcVR5Zd
         dy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383686; x=1758988486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmL4fKaZHfu9Rove6sJqAWTVy87f5w83yGb6oPzqQsA=;
        b=oIWE6rlr0HPtGD+eriJnEy4CmhAsrOVP8xqtmZ0A3ft/HBfeY22a3ybEJtApZYGCxe
         vcbEfZoWNfiSdz6YDxWU8yg4Vg180mdu2NF+V/VzNs6MGb4BCqJxAUh+uteigw13Kr20
         3q93Xare8gij6b6yZAR08l+Yt8rwr3uEz6SvvNDKqvUdQmPuOeKXAgT2at7wD9xEL5M+
         n/U0XgnVrXybPFEOrtdhvIaRTbb4M1zbKTguohwot5ISUSItqlvi45aXzLWLHjiGWWZc
         xwtkgHhtr8Ji5BOht63OP5W4osSEv4sqtRtt/fVbNeA0AJ6+rZt3Jse6CuCmM/0L+4Ec
         sV9g==
X-Forwarded-Encrypted: i=1; AJvYcCWwNTYJbBrUgrVVyCwDhKCwXltmmZKmjgLCEJaDkrAD58Hz7EpSN7VEYaL+Tm0xYOV9bv1ghaW9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KJzR+PxWq8c6FUyP8XEsBfy6pAZaJjfw5p0CPpR5/JbfkmCp
	FlyjPGMz2eYVfLyKASM/V7b3IsEWUUaEdEzYnpLrGFpGwD6pJHfsuTyxszEcazFdaXMdSR4/15d
	W0nFJ1zuJGcVSpF9ct8fMxJ1SBFgsO+I=
X-Gm-Gg: ASbGncsDbeSA0eqK7wKCFPvct0m2prupjBXdVrnwNCNcyEfiYAHKi9BoujaR54if8uN
	lCISYeuK9x4Pmxb3agSYurNwKxeEFXK9aFa/mLJ+8mskTT83Ls1HVp3DOM+GZSq/8rJqvfNK3GV
	t8WSnQY73fDfV2UXFRvSm1C3tnetgzZg1qtXsDU1t40P+g5wDC6yIrRyeKKjevaUZaQENf3R0Lc
	4Zib0S4zm51kenBvRbV4x8WO3ihw3yf1ScB
X-Google-Smtp-Source: AGHT+IGfSRPp5unU0ikqgKe6L71mc7gqY7OrcTaOXCxInbx+GrRtbs1vqbP9ZDrhOUBg5/YKgmUImu9rrpRpu5dArLE=
X-Received: by 2002:a05:6000:1789:b0:3ee:154e:4f9 with SMTP id
 ffacd0b85a97d-3ee7d0c8af1mr7055134f8f.20.1758383685795; Sat, 20 Sep 2025
 08:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
 <CAADnVQK_wvu-KBgF6dNq=F5qNk-ons-w3UenJNaew6h9qTBpGw@mail.gmail.com> <eba3aiglp2hmj65sd4vsmav26o45orrlog2ifexd44yovygcdg@43wfk6dbgqda>
In-Reply-To: <eba3aiglp2hmj65sd4vsmav26o45orrlog2ifexd44yovygcdg@43wfk6dbgqda>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 08:54:34 -0700
X-Gm-Features: AS18NWC4-3QCvE4i9hUGZd-7Pyusy_D5tB_ZRka07Www2wvdZZcy7N-fgfJJ47M
Message-ID: <CAADnVQJF-JodmrfqJzwfpaK1wjmo6-4_R-cdUfu9ZFN52zxEsA@mail.gmail.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:31=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Sep 19, 2025 at 07:47:57PM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 7:49=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > > +
> > > +static DEFINE_PER_CPU(struct defer_memcg_events, postpone_events) =
=3D {
> > > +       .memcg_llist =3D LLIST_HEAD_INIT(memcg_llist),
> > > +       .work =3D IRQ_WORK_INIT(process_deferred_events),
> > > +};
> >
> > Why all these per cpu stuff ? I don't understand what it helps with.
> > To have max_events per-cpu?
> > Just one global llist and irq_work will do just fine.
> > and global max_events too.
>
> Right, global llist and irq_work will work but max_events has to be
> per-memcg. In addition we will need llist_node per-memcg and I think we
> will need to do a similar cmpxchg trick I did in css_rstat_updated() to
> eliminate the potential race of llist_node of a given memcg i.e.
> multiple CPUs trying to add llist_node of a memcg to the global llist.

ohh. that cmpxchg is quite unusual. Never seen anything like that.
I'm not convinced it's correct either.
I would replace that with traditional:
if (!atomic_xchg(&c->enqueued, 1))
   if (llist_add(&c->llnode, &global_llist))
     irq_work_queue(&global_irq_work);

and use traditional dequeue:

nodes =3D llist_del_all(&global_llist);
for_each(nodes) {
  memcg_memory_event(c, MEMCG_MAX);
  atomic_set(&c->enqueued, 0);
}

since llist_del_first_init() is slower.

max_events still looks unnecessary to me.

> This can work but I am still debating if this additional complexity is
> worth it as compared to the original patch where we skip
> cgroup_file_notify() for !allow_spinning condition.

I would skip it too. deferral doesn't seem necessary.

