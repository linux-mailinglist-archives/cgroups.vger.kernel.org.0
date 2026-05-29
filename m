Return-Path: <cgroups+bounces-16461-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFasGnbzGWp/0AgAu9opvQ
	(envelope-from <cgroups+bounces-16461-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:13:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB1608541
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EF530E61C9
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6747276C;
	Fri, 29 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRo9tY6W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901846AEE5
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084889; cv=pass; b=RNynKMonWxIhT1cevquhfDZgOQKlv4hlH4DWnXQ3nTeqogrPjRQn3pZuU17rPwy8id2Q8TXkCTDEk8BUEim3c/odqhLFCo5SVo9qLfWjxG0a/F9ud6Bf+LnWg0hBz3Ssfg/5VL9XL7+eIyPMfMTOWCj3Kiqih4GpLlrCo1sISl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084889; c=relaxed/simple;
	bh=KaqwHfp1L3nqAAOV0CMesoD1cT1icMUGhJtrVbzAUB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceRVZyCSvnEWVis4SSo98WERBehOXK7eX8j/glY+dQFkIXmx3wiH8Nm9lLzb4tbrF6XAdgteTMLoad/IKhR4q8UTdBqhTKTLL99qVqhEv+Vxkcx9r3LHgurxhburq2tPSgn8y6vWYPJfrBtSOzP0Ro+ZskILCOzaa+uPy2X0lYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRo9tY6W; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b0786beso95485965e9.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780084887; cv=none;
        d=google.com; s=arc-20240605;
        b=fbKCeS+cflEGHc5Z6IL/NbrSnqRU9lbyzvcPBNBPPape+zijHPru7bBPO1LYw8PZJK
         VGwpRBSWgR9lw7+ePSITi/aFpl3zyiPYmUcUI28bwDLN1iqFWDqyniiNLw7Qz5UrNTDG
         /yuDX/+9n4t6gVLvzH/4UEuIdM01ymEs97mTs8OfSUQyVFtqQYXOxNzqXXXhxOtEf5/A
         5X847pkMfyDbqEq0VPSsiXEo8wvnRabv2/rwbo7UPhTL6F0sBvHlDVqzl2liIfr5FFod
         kRaODgl03vIIe7GkXvqMpnSSQ/Q1j86jGaO92sPSTMHSXUV7Ig554XLqk32x1n4rJ0GJ
         vXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+5IFUGExZ+iwBSpEJguGBn5lCaGGh6fBKDVTB3MkGQ=;
        fh=J5/8F6iGVYoigxGZL1wJG/qzAr+GFxTjvYXl8rKyqJI=;
        b=C7zBbz0iQrOLjBom/lPLwrBHXl2veXDYNM0zY7jQq+wRA+OFpH05uEHDCeKoixSwM7
         vlF/7py0km5MND6MMKX9gotGTRzi0oWju26IM/g0mMDnp5XqZteL+mjiz8COvxiYzzDF
         QRSCPHfc5IQhxD831HS0NANQCbMwDVVxlWXfpgtpoU+ls5osxbX/a83PI9M9kehreTAf
         UvtO5MS4EYROxnYUzCOUzJka76xlhlaZRNkJXYFCM7GH/MwcRUPAlw63p05lJStUtKmc
         6O9Se4LxlGBzKLnCzs/++q7NGM/QR9fqU9VZWDChgvKBIe6m7VqpfbPyTQS8wE6q+aM0
         4n0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084887; x=1780689687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+5IFUGExZ+iwBSpEJguGBn5lCaGGh6fBKDVTB3MkGQ=;
        b=YRo9tY6WSEjvQ6vAxmBVKowUNPrb5s/xa4bmNhchNw3cRjg8I/Yc0kG7hqHZRVi66P
         dQ8aWcZJ4Wit3/Y49yYFn3UtaTuJeN3CbS2K5c3Yrt4UCbMOy6cewgBekS03liAVw4rs
         merzoSfErhFl6uDIxHq7MxX0p5ozUBv6x1Q0n5wqP/SCGcnMLWIKzwCZWa5BChNCoTin
         jDaj9r01YibIC1++cN+pRxHOtIz2y8VUvlwuxPjTErxH7BNQ4V9LBvrcqLwp28HNUG5h
         2WiVCnoQPdNyeVm/H9E+G1HyENZVAUZTc10X2xvpei6DpgZ3tYFctEf1GXdNdYNeAQIL
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084887; x=1780689687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+5IFUGExZ+iwBSpEJguGBn5lCaGGh6fBKDVTB3MkGQ=;
        b=c8ht8vCc3XBTYsHFDEL+1UCBUqaIQQE5/++XRu8rQK39nHf1WY4lJl1zmTfkBPULhn
         9Zp9xpaK9hnoXsyluOA49a7x0nFIjlxlx8qWwGg7ECoooSufMcfglJko7jFrMQoboXV3
         ZGv0GU6NYy4gjXyRDMvZt6I6LgPKwWyuxF2TznjHr2OeQXHEVgUfMD+ZONL5d7wo/lUI
         TKKM0cAoxkbXdcvLHDKnti2svQlm2+TWeUCqufPrIrJEC8z7N+IXQa1Owj5vUeFRcuA8
         wKC7IV4w3FfzuCIkX2ydVAxQ4ssNUoktlzZNg/BAfszUO2KPXOS7hQenJaD1PWCZF1Jc
         WjpA==
X-Forwarded-Encrypted: i=1; AFNElJ9gHTaKvX9y7OaQqc7yk2NtSSl+1jxAf/M0T93M8h02L+/pR51UrLouAqgr7UOLMa6Crh5vCNmC@vger.kernel.org
X-Gm-Message-State: AOJu0YwB725wZTCOaY1SO395HyeHyRtft1YfXxUo5oDpEyEu3MoXf1tK
	rILEUaP2hs+UAsPErSSddA7JLbhRfpakWP05MubRTweW4hvYP3sO8VCzf6694qUd21MfSDJa6w0
	cpJqyTH6Kbh2nH1cdUYdTVNkoCPCU+ic=
X-Gm-Gg: Acq92OGvA7vPDcXYbliB+T3vr02DWhPN3RENA0J37J/k196jcquWzijONm7RBTFWmdE
	vaJtyauRAH+DGsG2o6Y9t7bVL9OH1paG0j3bKDP4RbvEztYZ9jRhIIcv/amL6jaIZ4KABpyrsVJ
	at6S0C92SJq43TA+Dxi8tmSCs42gtl9tPPYq/ljXrowCqry557Xn4+cdpB7rOCOFV/wQHLOo0K2
	LfZ0JU8eWo0L/e2CMwwsomXc0FqYs7W9fVMLtHLFebHPr0lFAwyhYhr35pXThOc5GMl2wbeLRMf
	UNPluryaBYgUrT4DW9TU49pW06dkcpdCgEm0jsRWvFBSowkBmA==
X-Received: by 2002:a05:600c:8582:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490a29399fcmr13599005e9.14.1780084886357; Fri, 29 May 2026
 13:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com> <20260526114601.67041-4-jiahao.kernel@gmail.com>
In-Reply-To: <20260526114601.67041-4-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 13:01:14 -0700
X-Gm-Features: AVHnY4JBZV7V4Cuv6pthC1wuO8sZSjsWbark17MncjIwi_r03e6A9nAix31rk6E
Message-ID: <CAKEwX=PcFqmsdFqUnpWxrPkoc1B-1w3CEb0ydK3df0qJGG-mnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm/zswap: Add per-memcg stat for proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16461-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,lixiang.com:email]
X-Rspamd-Queue-Id: BDFB1608541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 4:46=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
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
>  Documentation/admin-guide/cgroup-v2.rst |  4 +++
>  include/linux/vm_event_item.h           |  1 +
>  mm/memcontrol.c                         |  1 +
>  mm/vmstat.c                             |  1 +
>  mm/zswap.c                              | 41 ++++++++++++++++++-------
>  5 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6564abf0dec5..7d65aef83f7b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1748,6 +1748,10 @@ The following nested keys are defined.
>           zswpwb
>                 Number of pages written from zswap to swap.
>
> +         zswpwb_proactive
> +               Number of pages written from zswap to swap by proactive
> +               writeback. This is a subset of zswpwb.
> +

nit: I think this is specifically the zswap_writeback_only mode right?

Technically, normal proactive reclaim (memory.reclaim) can also hit zswap :=
)

Maybe some clarification here?

>           zswap_incomp
>                 Number of incompressible pages currently stored in zswap
>                 without compression. These pages could not be compressed =
to
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index 03fe95f5a020..7a5bee0a20b6 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -138,6 +138,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT=
,
>                 ZSWPIN,
>                 ZSWPOUT,
>                 ZSWPWB,
> +               ZSWPWB_PROACTIVE,
>  #endif
>  #ifdef CONFIG_X86
>                 DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e205e5de193d..7648b3fd940e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -571,6 +571,7 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>         ZSWPIN,
>         ZSWPOUT,
>         ZSWPWB,
> +       ZSWPWB_PROACTIVE,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index f534972f517d..66fd06d1bb01 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1452,6 +1452,7 @@ const char * const vmstat_text[] =3D {
>         [I(ZSWPIN)]                             =3D "zswpin",
>         [I(ZSWPOUT)]                            =3D "zswpout",
>         [I(ZSWPWB)]                             =3D "zswpwb",
> +       [I(ZSWPWB_PROACTIVE)]                   =3D "zswpwb_proactive",
>  #endif
>  #ifdef CONFIG_X86
>         [I(DIRECT_MAP_LEVEL2_SPLIT)]            =3D "direct_map_level2_sp=
lits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7bcbf788f634..b45d094f532a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -160,6 +160,11 @@ struct zswap_pool {
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
>  };
>
> +struct zswap_shrink_walk_arg {
> +       bool proactive;
> +       bool encountered_page_in_swapcache;
> +};
> +
>  /* Global LRU lists shared by all zswap pools. */
>  static struct list_lru zswap_list_lru;
>
> @@ -1042,7 +1047,8 @@ static bool zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>   * freed.
>   */
>  static int zswap_writeback_entry(struct zswap_entry *entry,
> -                                swp_entry_t swpentry)
> +                                swp_entry_t swpentry,
> +                                bool proactive)
>  {
>         struct xarray *tree;
>         pgoff_t offset =3D swp_offset(swpentry);
> @@ -1097,6 +1103,12 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         if (entry->objcg)
>                 count_objcg_events(entry->objcg, ZSWPWB, 1);
>
> +       if (proactive) {
> +               count_vm_event(ZSWPWB_PROACTIVE);
> +               if (entry->objcg)
> +                       count_objcg_events(entry->objcg, ZSWPWB_PROACTIVE=
, 1);
> +       }
> +

With the above clarification, the rest LGTM.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

