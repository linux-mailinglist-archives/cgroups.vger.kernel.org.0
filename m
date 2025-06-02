Return-Path: <cgroups+bounces-8416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3BACBB16
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 20:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CF7175CED
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD951AA1FE;
	Mon,  2 Jun 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jac4L/Tt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B06225779;
	Mon,  2 Jun 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889008; cv=none; b=t0YNkPKU9FV4eEYhEfq6wtJfEb9TV2HDxFGbRIGSc39UeH7sg7Hr/hGCzQcyl+ZqOSvh7byg/z0hPq7kipi6cAs9MD2CZwXx/ZR7pMjzzQ6jxUR5aK0adrsPB17qEyaLP78F6rLdfm+QVDORzBSaGX/94Mtjt41zjA+q4cHuGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889008; c=relaxed/simple;
	bh=I3ps/vXS6xOBaRTDgBK/4ZINVG3GFVOLQseSmjF/i0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfJrv0iU4HoSLGn1az35LuucUuqfnV9aiXpIDX3dHnd4MnuQov4BG791ThUU81pF8c6/r3syFiCde5K6SjufFl4o2G/jyDJR+dM0LbFOqjcbg/DbwRGaFmY7Vzcc739tYhrRmf4TqZrUUWOm36WrLPB5R8RmIdtmrs3wI7dbjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jac4L/Tt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a52d82adcaso35604401cf.0;
        Mon, 02 Jun 2025 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748889005; x=1749493805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ps/vXS6xOBaRTDgBK/4ZINVG3GFVOLQseSmjF/i0E=;
        b=jac4L/TtDR4/1l60PxILfHcMeezITvlv1qGw2tF4JCwbeV6k5JGMcLTeU7KLW1cs11
         gxNFy2m7D6pjjTxi5ywah9dRUGKuTeGQ6UEdujigcu3B0ex91YKYnE43mTF7k8/QYyVY
         e+z6CNVJB0FXqFHCxGiAA5kB+CmDkvqKv5jco8y+Z6TRyHVYJvoh5WfoS+sdUAZlXAa6
         oS3KPaJQwMD4SVo14VCgqi6oV6nnMguLtLw1bllRPKp+Egkqx3jwYHQVEqk9sph7eQVa
         Nmtyx9cLCB7FBtDeIq9bHRs5eVeEC6AsgkCu1zICQ6rDXcTkrhgsTkcBAKpK8qW4UPEx
         ojCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889005; x=1749493805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3ps/vXS6xOBaRTDgBK/4ZINVG3GFVOLQseSmjF/i0E=;
        b=j+vxSnn5S2k1PrJeGjSnk5MKU0Mm7qCKG2Q8SXsnr2jAaQbCWKHBH5R2uOVgPdNPtn
         qLf1ukrfFLvAmORqrP/RGhvJsZwYQKMgp0fvEF03kouefUWCsOcCBTZRVwOVtjhvJVtJ
         bC5nD7eoxcRGL9+o09ZzZsZsKdilOK9GHDOu93jJLgyrqUtUlIzdfW1fq9HPz1Ym3POP
         l5YVGECAjHR3zLLze+2K7lY9Uoe9DbTGpqkxng7TTHy9g8VWMRwTpEFBvI143LSdogwY
         Gcqx4vtH52LLohKocAgJzOrOoCUSStqOV+x98F9DAGYkDnTq32PDSm9RpYn1KAeOvdSE
         GUNw==
X-Forwarded-Encrypted: i=1; AJvYcCUN1OihZN93WijfMQpz/2VhpBFp3+nXfjERifccs2w9lih0TuLkUxiBI3iSRxrQM2mTtJLKsyP0xZ0=@vger.kernel.org, AJvYcCVn3szO6qMPxXzmGNRfCcOqilOp99rRjWPR6OTZot71fXC+c5pNySFtZhaOAXmZhpqF2LA3GOixvpLdJjqH@vger.kernel.org, AJvYcCWyd0EEeJptroU6z+mWR6Ss2s+DrZYNo6q0Ctbse9JpF7sVXxai5Si4v1bcvR7pbYFM1NFnQBxR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34vXMQeE8CHMri0PujnTCO4WmMHPJaKWLQPX5tEmbTH+JCVy4
	KGlwxoJRs361Mq2jftTdqLHXr/+DxTmPwbPJgVJWYq1q1W4XYpw7vrBS3Ouehqmee1xpsn4rjfw
	hVxPCUOgRkQ8+3AZIltVU2ZuSp5hIovg=
X-Gm-Gg: ASbGncvJbTBZV4Snj+W9EFL4PttF4suanZS1c3pRe0kI3duLMevSOSY5xg0AKOlw+sB
	mgJWYSqI3MqC4/EZznMXkn3G240bCFMGBKN14JQMh63FWFhUNxppsYUC0aMaICcRVsBr1NitwRW
	j2204vP+QVGtgVdG/mwi/7tfB7F6U7DQyKUw==
X-Google-Smtp-Source: AGHT+IHZPAHvPgBuwq78m2HFFGPtWr5KuODcu/WE969DSVc6e4SrjlVi7L7mgjIj8hJ5MrOb7Fv9nOQykrouQpQkSGo=
X-Received: by 2002:a05:6214:1d2c:b0:6f2:a4cf:5fd7 with SMTP id
 6a1803df08f44-6fad9165a84mr147092146d6.45.1748889004983; Mon, 02 Jun 2025
 11:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
 <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330> <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>
In-Reply-To: <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 2 Jun 2025 11:29:53 -0700
X-Gm-Features: AX0GCFt-PUurM1QtJWwmhEL52y2jIqhge_cou40ibH8eyg0VQefqwQtBHmfOVoM
Message-ID: <CAKEwX=P4Q6jNQAi+H3sMQ73z-F-rG5jz8jj1NeGgUi=Pem_ZTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, len.brown@intel.com, chengming.zhou@linux.dev, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 9:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
>
> Hi All,

Thanks for sharing your setup, Kairui! I've always been curious about
multi-tier compression swapping.

>
> I'd like to share some info from my side. Currently we have an
> internal solution for multi tier swap, implemented based on ZRAM and
> writeback: 4 compression level and multiple block layer level. The
> ZRAM table serves a similar role to the swap table in the "swap table
> series" or the virtual layer here.
>
> We hacked the BIO layer to let ZRAM be Cgroup aware, so it even

Hmmm this part seems a bit hacky to me too :-?

> supports per-cgroup priority, and per-cgroup writeback control, and it
> worked perfectly fine in production.
>
> The interface looks something like this:
> /sys/fs/cgroup/cg1/zram.prio: [1-4]
> /sys/fs/cgroup/cg1/zram.writeback_prio [1-4]
> /sys/fs/cgroup/cg1/zram.writeback_size [0 - 4K]

How do you do aging with multiple tiers like this? Or do you just rely
on time thresholds, and have userspace invokes writeback in a cron
job-style?

Tbh, I'm surprised that we see performance win with recompression. I
understand that different workloads might benefit the most from
different points in the Pareto frontier of latency-memory saving:
latency-sensitive workloads might like a fast compression algorithm,
whereas other workloads might prefer a compression algorithm that
saves more memory. So a per-cgroup compressor selection can make
sense.

However, would the overhead of moving a page from one tier to the
other not eat up all the benefit from the (usually small) extra memory
savings?

>
> It's really nothing fancy and complex, the four priority is simply the
> four ZRAM compression streams that's already in upstream, and you can
> simply hardcode four *bdev in "struct zram" and reuse the bits, then
> chain the write bio with new underlayer bio... Getting the priority
> info of a cgroup is even simpler once ZRAM is cgroup aware.
>
> All interfaces can be adjusted dynamically at any time (e.g. by an
> agent), and already swapped out pages won't be touched. The block
> devices are specified in ZRAM's sys files during swapon.
>
> It's easy to implement, but not a good idea for upstream at all:
> redundant layers, and performance is bad (if not optimized):
> - it breaks SYNCHRONIZE_IO, causing a huge slowdown, so we removed the
> SYNCHRONIZE_IO completely which actually improved the performance in
> every aspect (I've been trying to upstream this for a while);
> - ZRAM's block device allocator is just not good (just a bitmap) so we
> want to use the SWAP allocator directly (which I'm also trying to
> upstream with the swap table series);
> - And many other bits and pieces like bio batching are kind of broken,

Interesting, is zram doing writeback batching?

> busy loop due to the ZRAM_WB bit, etc...

Hmmm, this sounds like something swap cache can help with. It's the
approach zswap writeback is taking - concurrent assessors can get the
page in the swap cache, and OTOH zswap writeback back off if it
detects swap cache contention (since the page is probably being
swapped in, freed, or written back by another thread).

But I'm not sure how zram writeback works...

> - Lacking support for things like effective migration/compaction,
> doable but looks horrible.
>
> So I definitely don't like this band-aid solution, but hey, it works.
> I'm looking forward to replacing it with native upstream support.
> That's one of the motivations behind the swap table series, which
> I think it would resolve the problems in an elegant and clean way
> upstreamly. The initial tests do show it has a much lower overhead
> and cleans up SWAP.
>
> But maybe this is kind of similar to the "less optimized form" you
> are talking about? As I mentioned I'm already trying to upstream
> some nice parts of it, and hopefully replace it with an upstream
> solution finally.
>
> I can try upstream other parts of it if there are people really
> interested, but I strongly recommend that we should focus on the
> right approach instead and not waste time on that and spam the
> mail list.

I suppose a lot of this is specific to zram, but bits and pieces of it
sound upstreamable to me :)

We can wait for YoungJun's patches/RFC for further discussion, but perhaps:

1. A new cgroup interface to select swap backends for a cgroup.

2. Writeback/fallback order either designated by the above interface,
or by the priority of the swap backends.


>
> I have no special preference on how the final upstream interface
> should look like. But currently SWAP devices already have priorities,
> so maybe we should just make use of that.

