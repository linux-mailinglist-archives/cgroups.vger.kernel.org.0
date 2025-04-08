Return-Path: <cgroups+bounces-7427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E327A80FDA
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74AC4A47EB
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508DF2253B2;
	Tue,  8 Apr 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeOWHrus"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B81E1C1F;
	Tue,  8 Apr 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125664; cv=none; b=gfVU8mwdADDppNPnIvCiLJ2/a4seOkb3RktUN3bV5SPnoDDQtMaCQPMj2Mc4lCZI6pC0dBwmRSXRkqzE5pz6ZFZLpmYjJO/MOE2p5waDGchPe8nL39k/3+cfZa1xmdZ764Mn7SBWoiATrkbbunIcBg/LurVfsKX/PhZCjGUrKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125664; c=relaxed/simple;
	bh=BjrH2CVJhKWvS2ppzqRbScIuFc7QlVq8GFZa31rH4s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6EP0Pl7QalGCNyYX33fEYzz0XDOONTgdGvuzNj5t7fGsktOcnbjq6vxXj80NCFr0Jg7SahWQXiDPur8/YeOS3UBTqgzjBQrWpBAqNgw2PaOfo9OnUc6u+BJ2jkUoVnJkJ+aDchQuBpGs2IQMmweTQ4HbdCUM+Wsv7EIAQUE05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeOWHrus; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so27646356d6.2;
        Tue, 08 Apr 2025 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125661; x=1744730461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey6nWCXg+L3TPWpZ7z3kTJsMGtn+HxgT/Jr3SmGd3uk=;
        b=QeOWHruszbZ6suu8EyaQt8uMz/BYYLohgt7HvSBX4t+RpbbtkhX9ElLKh3rOM19Kzq
         cO2n0ZcRLMaNgX66V01LQ+NewDEHombMEUH8Z+sy5kuPdSYd8n0SY2rQ1e3vLlZkwSvb
         wsZ5Rb/RvFu5QedwDRhC8wLI9rVu59rgOeHQgvFgY6q+Ud8jpQTIiNwKV3Io5bH/9lIC
         TzrvNzuDJ1qZeNdNhMlc51xm7ZB9I8p0wVIDvhGfD3Hk9uJeP7HS54ftSmeONhV6U3zL
         Kirb7m40Kn0Vy3L2VVsJvHUW5Ut0O+wzf/a5EXRzt3LgGFDlwX2sQ5COiYeY53yVML8i
         p2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125661; x=1744730461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey6nWCXg+L3TPWpZ7z3kTJsMGtn+HxgT/Jr3SmGd3uk=;
        b=cEL5OkPTxb2zfDlexHg3gzMvuHkyKVzwepMsA/T469KjHNnwfM2hMrtlFGU5I1styS
         gmvzD+bnIb+Obu1ZCmzNxXGkhgn3OvUM4SjJTGRx9zVBMmW7U5/KrJlRitGEJoZJmTgh
         t5ZVTtHEM7fMZqTAxfUm5ifZIf3dzqyUVBh2CYV0nVapSUW75frxI4IsVo79B8NKhDTd
         VsX64idZZ5jLul/YfaKgvBgeiYIILaYBqdt228gnrxWoZNGxfqyeaAVUsrdj3sxKD7cv
         PdLrZ8L488i0GiuAzEEoc4fAVMjM/HmdnZ+ilGcvdeO+d1obn/8PPUaO6gt4axWt7YaQ
         tfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9raaqseSWMIxvFB5Kt9xusEII4wG8BNqtWE8jaQvbJlgLxxPqggNC8I3rvbRxW09ADuBCstd@vger.kernel.org, AJvYcCVRLuP5uq5pOeST6BQoUFe36nIts9rkskhZ3l4jU5U+EIzEA4EE8249MxZoVGqSEd3wyVXaDlQJklBDft/n@vger.kernel.org, AJvYcCVTbfwMXOkj1iTL2wILIfUzZvD4WQmMxpKCUIJZED2ReKQToANAVTBlKCccDBmSCu2pNNwbTM3ni6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lBAA+UUAL0d4FbdsgyrWH2EY81WesyookLKQVt35WrN125gg
	jR4RB2x4ueC9V5wxCaWG7bg51rej3sdNbw1xmLmUatWe0U7QrX+lG5OYTzNz2136uVFQNggFcoi
	s3SbT6ymEUXpB4TKVRgkU8zuBHqU=
X-Gm-Gg: ASbGncuNJzVmiQOwQlhIlAYFLcowVPIISKF/2kLtbdQsYW6HZ0QmfnReCP06EegBs0b
	IGEY/Yf5npnDWaS6xISeFlGITo2aD2h/0Ec2MvGwfipYpi7LDm1CBJD+sxuVTugzEJhcqlSTdrh
	vcumEW+LLwpufnyPKITfZpJJnRpf+J6xnPgQAs3Jl4n6/N1BKJQQ2FasW22Q==
X-Google-Smtp-Source: AGHT+IGTRrDxwbNLzuvOqywnxn09Z9MIBiIW8jL7PYmbgeYEi936Vh8zP1vHoGOkooIJWXgAh2kitK9H48FMp+nw93M=
X-Received: by 2002:a05:6214:4109:b0:6e8:f0fc:d6c4 with SMTP id
 6a1803df08f44-6f05830f669mr182684556d6.6.1744125660685; Tue, 08 Apr 2025
 08:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
In-Reply-To: <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 08:20:49 -0700
X-Gm-Features: ATxdqUG2C20-NmbiR2-sPu0qDu-T-1hXdwmt4JH5TA7kOt76dOuAJy2oi4SCmNo
Message-ID: <CAKEwX=Nzp_sRhEV4rYjcOaK5mMnDsRmsFWpjzOt8o2EJagBWKg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 08/04/2025 00:42, Nhat Pham wrote:
> >
> > V. Benchmarking
> >
> > As a proof of concept, I run the prototype through some simple
> > benchmarks:
> >
> > 1. usemem: 16 threads, 2G each, memory.max =3D 16G
> >
> > I benchmarked the following usemem commands:
> >
> > time usemem --init-time -w -O -s 10 -n 16 2g
> >
> > Baseline:
> > real: 33.96s
> > user: 25.31s
> > sys: 341.09s
> > average throughput: 111295.45 KB/s
> > average free time: 2079258.68 usecs
> >
> > New Design:
> > real: 35.87s
> > user: 25.15s
> > sys: 373.01s
> > average throughput: 106965.46 KB/s
> > average free time: 3192465.62 usecs
> >
> > To root cause this regression, I ran perf on the usemem program, as
> > well as on the following stress-ng program:
> >
> > perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pagesw=
ap $(nproc) --pageswap-ops 100000
> >
> > and observed the (predicted) increase in lock contention on swap cache
> > accesses. This regression is alleviated if I put together the
> > following hack: limit the virtual swap space to a sufficient size for
> > the benchmark, range partition the swap-related data structures (swap
> > cache, zswap tree, etc.) based on the limit, and distribute the
> > allocation of virtual swap slotss among these partitions (on a per-CPU
> > basis):
> >
> > real: 34.94s
> > user: 25.28s
> > sys: 360.25s
> > average throughput: 108181.15 KB/s
> > average free time: 2680890.24 usecs
> >
> > As mentioned above, I will implement proper dynamic swap range
> > partitioning in a follow up work.
> >
> > 2. Kernel building: zswap enabled, 52 workers (one per processor),
> > memory.max =3D 3G.
> >
> > Baseline:
> > real: 183.55s
> > user: 5119.01s
> > sys: 655.16s
> >
> > New Design:
> > real: mean: 184.5s
> > user: mean: 5117.4s
> > sys: mean: 695.23s
> >
> > New Design (Static Partition)
> > real: 183.95s
> > user: 5119.29s
> > sys: 664.24s
> >
>
> Hi Nhat,
>
> Thanks for the patches! I have glanced over a couple of them, but this wa=
s the main question that came to my mind.
>
> Just wanted to check if you had a look at the memory regression during th=
ese benchmarks?
>
> Also what is sizeof(swp_desc)? Maybe we can calculate the memory overhead=
 as sizeof(swp_desc) * swap size/PAGE_SIZE?

Yeah, it's pretty big right now (120 bytes). I haven't done any space
optimization yet - I basically listed out all the required
information, and add one field for each of them. A couple of
optimizations I have in mind:
1. Merged swap_count and in_swapcache (suggested by Yosry).
2. Unionize the rcu field with other fields, because rcu head is only
needed for the free paths (suggested by Shakeel for a different
context, but should be applicable here). Or maybe just remove it and
free the swap descriptors in-context.
3. The type field is really only 2 bits - might be able to squeeze it
in one of the other fields as well.
4. The lock field might not be needed. I think the in_swapcache bit is
already used as a form of "backing storage pinning" mechanism, which
should allow pinners exclusive rights to the backing state.

etc. etc.

The code will get uglier though, so I wanna at least send out one
version with everything separate for clarity sake, before optimizing
them away :)

>
> For a 64G swap that is filled with private anon pages, the overhead in MB=
 might be (sizeof(swp_desc) in bytes * 16M) - 16M (zerobitmap) - 16M*8 (swa=
p map)?

That is true. I will note, however, that in the past the overhead was
static (i.e it is incurred no matter how much swap space you are
using). In fact, you have to often overprovision for swap, so the
overhead goes beyond what you will (ever) need.

Now the overhead is (mostly) dynamic - only incurred on demand, and
reduced when you don't need it.


>
> This looks like a sizeable memory regression?
>
> Thanks,
> Usama
>

