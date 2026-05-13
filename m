Return-Path: <cgroups+bounces-15919-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qRDeCnnrBGr/QQIAu9opvQ
	(envelope-from <cgroups+bounces-15919-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:22:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16753AF2C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 338A9301ABA1
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471A3B27C6;
	Wed, 13 May 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbudxygw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A53B19B1
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707315; cv=pass; b=D+La+s3BFJZ9LyKXLnT+ZCtzAcw2KBEBEjglICvQf2ThA+ddY7pz/XPwfOxkFetUPRAvL02fZkO8EJ/E02hiFi6dU32xjDaWm2x3ChqCi88GfB5lMoHEjy7Y+h4HjXqc9mzC4jvLrY0Uv1ZhBKfdWM/EcX3jS3NJZy7LMA/cXnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707315; c=relaxed/simple;
	bh=GwWTZ9wHU1c1tiJoXgTKyaUHGEkH2A3iGOiUNEu61bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEs3Cvh++mYox0j35KvpI+iM702iLhpZ1pjVDOtTa0ecEpjXtk7yOoXFJj6IU3FQ+NGiCdpgg3dijhPw6UHJGwQlsQzIyZ7vTN53iG2DmLvWqVVpy0GMQZv5/cxROHHV83a6GTy2e607bnAhyjY/vcOord4TFHVrqZNH2Ibb+Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbudxygw; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so66267445e9.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 14:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778707312; cv=none;
        d=google.com; s=arc-20240605;
        b=UB/X/Pby2NnFfM54uDcfOgOL6Nrv2q8aAegSoFs7JdXbXSjp9jnexyuoWFlOjNDbg7
         r7+xUjiH15juXK1rbSViI0mSlIWn8PW8LBePvck1YQ/RqgSU7HQHM27ofwIHTdvbtOXS
         rIzSM65DTopZ1Vsrfdf0qUREWGJHd2n6IuAKx0a6wBP4szCQwwewNTnOue0worxCmo+/
         n3QagWJ9a4uKTfdY/ZP27ObVuc+QwEwW49cIlfowHqtfhIBiCPS8ycLSj/mRkpYVCg6M
         /NLnvSEtzELme9bkJaQfDwxi9y2laewxQjSaHPu5HiYzrxR+GNNJMIooCjFekPJpsxk1
         9a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LiBJ0GST8n1XIAy51r++M8mb131NJHPjLOoQNAGYF8=;
        fh=3KEhLVvr5tG7xJAfk77/QbY55QYpBD7SOYYacRpD8Fc=;
        b=PEi/rKRIWcK13t9DvJF3YDZiWr2g1QVo7AmdNm9qOOk/qt321LeXPkj9peGTU36juK
         Izy6kKWVspBCWW8pDHf48z2wYDy7dN71lg8/UGEXK/eZm1rJ60SyqS4fH51YoYO42aGW
         yanNZR9i1JiqBCODFXDW+HydOArvpmAeUtLzwKL1yCONY+8HreqJMYA5v2fNAHSkXRQ+
         Vsd0EqJl3J02a5Z352xBAjTIREGxAkCR429lmycCEH7SnoHB43p5nM15QRshQVIhIAtU
         p2cUYApwRplO4bUNVVga9nF9wfvtpi8BPGAQkViVUIhGPqtdlUnrURSdwIyMXwqS2EiO
         eBVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707312; x=1779312112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LiBJ0GST8n1XIAy51r++M8mb131NJHPjLOoQNAGYF8=;
        b=Cbudxygwui6or2FS4/nAAP0+l0ghpe+tRnVxJ4IrpdgxmZ4JNwZYXPloMU8k8S3zjN
         JDm899AasKPQ+jtBm91pA7RQNSHIgsHS7yQKORH9615AzUtOhhVGIghcPaB5pW4VuM+D
         U9v1gTW9p//UWhke1XkIqFLfqmlGbsLfONNc4wAH7JcGW2vh0oZgldE8mE89wRpu0Rbk
         prGi3zY+Ohe8zM9wkabfHCsjWu7QSmQBg+09kgJHYXqZwsJbrvXxYGQyqw/NAZJBfGGD
         E6Iza6JMAGwHodUTZaO0pUp1h3R8T2RvfbVWPHGNkIQXNMT6wKTocRe4pMrTF3B7+t8C
         aJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707312; x=1779312112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LiBJ0GST8n1XIAy51r++M8mb131NJHPjLOoQNAGYF8=;
        b=HjGi5BG0RMuX17m2WnzPa/R9TwMKXlD4x7rDSAhT7z6/rgPBXTuwQdyXRxOzXw46FU
         qwxIJtz0oyY6M8Yplg157iHrD08aLQKm/7/fpS2idMJgKN5z5lIg/Vy09utvR0ILb9dy
         EKbCpTsPOV4w/Vj/cgWK2TdO9eAliI9R7IdJHNqPyEZuqggnB57squu2ozW52nF6soya
         zRsalDmSvIeJcdoc0lJ3NvV1tgkzWqT4OVLAcH6x9vGVWtF8FFI0otWVOZfHHo/1bgXy
         G3c/pwkQkGlxdNXLh9EsZdz3RGfJkil6vKlfwQgw2zYb0jQgGEzpu4uEJyMhQjaL8HeP
         Ws6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Z3zFzK0xnXRujmLAlI5d29Jnt4aYyCTHBfsQBPtOsdCPGI8vfoz+iyvIBu1d44WHaItzVFx8v@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVhsOHaGJQqpcScg882X9uI0LSAUoycmqMSUyj1RQxznhu28F
	3TXBzsFKxZSYj5y6ckVhq2V/A7MD9I46aGb6MFGVK7AH/9DuwVc+hFT4DXz3l0lPDossNJVPa6g
	1LJ2HUzwi0AxXrUHLhm/4+MGfnWW30XU=
X-Gm-Gg: Acq92OFSdyQCgwQISHvOTJ51atG7QBoQGsiAIT3zyiYNi8Es+Q5z5I6Y6OfHOrOswMm
	vGYuwGMh3LdK3u4KtPQn19v+on0ijZ2vb9WYpoACV6UGwfYWrpirNavMzZIEShTF5u9B+JxrsK4
	j/8vKLVfyen9pqPdFMEbpGRPxnA0VGf5VVdFwrHa5I0RC5Q/1Di2pb9sEEXDiZ01yLmMCOnP/eb
	bRctiYhLjnkyFGnqN+p3QPuvUIbKhf+c3aK/DnAxxttG91p+Z2nZtrp0VJHlClzpcUaoPzjx8QA
	mOv99PMD8fGvF6FwdgPesPV4fshnu/S2JHNGxMQ=
X-Received: by 2002:a05:600c:828d:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48fc9a0eda5mr74529125e9.12.1778707312397; Wed, 13 May 2026
 14:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com> <20260511105149.75584-4-jiahao.kernel@gmail.com>
In-Reply-To: <20260511105149.75584-4-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 May 2026 14:21:40 -0700
X-Gm-Features: AVHnY4LlrQC7Ry6VArRSJYRPvyqB23MBm6HpLrXk9Drx2Jq6lQCY_hsRAA8ZZgo
Message-ID: <CAKEwX=OigngmcNo1OU-apCFG2hebt5yZwXQxZQHqgC7SwH_HAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/zswap: Add per-memcg stat for proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6E16753AF2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15919-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lixiang.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Currently, zswap writeback can be triggered by either the pool limit
> being hit or by the proactive writeback mechanism. However, the
> existing 'zswpwb' metric in memory.stat and /proc/vmstat counts all
> written back pages, making it difficult to distinguish between pages
> written back due to the pool limit and those written back proactively.
>
> Add a new statistic 'zswpwb_proactive' to memory.stat and /proc/vmstat.
> This counter tracks the number of pages written back due to proactive
> writeback. This allows users to better monitor and tune the proactive
> writeback mechanism.
>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
>  include/linux/vm_event_item.h           |  1 +
>  mm/memcontrol.c                         |  1 +
>  mm/vmstat.c                             |  1 +
>  mm/zswap.c                              | 11 +++++++++--
>  5 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 05b664b3b3e8..29a189b18efc 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1734,6 +1734,10 @@ The following nested keys are defined.
>           zswpwb
>                 Number of pages written from zswap to swap.
>
> +         zswpwb_proactive
> +               Number of pages written from zswap to swap by proactive
> +               writeback. This is a subset of zswpwb.
> +
>           zswap_incomp
>                 Number of incompressible pages currently stored in zswap
>                 without compression. These pages could not be compressed =
to

nit: once we have reached consensus on an interface, can you add
documentation for the new knob in cgroup v2 doc and zswap doc too, and
how it interacts with the other interface (memory.zswap.writeback,
shrinker_enabled sysfs knob).

A kselftest would be very much appreciated too :)

