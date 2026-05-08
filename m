Return-Path: <cgroups+bounces-15675-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hofaNdZq/WlndwAAu9opvQ
	(envelope-from <cgroups+bounces-15675-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 06:47:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD94F1B86
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 06:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 387B43009CC0
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 04:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBAA226CFE;
	Fri,  8 May 2026 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSRjMKxf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028B171BB
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778215633; cv=none; b=TiHPcLWzxjFilC1k+GFDd7A6gZZvBSOqRMqAMnEFIQ+ItfE3U9MCqZLCPSFd4hM9x2khfpfO60goa8+RZZZHd3rbBMRK6fYHYU4ZewayxTm0XpddaygZJwAX5bHzsBJNMJdYaKt7fMfzO3OHuK5JjsnLsqDapJKBWsbDKcKD32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778215633; c=relaxed/simple;
	bh=0qktAd4l2NHky9b1tIhnepqyzEFVW3UHSxo2N4g8AOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7XO/mmeFGQCH9R9jSy8yMHwov16rYvchK9Qqmlpicm4N8+H9PSksrZe/4K5UwPY9SZxOfDrjyQmRP3Lz8vf424bNnKt8qCBMj4p/Ch9CvvKGuXNN3ASUw6TKV52SofPKA7lP4eyADVdqBam8x7VYZICjrjekgDPJ+5kaRIHs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSRjMKxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF6CC32782
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 04:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778215632;
	bh=0qktAd4l2NHky9b1tIhnepqyzEFVW3UHSxo2N4g8AOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSRjMKxf0On0ogsyzTsdQrF0HQzLY3+ji3tGUcGepJ9SwGXEA7whjI53MjBA27CvX
	 obdYqZFfsIAWLkcEu9OCmy8hJFO9OuGxG/NTsiFWxESvnrf+5iQxhMhtkcxPDshEiK
	 wJbkh6pLhwWn8GeY3Sv8Lf7lwDvhVeP16egfNrzAH6QVVz+bVwhkskwuiKQieH1YYt
	 dbk4t8ll40KHpeqbExJZX6WznkHJfAYTynFxu+qrlqzxhLiznab3oMrhppfTvrOR06
	 u2nNiNtLzbYgv8h5DogW1w8+XAtp10IrUNw411HoVMXYB9ONESast5IpoSYhckYUby
	 Y2HptF5cmpLLA==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-654672a6d68so1714993d50.0
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 21:47:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9r1Gv5QleQwmrjKdtcRcOI254REPedX0YpKv8Syb2IEmL4bfCDJvvnexVukTvilttZ9nllN5nD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QnPxZplBdmMEvSqti2Xs058mIQD39oQ1/MAKD6MONapxYN9E
	dwasWq/lqBqNzJru1mudMpwFFInINHSKBAUtRsVLT9FhQMyjanQHw2VcbeDMhordm/tgq1Xl51n
	THU6R0n+i+YVBvkmFRoAkqVBLaVNZLQTmnPA3E9R8/Q==
X-Received: by 2002:a53:c0ca:0:b0:65c:7636:2b09 with SMTP id
 956f58d0204a3-65c7987a6fbmr8008927d50.5.1778215631896; Thu, 07 May 2026
 21:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-8-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-8-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 8 May 2026 06:46:59 +0200
X-Gmail-Original-Message-ID: <CACePvbUsKUBF=inQDRfcp-_RGiADobAkGDmeMuUZOAxi3v_SAg@mail.gmail.com>
X-Gm-Features: AVHnY4KetDuole5QnixkPzeG-7HFBT7kfW6Cpd6AWd7bWIYMqoph8vhRCrznyMY
Message-ID: <CACePvbUsKUBF=inQDRfcp-_RGiADobAkGDmeMuUZOAxi3v_SAg@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] mm, swap: delay and unify memcg lookup and
 charging for swapin
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
X-Rspamd-Queue-Id: 6CCD94F1B86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15675-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of checking the cgroup private ID during page table walk in
> swap_pte_batch(), move the memcg lookup into __swap_cache_add_check()
> under the cluster lock.
>
> The first pre-alloc check is speculative and skips the memcg check since
> the post-alloc stable check ensures all slots covered by the folio
> belong to the same memcg. It is very rare for contiguous and aligned
> entries across a contiguous region of a page table of the same process
> or shmem mapping to belong to different memcgs.
>
> This also prepares for recording the memcg info in the cluster's table.
> Also make the order check and fallback more compact.
>
> There should be no user-observable behavior change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  include/linux/memcontrol.h |  6 +++---
>  mm/internal.h              | 10 +---------
>  mm/memcontrol.c            | 10 ++++------
>  mm/swap_state.c            | 28 +++++++++++++++++++---------
>  4 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7d08128de1fd..a013f37f24aa 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -646,8 +646,8 @@ static inline int mem_cgroup_charge(struct folio *fol=
io, struct mm_struct *mm,
>
>  int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
>
> -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
> -                                 gfp_t gfp, swp_entry_t entry);
> +int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short i=
d,
> +                                  struct mm_struct *mm, gfp_t gfp);
>
>  void __mem_cgroup_uncharge(struct folio *folio);
>
> @@ -1137,7 +1137,7 @@ static inline int mem_cgroup_charge_hugetlb(struct =
folio* folio, gfp_t gfp)
>  }
>
>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
> -                       struct mm_struct *mm, gfp_t gfp, swp_entry_t entr=
y)
> +                unsigned short id, struct mm_struct *mm, gfp_t gfp)
>  {
>         return 0;
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 5a2ddcf68e0b..9d2fec696bd6 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -451,24 +451,16 @@ static inline int swap_pte_batch(pte_t *start_ptep,=
 int max_nr, pte_t pte)
>  {
>         pte_t expected_pte =3D pte_next_swp_offset(pte);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
> -       const softleaf_t entry =3D softleaf_from_pte(pte);
>         pte_t *ptep =3D start_ptep + 1;
> -       unsigned short cgroup_id;
>
>         VM_WARN_ON(max_nr < 1);
> -       VM_WARN_ON(!softleaf_is_swap(entry));
> +       VM_WARN_ON(!softleaf_is_swap(softleaf_from_pte(pte)));
>
> -       cgroup_id =3D lookup_swap_cgroup_id(entry);
>         while (ptep < end_ptep) {
> -               softleaf_t entry;
> -
>                 pte =3D ptep_get(ptep);
>
>                 if (!pte_same(pte, expected_pte))
>                         break;
> -               entry =3D softleaf_from_pte(pte);
> -               if (lookup_swap_cgroup_id(entry) !=3D cgroup_id)
> -                       break;
>                 expected_pte =3D pte_next_swp_offset(expected_pte);
>                 ptep++;
>         }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c7df30ca5aa7..641706fa47bf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5062,27 +5062,25 @@ int mem_cgroup_charge_hugetlb(struct folio *folio=
, gfp_t gfp)
>
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for s=
wapin.
> - * @folio: folio to charge.
> + * @folio: the folio to charge
> + * @id: memory cgroup id
>   * @mm: mm context of the victim
>   * @gfp: reclaim mode
> - * @entry: swap entry for which the folio is allocated
>   *
>   * This function charges a folio allocated for swapin. Please call this =
before
>   * adding the folio to the swapcache.
>   *
>   * Returns 0 on success. Otherwise, an error code is returned.
>   */
> -int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
> -                                 gfp_t gfp, swp_entry_t entry)
> +int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned short i=
d,
> +                                  struct mm_struct *mm, gfp_t gfp)
>  {
>         struct mem_cgroup *memcg;
> -       unsigned short id;
>         int ret;
>
>         if (mem_cgroup_disabled())
>                 return 0;
>
> -       id =3D lookup_swap_cgroup_id(entry);
>         rcu_read_lock();
>         memcg =3D mem_cgroup_from_private_id(id);
>         if (!memcg || !css_tryget_online(&memcg->css))
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 12b290d43e45..86d517a33a55 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -142,16 +142,20 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>   * @ci: The locked swap cluster
>   * @targ_entry: The target swap entry to check, will be rounded down by =
@nr
>   * @nr: Number of slots to check, must be a power of 2
> - * @shadowp: Returns the shadow value if one exists in the range.
> + * @shadowp: Returns the shadow value if one exists in the range
> + * @memcg_id: Returns the memory cgroup id, NULL to ignore cgroup check
>   *
>   * Check if all slots covered by given range have a swap count >=3D 1.
> - * Retrieves the shadow if there is one.
> + * Retrieves the shadow if there is one. If @memcg_id is not NULL, also
> + * checks if all slots belong to the same cgroup and return the cgroup
> + * private id.
>   *
>   * Context: Caller must lock the cluster.
>   */
>  static int __swap_cache_add_check(struct swap_cluster_info *ci,
>                                   swp_entry_t targ_entry,
> -                                 unsigned long nr, void **shadowp)
> +                                 unsigned long nr, void **shadowp,
> +                                 unsigned short *memcg_id)
>  {
>         unsigned int ci_off, ci_end;
>         unsigned long old_tb;
> @@ -169,19 +173,24 @@ static int __swap_cache_add_check(struct swap_clust=
er_info *ci,
>                 return -EEXIST;
>         if (!__swp_tb_get_count(old_tb))
>                 return -ENOENT;
> -       if (swp_tb_is_shadow(old_tb) && shadowp)
> +       if (shadowp && swp_tb_is_shadow(old_tb))
>                 *shadowp =3D swp_tb_to_shadow(old_tb);
> +       if (memcg_id)
> +               *memcg_id =3D lookup_swap_cgroup_id(targ_entry);

Nitpick: Consider also use a local variable to stare the memcg_id value her=
e.

>
>         if (nr =3D=3D 1)
>                 return 0;
>
> +       targ_entry.val =3D round_down(targ_entry.val, nr);
>         ci_off =3D round_down(ci_off, nr);
>         ci_end =3D ci_off + nr;
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 if (unlikely(swp_tb_is_folio(old_tb) ||
> -                            !__swp_tb_get_count(old_tb)))
> +                            !__swp_tb_get_count(old_tb) ||
> +                            (memcg_id && *memcg_id !=3D lookup_swap_cgro=
up_id(targ_entry))))

Nitpick: You can use the local variable here to avoid a memory fetch.
Micro optimizations.

Chris

