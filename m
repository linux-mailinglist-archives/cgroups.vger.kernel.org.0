Return-Path: <cgroups+bounces-14859-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIGDDHvnuWnBPQIAu9opvQ
	(envelope-from <cgroups+bounces-14859-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:44:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA142B4706
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D6130BDF10
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8F392C4F;
	Tue, 17 Mar 2026 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx8Petuv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62A37CD5A
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791088; cv=none; b=WLr+FtfFaOL3yNjOI2Iepz7b+yAWIuuADMkI8g8mnGM1j9wBpc/eXBuPHwjSytnRY3J8QLP8Qo2AKriSW2pJBNsUguekMlNLf9qEBqfnp2qm1Z0Td/s7q7e9L8Du8mXnSP2qaO6nzYpKtG9G3ksbqeRGQzTgMiJxR1Sd9sLV6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791088; c=relaxed/simple;
	bh=61d3W2tpnS0KkrdeI1XmmuVAhVXpxBDTBzXbwdbx58I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjK+gBFaGOuGMOEvkOnhEyXejLIzW5PC03fj6qHJEO1PLtEFcg0MMnTF6EE+ELTF95UvQf35hEGs4GnKKYqr9wl5sqC0vOaef+v8I3iUtga8doNuWiOKVkAwOHUtRjizfrxxUBfiGjGBX4kkCse5xPVb7JRRvzNVGgRfD57fTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx8Petuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF97C2BCC4
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773791088;
	bh=61d3W2tpnS0KkrdeI1XmmuVAhVXpxBDTBzXbwdbx58I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zx8PetuvkWzEq287mV1/1xmSAQFlPBf9HGJCgMfsSb3rm2Baozjac/ZeWWLFuodMo
	 90hHgnjtQ92Nfyxrr5BQ1EoAnfmLXBdVpUjDpGY8f2zBQ0aJpQQjEqoGX7CixHqx2t
	 En3s6WGYYvNnU+jKknNZNIAvgRO/vi3lprYBeFrl3NYgT+1P7jsU1c/yz/v5S4bdTd
	 yNHWGK20dSl1c7Y7S2+CO/9lB5MEVBLtDysupkUEtZI4y7CkoF6oNHVtSljB4g36o3
	 K6Vf9saNs9IbroueePq7bDhtcRjcjLD5APdZZf9bTs2jhiySXlU8Npjvlvh/cahprt
	 K03oB7bDxXDuw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b979d16dd0cso579244366b.1
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:44:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBy3veIUMwXruT0wCbOvqC7ZkyK6RvLopz8VEha9vzAjm6efUyHUDfNZuiqVnqB+FJHl4kHAdS@vger.kernel.org
X-Gm-Message-State: AOJu0YweST8aK8ScMLav2wwP0drcDY7xh9hiSSbZBy/bHfZSEM11TASS
	MwIUzROuwwXoRszowpT9WWmo2t6ZMzcA9odTAP4Rr5I9YBz+P2vNqNK/lGIdWKbeK+ymfh68mM5
	Z4GH8VlLRvsfTpHtavuEBmd3z43HCsoM=
X-Received: by 2002:a17:907:c1f:b0:b97:a215:3d1 with SMTP id
 a640c23a62f3a-b97f4aad947mr58264266b.42.1773791086816; Tue, 17 Mar 2026
 16:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317230720.990329-1-bingjiao@google.com> <20260317230720.990329-3-bingjiao@google.com>
In-Reply-To: <20260317230720.990329-3-bingjiao@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 17 Mar 2026 16:44:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP5HmeE1uOZE9WxN1GyC59mM_F2JGaKLEkxzzCvnxpW2g@mail.gmail.com>
X-Gm-Features: AaiRm53K1T7iGoYV3Lx1Cc_11ZGTWZyjENkvqraqWVXO2-lNXSjZMG9_FFHOcZc
Message-ID: <CAO9r8zP5HmeE1uOZE9WxN1GyC59mM_F2JGaKLEkxzzCvnxpW2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/memcontrol: disable demotion in memcg direct reclaim
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14859-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,google.com,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DA142B4706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 4:07=E2=80=AFPM Bing Jiao <bingjiao@google.com> wro=
te:
>
> NUMA demotion counts towards reclaim targets in shrink_folio_list(), but
> it does not reduce the total memory usage of a memcg. In memcg direct
> reclaim paths (e.g., charge-triggered or manual limit writes), where
> demotion is allowed, this leads to "fake progress" where the reclaim
> loop concludes it has satisfied the memory request without actually
> reducing the cgroup's charge.
>
> This could result in inefficient reclaim loops, CPU waste, moving all
> pages to far-tier nodes, and potentially premature OOM kills when the
> cgroup is under memory pressure but demotion is still possible.
>
> Introduce the MEMCG_RECLAIM_NO_DEMOTION flag to disable demotion in
> these memcg-specific reclaim paths. This ensures that reclaim
> progress is only counted when memory is actually freed or swapped out.

See the discussion @
https://lore.kernel.org/linux-mm/20250909012141.1467-1-cuishw@inspur.com/
and the commits/threads it is referring to.

>
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> ---
>  include/linux/swap.h |  1 +
>  mm/memcontrol-v1.c   | 10 ++++++++--
>  mm/memcontrol.c      | 16 +++++++++++-----
>  mm/vmscan.c          |  1 +
>  4 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7a09df6977a5..e83897a6dc72 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -356,6 +356,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, =
enum lru_list lru, int zone
>
>  #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> +#define MEMCG_RECLAIM_NO_DEMOTION (1 << 3)
>  #define MIN_SWAPPINESS 0
>  #define MAX_SWAPPINESS 200
>
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 433bba9dfe71..3cb600e28e5b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1466,6 +1466,10 @@ static int mem_cgroup_resize_max(struct mem_cgroup=
 *memcg,
>         int ret;
>         bool limits_invariant;
>         struct page_counter *counter =3D memsw ? &memcg->memsw : &memcg->=
memory;
> +       unsigned int reclaim_options =3D MEMCG_RECLAIM_NO_DEMOTION;
> +
> +       if (!memsw)
> +               reclaim_options |=3D MEMCG_RECLAIM_MAY_SWAP;
>
>         do {
>                 if (signal_pending(current)) {
> @@ -1500,7 +1504,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup =
*memcg,
>                 }
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                               memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)=
) {
> +                                                reclaim_options, NULL)) =
{
>                         ret =3D -EBUSY;
>                         break;
>                 }
> @@ -1520,6 +1524,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup =
*memcg,
>  static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  {
>         int nr_retries =3D MAX_RECLAIM_RETRIES;
> +       unsigned int reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP |
> +                                      MEMCG_RECLAIM_NO_DEMOTION;
>
>         /* we call try-to-free pages for make this cgroup empty */
>         lru_add_drain_all();
> @@ -1532,7 +1538,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup=
 *memcg)
>                         return -EINTR;
>
>                 if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> -                                                 MEMCG_RECLAIM_MAY_SWAP,=
 NULL))
> +                                                 reclaim_options, NULL))
>                         nr_retries--;
>         }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 303ac622d22d..fcf1cd0da643 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2287,6 +2287,8 @@ static unsigned long reclaim_high(struct mem_cgroup=
 *memcg,
>                                   gfp_t gfp_mask)
>  {
>         unsigned long nr_reclaimed =3D 0;
> +       unsigned int reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP |
> +                                      MEMCG_RECLAIM_NO_DEMOTION;
>
>         do {
>                 unsigned long pflags;
> @@ -2300,7 +2302,7 @@ static unsigned long reclaim_high(struct mem_cgroup=
 *memcg,
>                 psi_memstall_enter(&pflags);
>                 nr_reclaimed +=3D try_to_free_mem_cgroup_pages(memcg, nr_=
pages,
>                                                         gfp_mask,
> -                                                       MEMCG_RECLAIM_MAY=
_SWAP,
> +                                                       reclaim_options,
>                                                         NULL);
>                 psi_memstall_leave(&pflags);
>         } while ((memcg =3D parent_mem_cgroup(memcg)) &&
> @@ -2572,7 +2574,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>                 /* Avoid the refill and flush of the older stock */
>                 batch =3D nr_pages;
>
> -       reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP;
> +       reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_NO_DEM=
OTION;
>         if (!do_memsw_account() ||
>             page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>                 if (page_counter_try_charge(&memcg->memory, batch, &count=
er))
> @@ -2610,7 +2612,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>
>         psi_memstall_enter(&pflags);
>         nr_reclaimed =3D try_to_free_mem_cgroup_pages(mem_over_limit, nr_=
pages,
> -                                                   gfp_mask, reclaim_opt=
ions, NULL);
> +                                       gfp_mask, reclaim_options, NULL);
>         psi_memstall_leave(&pflags);
>
>         if (mem_cgroup_margin(mem_over_limit) >=3D nr_pages)
> @@ -4638,6 +4640,8 @@ static ssize_t memory_high_write(struct kernfs_open=
_file *of,
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
>         unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
> +       unsigned int reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP |
> +                                      MEMCG_RECLAIM_NO_DEMOTION;
>         bool drained =3D false;
>         unsigned long high;
>         int err;
> @@ -4669,7 +4673,7 @@ static ssize_t memory_high_write(struct kernfs_open=
_file *of,
>                 }
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_page=
s - high,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, NULL);
> +                                       GFP_KERNEL, reclaim_options, NULL=
);
>
>                 if (!reclaimed && !nr_retries--)
>                         break;
> @@ -4690,6 +4694,8 @@ static ssize_t memory_max_write(struct kernfs_open_=
file *of,
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
>         unsigned int nr_reclaims =3D MAX_RECLAIM_RETRIES;
> +       unsigned int reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP |
> +                                      MEMCG_RECLAIM_NO_DEMOTION;
>         bool drained =3D false;
>         unsigned long max;
>         int err;
> @@ -4721,7 +4727,7 @@ static ssize_t memory_max_write(struct kernfs_open_=
file *of,
>
>                 if (nr_reclaims) {
>                         if (!try_to_free_mem_cgroup_pages(memcg, nr_pages=
 - max,
> -                                       GFP_KERNEL, MEMCG_RECLAIM_MAY_SWA=
P, NULL))
> +                                       GFP_KERNEL, reclaim_options, NULL=
))
>                                 nr_reclaims--;
>                         continue;
>                 }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 33287ba4a500..7a8617ba1748 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6809,6 +6809,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct m=
em_cgroup *memcg,
>                 .may_unmap =3D 1,
>                 .may_swap =3D !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP=
),
>                 .proactive =3D !!(reclaim_options & MEMCG_RECLAIM_PROACTI=
VE),
> +               .no_demotion =3D !!(reclaim_options & MEMCG_RECLAIM_NO_DE=
MOTION),
>         };
>         /*
>          * Traverse the ZONELIST_FALLBACK zonelist of the current node to=
 put
> --
> 2.53.0.851.ga537e3e6e9-goog
>

