Return-Path: <cgroups+bounces-14085-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrOFsBpmWkjTwMAu9opvQ
	(envelope-from <cgroups+bounces-14085-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 09:16:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65116C668
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 09:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1169B3018D43
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3442E339B;
	Sat, 21 Feb 2026 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1tS+AR2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37C2DF12F
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771661756; cv=pass; b=rOkE3HTFxE3LnyExdMUsKWHRVVdpDXKP0aQ5/JG/yix7zFAUvYRLH9E8Ehf6xSsgXXxwtZk6J3kJDuxKpMG9R3qGrMOH4/M079Vk+SQAmKxcJ1bOZ/8H8cJxel4vE7x+I2MBP6JQtbzK69Dje7AEv6YsJePs4p5VogTH1gBiAJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771661756; c=relaxed/simple;
	bh=412MfC+6G9qWsqp7OEx5WaFJYjbUSW3rhAD+QwFgK6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQUWkJzHQNUAOsiEVnJHhvaBrdTsWaqyopBTWZLaRvhB0HvwIkPprkyxK8j7Oy1RrDIIsWLriF+m5zqhXCYe5RZp1joltEKymEqC9vKqx8LgmMNs6HaIMIHLCs0QrOJF2mt2eaWIA/0LG2G/ntt6lT3yX0OjFAO7IVaWt7cYnXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1tS+AR2; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8947e6ffd20so30137926d6.1
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 00:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771661753; cv=none;
        d=google.com; s=arc-20240605;
        b=C9XnEB8Ob5fxu4Ez+Doca8Ws15UjkoENeEc/OvM8bZ1BT9OQd1iQRfwTYSnWRblrJP
         +UVU+U1+AI1fcfjNN4zVxMJ3q+Uo+IARu8cgMqPuTn6FKo823ivzaEiVe0rXnEradWVH
         iJkqml3N+kcRD+RHN3k7YnAvxMHt6eLfy6xLigqd3UzZcoV00SCOyY88P97zvhnMv01E
         X5KW8D83rCmUP9wp35JqJHNKTqxY8ZeNmex03gk504KFkcWtytVHffh5aluR9MT104or
         OmRv/1POdsQsBJEl2OfgHYMD3VmM5dwtxXg5sRXSytupOLBQnen8uyIeFPXEoYlCXBdU
         O72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqJhtOyCKaatcPuVbcWAYul34KhkdgQblBgCMkQEGTI=;
        fh=TLt8eQBbii2Egg554SW4bex5R3wi3gmbVlvljvsfx4Q=;
        b=ktp1xZ/KLIaw2S+GWSaYNYnzMq1di7tPuA0t/CME4NLaPoLQ5Nk5TD2nNxJfZHcPio
         LSaZ5MMIwUp6H2pfO//FvzyoD8Y2CHl7m5fokVisYkbPN4SvSNSSYkA9h4Z+31YuNhvu
         b8b8HeXdzmNLSyCNsakscpE0e7stw7aGzA2VgsDxoEVar7QhHaiUWnj8HEyJ9VrZ4r1k
         XD0q8+FGxFDWnt2pssOne+sHMwXWLCDuj/LinTB+7ME0B4uQXl2jNJq3VNAAlDv1iiZy
         MDtY3y0ku2ApziHY55D4x+GFaexEJWSz8p0pc/4ch8aJ+P0WHoZG4N5839wJNYqFU+Ft
         gOVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771661753; x=1772266553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqJhtOyCKaatcPuVbcWAYul34KhkdgQblBgCMkQEGTI=;
        b=N1tS+AR2NfdIZsBpHYlnS/sb1+PTac9KS5Whrx9Ypg5NdLUKrHnAFNMk3mSZofEApn
         I5pi2kRS0N7pzw8rwYOb1QQ32Y4fAiEzaOxVtcN+TfqluNIDfNcilvMdAH/MT8QhTLd7
         gxsuFNAIuMTixZdiGGaoJ6CpsicgmWthoYbiQ8wcr2ZfZ77K0jVHi16bgjo2j55kSLN+
         Y2e+ZjpWRv+2NF3roDTX5fm3boGLkWkmngpdFGclTEJTWAool9AakepTPewPsJn7Pgvw
         6lma8pmVXqW9x4wCAi++lJsrnMCV/dsOKN8l1tCGGtZDN1Ys2jDmyM8lGw0s5iO4NJLq
         LgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771661753; x=1772266553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqJhtOyCKaatcPuVbcWAYul34KhkdgQblBgCMkQEGTI=;
        b=BK2kPn49k7eChG/vNUpdPnKp3h5MkHfaVLRikhYKeI5ez16g0tJ1JloF/dSUlXSp3H
         2NXFecdgbPZmk7/y+SS8uQcy7zlen6MeBVRUd9b6xtS0B6AL5txAUCnAmwMUOOw1qR9M
         H6BjwPdh4ZCiF2Ng+n6qV5Yik0+f199a9R1yfLPK+eAAz7MvWGiAylMr7fevdyB5NLyr
         E9Yjvrz7k0z85NPkHd/TJ15NtTK7OyQPTFtyfYmEW+XcgQp0Ub2jpiqGs8grbME2EtKn
         l0cpjCAvkPwc21DjatvurJzuiOklO0890TXVy5NzCfNqfbHyY9KCPQ6dVrEu5O0JbEe/
         Q6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUpP6ToPS+nl1tUmIrZytJ5PPPyozp2YViXKIhWwOxpvF2Zi8rse3J01HJACyK+uEtKaLc2Q/EK@vger.kernel.org
X-Gm-Message-State: AOJu0YwLt6MXryHIBS6UBB1eH/am/utcq9FIdVj3WIbHqNDv6o122rBO
	js6VWkaOTUOsX9XWNVfEHqcqTjZAitBRHUZd2Pm8pxMK0nYn1O1RbYT9VciZ99pHuhD4PvGEVae
	wgQzXKEsGxRE0ll9Iuq5eRM/fQZ12/1A=
X-Gm-Gg: AZuq6aJ/gNUHdBCEARuWL4OdfdLbyFlwlCtzPmZGYiiFmoAgCU+HfG/oGUnr+j4x+9Y
	gxYN7JRi9S37fKyWzQ7SWmfp3HHUudxY7vtGjSZhoUnNlomR2FhHjZKzCaKxKmWQd3tzepM85JO
	4yThvfi8/zvG/fZu/+A3s+tFc4uJj/pW1EmOz7jeo5PGtKrTR8vP9oRiwIJmVJTLgSc0P8krNJK
	Oi2Bs62mE3ZiiPflqc9tOrPDfzcRKgB6RD307R6QyOHcjjCeSX9NKGzGmUkdUpYjhtZ+gZ/vxf+
	z9CayA==
X-Received: by 2002:ad4:5b83:0:b0:894:773a:4581 with SMTP id
 6a1803df08f44-89979ef88f8mr35023106d6.49.1771661752857; Sat, 21 Feb 2026
 00:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 21 Feb 2026 16:15:41 +0800
X-Gm-Features: AaiRm51aBJQnXsyOpa3tomJfwexW2cBBfl33LWP9FjuNSVqwIZLll-dWCZQAZ08
Message-ID: <CAGsJ_4xF5sK8H1RsqRNoi7DfGBtThASsozY30gq_kdRLaYgaTw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,mail.gmail.com:server fail,tencent.com:server fail,lwn.net:server fail];
	TAGGED_FROM(0.00)[bounces-14085-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,lwn.net:url]
X-Rspamd-Queue-Id: 7A65116C668
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> NOTE for an RFC quality series: Swap table P4 is patch 1 - 12, and the
> dynamic ghost file is patch 13 - 15. Putting them together as RFC for
> easier review and discussions. Swap table P4 is stable and good to merge
> if we are OK with a few memcg reparent behavior (there is also a
> solution if we don't), dynamic ghost swap is yet a minimal proof of
> concept. See patch 15 for more details. And see below for Swap table 4
> cover letter (nice performance gain and memory save).

To be honest, I really dislike the name "ghost." I would
prefer something that reflects its actual functionality.
"Ghost" does not describe what it does and feels rather
arbitrary.

I suggest retiring the name "ghost" and replacing it with
something more appropriate. "vswap" could be a good option,
but Nhat is already using that name.

>
> This is based on the latest mm-unstable, swap table P3 [1] and patches
> [2] and [3], [4]. Sending this out early, as it might be helpful for us
> to get a cleaner picture of the ongoing efforts, make the discussions eas=
ier.
>
> Summary: With this approach, we can have an infinitely or dynamically
> large ghost which could be identical to "virtual swap", and support
> every feature we need while being *runtime configurable* with *zero
> overhead* for plain swap and keep the infrastructure unified. Also
> highly compatible with YoungJun's swap tiering [5], and other ideas like
> swap table compaction, swapops, as it aligns with a few proposals [6]
> [7] [8] [9] [10].
>
> In the past two years, most efforts have focused on the swap
> infrastructure, and we have made tremendous gains in performance,
> keeping the memory usage reasonable or lower, and also greatly cleaned
> up and simplified the API and conventions.
>
> Now the infrastructures are almost ready, after P4, implementing an
> infinitely or dynamically large swapfile can be done in a very easy to
> maintain and flexible way, code change is minimal and progressive
> for review, and makes future optimization like swap table compaction
> doable too, since the infrastructure is all the same for all swaps.
>
> The dynamic swap file is now using Xarray for the cluster info, and
> inside the cluster, it's all the same swap allocator, swap table, and
> existing infrastructures. A virtual table is available for any extra
> data or usage. See below for the benefits and what we can achieve.
>
> Huge thanks to Chris Li for the layered swap table and ghost swapfile
> idea, without whom the work here can't be archived. Also, thanks to Nhat
> for pushing and suggesting using an Xarray for the swapfile [11] for
> dynamic size. I was originally planning to use a dynamic cluster
> array, which requires a bit more adaptation, cleanup, and convention
> changes. But during the discussion there, I got the inspiration that
> Xarray can be used as the intermediate step, making this approach
> doable with minimal changes. Just keep using it in the future, it
> might not hurt too, as Xarray is only limited to ghost / virtual
> files, so plain swaps won't have any extra overhead for lookup or high
> risk of swapout allocation failure.
>
> I'm fully open and totally fine for suggestions on naming or API
> strategy, and others are highly welcome to keep the work going using
> this flexible approach. Following this approach, we will have all the
> following things progressively (some are already or almost there):
>
> - 8 bytes per slot memory usage, when using only plain swap.
>   - And the memory usage can be reduced to 3 or only 1 byte.
> - 16 bytes per slot memory usage, when using ghost / virtual zswap.
>   - Zswap can just use ci_dyn->virtual_table to free up it's content
>     completely.
>   - And the memory usage can be reduced to 11 or 8 bytes using the same
>     code above.
>   - 24 bytes only if including reverse mapping is in use.
> - Minimal code review or maintenance burden. All layers are using the exa=
ct
>   same infrastructure for metadata / allocation / synchronization, making
>   all API and conventions consistent and easy to maintain.
> - Writeback, migration and compaction are easily supportable since both
>   reverse mapping and reallocation are prepared. We just need a
>   folio_realloc_swap to allocate new entries for the existing entry, and
>   fill the swap table with a reserve map entry.
> - Fast swapoff: Just read into ghost / virtual swap cache.
> - Zero static data (mostly due to swap table P4), even the clusters are
>   dynamic (If using Xarray, only for ghost / virtual swap file).
> - So we can have an infinitely sized swap space with no static data
>   overhead.
> - Everything is runtime configurable, and high-performance. An
>   uncompressible workload or an offline batch workload can directly use a
>   plain or remote swap for the lowest interference, memory usage, or for
>   best performance.
> - Highly compatible with YoungJun's swap tiering, even the ghost / virtua=
l
>   file can be just a tier. For example, if you have a huge NBD that doesn=
't
>   care about fragmentation and compression, or the workload is
>   uncompressible, setting the workload to use NBD's tier will give you on=
ly
>   8 bytes of overhead per slot and peak performance, bypassing everything=
.
>   Meanwhile, other workloads or cgroups can still use the ghost layer wit=
h
>   compression or defragmentation using 16 bytes (zswap only) or 24 bytes
>   (ghost swap with physical writeback) overhead.
> - No force or breaking change to any existing allocation, priority, swap
>   setup, or reclaim strategy. Ghost / virtual swap can be enabled or
>   disabled using swapon / swapoff.
>
> And if you consider these ops are too complex to set up and maintain, we
> can then only allow one ghost / virtual file, make it infinitely large,
> and be the default one and top tier, then it achieves the identical thing
> to virtual swap space, but with much fewer LOC changed and being runtime
> optional.
>
> Currently, the dynamic ghost files are just reported as ordinary swap fil=
es
> in /proc/swaps and we can have multiple ones, so users will have a full
> view of what's going on. This is a very easy-to-change design decision.
> I'm open to ideas about how we should present this to users. e.g., Hiding
> it will make it more "virtual", but I don't think that's a good idea.

Even if it remains visible in /proc/swaps, I would rather
not represent it as a real file in any filesystem. Putting
a "ghost" swapfile on something like ext4 seems unnatural.

>
> The size of the swapfile (si->max) is now just a number, which could be
> changeable at runtime if we have a proper idea how to expose that and
> might need some audit of a few remaining users. But right now, we can
> already easily have a huge swap device with no overhead, for example:
>
> free -m
>                total        used        free      shared  buff/cache   av=
ailable
> Mem:            1465         250         927           1         356     =
   1215
> Swap:       15269887           0    15269887
>
> And for easier testing, I added a /dev/ghostswap in this RFC. `swapon
> /dev/ghostswap` enables that. Without swapon /dev/ghostswap, any existing
> users, including ZRAM, won't observe any change.

/dev/ghostswap is assumed to be a virtual block device or
something similar? If it is a block device, how is its size
related to si->size?

Looking at [PATCH RFC 14/15] mm, swap: add a special device
for ghost swap setup, it appears to be a character device.
This feels very odd to me. I=E2=80=99m not in favor of coupling the
ghost swapfile with a memdev character device.
A cdev should be a true character device.

>
> =3D=3D=3D
>
> Original cover letter for swap table phase IV:
>
> This series unifies the allocation and charging process of anon and shmem=
,
> provides better synchronization, and consolidates cgroup tracking, hence
> dropping the cgroup array and improving the performance of mTHP by about
> ~15%.
>
> Still testing with build kernel under great pressure, enabling mTHP 256kB=
,
> on an EPYC 7K62 using 16G ZRAM, make -j48 with 1G memory limit, 12 test
> runs:
>
> Before: 2215.55s system, 2:53.03 elapsed
> After:  1852.14s system, 2:41.44 elapsed (16.4% faster system time)
>
> In some workloads, the speed gain is more than that since this reduces
> memory thrashing, so even IO-bound work could benefit a lot, and I no
> longer see any: "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying
> PF", it was shown from time to time before this series.
>
> Now, the swap cache layer ensures a folio will be the exclusive owner of
> the swap slot, then charge it, which leads to much smaller thrashing when
> under pressure.
>
> And besides, the swap cgroup static array is gone, so for example, mounti=
ng
> a 1TB swap device saves about 512MB of memory:
>
> Before:
>         total     used     free     shared  buff/cache available
> Mem:    1465      854      331      1       347        610
> Swap:   1048575   0        1048575
>
> After:
>         total     used     free     shared  buff/cache available
> Mem:    1465      332      838      1       363        1133
> Swap:   1048575   0        1048575
>
> It saves us ~512M of memory, we now have close to 0 static overhead.
>
> Link: https://lore.kernel.org/linux-mm/20260218-swap-table-p3-v3-0-f4e34b=
e021a7@tencent.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20260213-memcg-privid-v1-1-d8cb7af=
cf831@tencent.com/ [2]
> Link: https://lore.kernel.org/linux-mm/20260211-shmem-swap-gfp-v1-1-e9781=
099a861@tencent.com/ [3]
> Link: https://lore.kernel.org/linux-mm/20260216-hibernate-perf-v4-0-1ba9f=
0bf1ec9@tencent.com/ [4]
> Link: https://lore.kernel.org/linux-mm/20260217000950.4015880-1-youngjun.=
park@lge.com/ [5]
> Link: https://lore.kernel.org/all/CAMgjq7BvQ0ZXvyLGp2YP96+i+6COCBBJCYmjXH=
GBnfisCAb8VA@mail.gmail.com/ [6]
> Link: https://lwn.net/Articles/974587/ [7]
> Link: https://lwn.net/Articles/932077/ [8]
> Link: https://lwn.net/Articles/1016136/ [9]
> Link: https://lore.kernel.org/linux-mm/20260208215839.87595-1-nphamcs@gma=
il.com/ [10]
> Link: https://lore.kernel.org/linux-mm/CAKEwX=3DOUni7PuUqGQUhbMDtErurFN_i=
=3D1RgzyQsNXy4LABhXoA@mail.gmail.com/ [11]
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Chris Li (1):
>       mm: ghost swapfile support for zswap
>
> Kairui Song (14):
>       mm: move thp_limit_gfp_mask to header
>       mm, swap: simplify swap_cache_alloc_folio
>       mm, swap: move conflict checking logic of out swap cache adding
>       mm, swap: add support for large order folios in swap cache directly
>       mm, swap: unify large folio allocation
>       memcg, swap: reparent the swap entry on swapin if swapout cgroup is=
 dead
>       memcg, swap: defer the recording of memcg info and reparent flexibl=
y
>       mm, swap: store and check memcg info in the swap table
>       mm, swap: support flexible batch freeing of slots in different memc=
g
>       mm, swap: always retrieve memcg id from swap table
>       mm/swap, memcg: remove swap cgroup array
>       mm, swap: merge zeromap into swap table
>       mm, swap: add a special device for ghost swap setup
>       mm, swap: allocate cluster dynamically for ghost swapfile
>
>  MAINTAINERS                 |   1 -
>  drivers/char/mem.c          |  39 ++++
>  include/linux/huge_mm.h     |  24 +++
>  include/linux/memcontrol.h  |  12 +-
>  include/linux/swap.h        |  30 ++-
>  include/linux/swap_cgroup.h |  47 -----
>  mm/Makefile                 |   3 -
>  mm/internal.h               |  25 ++-
>  mm/memcontrol-v1.c          |  78 ++++----
>  mm/memcontrol.c             | 119 ++++++++++--
>  mm/memory.c                 |  89 ++-------
>  mm/page_io.c                |  46 +++--
>  mm/shmem.c                  | 122 +++---------
>  mm/swap.h                   | 122 +++++-------
>  mm/swap_cgroup.c            | 172 ----------------
>  mm/swap_state.c             | 464 ++++++++++++++++++++++++--------------=
------
>  mm/swap_table.h             | 105 ++++++++--
>  mm/swapfile.c               | 278 ++++++++++++++++++++------
>  mm/vmscan.c                 |   7 +-
>  mm/workingset.c             |  16 +-
>  mm/zswap.c                  |  29 +--
>  21 files changed, 977 insertions(+), 851 deletions(-)
> ---
> base-commit: 4750368e2cd365ac1e02c6919013c8871f35d8f9
> change-id: 20260111-swap-table-p4-98ee92baa7c4
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>
>

Thanks
Barry

