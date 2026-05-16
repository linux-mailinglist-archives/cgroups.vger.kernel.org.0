Return-Path: <cgroups+bounces-16007-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK8BBxu3CGp42QMAu9opvQ
	(envelope-from <cgroups+bounces-16007-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 20:27:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6B55D1C7
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DC1C300D688
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC932939C;
	Sat, 16 May 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4KMCgd2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D9325716
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956040; cv=pass; b=mNR/L81n6SmEUOCWmp5vJLoEerqY7UFSlxv0C38ivCF8/DRSnMoYzZ3NQVDLQKMoqIYU4QRwkQmLkSTYWSdHaWGFCocNK6kRSvxljlDcUGwvgx0rqqb5UBxUAfh7cwHnunm37+lGWE1J9gbepep4j7YbtRp+uozh31rts+Xo+Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956040; c=relaxed/simple;
	bh=tmxBaTIdU4jlIoDY1Lq4mW5hD6m8lzzGD85WQuqCBEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OClmSVd6hm7tXMFdfQvXBbuNh8FQbLDNmqhM96gqg23kTg6LWYI1nc1/u76vQN/6Ef8A+3uA7Dezfxa2yNlvUrre+Mq5KMFa/xuiGkUQndqgYq4/m077OjQOyZBD4TlZCHtFbUGRJf+kfr72r9t4eoyFRfpeDeeVo9rW99mnYrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4KMCgd2; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so1962781a12.0
        for <cgroups@vger.kernel.org>; Sat, 16 May 2026 11:27:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778956037; cv=none;
        d=google.com; s=arc-20240605;
        b=I3nk6ItPbjK3lJT5piIxGygf30vb/AF9Ij+Iw1TuRFkhzt8d4YoeOueZ00IOXTP94U
         DJCsmhA7fIyPV05ogeqeUR5PbWeplSTMNRf+lrVEU8sy5M9pAzTLdwBBd14hHKhHw4bb
         UdFBZX4yqSZagu4tZX9u4rjmovbSS4v6bsgFXGvYrwBr+6r/S5MmMubVXyPH2YE0umRB
         XObXzXNxDLrW1V3Z+Yjwe/1emN8ER3I0g+/u8qGCC+BmIeLDJUFAIjSspKTPsh9yxY1n
         rkJTwidz+uGs39fOZ1LGW3ryABlxKZaf8qs5YACyvpewvR2KV4IurN3YW1agDqIHtw59
         6QMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ipLjnPPVoAmFo9hBOVjjo0mZdXOpS4I9gXteWAq5QAU=;
        fh=7idGklzi81L75adM4LPDequhAy3aNiXPFnu9GXwfSNA=;
        b=HZLhAp9+hqvqT0GqJWtave+Dp+o1sfwBkATWMOnKSvbprAcKaCaiIDIzYwhRQ13+uP
         AXgLoi7uCaG0/bgzcAr/vRdVVM1Uk4b72ssFm/0VeBus7aNjRgE1oh8q/XofUZ73tdsZ
         LBCqMDrdh/eUM22IL4lGdeW+C9bWClTDvzJ5IxTnbRyMIuKN9dOx2gPVWpML2O6Ex5VK
         VaRp/b1Xy2WWdK27QOSf7KcRHFiFB1YdhI7CMkdTalNWkiqHWFb+eUSLSbBgW52dAxEa
         85PQF+w/NrIHwYJOojWxRIq4tdjCWRwyFzMEJ2BaM3sPnNQKqzmnnhW72x1sCNABHo/g
         BcJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778956037; x=1779560837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipLjnPPVoAmFo9hBOVjjo0mZdXOpS4I9gXteWAq5QAU=;
        b=d4KMCgd23masonoOtrS01Q18dLA6A8CCOXnyPgTtHTYCZqNMFCDK81rzIgB8/ASzuQ
         LbgstwiX073C3rkUaEXq8FQOKq4+nGwwr+3A1OODdjAH9GldJu+HQQIYEB2yjnL9iDwf
         L5e5VKt5/1M7wvpkrovKGxTBGUf6dJV0TkdzFU2TdUxTP8/jPglzVWCqMBMPPQVuPWqr
         PH1EYWeU8zM90yBzGkXVt/1QbH3piKaDL3QzZbupyV9egPix0u8Ch+RDGUjJ2Sa0CuiH
         7iUKlaiJxzmGVTqzIjLcCtZVprZfk6BAvkmHkq/oE97sCOcfpGtnDl2wlJ29pSCpPAF1
         7X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778956037; x=1779560837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipLjnPPVoAmFo9hBOVjjo0mZdXOpS4I9gXteWAq5QAU=;
        b=soQCrBSZzb2xTF7uOgkAVgvBrLlmrNscPUuGvuzaoL0OdoNwMOqs0nQUisWuwU8LsC
         BJC1k5MBge6w8QSxXyvlsxzRC8eDvu1ENXCfj5xDgHMyTA4t/+CYDqf2mLdCR7X3ME9F
         3nayiH/Gc/9lLSXLaKUfVnQ8etsI7SIC4bIoVx8xRjHeIfailHVAM3x0wIV+nNDxJ+Ub
         kPXXw/FNA5Ju/rhwnc9sJvSLrdfKVjMur7uQ4QQdxNsZtBZcvuPmOYqs7iK5OISQgDSv
         5Dbx74lL6OfrQfz1Trf7Gs5dpZU1Hd6TkjX7Quz1O27z0KJrM5cxdJEOGOm9SqjvdtWF
         NNxA==
X-Forwarded-Encrypted: i=1; AFNElJ+5niJIrmcyJuXt3UtmBLNVCf++aSfiLXXJ3cwC5pKqgACMJDpw/9tul1byVlSxH/R6o/Q2hxqn@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyHPQkd7P/kkP45ZRpzD5l8CA8v1UT/mSVwlJ0Ok9k8aRgaBN
	g7esbBfj5qlrN/rTKjpLxSprcAIoEov3tUlxpFX+MIRD6qAIw9z0GfLlTn1/6RGGOzMbS+uvlef
	84/hL6DtVDHskyQV/L4M2tCdMGY/lPHg=
X-Gm-Gg: Acq92OFpM/d0hjHTUzgqT4qPy5ye5TevNw8mQ6qkBng4CRPEvfg7H7inTCQhwyU1gyc
	RmVQQaym9/keTKLyDzUspCPxZA54CwCTbjQGm3iIErOItdqy998hRa6Pdwz8cmcbpFLVNQYBPgl
	rU85eTw+lkzWS2WXhTPGl76L7XD1A+kWzpp1Wc4m5C9lP4HBd9FHXkYgwbR8bfWZV/BUp/m+EiQ
	/c1gEtBkPV5jfNvp3kbEnGm5ioRILCU47TkAV5w4tNRzon7g+fQQuHzEAAW4crbnBrZn1Pvg15C
	4X9o6APqXYfv0nRXt8AgXZXN922nKLk8hmj5R26ketPnggJC0OA=
X-Received: by 2002:aa7:d6cc:0:b0:672:be92:e913 with SMTP id
 4fb4d7f45d1cf-683bd589317mr3236394a12.17.1778956036340; Sat, 16 May 2026
 11:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com> <20260515-swap-table-p4-v4-5-f1b49e845a8d@tencent.com>
In-Reply-To: <20260515-swap-table-p4-v4-5-f1b49e845a8d@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 17 May 2026 02:26:39 +0800
X-Gm-Features: AVHnY4LwzFo6b6lT16u0Jm5tkZjNNGtyC5TXmtlNsG_Qn3_5hxODn6Nmeys6Exk
Message-ID: <CAMgjq7AqKskE5UVivTEdPzmTa09_aapWZM7JeSshhmf-4GYbZw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] mm, swap: unify large folio allocation
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
	Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9CE6B55D1C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16007-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 6:11=E2=80=AFPM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now that direct large order allocation is supported in the swap cache,
> both anon and shmem can use it instead of implementing their own methods.
> This unifies the fallback and swap cache check, which also reduces the
> TOCTOU race window of swap cache state: previously, high order swapin
> required checking swap cache states first, then allocating and falling
> back separately. Now all these steps happen in the same compact loop.
>
> Order fallback and statistics are also unified, callers just need to
> check and pass the acceptable order bitmask.
>
> There is basically no behavior change. This only makes things more
> unified and prepares for later commits. Cgroup and zero map checks can
> also be moved into the compact loop, further reducing race windows and
> redundancy
>
> Acked-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     |  77 ++++++------------------------
>  mm/shmem.c      |  95 ++++++++++---------------------------
>  mm/swap.h       |  30 ++----------
>  mm/swap_state.c | 143 ++++++++++----------------------------------------=
------
>  mm/swapfile.c   |   3 +-
>  5 files changed, 68 insertions(+), 280 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6edb23b41bac..e3edc0c20e34 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -159,7 +159,7 @@ static unsigned long shmem_default_max_inodes(void)
>
>  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>                         struct folio **foliop, enum sgp_type sgp, gfp_t g=
fp,
> -                       struct vm_area_struct *vma, vm_fault_t *fault_typ=
e);
> +                       struct vm_fault *vmf, vm_fault_t *fault_type);
>
>  static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>  {
> @@ -2017,68 +2017,25 @@ static struct folio *shmem_alloc_and_add_folio(st=
ruct vm_fault *vmf,
>  }
>
>  static struct folio *shmem_swap_alloc_folio(struct inode *inode,
> -               struct vm_area_struct *vma, pgoff_t index,
> +               struct vm_fault *vmf, pgoff_t index,
>                 swp_entry_t entry, int order, gfp_t gfp)
>  {
> +       pgoff_t ilx;
> +       struct folio *folio;
> +       struct mempolicy *mpol;
> +       /* Always allow order 0 so swap won't fail under pressure. */
> +       unsigned long orders =3D BIT(order) | BIT(0);
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> -       struct folio *new, *swapcache;
> -       int nr_pages =3D 1 << order;
> -       gfp_t alloc_gfp =3D gfp;
> -
> -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -               if (WARN_ON_ONCE(order))
> -                       return ERR_PTR(-EINVAL);
> -       } else if (order) {
> -               /*
> -                * If uffd is active for the vma, we need per-page fault
> -                * fidelity to maintain the uffd semantics, then fallback
> -                * to swapin order-0 folio, as well as for zswap case.
> -                * Any existing sub folio in the swap cache also blocks
> -                * mTHP swapin.
> -                */
> -               if ((vma && unlikely(userfaultfd_armed(vma))) ||
> -                    !zswap_never_enabled() ||
> -                    non_swapcache_batch(entry, nr_pages) !=3D nr_pages)
> -                       goto fallback;
>
> -               alloc_gfp =3D thp_shmem_limit_gfp_mask(vma_thp_gfp_mask(v=
ma), gfp);
> -       }
> -retry:
> -       new =3D shmem_alloc_folio(alloc_gfp, order, info, index);
> -       if (!new) {
> -               new =3D ERR_PTR(-ENOMEM);
> -               goto fallback;
> -       }
> +       if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
> +            !zswap_never_enabled())
> +               orders =3D BIT(0);
>
> -       if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> -                                          alloc_gfp, entry)) {
> -               folio_put(new);
> -               new =3D ERR_PTR(-ENOMEM);
> -               goto fallback;
> -       }
> +       mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
> +       folio =3D swapin_sync(entry, gfp, orders, vmf, mpol, ilx);
> +       mpol_cond_put(mpol);
>
> -       swapcache =3D swapin_folio(entry, new);
> -       if (swapcache !=3D new) {
> -               folio_put(new);
> -               if (!swapcache) {
> -                       /*
> -                        * The new folio is charged already, swapin can
> -                        * only fail due to another raced swapin.
> -                        */
> -                       new =3D ERR_PTR(-EEXIST);
> -                       goto fallback;
> -               }
> -       }
> -       return swapcache;
> -fallback:
> -       /* Order 0 swapin failed, nothing to fallback to, abort */
> -       if (!order)
> -               return new;
> -       entry.val +=3D index - round_down(index, nr_pages);
> -       alloc_gfp =3D gfp;
> -       nr_pages =3D 1;
> -       order =3D 0;
> -       goto retry;
> +       return folio;
>  }
>

Sashiko reported a problem on this:

When shmem_swap_alloc_folio() computes the interleave index (ilx) for
MPOL_INTERLEAVE and MPOL_WEIGHTED_INTERLEAVE NUMA policies, it passes the
original large swap entry order to shmem_get_pgoff_policy().
If the allocation falls back to smaller orders (like order-0) inside
swap_cache_alloc_folio(), will this ilx be reused for all those fallback
allocations?
Since the calculation of ilx incorporates the original order, reusing the
same interleave index for all 512 fallback pages of a 2MB swap entry might
force them all onto the exact same NUMA node. Does this defeat the intended
page-by-page interleaving policy and potentially cause memory bandwidth
bottlenecks?

=3D=3D=3D

I initialially thought this is trivial. ilx is already somewhat broken
if we are doing fallback. shmem_get_pgoff_policy() computes ilx =3D
i_ino + (index >> order). The shift makes sense of all folios are in
the same order: an unshifted ilx =3D i_ino + index would give index %
nnodes =3D=3D 0 for every folio on power-of-2 node counts for THP so
shifting by order will ensure interleave is still effective.

However, once a file is backed with mixed-order folios due to fallback
or case, the shift becomes order-dependent and the ilx mapping is no
longer monotonic. The calculated interleave is skewed already.

It deserves a separate look as that's a pre-exist seperate problem. I
think I better not change that, as it might cause confusion. The
problem can be solved (or ignored?) later as it's not critical, the
ilx is just a hint anyway. For now I'll just squash the following
change to keep the behavior identical to before (hoist the fallback to
shmem just like before):

diff --git a/mm/shmem.c b/mm/shmem.c
index e3edc0c20e34..4427661ab2ee 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2023,19 +2023,26 @@ static struct folio
*shmem_swap_alloc_folio(struct inode *inode,
  pgoff_t ilx;
  struct folio *folio;
  struct mempolicy *mpol;
- /* Always allow order 0 so swap won't fail under pressure. */
- unsigned long orders =3D BIT(order) | BIT(0);
  struct shmem_inode_info *info =3D SHMEM_I(inode);

  if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
       !zswap_never_enabled())
- orders =3D BIT(0);
+ order =3D 0;

+again:
  mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
- folio =3D swapin_sync(entry, gfp, orders, vmf, mpol, ilx);
+ folio =3D swapin_sync(entry, gfp, BIT(order), vmf, mpol, ilx);
  mpol_cond_put(mpol);

- return folio;
+ if (!IS_ERR(folio))
+ return folio;
+
+ if (order) {
+ order =3D 0;
+ goto again;
+ }
+
+ return NULL;
 }

 /*
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 946ec4ae9ae1..ce4e8c39ed12 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -652,7 +652,7 @@ static struct folio
*swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
  * if needed. @entry is rounded down if @orders allow large allocation.
  *
  * Context: Caller must ensure @entry is valid and pin the swap
device with refcount.
- * Return: Returns the folio on success, NULL if failed.
+ * Return: Returns the folio on success, error code if failed.
  */
 struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orde=
rs,
     struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
@@ -667,7 +667,7 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t
gfp, unsigned long orders,
  } while (IS_ERR(folio) && PTR_ERR(folio) =3D=3D -EEXIST);

  if (IS_ERR(folio))
- return NULL;
+ return folio;

  swap_read_folio(folio, NULL);
  return folio;

