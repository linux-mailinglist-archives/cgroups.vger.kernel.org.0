Return-Path: <cgroups+bounces-15644-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGshO1NT+2n+ZQMAu9opvQ
	(envelope-from <cgroups+bounces-15644-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:42:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 906AC4DC6FD
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09CAE3003358
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4568423176;
	Wed,  6 May 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8YkwgMC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724526ED3D
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078539; cv=none; b=HakrGoPJDrUHoTKZOK8Y0MFUo+58/umMlN0MO/7+iBtKNhGDKULlaHyCoHteVJ+H6qWxl04ciOmntKBKV2k3Df3JVjhADTdG+6yA3X/+Cmxx1N8h3vZ1ftLJpfdPgxgPXgTV3aeVJ6bvHq+XhEEHl0DVLj0yKyWzNeBNx8xzkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078539; c=relaxed/simple;
	bh=Z4SlF8NBsQlFWpbQMVXeCO/cJjCPL7rhbRaYvnTwuQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyqENdz7dlrI+JDavQWXf0vyE/u1aCZYKJ8jUtYjsxDqRbGo5HlJn6r2vlLEL2EjJOtk5dj+dYUmVkXSGVrjUgRiPDG6Op2qlTvz+gNalknVgUYPn6EH/9am/K6Bm7hSo+bDMvuZcSUd/nXRgRudmcUiB9lhFRVHmQ7boHmys8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8YkwgMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C8C2BCFC
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078539;
	bh=Z4SlF8NBsQlFWpbQMVXeCO/cJjCPL7rhbRaYvnTwuQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y8YkwgMCjVkxTjapUn2w/qpBksIOxExMFWQSeNig7diAlEJCHvAe+tJzJNv61OqzX
	 1dz8GnLfmUYgUOyVAvrIPYgBMUG0aC7AYRC3s0uKLyDCpt5DsjV5S6hFIDUQ2XymYA
	 +iZQbiVERJHWPFV8gqwO3bTsybmehXna5tip1ycvopJ+CHl5Lp0uSmVM4o0a6Gx0LW
	 u2f9ltr3JrWQNtrjjF0pGVXD9hWOLaCq7AnXpu8tFPq71grxCOjGfhJbFCGpM2tQJH
	 WepRUIXKkWPBZaog+C+g624PtjwNpViiR06u+l29ELaWIDTM2P6saqYFSxvKd6VTZo
	 NRiRBs/fhaPnQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd5e373d07so60725927b3.2
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 07:42:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9EaAe4Br4fg/z+2OEaCLX9wcO486Maflf7cOnvmFZnnLgFUYACAWrvGUja9bZ7eVpxL4+DYm2J@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbONouzvL/O9QfGCFMxbB3eulnoGsvUj/zzDNVXZyXDZF+2HB
	RL0tbczsqVNI/HgYRS+P1aAy8b8fON/j3dSDU7/J0r8q9XvulOY/Pfm8I/QwYTlPvfJlhoOt2q9
	Bu7u8zVXXa4Ua7i4njeN7ztiEIb+0t2y3rpltId4H6g==
X-Received: by 2002:a05:690c:388:b0:7b8:926e:3ef1 with SMTP id
 00721157ae682-7bdf5d6ba1amr42892017b3.9.1778078538262; Wed, 06 May 2026
 07:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-2-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-2-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 May 2026 16:42:05 +0200
X-Gmail-Original-Message-ID: <CACePvbX3Bead1Ea+UJfUAq0e4JNJ0P+yN0=zf5rhdPsH8y9PUg@mail.gmail.com>
X-Gm-Features: AVHnY4IwL-gw4Sl3FRXlNA5vHPxixzm39dfEKEl2DSbStJz8gX21tz29sDT583A
Message-ID: <CACePvbX3Bead1Ea+UJfUAq0e4JNJ0P+yN0=zf5rhdPsH8y9PUg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] mm, swap: move common swap cache operations into
 standalone helpers
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
X-Rspamd-Queue-Id: 906AC4DC6FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15644-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]

On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Move a few swap cache checking, adding, and deletion operations
> into standalone helpers to be used later. And while at it, add
> proper kernel doc.
>
> No feature or behavior change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>


> ---
>  mm/swap_state.c | 141 ++++++++++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 95 insertions(+), 46 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 204a9499d50c..3da285a891b2 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -137,8 +137,42 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>         return NULL;
>  }
>
> -void __swap_cache_add_folio(struct swap_cluster_info *ci,
> -                           struct folio *folio, swp_entry_t entry)
> +/**
> + * __swap_cache_add_check - Check if a range is suitable for adding a fo=
lio.
> + * @ci: The locked swap cluster.
> + * @ci_off: Range start offset.
> + * @nr: Number of slots to check.
> + * @shadow: Returns the shadow value if one exists in the range.
> + *
> + * Check if all slots covered by given range have a swap count >=3D 1.
> + * Retrieves the shadow if there is one.
> + *
> + * Context: Caller must lock the cluster.
> + */
> +static int __swap_cache_add_check(struct swap_cluster_info *ci,
> +                                 unsigned int ci_off, unsigned int nr,
> +                                 void **shadow)
> +{
> +       unsigned int ci_end =3D ci_off + nr;
> +       unsigned long old_tb;
> +

Nitpick: Can add lockdep_assert_held(&ci->lock);

Can check ci_end < SWAPFILE_CLUSTER and bail out on error.

> +       if (unlikely(!ci->table))
> +               return -ENOENT;
> +       do {
> +               old_tb =3D __swap_table_get(ci, ci_off);
> +               if (unlikely(swp_tb_is_folio(old_tb)))
> +                       return -EEXIST;
> +               if (unlikely(!__swp_tb_get_count(old_tb)))
> +                       return -ENOENT;
> +               if (swp_tb_is_shadow(old_tb))
> +                       *shadow =3D swp_tb_to_shadow(old_tb);

Nitpick: You can create a local variable for the shadow and assign it
at the end. Because it is a pointer, the compiler can't optimize the
store away.

Chris

