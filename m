Return-Path: <cgroups+bounces-7432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE7A8125B
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBCE446A19
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7622F397;
	Tue,  8 Apr 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahbnNzuv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244C22C35B;
	Tue,  8 Apr 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129573; cv=none; b=tHinLpff/Dd+GPJR3W4FPI2cLveROA6rpZ6Rb9WtvT07/6v9cdnB61OB3J1e4lkpKPSjOFL/UhHA7NG18TX4D93lUTmvVg5e5OHeQlMVZGb9uYHz6XlJop00j5kfMHvkVh7xHlyev2mbGa9JNdVC00Ex4vQ6ehjteBGvINX7e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129573; c=relaxed/simple;
	bh=Rd6D39mHfzdcD74W1C2YwPbPtRgtevNmGiWO8VUM5EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOPAOTDLVhx/4RlYf44J+0Grogpv5XDIWUJj9SpJWx0q5M0sIYSuXxvzQeuYbk1n2HNCC3dBpjr0Bm1NmMfLcvybJp/PBMF9/9rfnWlXb6O7QPE0h7TF1vHX5QM9evnm5jLXb2m7KDnUqZpyDb0NH8hwRCmQDCQXzm5ar9mUDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahbnNzuv; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so69674136d6.3;
        Tue, 08 Apr 2025 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744129569; x=1744734369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhn6KcKMjy8VBvjrg/SdvedbkOPjB9+PrtODTZSo3FU=;
        b=ahbnNzuvDufiVt8rfbWGVk6zCqma5ekXKAz95lBTYYLEWugSAAlWdOS7nofxNWiceG
         KHC4d2obApN6GiECyIn6k6Kh54ylEHSLwjB/edUO08uXODpRnf98B38ft904lbJSw98Q
         wNApgr9xTPiJNvtxdvTOE88dfkn11ITkn8fcS7Xa703brEwwWXvutcStsO4RdJMw2Eh5
         GPJzaaXHYzwt5rqg890XIbVbHGawueqkMtyik8LB+F6DgviRNH08plizRFwIowpIgSbw
         0UFXWVoNCY+IUPLr0sxixUQ5ERINBHqKbj5Q4FOkLwhoUIJNd1zy7UaHqYAOn0YWC7oV
         HU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129569; x=1744734369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhn6KcKMjy8VBvjrg/SdvedbkOPjB9+PrtODTZSo3FU=;
        b=P2m3eCPtJ1hk8AledqFWlwPiCB6QSF721gfYNyIPxQ0klqEHQiouqRpyHXXdOXMVob
         YfHPEeq4xh7QOdeClfknoKoNkUpE6l+q3A2TR20Dfu7JNsxu1cnNaITyWdkwoKKe71ef
         rMYst7JQkOeRsCD1U42clb5z6SXcr8tYY6ptFfPM1UObCTbUW1Pr+kw+e3sqOqMlvBVw
         gz2hmxuYR+VH++lAwmNn1Gi8kb3vfZ4vqpc502enghObWpsvaQzMfvR2dcg8Dw05QwBV
         xEDzpQmSCqJ/CDzhopT/Ug7ES897s/6OTsTwZsB2T4uSVGRgvZLTvTIOkxkBWrvhNQix
         7y2g==
X-Forwarded-Encrypted: i=1; AJvYcCUk6jEK9bhC6TfcxJluzRkn9TaBCp8kOFUawdRNNHuVRv/EAOqvNTtVHBKMcHQL4c1w3fiRjErv@vger.kernel.org, AJvYcCVND83gbgsjdg00WgwXYFM/SuJ7XdMM67Wd4OIbq+9Lv3Qqhm9iuhmuwZAaa01jTxesSIfHdiSW+XkvqgAc@vger.kernel.org, AJvYcCX2MnQu5v4IEw5VK+4Yupzzjkc3vDCVfrcnpLaS8LHM+2xNu4k/RMMFnWeZcxCrDi/fI8dC3AheLb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvgAGgR7qwZgIq8qDqec+74JinEJHUt/pp4Q8Irqs8knspSpT
	5MGZZmjVh4ylUQ6Ceie7vx+stlL+PsANF1j2/MDfnMEQnGGh7s2G49/1UVfBf3cdlb5zKldharr
	djKUCNeoukMsEZwhwHGePzgeT5ZA=
X-Gm-Gg: ASbGnctD9Y8S8E8nhDZ2QXMC06zxF+qDPSB3Zgvp2Ur6Jb7XUXSNEjHkM9Qc5zsfwmV
	Stod/cTXsf5/ZkV42nNH33p9Xzl1FmCIjzMQiurnWJ5SETSWnsURWxh4CH5wp+NssXfz/pKBjXZ
	dxqJN27sfdbNuZrqgpAw6Qjfi44eyTAyGI/nwJ5ZzjyeY1hWhpAfKem+8Gziz4iSqSEwKV
X-Google-Smtp-Source: AGHT+IF95+ROBjtnrwaG59uDsd7mH2fJA1TgN7kNoJHPZ0NwlONqzdIMZcvIDeGvkgOQjd1e0Dk5wWb7MdU2E1rIBq8=
X-Received: by 2002:ad4:5c66:0:b0:6e8:fa7a:14ab with SMTP id
 6a1803df08f44-6f00de8c617mr244954026d6.6.1744129569215; Tue, 08 Apr 2025
 09:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
 <20250408154547.GC816@cmpxchg.org>
In-Reply-To: <20250408154547.GC816@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 09:25:57 -0700
X-Gm-Features: ATxdqUGRI-s0CMdaIzHY2p5bsSzJ0Q70zuzJHdhPtpKtQvsR8BXYJRkkZdtS_3I
Message-ID: <CAKEwX=M3do_7SJGKwfZQ8vOSQN4aM1ZU04Q3E99CW=UTCkUMOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
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

On Tue, Apr 8, 2025 at 8:45=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Tue, Apr 08, 2025 at 02:04:06PM +0100, Usama Arif wrote:
> >
> >
> > On 08/04/2025 00:42, Nhat Pham wrote:
> > >
> > > V. Benchmarking
> > >
> > > As a proof of concept, I run the prototype through some simple
> > > benchmarks:
> > >
> > > 1. usemem: 16 threads, 2G each, memory.max =3D 16G
> > >
> > > I benchmarked the following usemem commands:
> > >
> > > time usemem --init-time -w -O -s 10 -n 16 2g
> > >
> > > Baseline:
> > > real: 33.96s
> > > user: 25.31s
> > > sys: 341.09s
> > > average throughput: 111295.45 KB/s
> > > average free time: 2079258.68 usecs
> > >
> > > New Design:
> > > real: 35.87s
> > > user: 25.15s
> > > sys: 373.01s
> > > average throughput: 106965.46 KB/s
> > > average free time: 3192465.62 usecs
> > >
> > > To root cause this regression, I ran perf on the usemem program, as
> > > well as on the following stress-ng program:
> > >
> > > perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --page=
swap $(nproc) --pageswap-ops 100000
> > >
> > > and observed the (predicted) increase in lock contention on swap cach=
e
> > > accesses. This regression is alleviated if I put together the
> > > following hack: limit the virtual swap space to a sufficient size for
> > > the benchmark, range partition the swap-related data structures (swap
> > > cache, zswap tree, etc.) based on the limit, and distribute the
> > > allocation of virtual swap slotss among these partitions (on a per-CP=
U
> > > basis):
> > >
> > > real: 34.94s
> > > user: 25.28s
> > > sys: 360.25s
> > > average throughput: 108181.15 KB/s
> > > average free time: 2680890.24 usecs
> > >
> > > As mentioned above, I will implement proper dynamic swap range
> > > partitioning in a follow up work.
> > >
> > > 2. Kernel building: zswap enabled, 52 workers (one per processor),
> > > memory.max =3D 3G.
> > >
> > > Baseline:
> > > real: 183.55s
> > > user: 5119.01s
> > > sys: 655.16s
> > >
> > > New Design:
> > > real: mean: 184.5s
> > > user: mean: 5117.4s
> > > sys: mean: 695.23s
> > >
> > > New Design (Static Partition)
> > > real: 183.95s
> > > user: 5119.29s
> > > sys: 664.24s
> > >
> >
> > Hi Nhat,
> >
> > Thanks for the patches! I have glanced over a couple of them, but this =
was the main question that came to my mind.
> >
> > Just wanted to check if you had a look at the memory regression during =
these benchmarks?
> >
> > Also what is sizeof(swp_desc)? Maybe we can calculate the memory overhe=
ad as sizeof(swp_desc) * swap size/PAGE_SIZE?
> >
> > For a 64G swap that is filled with private anon pages, the overhead in =
MB might be (sizeof(swp_desc) in bytes * 16M) - 16M (zerobitmap) - 16M*8 (s=
wap map)?
> >
> > This looks like a sizeable memory regression?
>
> One thing to keep in mind is that the swap descriptor is currently
> blatantly explicit, and many conversions and optimizations have not
> been done yet. There are some tradeoffs made here regarding code
> reviewability, but I agree it makes it hard to see what this would
> look like fully realized.
>
> I think what's really missing is an analysis of what the goal is and
> what the overhead will be then.
>
> The swapin path currently consults the swapcache, then the zeromap,
> then zswap, and finally the backend. The external swap_cgroup array is
> consulted to determine who to charge for the new page.
>
> With vswap, the descriptor is looked up and resolves to a type,
> location, cgroup ownership, a refcount. This means it replaces the
> swapcache, the zeromap, the cgroup map, and largely the swap_map.
>
> Nhat was not quite sure yet if the swap_map can be a single bit per
> entry or two bits to represent bad slots. In any case, it's a large
> reduction in static swap space overhead, and eliminates the tricky
> swap count continuation code.

You're right. I haven't touched the swapfile swap map and the zeromap
bitmap at all, primarily because it's non-functional change
(optimization only). It also adds more ifdefs to the final codebase :)

In the next version, I can tag on one patch to:

1. remove zeromap bitmap. This one is pretty much straightforward -
we're not using it at all.

2. Swap map reduction. I'm like 70% sure we don't need SWAP_MAP_BAD
state. With the vswap reverse map and the swapfile inuse counters, we
should be able to convert the swapmap into a pure bitmap. If we can't,
then it's 2 bits per physical swapfiles.

