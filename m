Return-Path: <cgroups+bounces-15977-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEY8Kc4iB2rasAIAu9opvQ
	(envelope-from <cgroups+bounces-15977-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:42:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5D550A30
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 15:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D071330FB75D
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C629A32D;
	Fri, 15 May 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAaS/rbS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C879283C93
	for <cgroups@vger.kernel.org>; Fri, 15 May 2026 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849603; cv=pass; b=pokWC3C0lprQm4KF7TP1k1D8G38q+Q23Y7bY2gcj7DGgaGj/JdfnsCFdU0m849Fp90CF91grWBnTCP7HZKj6vNRE6Fi9n3Z4CHwMau0CGMeZKyYsv5qEKz4/Fja8hvm5jIF5wYwbcNNO0xbVVtd8SVJnhom9qHsD0pmsfeTSn+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849603; c=relaxed/simple;
	bh=cDiD3mOBPjlimAEz84KDuOLMyycZtAzu4DSI3by0V5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDzdZQWayjkQ54AXgvZViYAU5bEvU+/kD75VR89Opk80hw53xQN3bZvZBxa3qcGZbSWUjpXufbvqFZJpl1AtyNLFgJePF7ZYb3AfNmBWBNvp4MOvNLw3n5Wz/ah3DDzFnYbEezDyhijnVftzgxwlvZle/BSqklIOo0oZcXGFjVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAaS/rbS; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so764757566b.0
        for <cgroups@vger.kernel.org>; Fri, 15 May 2026 05:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849599; cv=none;
        d=google.com; s=arc-20240605;
        b=lY7DO/MjirONJwbHiWe7i/FBVBHg56Lftj3FBSCMeJ9yNBlbohLU+0I95/BxnOcJ52
         WCJxMWDMAqGHgR4+aRAL7CA9Uzre6KqaJWgBhRlTl8/p9l6iPSHrdxztfmJ7JF7HRhyA
         k4W3vElFP7YcRv/4/AkKbv1ZhTMgI9qS7MnA3aplcgsbJgKcbdJ6vwgr9NeAvykBrhsg
         XhoMnwFvNJToYU8/32KcQy9a8E3URt66TeH6EZDyKos+cmKUjzbPxzessU53CxrZb14X
         XIv+HBAvTUmE2d/vY8As6YjmYepgEy99UyqRVE3ozAD3qIvoBKq35P0TmqL6nxILIACZ
         gH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ke0Li5xx3d2PGZfPx3tj+IVT63oudggFt2tC7FV9z5U=;
        fh=txvZZK6Tpu3AjkLdYpjM/KvaxOf/xvV6qe7RULC8t1A=;
        b=BzW/DOSdNwWkr1oYbi4swiNvf6TZdTRTrWh/tRMUY8D8m+A0JZ458Rc14ok7u59Pmd
         fKitgAw5fDmxa6dPE/S+kW87P3QMTnU8b6uUFmrHODQMF3XtO6hp+En4F+B+/uOeuJF9
         8ta7zn9LsaliqEaU7w9FQUSbC/Amz4jN3IN8WKPj1YoW2jYUaQETg5zkahMFQgcuED3U
         EHpI2+Mzplmey0liEd8OYIBVPg3nWn9XU1frv2SFCDTK7djhcpAbEZmpZOQgpbOWH41S
         wuFjMXYHSGfeqd865oukkh7xoTGE6tX8OgJMw+wu1CD26sp7F8oibFkRfk4RX7Z4PyF/
         Nslg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849599; x=1779454399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke0Li5xx3d2PGZfPx3tj+IVT63oudggFt2tC7FV9z5U=;
        b=WAaS/rbSCgW41KOwhheSZmr8cGbpttaJeVt6yttriLWKkXvjjD3w9KlMJSJnfPhtJ6
         eeRU9cWuQNNHC9RwqGe56BTI1q5CFuu7JJSx0PjUE4Zf60cfEd8+Zh7PoUulPlC0ZQ9W
         7FvIJxQYeyTt5HYA5jfLq2BXbbf9YbdwWJ0JIylL6fPOu64vgyOWl5ScYgQoCjuwi5rB
         JSK267ovxy7EWt6DUzaXVqkAvPuR3f8/c0Uw9ijyB+orbPFhTYxJxoqM9niIBjkxlgVg
         xIvm21DLNFeUfWddiyUCt8rq2QDGI1vwM34sbwlfL4wD0rkPcVhZhCKMTCa5zhZoVLcZ
         vSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849599; x=1779454399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ke0Li5xx3d2PGZfPx3tj+IVT63oudggFt2tC7FV9z5U=;
        b=j1zGiWe5DPn31mUBUISeGIzhmlW0j01l90nuS1m+eGqlf0puCTKugyp0qooqa6rySo
         EYDsBMCU0SD6EOoBynZggUeG2S+D/IivBUL3RLBwY+XCjWl0Pw6GVL7vnnhOxhFhyTfd
         etsqm/TLDcvYjHw8NPGJ0ao8NcfnMSGrBIlt4/RIaUoKGRlXpPN7Enxwe2LLD0iHpmiR
         HD1gzFpSlcGj6NJq3ArBH8yhQydVkBxevkd9UX0zkCwsd2Z3F0bJF+lcao4Gv5eFDzvJ
         MfnQd8xacZjvjKnTyIlHE99wCZgTAAAXFwEcwCVhPbEEQ3o6lNFJB/S9ojJBful/y3Mq
         GWEA==
X-Forwarded-Encrypted: i=1; AFNElJ98pBRGhpfNEqCE1avy2+VBOIrU29CSMS/+Rf1wgD6nnh3ImyYSWu6rfxHvMGkUDSq02Ra3S9Gn@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTN4uVgxLEzT1/mkExDlcHRdhahtSqnNfRAx8O5CoT479OHNB
	nnJE3Q91oF1h7YZxOJ+Rz2DDxHQXWcWu1zARWOgtDy3uRgpmUWlYOHEsVEhHeauWD3ZYNKj+Dat
	Uv8lWXv5ZBUFEzWMXGAnhGwDwMIAUob8=
X-Gm-Gg: Acq92OF2dP6lefbWop6k1lU+gWUwMN+oteapwmRr1ApWX9DIlnmWUkx+tA71phcgvs7
	0D3YhKj850mgvS/oxqloACSiUYTbZTPZJZhqAxwXoIWxSRZkQSQoS3OvSpb9x1nSw89JIJNoqnh
	yksFVA+hC10YwMh/2fojZlRzcUpxm/PwoH1RwWAbPKhcfCK4JC5BG1U3vxWKac0TAAwN8872WB0
	jl5jUq/WCpkfzTubW3jsXelngA7WM6LAXrwEP6K6ttAhr2Y5X5+fIcES9kCiGsscMhTRgEWhhhb
	oypiPRNGtYKAgKFleiUT4tdpZv7Kb/1TWmAp+9Jd
X-Received: by 2002:a17:906:f5a1:b0:bd5:7c3:ac9f with SMTP id
 a640c23a62f3a-bd517aa8204mr200673666b.47.1778849598429; Fri, 15 May 2026
 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com>
In-Reply-To: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 15 May 2026 20:52:41 +0800
X-Gm-Features: AVHnY4KKMC6UsoCY2OZW80O3AVaXMrw5VqL9AagwO8cKOz1-c41n3YswGGjQ8iM
Message-ID: <CAMgjq7BpZWs22W4F5G5vT2xskQENsoW3vgsKUvcy6KrNPb9B+A@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Usama Arif <usama.arif@linux.dev>, fujunjie <fujunjie1@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5E5D550A30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15977-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,qq.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 6:15=E2=80=AFPM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> This series unifies the allocation and charging of anon and shmem swap
> in folios, provides better synchronization, consolidates the metadata
> management, hence dropping the static array and map, and improves the
> performance. The static metadata overhead is now close to zero, and
> workload performance is slightly improved.
>
> For example, mounting a 1TB swap device saves about 512MB of memory:
>
> Before:
> free -m
>           total   used      free   shared   buff/cache   available
> Mem:       1464    805       346        1          382         658
> Swap:   1048575      0   1048575
>
> After:
> free -m
>           total   used      free   shared   buff/cache   available
> Mem:       1464    277       899         1         356        1187
> Swap:   1048575      0   1048575
>
> Memory usage is ~512M lower, and we now have a close to 0 static
> overhead. It was about 2 bytes per slot before, now roughly 0.09375
> bytes per slot (48 bytes ci info per cluster, which is 512 slots).
>
> Performance test is also looking good, testing Redis in a 2G VM using
> 6G ZRAM as swap:
>
> valkey-server --maxmemory 2560M
> redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
>
> Before: 3385017.283654 RPS
> After:  3433309.307292 RPS (1.42% better)
>
> Testing with build kernel under global pressure on a 48c96t system,
> limiting the total memory to 8G, using 12G ZRAM, 24 test runs,
> enabling THP:
>
> make -j96, using defconfig
>
> Before: user time 2904.59s system time 4773.99s
> After:  user time 2909.38s system time 4641.55s (2.77% better)
>
> Testing with usemem on a 32c machine using 48G brd ramdisk and 16G
> RAM, 12 test run:
>
> usemem --init-time -O -y -x -n 48 1G
>
> Before: Throughput (Sum): 6482.58 MB/s Free Latency: 371371.67us
> After:  Throughput (Sum): 6539.28 MB/s Free Latency: 363059.88us
>
> Seems similar, or slightly better.
>
> This series also reduces memory thrashing, I no longer see any:
> "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF", it was
> shown several times during stress testing before this series when under
> great pressure:
>
> Before: grep -Ri VM_FAULT_OOM <test logs> | wc -l =3D> 18
> After:  grep -Ri VM_FAULT_OOM <test logs> | wc -l =3D> 0
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Changes in v4:
> - Rebased on latest mm-unstable and re-test, benchmark results are
>   basically the same so mostly kept unchanged. Changes in v4 are code
>   style and very minor behavior change.
> - Improve a few commit messages, rename a few variables as suggested by
>   [ Chris Li ].
> - Rename thp_limit_gfp_mask to thp_shmem_limit_gfp_mask as suggested by
>   [ Zi Yan ].
> - Cleanup a few allocation and code style issue [ YoungJun Park ]
> - Remove the forced fallback in swap_cache_alloc_folio, the caller will
>   pass in the exact orders to be used. [ Baolin Wang ]

I thing I forgot to mention is that this will also provide better
infra from swap side for Usama's PMD swapin, now
swap_cache_alloc_folio(orders=3D<PMD ORDER>) will provide a stable PMD
sized folio that is ready to be used as swap cache folio for doing IO.

> - Rename swapin_entry to swapin_sync, it's only used by synchronization
>   devices at this moment and describes what it does better
>   [ David Hildenbrand ]

And the rename here is inspired from Fujunjie's ZSWAP series. This
series should also enable the implementation of more generic THP
(including zswap THP) support.

