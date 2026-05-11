Return-Path: <cgroups+bounces-15780-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDhsFh00AmocpAEAu9opvQ
	(envelope-from <cgroups+bounces-15780-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:55:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F3515525
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3626A30182C7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDB737E31E;
	Mon, 11 May 2026 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeKocPaL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B937EFEF
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529307; cv=pass; b=R6Mia3oDcYsOY4xocz1Rh6M6dV6S1n/BgOhrKkl2OqqWQfCNTBl4Ce0P5B2OrBTvedpgoF5s/RE5O1ni8+Giq7o9F0jje0eTDfuI4NHy/2ox2rGaJ4IYWjVd9clPt4cUsSqsTIQDOJKtnMpUrf5wBnlplpq+ON/1xCF/4gdPArw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529307; c=relaxed/simple;
	bh=OR8yyipJ9O4RJUTelOjhogfDT0juzOkkFJACSZPniZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7tV5EaCgH/o07tJI6PdP9UUYtmX5vd8wicx5BPmsF6QF3Q/L9Vd34bCFuTpPnMm1lxwdwMNiDjIgiSUxqhloDpWWQNPCTxML8kHaQQrZJd/RdvvCGHquefk4Er3Qt2/tksB7hkQ+kBUJ3E3OS/8J5fZyfW2PCe4gP95s2e6EIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeKocPaL; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so52929335e9.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 12:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778529302; cv=none;
        d=google.com; s=arc-20240605;
        b=KVQ1Hqr32DK8YyOM0M7/KG26XWaUNAU2Q0s+2WvabELe6aDyEd1mm+QPF5oSNImeL4
         xj7GXyQFzqy0wsxIUxRgiiDkZJT+VW19C1R6nfwumEI/B6Sei2fnyXIYnUjhkFrzp0d/
         fnuH87Mt1BVe5cv4eWHT0khLgGqNnqXtzhADwSV70DwdsSroAyWijO0TaQMHhtwC5wu7
         L/FbsGXH9zhsr3pSqxltZT/c6QBoFePDKw51aY6BDoW662v9OhYuZpWH0Vl+8zLJHCkJ
         1wBS4BGowEuXSv9JBveuZBjDT/5LbvKKrPfL7SbwrJ2O9fCi+OOdZ/i5fkYb0Eta5D6l
         ZE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7Wb8FVSSb9fnvT6S6aZiv4w+DGoN/cjPv8shYHV1nQ=;
        fh=PpYKb7Wh6azt2PNJn++KGawUWszxschblLoZWEdA+Jk=;
        b=jUQpoSVH9NHgv4dEhvIYH36Wjo9VkBL1VoGjmQW9HPBRbWycRMf/hZyh1kuZeHa0CK
         xr0vv3gg3/fh9LuGWNWXWvRDMfNW3FH1rbFSzQT+XyXFMuYFEwvOBWgBOY8MJBeow4T7
         w25buVXNhwSV0MOwHUkyIczCMg9vVOsn37BFXwcYkDxsGvzOmXUZIYaawdRhwF10dMZh
         OpxYQmIigTpAqWgdDmTCZqdNfSLeePipdyIAOiEnD0UY6KuFPn5nl0QoFucoQjpeZUw0
         mu1EToJc3ob/c6qrR8pDM9lxxV2r7vc4sLjfxVizBUUXAVFHz2LW4thcOnWWQIcq2/ia
         PXEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529302; x=1779134102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Wb8FVSSb9fnvT6S6aZiv4w+DGoN/cjPv8shYHV1nQ=;
        b=CeKocPaLEIpSVqSueKt8H84eXmwtv8RhcMr0J6jVE3s2TS8+/ScEingp98QivcPsKq
         kD1dHmqMvr228Ww6M4Urc3cyfNFT9If0xn7xRQbTQVyqS/MjsNOTGyh54bKvoy7DhUbV
         wFvxLnnTZHla6+SDUHFjHa0taFeF5u5KJZv0PRRIwvzYMDdQgkOk1NhdolkNJlWcBWiz
         w42WoSwwUt3YFTfGrkxT8RovFNqlb6z2jABh9QQi9qL6sKnydscw9YAgKgA8AowcwKSX
         4vloRRQyFlcq8du+Ewnr4H13yPqWDik6iw+bIvJhkzyDo8ya6D8J9RvYDyFJvFavSfTR
         GIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529302; x=1779134102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7Wb8FVSSb9fnvT6S6aZiv4w+DGoN/cjPv8shYHV1nQ=;
        b=WJu6mHXBREl+opWGGlB8ZfhU6iqfUmapMKAD7yzda//KpjKGl7uyMnJ4cEKByWDZWo
         3yV1dLENOkTuj1Mj20UlN9RlyLrScf7B+lNbq0Vb9duhnuVh89+xEWo5sRhFn7leOC2J
         keDMcZTMIAqmpp00Gb09by65so0I94OYIfT2hQpzaI9PS848VNQlkr77bWtdyhLH8/sM
         VqupLrii8OOSLffWcgf3xdl88tTAjiMSJRvOYQnjyRyVtLt3dKs0EJyH/i5R4GI/Ef3c
         vq+zy9MEJsJFF9aztrdgGOfHRZjfm1PXAzSfJniifQysudPWn9GNGxWoO+qWfjWRsqO1
         2flw==
X-Forwarded-Encrypted: i=1; AFNElJ88vbIxttLj801vLZUMSCSurci0wAeXRBJYz6TvujDNS8C9k5zUo4l5gPOoT8sfp+4aKRIptlIC@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq3p1tRnWcclOeH11inZZ61eRKwxxRzpU0Nn2eMY5hCAqblmJ
	ux64JFsOPRbQE435tjRbv3wOVZ/KLWMC+/Ew6Ze8IMhviwPW3UpXGrLp27ee/abz8rZhTucnxVr
	uiOOlGdhN4ERedxkvJ2rTke7IbsdmaWo=
X-Gm-Gg: Acq92OEQDwVRVHfFunJ9Gurxp3ZDa4vRlRRkjksEOnG6zH6ATDJMS+SLkctzcxmpSxZ
	r6QdRslLFka9d1nJ3jfieTEYCzi2D3K7Z/BO2h/MVzYL/xQMb2kM77myeVppIm/0h9UPeyW6g5U
	NydVWvKpdwzL5eQWB/nRO6TfPLaDgFpw1Cv0oUt8t2yx7dfeprTQ0PebZCidCTaCGc6Tk5oNPRW
	KLftQMuXIKuuzR1vMy3BJaAKAUhkpDHXH5YVLTXzqu7jaPG7Sjj0QHMQiIW7NFGG76jOozWLBYR
	O/0UlrsIdW89LxN67nj1t/cUmipMskEf10htGbU=
X-Received: by 2002:a05:600c:35d6:b0:489:1ff1:74d3 with SMTP id
 5b1f17b1804b1-48e707033f0mr185372725e9.20.1778529302289; Mon, 11 May 2026
 12:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com> <20260511105149.75584-3-jiahao.kernel@gmail.com>
In-Reply-To: <20260511105149.75584-3-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 11 May 2026 12:54:48 -0700
X-Gm-Features: AVHnY4KxTofzGA29WdApz7TAGVVFv1pib_PN6weIqMmJZRLUqnjNkT8S2YWonGY
Message-ID: <CAKEwX=PW2+EN41ANutv4cv+iM+JpwV5V+NSp5ukAt0M6fbHFLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zswap: Implement proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ED5F3515525
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15780-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lixiang.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Zswap currently writes back pages to backing swap devices reactively,
> triggered either by memory pressure via the shrinker or by the pool
> reaching its size limit. This reactive approach offers no precise
> control over when writeback happens, which can disturb latency-sensitive
> workloads, and it cannot direct writeback at a specific memory cgroup.
> However, there are scenarios where users might want to proactively
> write back cold pages from zswap to the backing swap device, for
> example, to free up memory for other applications or to prepare for
> upcoming memory-intensive workloads.
>
> Therefore, implement a proactive writeback mechanism for zswap by
> adding a new cgroup interface file memory.zswap.proactive_writeback
> within the memory controller.
>
> Users can trigger writeback by writing to this file with the following
> parameters:
> - max=3D<bytes>: The maximum amount of memory to write back (optional,
>   default: unlimited).
> - <age>: The minimum age of the pages to write back. Only pages that
>   have been in zswap for at least this duration will be written back.
>
> Example usage:
>   # Write back pages older than 1 hour (3600 seconds), max 10MB
>   echo "max=3D10M 3600" > memory.zswap.proactive_writeback
>
> The implementation consists of:
> 1. Add store_time to struct zswap_entry to record when each entry was
>    inserted into zswap, used for proactive writeback age comparison.
> 2. Introduce struct zswap_shrink_walk_arg, passed as the cb_arg to
>    list_lru_walk_one() in both the shrinker and proactive paths. It
>    carries the per-invocation cutoff_time and proactive flag down to
>    shrink_memcg_cb(), and propagates the encountered_page_in_swapcache
>    out-signal from the callback back to the caller.
> 3. Modify the callback function shrink_memcg_cb() to proactively
>    writeback zswap_entries that meet the time threshold.
> 4. Add zswap_proactive_writeback() as the proactive writeback driver:
>    a per-node batched list_lru_walk_one() loop bounded by the
>    writeback budget.
>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  24 ++++
>  include/linux/zswap.h                   |   8 ++
>  mm/memcontrol.c                         |  76 ++++++++++
>  mm/zswap.c                              | 176 ++++++++++++++++++++++--
>  4 files changed, 276 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed99..05b664b3b3e8 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1908,6 +1908,30 @@ The following nested keys are defined.
>         This setting has no effect if zswap is disabled, and swapping
>         is allowed unless memory.swap.max is set to 0.
>
> +  memory.zswap.proactive_writeback
> +       A write-only nested-keyed file which exists in non-root cgroups.
> +
> +       This interface allows proactive writeback of pages from the zswap
> +       pool to the backing swap device. This is useful to offload cold
> +       pages from the zswap pool to the slower swap device. It is only
> +       available if zswap writeback is enabled.
> +
> +       Users can trigger writeback by writing to this file with the foll=
owing
> +       parameters:
> +
> +       - "max=3D<bytes>" : Optional. The maximum amount of data to write=
 back.
> +         (default: unlimited). Please note that the kernel can over or u=
nder
> +         writeback this value.
> +
> +       - "<age>" : Required. The minimum age of the pages to write back
> +         (in seconds). Only pages that have been in the zswap pool for a=
t
> +         least this amount of time will be written back.
> +
> +       Example::
> +
> +         # Write back pages older than 1 hour (3600 seconds), max 10MB
> +         echo "max=3D10M 3600" > memory.zswap.proactive_writeback
> +
>    memory.pressure
>         A read-only nested-keyed file.
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index efa6b551217e..7a51b4f95017 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -44,6 +44,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_folio_swapin(struct folio *folio);
>  bool zswap_is_enabled(void);
>  bool zswap_never_enabled(void);
> +int zswap_proactive_writeback(struct mem_cgroup *root, unsigned long nr_=
max_writeback,
> +                             ktime_t cutoff);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -78,6 +80,12 @@ static inline bool zswap_never_enabled(void)
>         return true;
>  }
>
> +static inline int zswap_proactive_writeback(struct mem_cgroup *root,
> +                                           unsigned long nr_max_writebac=
k, ktime_t cutoff)
> +{
> +       return 0;
> +}
> +
>  #endif
>
>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 409c41359dc8..ba7f7b1954a8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -70,6 +70,7 @@
>  #include "memcontrol-v1.h"
>
>  #include <linux/uaccess.h>
> +#include <linux/parser.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/memcg.h>
> @@ -5891,6 +5892,76 @@ static ssize_t zswap_writeback_write(struct kernfs=
_open_file *of,
>         return nbytes;
>  }
>
> +enum {
> +       ZSWAP_WRITEBACK_MAX,
> +       ZSWAP_WRITEBACK_AGE,
> +       ZSWAP_WRITEBACK_ERR,
> +};
> +
> +static const match_table_t zswap_writeback_tokens =3D {
> +       { ZSWAP_WRITEBACK_MAX, "max=3D%s" },
> +       { ZSWAP_WRITEBACK_AGE, "%u" },
> +       { ZSWAP_WRITEBACK_ERR, NULL },
> +};
> +
> +static ssize_t zswap_proactive_writeback_write(struct kernfs_open_file *=
of,
> +                                              char *buf, size_t nbytes,
> +                                              loff_t off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       unsigned long nr_max_writeback =3D ULONG_MAX;
> +       substring_t args[MAX_OPT_ARGS];
> +       unsigned int age_sec;
> +       bool age_set =3D false;
> +       ktime_t cutoff_time;
> +       char *token, *end;
> +       int err;
> +
> +       if (!mem_cgroup_zswap_writeback_enabled(memcg))
> +               return -EINVAL;
> +
> +       buf =3D strstrip(buf);
> +
> +       while ((token =3D strsep(&buf, " ")) !=3D NULL) {
> +               if (!strlen(token))
> +                       continue;
> +
> +               switch (match_token(token, zswap_writeback_tokens, args))=
 {
> +               case ZSWAP_WRITEBACK_MAX:
> +                       nr_max_writeback =3D memparse(args[0].from, &end)=
;
> +                       if (*end !=3D '\0')
> +                               return -EINVAL;
> +                       nr_max_writeback >>=3D PAGE_SHIFT;
> +                       break;
> +               case ZSWAP_WRITEBACK_AGE:
> +                       if (age_set)
> +                               return -EINVAL;
> +
> +                       if (match_uint(&args[0], &age_sec))
> +                               return -EINVAL;
> +                       age_set =3D true;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (!age_set || !age_sec || !nr_max_writeback)
> +               return -EINVAL;
> +
> +       cutoff_time =3D ktime_sub(ktime_get_boottime(),
> +                               ns_to_ktime((u64)age_sec * NSEC_PER_SEC))=
;
> +       /* age_sec >=3D uptime: no entry can be that old, skip the walk. =
*/
> +       if (ktime_to_ns(cutoff_time) <=3D 0)
> +               return nbytes;
> +
> +       err =3D zswap_proactive_writeback(memcg, nr_max_writeback, cutoff=
_time);
> +       if (err)
> +               return err;
> +
> +       return nbytes;
> +}
> +
>  static struct cftype zswap_files[] =3D {
>         {
>                 .name =3D "zswap.current",
> @@ -5908,6 +5979,11 @@ static struct cftype zswap_files[] =3D {
>                 .seq_show =3D zswap_writeback_show,
>                 .write =3D zswap_writeback_write,
>         },
> +       {
> +               .name =3D "zswap.proactive_writeback",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .write =3D zswap_proactive_writeback_write,
> +       },
>         { }     /* terminate */
>  };
>  #endif /* CONFIG_ZSWAP */
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 19538d6f169a..1173ac6836fa 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -36,6 +36,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/list_lru.h>
>  #include <linux/zsmalloc.h>
> +#include <linux/timekeeping.h>
>
>  #include "swap.h"
>  #include "internal.h"
> @@ -160,6 +161,12 @@ struct zswap_pool {
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
>  };
>
> +struct zswap_shrink_walk_arg {
> +       ktime_t cutoff_time;
> +       bool proactive;
> +       bool encountered_page_in_swapcache;
> +};
> +
>  /* Global LRU lists shared by all zswap pools. */
>  static struct list_lru zswap_list_lru;
>
> @@ -183,6 +190,7 @@ static struct shrinker *zswap_shrinker;
>   * handle - zsmalloc allocation handle that stores the compressed page d=
ata
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
> + * store_time - Time when the entry was stored, for proactive writeback.
>   */
>  struct zswap_entry {
>         swp_entry_t swpentry;
> @@ -192,6 +200,7 @@ struct zswap_entry {
>         unsigned long handle;
>         struct obj_cgroup *objcg;
>         struct list_head lru;
> +       ktime_t store_time;

On the implementation side - will this blow up struct zswap_entry
memory footprint? If so, can you guard this behind a CONFIG option, if
we are to go this route?

