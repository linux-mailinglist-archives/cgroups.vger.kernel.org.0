Return-Path: <cgroups+bounces-15640-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNAJG2BH+2lPYgMAu9opvQ
	(envelope-from <cgroups+bounces-15640-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 15:51:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B94DB573
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D6A330088B7
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959874657D0;
	Wed,  6 May 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwx5xamB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E663FB060
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075485; cv=none; b=Q2+vjUaiOhHZZmgJFOQbFNqf04/GF0/rTIG3E1uUzrlng5cCVSvlwY2YA+DWP5+i4n4jUtjrZn9uMUQUFb3wXEHXFDLkDicglLnwfWw6A6cjBwUIZyZd4XxZo4NcKYtDyHFPa0omXyHO0UGnfMRCPsbdo0IjJ5jG0CNLoFekiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075485; c=relaxed/simple;
	bh=/b0ojsBTR2WCYdLbzi4IPCJCWiUyBjUlEcAnhywbuVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cddi6yk/MLW74WDQ65ydzzRSO7vkWIsFxMbF3dNj3Az0zmw5xDSua2lkW24nRwti20hHeMbi+GHvWvHon++zdueLSKjFTXTWG93SbQBRov73o+QiH3kEBAT4m3uRSGj9nQu1KFF3UAFJaAgyRpir7yhgxMaFmMf76ClP7Q2BsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwx5xamB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA55C2BCF4
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778075485;
	bh=/b0ojsBTR2WCYdLbzi4IPCJCWiUyBjUlEcAnhywbuVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iwx5xamBl1Qo/aHl/mN4MipNkk1xMJJqIo9TMK+cVhWIx5ThOt9m2yCE0w70ziSZy
	 Xy+G1h6NCVkG4GoasHcv/uckciH6dbkuyIdy2vErZ+G8Vpr9trVxfhx/zcKc8A7nvx
	 rXXTb7M7psZG6XnJGVPsgHLTIbjodDp0ASdPSeMPliHe2pAll9pZ7cyMfLGnbvJzHa
	 mwoYzOoe4X5N0XD6txT4QHOn9WkACCe639JCMLRDlbRHD0v2cGZaiXepQHHj8IoifS
	 hKzXpfe/82IuuV11DdrHhauUICgW95CmGPR5UDoifaxHg19RQV4c6W9N123yBiWTWS
	 HDy+7WBYrZg7Q==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c396d3b36so4718362d50.0
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 06:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Hm/MAko+d9OaxUEU6qeiGOiFGAhZ2AMA1uUG7ZeLYJa2iqu6Zdb2VO8IwgBOwANYJ0KsaxiUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+U8ujrdmnVdOAzjWLaGtM/ciFwwebYXJ/kdmJrbDXVik2BOy
	WE298o89zUsS1m5O++Zs6WQvF9XrtdC/8mAE8E+L/AR6PPG2qcpSN2joj/ufzyi+K105pvFBD+N
	XzphSPE3HmzqoM7UrtdI0OQbXiDDX+2PpjBd2+KCsng==
X-Received: by 2002:a05:690e:1688:b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65c799989cemr4054814d50.34.1778075484164; Wed, 06 May 2026
 06:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-1-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-1-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 May 2026 15:51:13 +0200
X-Gmail-Original-Message-ID: <CACePvbVNwaU=609oJmAwqxse4WTApj30rU9hB_ym=FLjKMk2PA@mail.gmail.com>
X-Gm-Features: AVHnY4LxL-hGZWVHlEcA-yXqssU0AutiMmJTiSAT10lVjcLbKfjQy6tcLKL8zss
Message-ID: <CACePvbVNwaU=609oJmAwqxse4WTApj30rU9hB_ym=FLjKMk2PA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] mm, swap: simplify swap cache allocation helper
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
X-Rspamd-Queue-Id: 008B94DB573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15640-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of trying to return the existing folio if the entry is already
> cached, simply return an error code if the allocation fails and drop the

Nitpick: Spell out which function changes the return type here. It is
__swap_cache_prepare_and_add()

> output argument. And introduce proper wrappers that handle the

Nitpick: Spell out the helper function. It is swap_cache_read_folio().
> allocation failure in different ways.

>
> For async swapin and readahead, the caller only wants to ensure that a
> swap-in read is issued when the allocation succeeded. And for zswap swap
> out, the caller will abort if the allocation failed because the entry is
> gone or cached already.

Should you add no functional change expected?

>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Very nice clean ups. I like it. Here are some nitpicks; feel free to
ignore them.

Acked-by: Chris Li <chrisl@kerel.org>

> ---
>  mm/swap.h       |   3 +-
>  mm/swap_state.c | 180 +++++++++++++++++++++++++++++---------------------=
------
>  mm/zswap.c      |  23 +++-----
>  3 files changed, 103 insertions(+), 103 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index a77016f2423b..ad8b17a93758 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -281,8 +281,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)=
;
>  void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
>  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
> -                                    struct mempolicy *mpol, pgoff_t ilx,
> -                                    bool *alloced);
> +                                    struct mempolicy *mpol, pgoff_t ilx)=
;
>  /* Below helpers require the caller to lock and pass in the swap cluster=
. */
>  void __swap_cache_add_folio(struct swap_cluster_info *ci,
>                             struct folio *folio, swp_entry_t entry);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 1415a5c54a43..204a9499d50c 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -459,54 +459,38 @@ void swap_update_readahead(struct folio *folio, str=
uct vm_area_struct *vma,
>   * All swap slots covered by the folio must have a non-zero swap count.
>   *
>   * Context: Caller must protect the swap device with reference count or =
locks.
> - * Return: Returns the folio being added on success. Returns the existin=
g folio
> - * if @entry is already cached. Returns NULL if raced with swapin or swa=
poff.
> + * Return: 0 if success, error code if failed.
>   */
> -static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
> -                                                 struct folio *folio,
> -                                                 gfp_t gfp, bool charged=
)
> +static int __swap_cache_prepare_and_add(swp_entry_t entry,
> +                                       struct folio *folio,
> +                                       gfp_t gfp, bool charged)
>  {
> -       struct folio *swapcache =3D NULL;
>         void *shadow;
>         int ret;
>
>         __folio_set_locked(folio);
>         __folio_set_swapbacked(folio);
>
> -       if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, =
entry))
> +       if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, =
entry)) {
> +               ret =3D -ENOMEM;
>                 goto failed;
> -
> -       for (;;) {
> -               ret =3D swap_cache_add_folio(folio, entry, &shadow);
> -               if (!ret)
> -                       break;
> -
> -               /*
> -                * Large order allocation needs special handling on
> -                * race: if a smaller folio exists in cache, swapin needs
> -                * to fallback to order 0, and doing a swap cache lookup
> -                * might return a folio that is irrelevant to the faultin=
g
> -                * entry because @entry is aligned down. Just return NULL=
.
> -                */
> -               if (ret !=3D -EEXIST || folio_test_large(folio))
> -                       goto failed;
> -
> -               swapcache =3D swap_cache_get_folio(entry);
> -               if (swapcache)
> -                       goto failed;
>         }
>
> +       ret =3D swap_cache_add_folio(folio, entry, &shadow);
> +       if (ret)
> +               goto failed;
> +
>         memcg1_swapin(entry, folio_nr_pages(folio));
>         if (shadow)
>                 workingset_refault(folio, shadow);
>
>         /* Caller will initiate read into locked folio */
>         folio_add_lru(folio);
> -       return folio;
> +       return 0;
>
>  failed:
>         folio_unlock(folio);
> -       return swapcache;
> +       return ret;
>  }
>
>  /**
> @@ -515,7 +499,6 @@ static struct folio *__swap_cache_prepare_and_add(swp=
_entry_t entry,
>   * @gfp_mask: memory allocation flags
>   * @mpol: NUMA memory allocation policy to be applied
>   * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> - * @new_page_allocated: sets true if allocation happened, false otherwis=
e
>   *
>   * Allocate a folio in the swap cache for one swap slot, typically befor=
e
>   * doing IO (e.g. swap in or zswap writeback). The swap slot indicated b=
y
> @@ -523,18 +506,40 @@ static struct folio *__swap_cache_prepare_and_add(s=
wp_entry_t entry,
>   * Currently only supports order 0.
>   *
>   * Context: Caller must protect the swap device with reference count or =
locks.
> - * Return: Returns the existing folio if @entry is cached already. Retur=
ns
> - * NULL if failed due to -ENOMEM or @entry have a swap count < 1.
> + * Return: Returns the folio if allocation succeeded and folio is added =
to
> + * swap cache. Returns error code if allocation failed due to race.
>   */
>  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
> -                                    struct mempolicy *mpol, pgoff_t ilx,
> -                                    bool *new_page_allocated)
> +                                    struct mempolicy *mpol, pgoff_t ilx)
> +{
> +       int ret;

Nitpick: Suggest renaming it to "err" to make it obvious that it is an
int type for the error code. Because this function previously returned
a folio pointer, I have to remind myself that it is an int type not a
folio.

> +       struct folio *folio;
> +
> +       /* Allocate a new folio to be added into the swap cache. */
> +       folio =3D folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id()=
);
> +       if (!folio)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /*
> +        * Try to add the new folio to the swap cache. It returns
> +        * -EEXIST if the entry is already cached.
> +        */
> +       ret =3D __swap_cache_prepare_and_add(entry, folio, gfp_mask, fals=
e);
> +       if (ret) {
> +               folio_put(folio);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return folio;
> +}
> +
> +static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
> +                                          struct mempolicy *mpol, pgoff_=
t ilx,
> +                                          struct swap_iocb **plug, bool =
readahead)
>  {
>         struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         struct folio *folio;
> -       struct folio *result =3D NULL;
>
> -       *new_page_allocated =3D false;
>         /* Check the swap cache again for readahead path. */
>         folio =3D swap_cache_get_folio(entry);
>         if (folio)
> @@ -544,17 +549,24 @@ struct folio *swap_cache_alloc_folio(swp_entry_t en=
try, gfp_t gfp_mask,
>         if (!swap_entry_swapped(si, entry))
>                 return NULL;
>
> -       /* Allocate a new folio to be added into the swap cache. */
> -       folio =3D folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id()=
);
> -       if (!folio)
> +       do {
> +               folio =3D swap_cache_get_folio(entry);
> +               if (folio)
> +                       return folio;
> +
> +               folio =3D swap_cache_alloc_folio(entry, gfp, mpol, ilx);
> +       } while (IS_ERR(folio) && PTR_ERR(folio) =3D=3D -EEXIST);

Nitpick: IS_ERR() only checks that the pointer is in the error code
range. If the pointer is -EEXIST, it will always be in the error code
range. I think the "IS_ERR(folio)" test can be dropped.

Chris

