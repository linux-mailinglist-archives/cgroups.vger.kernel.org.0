Return-Path: <cgroups+bounces-8005-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB10AA8EDF
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8718975EC
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F71F4184;
	Mon,  5 May 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0MeWC9Vi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzjkqVyJ"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021801E1DE5;
	Mon,  5 May 2025 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435987; cv=none; b=S7hnGVIaPCSHJKwJLXrtLunaX6TBGCRDsexoX7UrNUOqZsukgeJUNRSGedD4QW8ATpllHKQKbCW7VlfP3+niHkxkKOft5LCe7k9R0UJ+HWeOrHLtf30HYDAJqdMYTrzTayWS1FtkFUf8t7cuyGLLHl+eqrcV5Q9aW2sh+kWp8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435987; c=relaxed/simple;
	bh=dwiDZndRFyLkL2brJUMP8qqJ8MGyigXi64I7ooe65Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8fP4NypiHeIrKYvY72LMkwBVPd/bCMDG0OT3HjEiZAaJChk76eqIhWYGMgQgeX+zENZ5Ohwypb36CfxcyuxZJnY+Zd7t29UnGJriOi79t5/guFg/olFiE88styJhfvKZ2ZaLDdq2ORupSgAckvl7CA7pjcHSEOO4U0fkPfkH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0MeWC9Vi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzjkqVyJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 May 2025 11:06:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746435983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU2mOFIakYu1JXvoaJZnS0pZd0tIlcvrypVKAXkNPt8=;
	b=0MeWC9VixBL+yIvcu/2Vlj+rC6XYBt0Lwwuj3lI+T3JWTk7UbRlU6/M9YpEreOhCvWu2Qs
	B88oLp/ncbGh3sUCtOPSFA/rk2AgtwtYIlEnGFFACtfQaCK2ZyZ52kjwggqe3hdfec4gjY
	5hZh3sm7VvJylzBTo0G3yBviNVhGU1QBdUcmvlM7oo22hKZzut5vZBdUHIc1MFoqvVhUVV
	s7XDBVITq0Es3ChLniEuXjqIAn/m90t6UMj/LbsZz0cxH+aSLsaRKUxpya5OzxYBEEcjGx
	BTbdld+hUlBa4WNM4q8VP23PBdjCOQpZrBkWDV8v1VExSWa1ZS+TkuDN7fJUJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746435983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU2mOFIakYu1JXvoaJZnS0pZd0tIlcvrypVKAXkNPt8=;
	b=ZzjkqVyJrEYAyTAbEVRah1Hmfig2TmjA9h3qEpX0F3TlWJQjVp6+a5ySJH8PjLF0hAfJyy
	34v9hcGVh2sJizCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
Message-ID: <20250505090617.Q6tHb1NH@linutronix.de>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev>
 <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
 <CAADnVQ+dhiuvrmTiKeGCnjDk9=4ygETJXR+E4zQr5H2MzBLBCQ@mail.gmail.com>
 <CAGj-7pXrKBr+LC_Mbj+xyud=tXpR3bCYwzOQTUgM8aSZ0qNnhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGj-7pXrKBr+LC_Mbj+xyud=tXpR3bCYwzOQTUgM8aSZ0qNnhA@mail.gmail.com>

On 2025-05-02 16:40:53 [-0700], Shakeel Butt wrote:
> On Fri, May 2, 2025 at 4:28=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > > >
> > > > I don't think it works.
> > > > When there is a normal irq and something doing regular GFP_NOWAIT
> > > > allocation gfpflags_allow_spinning() will be true and
> > > > local_lock() will reenter and complain that lock->acquired is
> > > > already set... but only with lockdep on.
> > >
> > > Yes indeed. I dropped the first patch and didn't fix this one
> > > accordingly. I think the fix can be as simple as checking for
> > > in_task() here instead of gfp_mask. That should work for both RT and
> > > non-RT kernels.
> >
> > Like:
> > if (in_task())
> >   local_lock(...);
> > else if (!local_trylock(...))
> >
> > Most of the networking runs in bh, so it will be using
> > local_trylock() path which is probably ok in !PREEMPT_RT,
> > but will cause random performance issues in PREEMP_RT,
> > since rt_spin_trylock() will be randomly failing and taking
> > slow path of charging. It's not going to cause permanent
> > nginx 3x regression :), but unlucky slowdowns will be seen.
> > A task can grab that per-cpu rt_spin_lock and preempted
> > by network processing.
>=20
> Does networking run in bh for PREEMPT_RT as well?

It does but BH is preemptible.

> I think I should get networking & RT folks opinion on this one. I will
> decouple this irq patch from the decoupling lock patches and start a
> separate discussion thread.

Sebastian

