Return-Path: <cgroups+bounces-7281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE54A77F75
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6043AF2C8
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250E20AF88;
	Tue,  1 Apr 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DViVJupI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F81A5BB0;
	Tue,  1 Apr 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522418; cv=none; b=oEddDURBk1mrq79R37phxX2Sg9XSeg1vD2cBnKkWiC2ufVdV58fZcHZclxG7eG3D7kIlA1iTWeO3XIQgn8zv73owRpG9tUn9pDn/8PFYDq6JKmbsk1yrrwg7vR5w7C1vaVeEmrhfGw9dp2VsbiAdowK/d3H0HhuszjF1nBV4Xaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522418; c=relaxed/simple;
	bh=2exn8/g/zCy7m9Fb6N5nhJsO1TkWXtqg+gMexa3uIWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8uWIua7221BU0ObwOdQWzwKN+Lf2q3g1tEXxiOZt/zhWMBlAxU36fIBMBE7tX2U6dxwvnIOyXdA+gcidV4CszfCWxxasdNDuBhKyjEnQOqZVQIuJT0r+fS07rUO5CvUL9l7UTVe+BhDsVJ4+IP2ZVrCeC974PjzguhbsMQOJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DViVJupI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso48276866b.0;
        Tue, 01 Apr 2025 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743522415; x=1744127215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2exn8/g/zCy7m9Fb6N5nhJsO1TkWXtqg+gMexa3uIWs=;
        b=DViVJupI0U5IGEgDbY2k9OfWib+52x26vgkGK4cC2BEZOT46gbVjzZiv8BkqO3akDs
         VHGJvOyLxpk97ZCxuu76kYNEyHHjeNGt0XLzOqnBAcG5VrnoCjtq/I1U2er/izK4cDMS
         jHQB+selQBpNszJ3Wjp6tuUS0L+5MRDN0nqvDC8NwcuD86OJwZicxk2qsP1RJkvjipyr
         1MhjW4+MYZfQWI5ZlDrXeg2is6TUKMisY1kuM+rHt6GlpOO8hK/P/5ojwDv30US8FTc+
         FCy7xwumQSCVyXcVo1EhkpsquB1lmvzrpMPG0fTv8KzHMo2bpOSLcwaGAPpnCG0G+ID8
         hSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743522415; x=1744127215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2exn8/g/zCy7m9Fb6N5nhJsO1TkWXtqg+gMexa3uIWs=;
        b=o6uXBPDfMjBSATOVmD9QCUknw8j/ESK5BYVnZLak/zgiA5fWFJWNunk44wc4lnovcT
         AYqRqcZwBgU4zbFav/WDPa1VSUypncblx7ugf/c8C9neJfRValOvaQn+bZVuzyP9S2EE
         zFjo2iiUKffuXgOSIGb8kBp/ldc1GlH0UaHim3qD04XLdWmDFx6W3Fnj0QCIWKmhzkyc
         D01ZPaJSvSTsA0fEylQniIPhNB2Mam1xU8NByJBaRXlau8Q/YmGwYKkovJJ/h9ekFLoZ
         AzBVEYTBPojADfRCuV3jj6sZ5FVjKDqLciTYqob0LzvLbGbZSeKsDkBc0xhT1RNKr4mJ
         vYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnl1rrsMcgcmnIIzPDrmC3kWCP0/G5y3qtePdot2jJr+zsE+DciMx45CZA7Id3dPyXa2pQ20CrZMrsJAPy@vger.kernel.org, AJvYcCWwA4PIrH3Zln/WnkxCMfyvoTDHTeSf5qFOoGXiZdb8WhaVrgrg3S3oYxk4v7JcOEwYBtzyCDmr@vger.kernel.org
X-Gm-Message-State: AOJu0YyND7+9310177AVHQJX2UpicapMzPK7REFEUUGAytKRlxveSNr/
	/G6Ax/daHiT+uJ8PxWCbmH+vPcM/UHPGXNzgzyTb5zZl/EkaoHpPzol6sj3QbQi6HRvzDFrI1NU
	1YlmafeiowMOJDAdGsEq35QxuFP0=
X-Gm-Gg: ASbGncvUHLsPxBACii10yNbSO/4FhR+ohlpoFcrDbuO/Y+wN+ci9O9QrQSQy1WaivaP
	UG6B0uCx1SKZuWDPyMktmvuzUIXKvuSbgjcGW1LpZcMlQnm/y3P3jLHslszLaaF66yvTYjL0p/U
	/RKCzdodIDiN/Rhf6Dq2uVGUuo
X-Google-Smtp-Source: AGHT+IGSXvxdUrXZ2lnN0iPLAZDup7IGf6ZivA21FcXJjLnKJZtugd48GzBDlIr8iWl2CmynQ0cCnPmD28rAQZoUcj8=
X-Received: by 2002:a17:906:6a22:b0:ac2:88df:6a5b with SMTP id
 a640c23a62f3a-ac738bacaffmr1205063266b.42.1743522414446; Tue, 01 Apr 2025
 08:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319071330.898763-1-gthelen@google.com> <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com> <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
 <Z-WIDWP1o4g-N5mg@google.com> <CAGudoHHgMOQuvi5SJwNQ58XB=tDasy_-5SULPykWXOca6b=sDQ@mail.gmail.com>
 <3mc7l6otsn4ufmyaiuqgpf64rfcukilgpjainslniwid6ajqm7@ltxbi5qennh7>
In-Reply-To: <3mc7l6otsn4ufmyaiuqgpf64rfcukilgpjainslniwid6ajqm7@ltxbi5qennh7>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 1 Apr 2025 17:46:41 +0200
X-Gm-Features: AQ5f1JroPhysgzd0ze9vsDBMoC1N2D5djQFkh-AXd9efTKxzlVR50N1KCOUO7dA
Message-ID: <CAGudoHEF+dZmkoOJ2O_iaNEo5pR=BAbmYU8zuzKnfXcdKysj3A@mail.gmail.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:00=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
> On Thu, Mar 27, 2025 at 06:47:56PM +0100, Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > I feel compelled to note atomics on x86-64 were expensive for as long
> > as the architecture was around so I'm confused what's up with the
> > resistance to the notion that they remain costly even with modern
> > uarchs. If anything, imo claims that they are cheap require strong
> > evidence.
>
> I don't there's strong resistance, your measurements show that it's not
> negligible under given conditions.
>
> The question is -- how much benefit would flushers have in practice with
> coalesced unlock-locks. There is the approach now with releasing for
> each CPU that is simple and benefits latency of irq dependants.
>

Toggling every n cpus instead of every single time is trivial to do.

I'm trying to avoid sending a patch in hopes of not getting CC'ed for
unrelated stuff later.

> If you see practical issues with the limited throughputs of stat readers
> (or flushers in general) because of this, please send a patch for
> discussion that resolves it while preserving (some of) the irq freedom.
>

This is some background maintenance work and it should do what's
feasible to not eat CPU.

The stock loop was behaving poorly in face of a high CPU count and it
makes excellent sense make it toggle the lock in *some* capacity.

I just don't believe going from 400+ CPUs straight to literally 1
every time is warranted. It seems the author felt justified with the
notion that it does not add overhead on contemporary hardware, but per
your own e-mail I demonstrated this does not hold.

Is this really going to suffer for toggling every 8 CPUs? that's a 50x
factor reduction

I would not be mailing here if the change was hard to do, but it
really is not. it's literally a counter in a loop getting checked.

> Also there is ongoing work of splitting up flushing per controller --
> I'd like to see whether the given locks become "small" enough to require
> no _irq exclusion at all during flushing.

the temp changes like the to stay for a long time.

tl;dr I don't believe going straight from 400 to 1 was properly
justified and I demonstrated how it hurts on a rather modest box. at
the same time a (likely) more than enough improvement over the stock
state can be trivially achieved while adding only a small fraction of
the overhead.

that said, there is bigger fish to fry elsewhere and I have no stake
in this code, so I'm not going to mail any further about this.
--=20
Mateusz Guzik <mjguzik gmail.com>

