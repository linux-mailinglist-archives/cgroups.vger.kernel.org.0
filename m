Return-Path: <cgroups+bounces-14532-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPPPGy0HpmkzJAAAu9opvQ
	(envelope-from <cgroups+bounces-14532-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 22:54:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8161E4453
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 22:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12E583212187
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA037DEBF;
	Mon,  2 Mar 2026 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpw7037S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006C37CD20
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487106; cv=pass; b=CYMB92FTAShBt2itazdXVRToLqmJxZcrXxmVswSxjUgm9JjTbmCa8Yj8oOQe5mJw9Tgei68gHDyw3K1+ZINKCNo0mjQ+dGhT+Q/YTAQ1rzoeCd9gjjrcoZs9mXOnIJKYAHE/TXBWR4fUIPzaY9eAFZeml8vE4jzTNC6fn1YBfPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487106; c=relaxed/simple;
	bh=IvrZPQIOMIO3/kn7dvu2vuZRJiNd90WA+8QZI2Kcp8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2owf0StwqR4H5HK8cCOz/U756cbOr7Q7vJvmZ8ogQxKyIZTXtH9Ie0mUel22/SxgQ7/QuYcptis6fCt2D3sGexjB0HEyJWLszm1ZWO8+45t0KRRgrmPB0WVBgdymxMWjBZIQwSGheZKKxGYlZocsvJDsdcsTQn9ISeyBfmwDxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpw7037S; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1316865f8f.1
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 13:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772487103; cv=none;
        d=google.com; s=arc-20240605;
        b=BgljGfNkXzNbBRLO2CBM+rTXI3RAmB4z5cd0gQq2JQeTkmxxAo0GiWEhrRS3YN/ooH
         wHK5M0bMrhZvXd7xqr2SeEU8ZujqCIHJ3DIlbY55vOxW0B3Z2cIGJcDySlr5xaTmxqYT
         ivI3mEvOYciSD3RVjt7XhyvhDOGhOKVPIjZuzqEW0TCuL3u5JDzRHOFjhJ5v2hmIR3bd
         V8yzIN82MpDTnFW/jpnuF+XJl+e4zIAyHQ8WpuJZVkwiEDYtWaR8WJQayh+BgVHrJAT1
         OASbRdpm0N51xc6/Ii8+WCYuG2lF4G6XWdO3cfuUnaGn/7T0+t8qnOM70fTDxQs8WHiU
         p4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0JnYb95iDChj3/nA5mqzcjZo5gKvv6WEwEzSfKKmoo=;
        fh=NC1cBJkKLwtfN0DxgD+bkqQ6XwHBOruhU1AQyZSmsRc=;
        b=HT9lZLjIy6O1/33bH3iWH5iaIgMymYrR3+FZNOl33yB2g2490EUbFc1TF2AejXtKxH
         Qg8mIKMtc3/GRPNB8s/QX3FuszCFrj75dbflJD2IK1jg7pxHmh7gWV2fi2Jrdmsawuju
         gnSfeC00P9If/THXwrQCeUQAFDbCpmEQdKIOXsttH+ZqR2i1htl38sYxBBJaF/hDrQzD
         1VT3zypE8N9zFMbf/xNcoQS5RuJWxqYpBbT+SlgdB6EjpAV+eJodJVCbN4DIHXeYvEgD
         28a2Z7EnG+6+4o7mP0qyBxHjZsynK3I9RRFeHxn80QYenwBqaP56F3Xr5AN1fU+cYL6G
         y9yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487103; x=1773091903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0JnYb95iDChj3/nA5mqzcjZo5gKvv6WEwEzSfKKmoo=;
        b=Zpw7037SGTl+RBn3N7yEQWpMSPK0rD3yuQNcYtmXPezAW9oj4wPNmLYYPUnXrmm0WP
         M+Z6qDWqi8QPLStxVFGD33j1yWBRu5iURN+avQoGZvAg//LxKcxwUlgMFX1774BS6Fur
         XIUm7ZV88W9vLd/SANhQA6dmyqOxDBxOZtK+S8gGTUcs/axfD4HHmYSgY2s+EDNfMgVB
         HPtzqdi8U/jTnRctMXs3vomUNvJFNjAX02Z0ZKhOD+r17wY/6eQtVz6mKgallXpA9G73
         jG9hsyt+PMmbbQlaSKD4EFFa2FROKtA3xKJKn4gyga/qEAI5imjoxtkD6F+e1xepyMzF
         rtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487103; x=1773091903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0JnYb95iDChj3/nA5mqzcjZo5gKvv6WEwEzSfKKmoo=;
        b=nH6iWAKZgZ/J8UTdq7q4EWGrbuBbGJQON59cIL+V6RyGc7vhknBQXTQbEAcBSg5ytC
         txC5e3RFTUBEtvgfiJLULkaQRDnqm9QmrQ69eZYaA259M5gUzFMc4EMR41YO7QqB8fk8
         Zk0z012aT5GMS+hvgzZTUHMzAey4ff1sLRonlExgkjhgtEtjcP+7nS8fbouPlYNVNGii
         96uv6JvZQQyVOGkQgABdCWdageoKLcnlIzG7dGur/K2pT7N4zPHajhOXkmCdZXPee14F
         ow/1yne/5loNNOoi1JbREs4VkIO6jqI0KjpfEF6dlT6TZ9wuuBgLXQyPq8MGQG5W1wyZ
         ZBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpBpbEu4/8LbmiDp7HXDMH4oV6kYLS2Q7WIwefBTSo06v0MCjlFWZci0h93ZSOVLHE6x0DTGg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hORE5kpiSrPrGFHFziRDejlMSTACywCuuTpu1fG0FtbLy+cV
	LpYEvJiTsDptJ5Q5vhLi1t+8ASWxSyiFl1wZ2x5QZXIr3udoEWEAoEfMgGd30ABkjvjcyjeU8hF
	MErz8g1b+iIVCdrAuNNbm1esGevuFy1A=
X-Gm-Gg: ATEYQzwqBNl1wch0sVfWVDPoySerz3S95bG3rH+Dqr3dOls0Eej6iC4hGDcUpRcFVRH
	R5LVGT8jYKiw0CgaVHeg3p8WTOsB5WP/7wAr72Iv5TbC8joebikUcIpAyMEpgIIuWFMB0nBCRRp
	9eEZGrNgSLbtQNYNxlfiUgC68qw5ZEkj2Y+QVauGj9w9qGy3HXS1lcXaXSDXNS9GBDNSoejJ375
	mEJ+skzW3NhctbRZqluvG3WZz9ld2Rkb+TDZWt58hfasZhCHdXU/8RwirBGuwR6vhl12wfD11oL
	drWJ8FVT0EHA546nCJYyf9Xi4ozD6KF37gAoLRM=
X-Received: by 2002:a5d:5849:0:b0:439:b636:1fa7 with SMTP id
 ffacd0b85a97d-439b636204amr12010712f8f.54.1772487103164; Mon, 02 Mar 2026
 13:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 2 Mar 2026 13:31:32 -0800
X-Gm-Features: AaiRm52AZxKxWz3NtbrxL6r9gkN1ice4-5rGfwkRSmDsEXhIUZmBNUwDASkb2Ic
Message-ID: <CAKEwX=N-yzg66Ge5YgDNG7nh3ues62fSjmi6oGq1B=gkz6e2Uw@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm/zswap, zsmalloc: Per-memcg-lruvec zswap accounting
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DD8161E4453
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14532-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:29=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> INTRODUCTION
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The current design for zswap and zsmalloc leaves a clean divide between
> layers of the memory stack. At the higher level, we have zswap, which
> interacts directly with memory consumers, compression algorithms, and
> handles memory usage accounting via memcg limits. At the lower level,
> we have zsmalloc, which handles the page allocation and migration of
> physical pages.
>
> While this logical separation simplifies the codebase, it leaves
> problems for accounting that requires both memory cgroup awareness and
> physical memory location. To name a few:
>
>  - On tiered systems, it is impossible to understand how much toptier
>    memory a cgroup is using, since zswap has no understanding of where
>    the compressed memory is physically stored.
>    + With SeongJae Park's work to store incompressible pages as-is in
>      zswap [1], the size of compressed memory can become non-trivial,
>      and easily consume a meaningful portion of memory.
>
>  - cgroups that restrict memory nodes have no control over which nodes
>    their zswapped objects live on. This can lead to unexpectedly high
>    fault times for workloads, who must eat the remote access latency
>    cost of retrieving the compressed object from a remote node.
>    + Nhat Pham addressed this issue via a best-effort attempt to place
>      compressed objects in the same page as the original page, but this
>      cannot guarantee complete isolation [2].
>
>  - On the flip side, zsmalloc's ignorance of cgroup also makes its
>    shrinker memcg-unaware, which can lead to ineffective reclaim when
>    pressure is localized to a single cgroup.
>
> Until recently, zpool acted as another layer of indirection between
> zswap and zsmalloc, which made bridging memcg and physical location
> difficult. Now that zsmalloc is the only allocator backend for zswap and
> zram [3], it is possible to move memory-cgroup accounting to the
> zsmalloc layer.
>
> Introduce a new per-zpdesc array of objcg pointers to track
> per-memcg-lruvec memory usage by zswap, while leaving zram users
> unaffected.
>
> This creates one source of truth for NR_ZSWAP, and more accurate
> accounting for NR_ZSWAPPED.
>
> This brings sizeof(struct zpdesc) from 56 bytes to 64 bytes, but this
> increase in size is unseen by the rest of the system because zpdesc
> overlays struct page. Implementation details and care taken to handle
> the page->memcg_data field can be found in patch 3.
>
> In addition, move the accounting of memcg charges to the zsmalloc layer,
> whose only user is zswap at the moment.
>
> PATCH OUTLINE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Patches 1 and 2 are small cleanups that make the codebase consistent and
> easier to digest.
>
> Patches 3, 4, and 5 allocate and populate the new zpdesc->objcgs field
> with compressed objects' obj_cgroups. zswap_entry->objcgs is removed,
> and redirected to look at the zspage for memcg information.
>
> Patch 6 moves the charging and lifetime management of obj_cgroups to
> the zsmalloc layer, which leaves zswap only as a plumbing layer to hand
> cgroup information to zsmalloc.
>
> Patches 7 and 8 introduce node counters and memcg-lruvec counters for
> zswap. Special care is taken for compressed objects that span multiple
> nodes.
>
> [1] https://lore.kernel.org/linux-mm/20250822190817.49287-1-sj@kernel.org=
/
> [2] https://lore.kernel.org/linux-mm/20250402204416.3435994-1-nphamcs@gma=
il.com/#t3
> [3] https://lore.kernel.org/linux-mm/20250829162212.208258-1-hannes@cmpxc=
hg.org/
> [4] https://lore.kernel.org/linux-mm/c8bc2dce-d4ec-c16e-8df4-2624c48cfc06=
@google.com/
>
> Joshua Hahn (8):
>   mm/zsmalloc: Rename zs_object_copy to zs_obj_copy
>   mm/zsmalloc: Make all obj_idx unsigned ints
>   mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
>   mm/zsmalloc: Store obj_cgroup pointer in zpdesc
>   mm/zsmalloc,zswap: Redirect zswap_entry->obcg to zpdesc
>   mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
>   mm/memcontrol: Track MEMCG_ZSWAPPED in bytes
>   mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
>
>  drivers/block/zram/zram_drv.c |  17 +-
>  include/linux/memcontrol.h    |  15 +-
>  include/linux/mmzone.h        |   2 +
>  include/linux/zsmalloc.h      |   6 +-
>  mm/memcontrol.c               |  68 ++------
>  mm/vmstat.c                   |   2 +
>  mm/zpdesc.h                   |  25 ++-
>  mm/zsmalloc.c                 | 282 ++++++++++++++++++++++++++++++++--
>  mm/zswap.c                    |  67 ++++----
>  9 files changed, 345 insertions(+), 139 deletions(-)

I might have missed it and this might be in one of the latter patches,
but could also add some quick and dirty benchmark for zswap to ensure
there's no or minimal performance implications? IIUC there is a small
amount of extra overhead in certain steps, because we have to go
through zsmalloc to query objcg. Usemem or kernel build should suffice
IMHO.

To be clear, I don't anticipate any observable performance change, but
it's a good sanity check :) Besides, can't be too careful with stress
testing stuff :P

