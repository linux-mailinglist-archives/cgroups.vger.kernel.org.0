Return-Path: <cgroups+bounces-7591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2FA8B3C7
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D6F18845DB
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6422E3E7;
	Wed, 16 Apr 2025 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhiZO9on"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AC227EB9;
	Wed, 16 Apr 2025 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792167; cv=none; b=TPzk8WKt1x07jg2eEgwVlpAtXauPOiZ02x0z3utZUwat5jof4WPYIqzRuIFr/5DdaRtFt1gB1u5p2xyzrg+l1K0GFKt+BVrrBu/MI2lkSkR2JaIBBtQY57sUqnTFs6+HvcyWHkLCs5w+/P+4DQiiQ6nnZJtpUhFDCQNM4LPudDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792167; c=relaxed/simple;
	bh=pKkKKqoTEolPnTa/YFx9qPHQlIeHPpzcluXgfKWEFT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoFYhgfU/JWokxs7PAgMOQib1L7TTT15bnmShL3F5ikL8qbK8FUB0yl5ELTiXh4O1HyAiPNDvRhSe+ZcDhXxB5VRz0qlgaAtDPoSJSx3iEEZ+rxTmmmZdjQLOrmt1F0Ck9W7alhhwqB1/xxJVI9hsp4c8fjCuXbI40eYePMk8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhiZO9on; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so5671363a12.3;
        Wed, 16 Apr 2025 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744792165; x=1745396965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovSlUrKCeKW3pPZbEQAJqu/9QO1u+A25+RyFvDwdr+Y=;
        b=ZhiZO9onsC56+vjWpPOYm5nhe68RP0Zy6mU1Ww7SS7Z5h/W9iSX0T4zGUSRp5rj6BX
         VvNW/ns0fiZ8VTKoBQAEiBdj5Vrk9ZtDoxM7aICLg+jmW5yd4nE/P3JHW1NQZ2+IXGLX
         qvW+MrHlFk6En6893nJ+NMHYMvZkPBaIjiaCILH1Tur4B8bo8fIYjgPerjbtCgxxvosm
         8pfmdN4qmo0Hr8359JPx0mOypS3iJ1xV2kA62G32ooNUwRLwOixNyTp5UVYMOv/g5xMc
         apTNiZfALToDwmXXZU+41Roskuk2PVMeVt57SnU1ZGv7H4QHeB6N3wxF/BMPq9h0QbNs
         m3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792165; x=1745396965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovSlUrKCeKW3pPZbEQAJqu/9QO1u+A25+RyFvDwdr+Y=;
        b=Z7ogmA0b38OYG210t2Yx8rBPoYDJMyUz8sOxY4fFqrniivKGYT+Cggdg7doOXY1SIo
         ufllvtjo3p/5a75CJMnLTEQCwv7p7UGjPq2NujddlAjQ+yvrdsoYPoFUVWTjXVrZAfZw
         9BMsQJHcKlQIa9fgAsxdPW7MJe4PegdQkXmur6nECjuyEV5Q9Y9iTIWLdkZgRuOtAoje
         etDPY4oqRWf87y64jwNsyDRwLUKUshy5BZWyz16Jc7i9ZOBLgDKpyLdIaj6KCfi5vFD6
         hBA1qvNA8rKG7GQtV0on78lV2qI4/ulXRetC1oeUACxq4HvWdBqhn1QAUZAnSHZSfr0y
         XEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT53g6iVNbWfDlglp3AY9fAUyXLxixEGMMMeK5wEKzdfnQk0mCYT/g4N9kndYQulA3DJArkI6EG14onsiP@vger.kernel.org, AJvYcCWomounWRW7fvkyiFkwsffuJMJFzAgaaK+AMVGF+XYArZ5c0fdm1/RZ9TqizhKcQ/+d4mMfTksV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0b6NRzu9Ov/84jQ9MyiyupksdPgp8MAygqTY/uiapjfoxqkG
	xvJa9vCyap4sd7LvANenwqXtZApW2Dutiy/DlZ1pViAJwQB1EHmygATQLcEtUXR4ex3z+X4+Da8
	+b8ScSRbyCwFSpkuW5+1o65l8zQE=
X-Gm-Gg: ASbGncuW4vDGIHGQZH1FR+kY0+OQ6WGM5B+oy8+QQiPDYv2aqP97+0GxTAldlJ6ycJ6
	hNPXzVbgrYENht9asT0yyPiNIlK+iegJUfi7mVN79mAhA8yDua8qAj8W1iSHUO0Rk2d1ANLlS9w
	SlMoH3UNsZmJVCHNrrsfmpvu3+41NCskWC
X-Google-Smtp-Source: AGHT+IFPJsWFdxHLRn0A3K3T0Ttkaq59tPju15WeDboMAunp4Fr63JgpoiKfRarAkC7MF0/sucAkaLiHSi1wesRrcUY=
X-Received: by 2002:a17:90a:d88d:b0:2f7:e201:a8cc with SMTP id
 98e67ed59e1d1-30863f2f576mr1493568a91.18.1744792164501; Wed, 16 Apr 2025
 01:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com> <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com> <20250320142846.GG1876369@cmpxchg.org>
 <ipskzxjtm656f5srrp42uxemh5e4jdwzsyj2isqlldfaokiyoo@ly4gfvldjc2p>
 <4lygax4lgpkkmtmpxif6psl7broial2h74lel37faelc3dlsx3@s56hfvqiazgc>
 <CACSyD1NisD-ZggRz0BaxUdJ9so4j-sKPZi361HJAum3+bHO+tQ@mail.gmail.com>
 <CAJqJ8ihLfcDROuCjMfoNzOtRRZhVDWEx04ik6cS9NO6hVua0xA@mail.gmail.com> <qfxzzbcfnojz3oz2ackzorwokhmr2dbkxfgbmewd74vtzrzxkh@rlqide3wg2v7>
In-Reply-To: <qfxzzbcfnojz3oz2ackzorwokhmr2dbkxfgbmewd74vtzrzxkh@rlqide3wg2v7>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Wed, 16 Apr 2025 16:29:13 +0800
X-Gm-Features: ATxdqUHMcJS3GpWxSBSZsTcmQzVqWzPzHcmjHLMzsnvNr2EqwFUfW8_JXgsUyHE
Message-ID: <CAJqJ8iiyVQxf1Kg_UKuRM_Zg6u4Hqb=DwpbOH_7CrAscAonD-g@mail.gmail.com>
Subject: Re: [External] Re: [RFC 2/5] memcontrol: add boot option to enable
 memsw account on dfl
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, 
	muchun.song@linux.dev, kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Apr 2025 at 00:57, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Thu, Apr 03, 2025 at 05:16:45PM +0800, jingxiang zeng <jingxiangzeng.c=
as@gmail.com> wrote:
> > > We encountered an issue, which is also a real use case. With memory o=
ffloading,
> > > we can move some cold pages to swap. Suppose an application=E2=80=99s=
 peak memory
> > > usage at certain times is 10GB, while at other times, it exists in a
> > > combination of
> > > memory and swap. If we set limits on memory or swap separately, it wo=
uld lack
> > > flexibility=E2=80=94sometimes it needs 1GB memory + 9GB swap, sometim=
es 5GB
> > > memory + 5GB swap, or even 10GB memory + 0GB swap. Therefore, we stro=
ngly
> > > hope to use the mem+swap charging method in cgroupv2
>
> App's peak need determines memory.max=3D10G.
> The apparent flexibility is dependency on how much competitors the app
> has. It can run 5GB memory + 5GB swap with some competition or 1GB
> memory + 9 GB with different competition (more memory demanding).
> If you want to prevent faulty app to eating up all of swap for itself
> (like it's possible with memsw), you may define some memory.swap.max.
> (There's no unique correspondence between this and original memsw value
> since the cost of mem<->swap is variable.)
>
>
> > Yes, in the container scenario, if swap is enabled on the server and
> > the customer's container requires 10GB of memory, we only need to set
> > memory.memsw.limit_in_bytes=3D10GB, and the kernel can automatically
> > swap out part of the business container's memory to swap according to
> > the server's memory pressure, and it can be fully guaranteed that the
> > customer's container will not use more memory because swap is enabled
> > on the server.
>
> This made me consider various causes of the pressure:
>
> - global pressure
>   - it doesn't change memcg's total consuption (memsw.usage=3Dconst)
>   - memsw limit does nothing
> - self-memcg pressure
>   - new allocations against own limit and memsw.usage hits memsw.limit
>   - memsw.limit prevents new allocations that would extend swap
>   - achievable with memory.swap.max=3D0
> - ancestral pressure
>   - when sibling needs to allocate but limit is on ancestor
>   - similar to global pressure (memsw.usage=3Dconst), self memsw.limit
>     does nothing
>
> - or there is no outer pressure but you want to prevent new allocations
>   when something has been swapped out already
>   - swapped out amount is a debt
>     - memsw.limit behavior is suboptimal until the debt needs to be
>       repaid
>       - repay is when someone else needs the swap space
>
> The above is a free flow of thoughts but I'd condense such conversions:
> - memory.max :=3D memory.memsw.limit_in_bytes
> - memory.swap.max :=3D anything between 0 and memory.memsw.limit_in_bytes
>
> Did I fail to capture some mode where memsw limits were superior?
>
Hi, Michal

In fact, the memsw counter is mainly effective in proactive memory offload
scenarios.

For example, the current container memory usage is as follows:
memory.limit_in_bytes =3D 10GB
memory.usage_in_bytes =3D 9GB

Theoretically, through the memory.reclaim proactive reclaim interface, the
memory usage of [0GB, 9GB] can be reclaimed to the swap, so:
memory.limit_in_bytes =3D 10GB
memory.usage_in_bytes =3D 9GB - [0GB, 9GB]

In the case of proactive memory offload, the amount of memory that can be
reclaimed is determined by the container's PSI and other indicators. It is
difficult to set an accurate memory.swap.max value.
memory.swap.current =3D [0GB, 9GB]
memory.swap.max =3D ?

The memory space saved by swapping out to swap can continue to load
the operation of system components or more workloads.
memory.limit_in_bytes =3D 10GB
memory.usage_in_bytes =3D 9GB - [0GB, 9GB]
memory.swap.current =3D [0GB, 9GB]

The memory usage of memory.usage_in_bytes is reduced due to proactive
offload to swap, which will cause additional problems, such as:
1. There may be some memory leaks or abnormal imported network traffic
in the container, which may cause OOM to fail to trigger or be triggered la=
te;
2. In the oversold scenario, if the container's memory requirement is 10GB,
the container's memory+swap should only use 10GB.

In the above scenario, the memsw counter is very useful:
memory.limit_in_bytes =3D 10GB
memory.usage_in_bytes =3D 9GB - [0GB, 9GB]

memory.memsw.limit_in_bytes =3D 10GB
memory.memsw.usage_in_bytes =3D 9GB

Above, thanks.
> Thanks,
> Michal

