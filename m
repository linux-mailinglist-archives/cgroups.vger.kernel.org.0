Return-Path: <cgroups+bounces-15676-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iINvG4tu/Wl4eAAAu9opvQ
	(envelope-from <cgroups+bounces-15676-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 07:03:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C363E4F1CDD
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0AF30226B0
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F1321F5F;
	Fri,  8 May 2026 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmoHjLb/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43F1A262A
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216583; cv=none; b=hF/u3UM9Hbge4sGX0l6iHugZrCZWpEaU6E3MZR4nUYQje8dQkZ1ijtlFfkG+wq+VndDLZs4sqA7UaGKUZpmIS+V+iPKowR5QYhYWC8sTCmGjsYBYPXIR1FiLSYmZ/PuevCnu70OZ5zGHUcJz/odo517JqetSMqvKQDXBi2vE+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216583; c=relaxed/simple;
	bh=pvhofntp9fIH4mJaNNksnvFNACL/qXOHhn0SN5yzXTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLEwkI2Yfx+NrVQjhmewJncr8uIppgxa2u0/u7++Uc47nzFWk2MrRv9636cV2HQkYIisYCKdEVYz3MMo4o/sDo95ejRqgKYZ4d9Uy8lO2XToCq201jFUaqTAmOwytM5RMny8miMi8YMHBD6syL59aTZrPJjCiXvS2d01hg3+fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmoHjLb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A48C2BCFC
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778216583;
	bh=pvhofntp9fIH4mJaNNksnvFNACL/qXOHhn0SN5yzXTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZmoHjLb/9ZR+EA0YoF4rDDTUbwO+FT2BTWsm106TVcugL2YKM1dkdqGM4+hiKjlCI
	 d/SrpEw6VTDDY4DMSVoobpcQjLJKNxAog4G4CUYxk1+olrppNAnyIzvEaW+Ml1QGd1
	 cf00Njhe+HxvGKDVvhlkMR3yWjY7X1WFhAQBi2Nm/YZRTqTABRzrkgPOAfPqsWmJdU
	 cr5AUlUi5c0k2Wcx+XT8j4dBFjWn9itZMI0inNMc+xOnMN4MrnTmeioL57XmU6EOSC
	 uUg++J4nHFkjZN0m2516dB5/RJcLvCNZ0XZORD2IGtasZNs5C7q/d1cV3ie3YeJDlo
	 nByZa1ZCS06rA==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso1382517d50.2
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 22:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/iMnC5QO9tJr9u9s8qoF9aYzcK0yJLppn1TI+ExD64vB6AEDkc8lOFrleU4GGHtq5eGE1j6yrC@vger.kernel.org
X-Gm-Message-State: AOJu0YxAk3ln7urFU9VXqcyyyIAlxOG19o1A/tGLUqnhEvW/8++HU3Xn
	+UlK6Y2KN+hQX5eW1tWnzqflXw6xyVbGmtTANBfHGVu3qEFc4vYhNgAK9/GNIA1GMcUaYGdP7o6
	5vnDZI6ceEU5HF5SNC2y0TNCm5nnjvAbq+MkCmsaQ1Q==
X-Received: by 2002:a05:690e:4410:b0:654:6a61:fb5a with SMTP id
 956f58d0204a3-65c7988c04cmr8359043d50.2.1778216582806; Thu, 07 May 2026
 22:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-9-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-9-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 8 May 2026 07:02:51 +0200
X-Gmail-Original-Message-ID: <CACePvbUL5m-QniPLqRSrwmWDEpvVcM2DjCRggR+cy7PoEZBfYw@mail.gmail.com>
X-Gm-Features: AVHnY4Iw2Yw0C4zZB_QSvaFciSxejqqywdSjTcDEpmlXjSWF5O_Cm-Ti_YjH_wc
Message-ID: <CACePvbUL5m-QniPLqRSrwmWDEpvVcM2DjCRggR+cy7PoEZBfYw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] mm, swap: consolidate cluster allocation helpers
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C363E4F1CDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15676-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cluster table management is spread across several narrow
> helpers. As a result, the allocation and fallback sequences are
> open-coded in multiple places.
>
> A few more per-cluster tables will be added soon, so avoid
> duplicating these sequences per table type. Fold the existing
> pairs into cluster-oriented helpers, and rename for consistency.
>
> No functional change, only a few sanity checks are slightly adjusted.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  mm/swapfile.c | 110 ++++++++++++++++++++++++++--------------------------=
------
>  1 file changed, 49 insertions(+), 61 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8d3d22c463f3..2d16aa89a4fd 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -411,20 +411,7 @@ static inline unsigned int cluster_offset(struct swa=
p_info_struct *si,
>         return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  }
>
> -static struct swap_table *swap_table_alloc(gfp_t gfp)
> -{
> -       struct folio *folio;
> -
> -       if (!SWP_TABLE_USE_PAGE)
> -               return kmem_cache_zalloc(swap_table_cachep, gfp);
> -
> -       folio =3D folio_alloc(gfp | __GFP_ZERO, 0);
> -       if (folio)
> -               return folio_address(folio);
> -       return NULL;
> -}
> -
> -static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
> +static void swap_cluster_free_table_folio_rcu_cb(struct rcu_head *head)
>  {
>         struct folio *folio;
>
> @@ -432,15 +419,46 @@ static void swap_table_free_folio_rcu_cb(struct rcu=
_head *head)
>         folio_put(folio);
>  }
>
> -static void swap_table_free(struct swap_table *table)
> +static void swap_cluster_free_table(struct swap_cluster_info *ci)
>  {
> +       struct swap_table *table;
> +
> +       table =3D (struct swap_table *)rcu_dereference_protected(ci->tabl=
e, true);
> +       if (!table)
> +               return;
> +
> +       rcu_assign_pointer(ci->table, NULL);
>         if (!SWP_TABLE_USE_PAGE) {
>                 kmem_cache_free(swap_table_cachep, table);
>                 return;
>         }
>
>         call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> -                swap_table_free_folio_rcu_cb);
> +                swap_cluster_free_table_folio_rcu_cb);
> +}
> +
> +static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t =
gfp)
> +{
> +       struct swap_table *table =3D NULL;
> +       struct folio *folio;
> +
> +       /* The cluster must be empty and not on any list during allocatio=
n. */
> +       VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
> +       if (rcu_access_pointer(ci->table))
> +               return 0;
> +
> +       if (SWP_TABLE_USE_PAGE) {
> +               folio =3D folio_alloc(gfp | __GFP_ZERO, 0);
> +               if (folio)
> +                       table =3D folio_address(folio);
> +       } else {
> +               table =3D kmem_cache_zalloc(swap_table_cachep, gfp);
> +       }
> +       if (!table)
> +               return -ENOMEM;
> +
> +       rcu_assign_pointer(ci->table, table);
> +       return 0;
>  }
>
>  /*
> @@ -471,27 +489,15 @@ static void swap_cluster_assert_empty(struct swap_c=
luster_info *ci,
>         WARN_ON_ONCE(nr =3D=3D SWAPFILE_CLUSTER && ci->extend_table);
>  }
>
> -static void swap_cluster_free_table(struct swap_cluster_info *ci)
> -{
> -       struct swap_table *table;
> -
> -       /* Only empty cluster's table is allow to be freed  */
> -       lockdep_assert_held(&ci->lock);
> -       table =3D (void *)rcu_dereference_protected(ci->table, true);
> -       rcu_assign_pointer(ci->table, NULL);
> -
> -       swap_table_free(table);
> -}
> -
>  /*
>   * Allocate swap table for one cluster. Attempt an atomic allocation fir=
st,
>   * then fallback to sleeping allocation.
>   */
>  static struct swap_cluster_info *
> -swap_cluster_alloc_table(struct swap_info_struct *si,
> +swap_cluster_populate(struct swap_info_struct *si,
>                          struct swap_cluster_info *ci)
>  {
> -       struct swap_table *table;
> +       int ret;
>
>         /*
>          * Only cluster isolation from the allocator does table allocatio=
n.
> @@ -502,14 +508,9 @@ swap_cluster_alloc_table(struct swap_info_struct *si=
,
>                 lockdep_assert_held(&si->global_cluster_lock);
>         lockdep_assert_held(&ci->lock);
>
> -       /* The cluster must be free and was just isolated from the free l=
ist. */
> -       VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
> -
> -       table =3D swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_=
NOWARN);
> -       if (table) {
> -               rcu_assign_pointer(ci->table, table);
> +       if (!swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
> +                                         __GFP_NOWARN))
>                 return ci;
> -       }
>
>         /*
>          * Try a sleep allocation. Each isolated free cluster may cause
> @@ -521,7 +522,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>                 spin_unlock(&si->global_cluster_lock);
>         local_unlock(&percpu_swap_cluster.lock);
>
> -       table =3D swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KE=
RNEL);
> +       ret =3D swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLO=
C |
> +                                          GFP_KERNEL);
>
>         /*
>          * Back to atomic context. We might have migrated to a new CPU wi=
th a
> @@ -536,20 +538,11 @@ swap_cluster_alloc_table(struct swap_info_struct *s=
i,
>                 spin_lock(&si->global_cluster_lock);
>         spin_lock(&ci->lock);
>
> -       /* Nothing except this helper should touch a dangling empty clust=
er. */
> -       if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
> -               if (table)
> -                       swap_table_free(table);
> -               return ci;
> -       }
> -
> -       if (!table) {
> +       if (ret) {
>                 move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FRE=
E);
>                 spin_unlock(&ci->lock);
>                 return NULL;
>         }
> -
> -       rcu_assign_pointer(ci->table, table);
>         return ci;
>  }
>
> @@ -621,12 +614,11 @@ static struct swap_cluster_info *isolate_lock_clust=
er(
>         }
>         spin_unlock(&si->lock);
>
> -       if (found && !cluster_table_is_alloced(found)) {
> -               /* Only an empty free cluster's swap table can be freed. =
*/
> -               VM_WARN_ON_ONCE(flags !=3D CLUSTER_FLAG_FREE);
> +       /* Cluster's table is freed when and only when it's on the free l=
ist. */
> +       if (found && flags =3D=3D CLUSTER_FLAG_FREE) {
>                 VM_WARN_ON_ONCE(list !=3D &si->free_clusters);
> -               VM_WARN_ON_ONCE(!cluster_is_empty(found));
> -               return swap_cluster_alloc_table(si, found);
> +               VM_WARN_ON_ONCE(cluster_table_is_alloced(found));
> +               return swap_cluster_populate(si, found);
>         }
>
>         return found;
> @@ -769,7 +761,6 @@ static int swap_cluster_setup_bad_slot(struct swap_in=
fo_struct *si,
>         unsigned int ci_off =3D offset % SWAPFILE_CLUSTER;
>         unsigned long idx =3D offset / SWAPFILE_CLUSTER;
>         struct swap_cluster_info *ci;
> -       struct swap_table *table;
>         int ret =3D 0;
>
>         /* si->max may got shrunk by swap swap_activate() */
> @@ -790,12 +781,9 @@ static int swap_cluster_setup_bad_slot(struct swap_i=
nfo_struct *si,
>         }
>
>         ci =3D cluster_info + idx;
> -       if (!ci->table) {
> -               table =3D swap_table_alloc(GFP_KERNEL);
> -               if (!table)
> -                       return -ENOMEM;
> -               rcu_assign_pointer(ci->table, table);
> -       }
> +       /* Need to allocate swap table first for initial bad slot marking=
. */
> +       if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
> +               return -ENOMEM;
>         spin_lock(&ci->lock);
>         /* Check for duplicated bad swap slots. */
>         if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) !=3D SWP_TB_NULL) {
> @@ -2992,7 +2980,7 @@ static void free_swap_cluster_info(struct swap_clus=
ter_info *cluster_info,
>                 ci =3D cluster_info + i;
>                 /* Cluster with bad marks count will have a remaining tab=
le */
>                 spin_lock(&ci->lock);
> -               if (rcu_dereference_protected(ci->table, true)) {
> +               if (cluster_table_is_alloced(ci)) {
>                         swap_cluster_assert_empty(ci, 0, SWAPFILE_CLUSTER=
, true);
>                         swap_cluster_free_table(ci);
>                 }
>
> --
> 2.53.0
>
>

