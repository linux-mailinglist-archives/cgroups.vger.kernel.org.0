Return-Path: <cgroups+bounces-9843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1E3B509E2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 02:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314CE4451F3
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3C86340;
	Wed, 10 Sep 2025 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE0Fe/1v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C631D384
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464030; cv=none; b=MtM5SXM3An3ABFs7Byvk84gB35iTDqxdZ/h/UPXIsl8psbTtTRNOzVptGzqkkyYUcOlzy9rvVjx2btm9Bqjh8S6whtk2XrCi3ZEczHkPFjwkGoOPfB+yC0A0T11uBkeX2yU4W0tZCP5N0HfzU1VDss2YDOqglEcUlbbw0pLDOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464030; c=relaxed/simple;
	bh=GXXS6Yp6FuJ7Gx5+BIIsDkHLY0iBFugbjimeY8S4Bn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plqJi/cFM68g5zdY3szBupgRowYlGsb089qjMS0Ftwyk62yQfe17h28jd16HpgmBCRauo61IVj8dT3cGtgxeuDu5Q6gsU+WygY4Qmj4jzc1MySKuqrm9e/3OkJmrXLt+4mSTlzkKeEU+byeCWF4L0urjLYUrYF6iNYgdTgXW+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE0Fe/1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40AAC4CEFA
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 00:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757464029;
	bh=GXXS6Yp6FuJ7Gx5+BIIsDkHLY0iBFugbjimeY8S4Bn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nE0Fe/1vh6ownMVPPwkt+ywOvxdriVg3oAq2Uckyofgj4I2jk1xWBxlkWEaS80V0D
	 VZX0ZKAmC8Ei8eIclXUcwhZIAA71IvWUrM0QLVwriCBt5A7ApE7SFLPGyN2jegkACN
	 I7gBMNoeLxGHL+PEjNjeOhrF6AA+Ik2hhfIomWmNi2nu0iwGegcZ7op0fBawUpr2wv
	 Oo7InFIiOW2oHfXxeJpxzVI0UqeUoCSYdVz1NYtvPUfPqWE8hJp/8c0bO3Hu6FQ4Et
	 JsJ4qaS6N3iiU5/LfNmB+k2mG8/XbYg2sVCA0pp+fK3kQVnfYGq2n+V9d4B5A2r3wx
	 dLq0fifbG4OVQ==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so16365e9.1
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 17:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfhMlyz92ih2lcu+Hd/LxEb84+351mU7vtpUbBIMhiS5/nu+w8rK1ozszFXcWBoV1P/NLyDEoq@vger.kernel.org
X-Gm-Message-State: AOJu0YwPV5cJqoVyKWT9IxKwEUJ7uaN/hb8eQzmShJJuJflhQwabPM27
	LucJo/qCIK8L13m8SDav4LWoCMuhTTGyAICuuEv07BXPjTAjkIbH2RHfdMXe1kg5xlh9pFgBKmN
	rUYZQHnLl/b+UyxICv2ygvuitmpgV/CKR/APpYlyq
X-Google-Smtp-Source: AGHT+IEjO5KjVXeuirkJYchCdqjel2eUtWLp8SGydR4OerzOF+GrTMIJyccx5AMwbYmmZQutwhButD5dIBxqgYdkJ80=
X-Received: by 2002:a05:600c:a31a:b0:45c:b678:296 with SMTP id
 5b1f17b1804b1-45df82112e9mr295135e9.5.1757464028354; Tue, 09 Sep 2025
 17:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330> <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <aLqDkpGr4psGFOcF@yjaykim-PowerEdge-T330> <CAF8kJuPuOWUEMg6C9AnAA-mddgHRjuMVqURrbk6bUHxAmEvgFQ@mail.gmail.com>
 <CAF8kJuNW2kmxKYRE9t8WvSOad9JkLYt0WSAcFOQ9r9=2=XGc9Q@mail.gmail.com> <aL3GHJJ6+elPD7OP@yjaykim-PowerEdge-T330>
In-Reply-To: <aL3GHJJ6+elPD7OP@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 17:26:57 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPj6-gZ4H+VQtJpJj_MutTgTcR-9BfDQnweayOrXk-NCQ@mail.gmail.com>
X-Gm-Features: AS18NWAzRhK6Sza7aFhZ16A-JN0ICbt6KESSJLX5RLfWjX7iQZOSQJtZI6HXM48
Message-ID: <CAF8kJuPj6-gZ4H+VQtJpJj_MutTgTcR-9BfDQnweayOrXk-NCQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: YoungJun Park <youngjun.park@lge.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 10:51=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> > On Fri, Sep 5, 2025 at 4:45=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> > > >   - Mask computation: precompute at interface write-time vs runtime
> > > >     recomputation. (TBD; preference?)
> > >
> > > Let's start with runtime. We can have a runtime and cached with
> > > generation numbers on the toplevel. Any change will reset the top
> > > level general number then the next lookup will drop the cache value
> > > and re-evaluate.
> >
> > Scratch that cache value idea. I found the run time evaluation can be
> > very simple and elegant.
> > Each memcg just needs to store the tier onoff value for the local
> > swap.tiers operation. Also a mask to indicate which of those tiers
> > present.
> > e.g. bits 0-1: default, on bit 0 and off bit 1
> >        bits 2-3: zswap, on bit 2 and off bit3
> >        bits 4-6: first custom tier
> >        ...
> >
> > The evaluation of the current tier "memcg" to the parent with the
> > default tier shortcut can be:
> >
> >         onoff =3D memcg->tiers_onoff;
> >         mask =3D memcg->tiers_mask;
> >
> >         for (p =3D memcg->parent; p && !has_default(onoff); p =3D p->pa=
rent) {
> >                 merge =3D mask | p->tiers_mask;
> >                 new =3D merge ^ mask;
> >                 onoff |=3D p->tiers_onoff & new;
> >                 mask =3D merge;
> >         }
> >         if (onoff & DEFAULT_OFF) {
> >                 // default off, look for the on tiers to turn on
> >         } else {
> >                 // default on, look for the off tiers to turn off
> >         }
> >
> > It is an all bit operation that does not need caching at all. This can
> > take advantage of the short cut of the default tier. If the default
> > tier overwrite exists, no need to search the parent further.
> >
> > Chris
> >
>
> Hi Chris,
>
> Thanks a lot for the clear code and explanation.
>
> I=E2=80=99ll proceed with the runtime evaluation approach you suggested.
> I was initially leaning toward precomputing at write-time since (1)
> cgroup depth is might be deep, and (2) swap I/O paths are far more freque=
nt than config

Cgroup depth is typically not deep. Might have a lot of top level
cgroups. That is the more common setup I am family with. If you know
other usage cases contradicting that please let me know.

We can turn this into a LPC discussion question to ask the audience as well=
.

> writes. Is your preference for runtime for implementation simpleness?
> (Any other reasons I don't know?)

Oh, I think it provides the most flexibility with minimal code
complexity. It is kind of the best world. If the child overrides the
default value with leading "-/+" without tiername. It will trigger the
shortcut path and no need to look up the parent.

However, if the child has a default empty "swap.tiers" file, change to
the parent will impact every child cgroup. We can have it both ways
with what I consider pretty minimal code. That is actually the most
common usage case. K8s pods would change from the top level.

It is a good trade off in terms of ROI from complexity vs feature
flexibility point of view.

BTW, the "swap.tiers" file should require root or some kind of CAPS so
non root users can't write to it by themselves. Otherwise they can
abuse their own setting thus rendering the QoS aspect not effective to
other cgroups.

Chris

