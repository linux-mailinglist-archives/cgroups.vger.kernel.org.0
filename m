Return-Path: <cgroups+bounces-11580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29857C34071
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 07:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6EB934B74F
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7A2BE7D0;
	Wed,  5 Nov 2025 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ERQZDNRN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C726E709
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322534; cv=none; b=Ksz3ZTxG3f3h/tGEAC48B0UUupQ78VxK0y5dHT1/8/3jbImpi1n6MUSdYIRFl+sYrKEgxSFC7Ml4wc7lQqftWmBmS+7ksbaF6uA3DsxEtUzD/KDpQeDSzTe7NNpSyouhPhZ3Hcsw2Rf09TXP8Go/XsToVPXs2Z1zS+hDUTTV43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322534; c=relaxed/simple;
	bh=rB26i8gg+y3xFbXaOX+BukR99gcLLiKA6P6pz/n0flQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZYUR1DKCtIWNUKhQ45mfNM+Lh1ooh5jS+yOKBpt5pDPVqybUWIgU5SuIeCJ7hsB5DKY3sgRmKrCFcPf4KdZC3cNIIN9K2cBaEV85NW0b3/LqCV1kjmCdBZxIt10h90hBf8NMEKSwvhz8sgq24o3NAA3vlZB9v186XCy2TxwVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ERQZDNRN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso1217857366b.3
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 22:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762322530; x=1762927330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko+h2HHqIfyVkiIdgqbGuzIvxFEpCvepvxTD0kgHwio=;
        b=ERQZDNRN2PWRX1/EMYpLuryhsJePx8dLLR6HMR0G3StPlHyHMNU7tcKcLOyfEbhW+h
         inS0O8sMbszfsihBBXG23K3YUSpzE/cpyukL9MgARfVI23ILr3fgyUb9m+9wjPyfUjpr
         wESlDLbSGtW3SV79L89Zts97LY+pJ0xTfv2xbo0DT8rZk8DWo1KVR7RPR4Ar/1/E6Rp2
         3xfyFvxW6HODP/jEsVW/+vidb6+BhJvkqnjAmx0YQ90goj94gvaZQ0ewRGMb2yEVMP8w
         FQfUny5NtEVDkQQP4rfVLYLsnebR6QjNwv0PMkY6ELdHjyGt558Ke61gGTmqBUQEScTb
         yTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762322530; x=1762927330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko+h2HHqIfyVkiIdgqbGuzIvxFEpCvepvxTD0kgHwio=;
        b=ZcExb3Wt4Md5AzRqFAQf0ATgq7xtEDhnH8i9+QIfyt0t/eAFAb7FygiqnJX5TIcY5Q
         h65S2G2+wyseXVZD69R3I1XEjzG15eO6Lq4LnjZ8n3osUp3+6rFbJd3IWwBLfAxPE55C
         kg0Rl+XeELMe7w6PnU0TLtVWY+mDxN7gnwUTsslvMhMJ/Rpb2U+1WlQufGFjTeTGVKpM
         z7pzizXqeCZK20fDiYXEnPTb1tUjwPWdIPM00KNluxYee6kPhMX4QAC5vqGF3L3nqnmO
         WCjEYZ3m44PMhHFyQw+gv1PQ0AEIb3LKTV4mOZ8dsRv6GI5BS8hQhNkFVe62E0s5yVDN
         jC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3ipXkQ4umhYNZPUY2clDUV5AXWh5flkSPPB5yKnGUE7auNCH86JStSDYafMs0b2cfX6m4/I3T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4seTEStLS6lqX4NVuRGCNlB2Uv1naGTWbjilj/TOZYxt5wrOI
	tzsioFQ1HvAJpaDXu5Bf89cVsWDSUuOyTF0sCS8uKDrEI0ruP5AQbA2lsBg+BAxKy1JQLhYxP+e
	Rt3Y0ZyrDXhGqmDP8iVSumSVZdvgUIVVheLUffJuj4w==
X-Gm-Gg: ASbGnctSKSs9oIls2nkCBE0iW5/k7Fxygkm2DMlB11Cez6v8qwR8r6vrU8kf1ME68O6
	+p7foWb4zyZNSBZqaYrVUJtzLjC+oXdCLSaVTE4yDt286731L1m9oF3dY6Pj2l8oa4bzg7P/P3M
	+6wgLX89hJENUgduooL3zATCJm011KMBgMQxjzIUfSOz4TkOop5QHJVX5wVSvz4OdYrGyiuVqCL
	B2iRtxVz2AWKAQzgERUTghDtCWqsMBafnZW2K6/v+y6U55h6/nvAnF9lC8=
X-Google-Smtp-Source: AGHT+IGhzBDN0J2xo0zgTrF8hoLMoPjH/0yoSaTiCKabdffwkstVhE2JzObLLjxmM0V2ZK+kJ0pjRcykFQushFkcK04=
X-Received: by 2002:a17:907:94d2:b0:b71:ee24:8a3d with SMTP id
 a640c23a62f3a-b7265154e9bmr164396666b.12.1762322529791; Tue, 04 Nov 2025
 22:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104031908.77313-1-leon.huangfu@shopee.com> <aQnFn6vPQ5D6STGw@tiehlicka>
In-Reply-To: <aQnFn6vPQ5D6STGw@tiehlicka>
From: Leon Huang Fu <leon.huangfu@shopee.com>
Date: Wed, 5 Nov 2025 14:01:33 +0800
X-Gm-Features: AWmQ_bkS8mFduVj_GZzMUe3ULkR8btNSr45nec1ttI4iNP0pSA8_ELWgHC8BzUM
Message-ID: <CAPV86rrt0YT-npNSBJ_eHvAYdr_j1qkN7H+J4QLN8zsfi5TJ4w@mail.gmail.com>
Subject: Re: [PATCH mm-new] mm/memcontrol: Introduce sysctl vm.memcg_stats_flush_threshold
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com, 
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net, 
	lance.yang@linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:21=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 04-11-25 11:19:08, Leon Huang Fu wrote:
> > The current implementation uses a flush threshold calculated as
> > MEMCG_CHARGE_BATCH * num_online_cpus() for determining when to
> > aggregate per-CPU memory cgroup statistics. On systems with high core
> > counts, this threshold can become very large (e.g., 64 * 256 =3D 16,384
> > on a 256-core system), leading to stale statistics when userspace reads
> > memory.stat files.
> >
> > This is particularly problematic for monitoring and management tools
> > that rely on reasonably fresh statistics, as they may observe data that
> > is thousands of updates out of date.
> >
> > Introduce a new sysctl, vm.memcg_stats_flush_threshold, that allows
> > administrators to override the flush threshold specifically for
> > userspace reads of memory.stat. When set to 0 (default), the behavior
> > remains unchanged, using the automatic calculation. When set to a
> > non-zero value, userspace reads will use the custom threshold for more
> > frequent flushing.
>
> How are admins supposed to know how to tune this? Wouldn't it make more
> sense to allow explicit flushing on write to the file? That would allow
> admins to implement their preferred accuracy tuning by writing to the fil=
e
> when the precision is required.

Thank you for the feedback. Let me clarify the use case and design rational=
e.

The threshold approach is intended for scenarios where administrators want =
to
improve accuracy for existing monitoring tools on high core-count systems. =
On
such systems, the default threshold (MEMCG_CHARGE_BATCH * num_cpus) can rea=
ch
16K+ updates, causing monitoring dashboards to display stale data.

Regarding tunability: while the exact threshold value requires some
understanding, the principle is straightforward - lower values mean fresher
stats but higher overhead. Administrators can start conservatively (e.g.,
1/4 of the default: num_cpus * 16) and adjust based on observed overhead.

Your suggestion about allowing writes to memory.stat to trigger explicit
flushing is interesting. Comparing the two approaches:

- Threshold (this patch):
  - Administrator sets once system-wide via sysctl
  - Affects all memory.stat reads automatically
  - Tradeoff: harder to tune, always-on overhead

- Write-to-flush (your suggestion):
  - Tools write to memory.stat before reading: echo 1 > memory.stat
  - Per-cgroup, on-demand control
  - Tradeoff: requires tool modifications, but more precise control

Actually, your approach may be more elegant - tools pay the flush cost only
when they need accuracy, rather than imposing a system-wide policy. The
write-to-flush pattern is also more discoverable and self-documenting.

Let me try your approach in the next revision.

Thanks,
Leon

>
> --
> Michal Hocko
> SUSE Labs

