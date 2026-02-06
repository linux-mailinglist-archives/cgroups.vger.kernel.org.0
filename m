Return-Path: <cgroups+bounces-13755-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMSHMKFvhmnONAQAu9opvQ
	(envelope-from <cgroups+bounces-13755-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:48:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E005D103F23
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D171300E458
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB12E7648;
	Fri,  6 Feb 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWeUBFOG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D942248AF
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418070; cv=pass; b=TxjgrGI24rhNOapwBSwYgOYIHegi4SSLN/zIuM9SGeutFVppf3dC3qCgQcIEVpWgX251OEoKhtHTZawHPP8PnkAg5pu8FdDjD4V4Xr2T3UiiElC2IYLR5zcePJ9oeLnRQKE3Z2T6pq7xA1ODr4DEuqVYpumxkKqwpX2tN2h6/0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418070; c=relaxed/simple;
	bh=KZMki9zsd7xqDhqCfSZ+tkLRxJNln01g4KOtMebtSWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4MbLk4J7or3It954owHaKwT0KHwhMn3geNf6fAi15MdGF4VnBnVbJPZFCtqPJHHLEKZyss7tt3x+uCGVPyXGWy7fk+ThKingvjm0gyOZo+Lqw5Y4cN0N3VDYNskcXt+ri2kdOQi0s0aNzAmJgrb54G5UZ6feQNRBV4d9bQYHBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWeUBFOG; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9697so947c88.1
        for <cgroups@vger.kernel.org>; Fri, 06 Feb 2026 14:47:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770418069; cv=none;
        d=google.com; s=arc-20240605;
        b=FrHMcoPknne4m9KIzK5u+CgomzY8NMiJ8J6MjE3lR9sM4xiXLZykaSAnhla0fgW2Qn
         EgZ2UK5d4crCA8utzapyBiNmVnP814LUpYr/6tZ+HtVkP6CUKdG1qMQVgQIAmlisX+Zo
         S702KOAMHnSERx/UcxYMcSc5nYq9a+/wH3pkQjhv0do0CrR5rq7HzpP7PU6BIcXHcs5O
         bOmtodm7zk1JqUSyaAaIE+IY63u5KcBla8RJTbqOa4q8lVcfGn5ycU37EM5TednzOnM7
         GN683V9OIrVoFE5yRCazlGh86R7Pr4SNblVBXTk7ZRcHkWe12WjfjP4Vj7abJmApIWk2
         KMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+xzzbafv7IMwH2ifuNO4060POJWB+v1zgMFdCY/APJk=;
        fh=P23x1xg20oJG2/Ijg53O6MIA1BWVIb0/GUULZoQAuI0=;
        b=OyF2GPPDE5Y54USE3TSgNPw+oyA84pgdx2bDqQkdR5CYOvmzpGq+6UwydU6i0sHIjk
         2QMPbrMz3E7yU/fffnPZ91zfmdlH7Y90niYcwEdASCgj4j48imNjMFyeyyA0uPSKojIL
         7yc0KPsAvS0lcLvJ+EInjw17zsY8KsF9Nw5usqL+L5gdgxd3xDDq3KfMTupz2gqU1pHp
         i6Eg6pOYXjs9DV/2JFMl7VaL5Zv1Seurypu9pH0g2EbziDLiC1/iSwTWs0IzV/Ednf+r
         KQVO/vqqnlYqCjzMQAMLcUM6WmBweqWnYO4lshfk46wFeSFAvW9PMcP+Sm0uagK/rsiG
         QNdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770418069; x=1771022869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xzzbafv7IMwH2ifuNO4060POJWB+v1zgMFdCY/APJk=;
        b=KWeUBFOGBoO9sLdsqaPOXLQuaUpIjOogPOILMuLMHzNVYcn3MPHiwZvkoj1AvQlNMH
         co/e/mq7PeRkbPuic/6b1GOlqDWnyYscOFOTfUWHPu9iE0tozBWYNPH+C5lx2rXI9pKO
         JNqbGTnNi4iXprHBf1qPRl9z9gXNW7vDnAo9sIT9ecP3+HSa3SELxsdSr8WZX5zVuguc
         rZRO8MFA9UUZYgeA9MWoEfYFyS0PeLOxQBqMI58WQD+m+Ab37B1KfVHzZIk4QhU5smJn
         CG6iL7xVw8/Yrr4YEtHIJEazx44ytthyblmFVe6h63lBkDz6/pYkwFKElP7YUEbYOdSN
         MpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770418069; x=1771022869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+xzzbafv7IMwH2ifuNO4060POJWB+v1zgMFdCY/APJk=;
        b=aWjTx5bnqvVltAaevZrAhdb0sVXuXCEjLkCYsl2pVOqiAOMFG9lAMhfq322yvX/w8d
         Z6ZVoQ/sJsOCPggUzHvJo+M50sDHQ/72xiLr7LFkUTFnj0+uR5evEhu7YcvsPB+Nze1b
         hc48lPYeRZfkvgPo6ce0qX1Wh3EFbdhMpmu8zDJ2pd0kni6O7sD0whOKwPVUFhXWq7pm
         wmibc4QLNu67+D6ln7Kj+uFEkZljDLK0RQFmOSo82CZz+nWH/7fmP5ntMZfxhXIGVl2F
         0O+FAXquEiCIWb4ZK34fvQ6yJ1jiaAEuG3V8mZD2psY8E+DRwiDz5j8GBzy7lSbcoD3L
         CXog==
X-Forwarded-Encrypted: i=1; AJvYcCX5gPOhonZ+3SV+PYiHoiCejqhNET7q4OuWKYcFfUqil1BQh9KPk/F1B2LgeOxGd6zXdncfQphR@vger.kernel.org
X-Gm-Message-State: AOJu0YywjMgqVQ0Vcg89CWWheVUZYhHCKuphEQIbGy4Uqn7PNSb+/nID
	nUNFqQUcxN6xeUYEQV2daErcWo1fq01XvLfpeZo7HypvGeFi43FAnJV9shWMFvVguoHtQoPxYql
	z61dQ3JnIIn7YZu4/8Xk5F9dPfZJWy0N/mw94Zbw8
X-Gm-Gg: AZuq6aKPDprnsii8vEnrJIt6k/2FCuFmee18O9vkOH1KTg0ra9xbIazmuQrvMbX3x2N
	6CdOggnkDMucIs4XIYt1vLqbVloNO/JpsGGiozIOijfe5pqxhn1RYbfCro8WP+4suY4bnwLX+KE
	EfWjAfzrfxy1bmt87RntIslEH09D6C9NRTxOk4zgMesZ0ByN87/CfwahFg9c3rlG94DXmIXGyDa
	vqAndEBNmieZntRqFXXdMlBlpYRE3xyeFuTjl+cK4Ej3tabOVVx2KhARF+Z0OT1gj7dbbClFyj0
	/oElKrBbQKVAUV12uzMChWxE7Q==
X-Received: by 2002:a05:7022:609:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-1270eb77341mr35981c88.12.1770418068642; Fri, 06 Feb 2026
 14:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120134256.2271710-1-chenridong@huaweicloud.com> <20260120134256.2271710-2-chenridong@huaweicloud.com>
In-Reply-To: <20260120134256.2271710-2-chenridong@huaweicloud.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Fri, 6 Feb 2026 16:47:31 -0600
X-Gm-Features: AZwV_Qj0gV48Ve3tLxFlyOkgNoDi9Hpin9IqAYTK628v4lALi6UuflSgTpYRMQQ
Message-ID: <CAJj2-QEvrgQ+R-nc3LZ-cBfnzjakxfSgmNbqDa-RFBVOpdVaAQ@mail.gmail.com>
Subject: Re: [RFC PATCH -next 1/7] vmscan: add memcg heat level for reclaim
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, weixugc@google.com, 
	david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com, 
	ryncsn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13755-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,oracle.com,suse.cz,suse.com,lwn.net,linuxfoundation.org,cmpxchg.org,linux.dev,bytedance.com,kvack.org,vger.kernel.org,huawei.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuanchu@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: E005D103F23
X-Rspamd-Action: no action

Hi Ridong,

Thanks for working to reconcile the gaps between the LRU implementations.

On Tue, Jan 20, 2026 at 7:57=E2=80=AFAM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> The memcg LRU was originally introduced to improve scalability during
> global reclaim. However, it is complex and only works with gen lru
> global reclaim. Moreover, its implementation complexity has led to
> performance regressions when handling a large number of memory cgroups [1=
].
>
> This patch introduces a per-memcg heat level for reclaim, aiming to unify
> gen lru and traditional LRU global reclaim. The core idea is to track
> per-node per-memcg reclaim state, including heat, last_decay, and
> last_refault. The last_refault records the total reclaimed data from the
> previous memcg reclaim. The last_decay is a time-based parameter; the hea=
t
> level decays over time if the memcg is not reclaimed again. Both last_dec=
ay
> and last_refault are used to calculate the current heat level when reclai=
m
> starts.
>
> Three reclaim heat levels are defined: cold, warm, and hot. Cold memcgs a=
re
> reclaimed first; only if cold memcgs cannot reclaim enough pages, warm
> memcgs become eligible for reclaim. Hot memcgs are reclaimed last.
>
> While this design can be applied to all memcg reclaim scenarios, this pat=
ch
> is conservative and only introduces heat levels for traditional LRU globa=
l
> reclaim. Subsequent patches will replace the memcg LRU with
> heat-level-based reclaim.
>
> Based on tests provided by YU Zhao, traditional LRU global reclaim shows
> significant performance improvement with heat-level reclaim enabled.
>
> The results below are from a 2-hour run of the test [2].
>
> Throughput (number of requests)         before     after        Change
> Total                                   1734169    2353717      +35%
>
> Tail latency (number of requests)       before     after        Change
> [128s, inf)                             1231       1057         -14%
> [64s, 128s)                             586        444          -24%
> [32s, 64s)                              1658       1061         -36%
> [16s, 32s)                              4611       2863         -38%

Do you have any numbers comparing heat-based reclaim to memcg LRU?  I
know Johannes suggested removing memcg LRU, and what you have here
applies to more reclaim scenarios.

>
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.co=
m/
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/memcontrol.h |   7 ++
>  mm/memcontrol.c            |   3 +
>  mm/vmscan.c                | 227 +++++++++++++++++++++++++++++--------
>  3 files changed, 192 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index af352cabedba..b293caf70034 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -76,6 +76,12 @@ struct memcg_vmstats;
>  struct lruvec_stats_percpu;
>  struct lruvec_stats;
>
> +struct memcg_reclaim_state {
> +       atomic_long_t heat;
> +       unsigned long last_decay;
> +       atomic_long_t last_refault;
> +};
> +
>  struct mem_cgroup_reclaim_iter {
>         struct mem_cgroup *position;
>         /* scan generation, increased every round-trip */
> @@ -114,6 +120,7 @@ struct mem_cgroup_per_node {
>         CACHELINE_PADDING(_pad2_);
>         unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS]=
;
>         struct mem_cgroup_reclaim_iter  iter;
> +       struct memcg_reclaim_state      reclaim;
>
>  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
>         /* slab stats for nmi context */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f2b87e02574e..675d49ad7e2c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3713,6 +3713,9 @@ static bool alloc_mem_cgroup_per_node_info(struct m=
em_cgroup *memcg, int node)
>
>         lruvec_init(&pn->lruvec);
>         pn->memcg =3D memcg;
> +       atomic_long_set(&pn->reclaim.heat, 0);
> +       pn->reclaim.last_decay =3D jiffies;
> +       atomic_long_set(&pn->reclaim.last_refault, 0);
>
>         memcg->nodeinfo[node] =3D pn;
>         return true;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4aa73f125772..3759cd52c336 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5978,6 +5978,124 @@ static inline bool should_continue_reclaim(struct=
 pglist_data *pgdat,
>         return inactive_lru_pages > pages_for_compaction;
>  }
>
> +enum memcg_scan_level {
> +       MEMCG_LEVEL_COLD,
> +       MEMCG_LEVEL_WARM,
> +       MEMCG_LEVEL_HOT,
> +       MEMCG_LEVEL_MAX,
> +};
> +
> +#define MEMCG_HEAT_WARM                4
> +#define MEMCG_HEAT_HOT         8
> +#define MEMCG_HEAT_MAX         12
> +#define MEMCG_HEAT_DECAY_STEP  1
> +#define MEMCG_HEAT_DECAY_INTERVAL      (1 * HZ)
I agree with Kairui; I'm somewhat concerned about this fixed decay
interval and how it behaves with many memcgs or heavy pressure.

> +
> +static void memcg_adjust_heat(struct mem_cgroup_per_node *pn, long delta=
)
> +{
> +       long heat, new_heat;
> +
> +       if (mem_cgroup_is_root(pn->memcg))
> +               return;
> +
> +       heat =3D atomic_long_read(&pn->reclaim.heat);
> +       do {
> +               new_heat =3D clamp_t(long, heat + delta, 0, MEMCG_HEAT_MA=
X);
> +               if (atomic_long_cmpxchg(&pn->reclaim.heat, heat, new_heat=
) =3D=3D heat)
> +                       break;
> +               heat =3D atomic_long_read(&pn->reclaim.heat);
> +       } while (1);
> +}
> +
> +static void memcg_decay_heat(struct mem_cgroup_per_node *pn)
> +{
> +       unsigned long last;
> +       unsigned long now =3D jiffies;
> +
> +       if (mem_cgroup_is_root(pn->memcg))
> +               return;
> +
> +       last =3D READ_ONCE(pn->reclaim.last_decay);
> +       if (!time_after(now, last + MEMCG_HEAT_DECAY_INTERVAL))
> +               return;
> +
> +       if (cmpxchg(&pn->reclaim.last_decay, last, now) !=3D last)
> +               return;
> +
> +       memcg_adjust_heat(pn, -MEMCG_HEAT_DECAY_STEP);
> +}
> +
> +static int memcg_heat_level(struct mem_cgroup_per_node *pn)
> +{
> +       long heat;
> +
> +       if (mem_cgroup_is_root(pn->memcg))
> +               return MEMCG_LEVEL_COLD;
> +
> +       memcg_decay_heat(pn);
The decay here is somewhat counterintuitive given the name memcg_heat_level=
.

> +       heat =3D atomic_long_read(&pn->reclaim.heat);
> +
> +       if (heat >=3D MEMCG_HEAT_HOT)
> +               return MEMCG_LEVEL_HOT;
> +       if (heat >=3D MEMCG_HEAT_WARM)
> +               return MEMCG_LEVEL_WARM;
> +       return MEMCG_LEVEL_COLD;
> +}
> +
> +static void memcg_record_reclaim_result(struct mem_cgroup_per_node *pn,
> +                                       struct lruvec *lruvec,
> +                                       unsigned long scanned,
> +                                       unsigned long reclaimed)
> +{
> +       long delta;
> +
> +       if (mem_cgroup_is_root(pn->memcg))
> +               return;
> +
> +       memcg_decay_heat(pn);
Could you combine the decay and adjust later in this function?

> +
> +       /*
> +        * Memory cgroup heat adjustment algorithm:
> +        * - If scanned =3D=3D 0: mark as hottest (+MAX_HEAT)
> +        * - If reclaimed >=3D 50% * scanned: strong cool (-2)
> +        * - If reclaimed >=3D 25% * scanned: mild cool (-1)
> +        * - Otherwise:  warm up (+1)
> +        */
> +       if (!scanned)
> +               delta =3D MEMCG_HEAT_MAX;
> +       else if (reclaimed * 2 >=3D scanned)
> +               delta =3D -2;
> +       else if (reclaimed * 4 >=3D scanned)
> +               delta =3D -1;
> +       else
> +               delta =3D 1;
> +
> +       /*
> +        * Refault-based heat adjustment:
> +        * - If refault increase > reclaimed pages: heat up (more cautiou=
s reclaim)
> +        * - If no refaults and currently warm:     cool down (allow more=
 reclaim)
> +        * This prevents thrashing by backing off when refaults indicate =
over-reclaim.
> +        */
> +       if (lruvec) {
> +               unsigned long total_refaults;
> +               unsigned long prev;
> +               long refault_delta;
> +
> +               total_refaults =3D lruvec_page_state(lruvec, WORKINGSET_A=
CTIVATE_ANON);
> +               total_refaults +=3D lruvec_page_state(lruvec, WORKINGSET_=
ACTIVATE_FILE);
> +
> +               prev =3D atomic_long_xchg(&pn->reclaim.last_refault, tota=
l_refaults);
> +               refault_delta =3D total_refaults - prev;
> +
> +               if (refault_delta > reclaimed)
> +                       delta++;
> +               else if (!refault_delta && delta > 0)
> +                       delta--;
> +       }

I think this metric is based more on the memcg's reclaimability than
on heat. Though the memcgs are grouped based on absolute metrics and
not relative to others.

> +
> +       memcg_adjust_heat(pn, delta);
> +}
> +
>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc=
)
>  {
> ...snip
>  }

Thanks,
Yuanchu

