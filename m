Return-Path: <cgroups+bounces-16447-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNDGJwXWGWqjzQgAu9opvQ
	(envelope-from <cgroups+bounces-16447-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:08:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C406070DF
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD57316E1AB
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C36638B157;
	Fri, 29 May 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHX9Xov+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F71382395
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076039; cv=pass; b=YlLCM/n6OGpbtaw/Zi4ihiWWdLbBis6l6PC1+2ifvpAwJ/X+lt7ycloxjsrWDmiKdj5UF3K0tkLwb7Ne4ze9oBzo1d436wB1H000tEWxQmFTqHTB5vOOsI1m8Kbrdpu0RR9MtBIv+iqp64/xKERRMgYxQa0XGgHfNlKoCQer0cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076039; c=relaxed/simple;
	bh=HRzF155c5mEHrapLZcVdfqm/FavvS4cFZy12GiOSSfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBhXif12mJVZBLJotDgMizjYAzTQtf7PBV+I6pLMSEW9u2PmXv1/5gvtrzXbBaPkDdPtAfbCoLGLhemPwpA7umHMvBo8sVW63Kkf/s5KP/ju2NSOCkPmDQctaMwOSvSQsfi7scMr6tFz3Ene9+x/2rqkCXOSLtaqRpfnG5RR9vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHX9Xov+; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so993902a12.3
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 10:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780076035; cv=none;
        d=google.com; s=arc-20240605;
        b=MbQdU0aHRGglqh3T3gvNUixVw9kOKGqwJ44MGE2IuTmU1vZV2bagaSAlYn9kQxXhc+
         qDbftw1EL52u+tbbh58XICYA9ghUwypmZRfwvWS1HTiEGCveCvPbWWYrSV2MrhGEslM/
         3tAvyp1cNJDbU+rQpJMXc0jN5sf4/WdSltTj6Xlt1Ap9itcksKYwVzh6eHq150+EXdbi
         ViDfzNUliM+QCAxXm33bMiOzjsU00GClRtt0nNKrg0HDVFtjvwuuA7U1js2kqssEqy2C
         cWtizLZUOBvm9VODh6NYbwCqgTvvJ2m5KiLFF4KFqSw4bG1rw0wEZrJTecdT5bQE83Se
         F6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Y1XcjOHFQ9UlSj3LLvlBTMnTHneWT6yg0YWoIAFOd8=;
        fh=jf5+x9m8UfifIW6NdCmVOWDPNdyODJBmWfz0If2X7HA=;
        b=jnqEssxe2hF+OIKT27k9+LOHFtH5tioZiRuU0lOiTDx61WWpFSPCUhpiSjj4Z/UFK6
         6CgRMX/CCPeMUvL2yBxEQtOyjeA0MZV5WP1Kex9nFtEjY31kk6JZYWoJmgMAoozRfciw
         YLE53epqx627I43uRTH8tlWFFBuJVDkun3c4VfRY+ICzG4xQaWKVLIU8zrEa7Gu5MFhO
         uwhmlDxwYZehbNGrKbnwvKNAo6ZVrcm6gws9cUEgobr3j18KsFp0KjCsNM9dnJ5mTWnb
         I9aapdUZsv0Yk7LAEehYXvjh0SCl6eg/9OPpIKw1A3MMOMbPDGP57M2PZtPRutZHZZmB
         l3Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076035; x=1780680835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y1XcjOHFQ9UlSj3LLvlBTMnTHneWT6yg0YWoIAFOd8=;
        b=MHX9Xov+gxXqE9mKKdMskDJk2CLZ7KVjBAc+tyjWRS46CIGT2ylMlI8g7W7BjtNTKt
         18a9GUJQZXc/1X6MOLISYLeYxqErRZPipQOaVsygg0HGo2n5rAzMbk7j4B5GCnd93fu4
         iR5ny9m4AaAKJOnfslkLhnhxr4TlcMGTWGBaXnz8vcXiE8J1bCR6cnEC04msE89WV7pE
         H4E32KIevXaJn8fJZAUxoL8xQGhtgF5LtlKRirFJThzUFtJ8mRJgcs1X2ayYiAUvQZbf
         GDNjJIETaM0NYPeDB7NwKRo0KMdz04gLFKjAay8u4g3UFG/616j+OXYHfQ4GC6Q07ZH4
         U2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076035; x=1780680835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Y1XcjOHFQ9UlSj3LLvlBTMnTHneWT6yg0YWoIAFOd8=;
        b=PWRWAVDtB9ge6kq3Xo+qq7P6FJUyh2+mQaAs1iteloqp1BtTNXO56tFiX9IRmTh0B8
         Pl/QeUiHvIoUcfw3KhxHJX8XiklJil6nsfNKeKNxbq4n18XaURXRSn7lbzO91SIsZ9Ek
         PJs75DKWn4y28sJgFapPDFyvr71stQzx8rl7esyPoe+QKjo21q8aDjBpKrOlCqOiy7J+
         9QKlhwWlRMjhpK9ZVk6yX6Xy+neyi097DFUQhttwIKy8lEtUM5GozlYj3a78+yJkFVIo
         qgImwxTycbjBShcbfNl7s6RWaQwyh4GED87qVimfL8USQdTChMoW6iYH1Mdsu4tuwV5S
         htFA==
X-Forwarded-Encrypted: i=1; AFNElJ9SUA/I7Ad0XDq18+R5QLk6Ds5FdE4Kmp+JnV20czNqH48kZP4qpZoSvoLi/6vdWs9VoBmcHMeY@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGNcXskziKIqx2pjGhtLlVgAEGu1V/Mvse51m4jEjNu8A8yAe
	hkTLyuYsGDpDKP2B6BxIjUB5/hpVzCX2+6rkUeDaxdXpNj19z4bzXLjCB2TYo63cbepmBJIawK9
	oi/+SCBAFmifo/KpQjWETiv4abrC+VgQ=
X-Gm-Gg: Acq92OFIlu/HKdHqVJKuc6mjiSeTfTwegRWgyUkK/TaXBrdonq68WfK0rWamA860K8v
	Vo7f53RZsXusjtPRE7WeRJEDo69+rYhYlAW+Ak+aHOYPwqgV9N6tvSWm+wJns3PKpUikfZKciVM
	x3cfvnDgsTcPJXPOIpZ3PIBiBXZWEEMTP+8E+rTjLhuiD+pOp9D2p1jgkyvOKbGW7YZ3YvWxt+R
	uD6/UUAHxgsOjoPxurTsf1xz/7wUun0Wg0CuFRYm4qLnruEoQJqCXSkJo/nZC3ACanCSMHXuZVn
	BpoklicHW6jXo/Gv3a7zabZT/4nFu+FjURDONKdNaMkKONsJhR+U5J6+kyNtvA==
X-Received: by 2002:aa7:c1c6:0:b0:68b:539c:d269 with SMTP id
 4fb4d7f45d1cf-68c8c56029bmr262541a12.12.1780076035166; Fri, 29 May 2026
 10:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527204757.2544958-1-hannes@cmpxchg.org> <20260527204757.2544958-10-hannes@cmpxchg.org>
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 30 May 2026 01:33:16 +0800
X-Gm-Features: AVHnY4KkmKr_Dg7RuDhDe1BHG_7cHKvDQIjkTdZbfzW_BPAuMIyLPUW-Nsl3cwc
Message-ID: <CAMgjq7BFUrZ_nwENUycWZD2Fy2zBH4vms_GLTbp9ahYuA6SiHg@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mikhail Zaslonko <zaslonko@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16447-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:email,linux.dev:email,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 02C406070DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 4:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The deferred split queue handles cgroups in a suboptimal fashion. The
> queue is per-NUMA node or per-cgroup, not the intersection. That means
> on a cgrouped system, a node-restricted allocation entering reclaim
> can end up splitting large pages on other nodes:
>
>         alloc/unmap
>           deferred_split_folio()
>             list_add_tail(memcg->split_queue)
>             set_shrinker_bit(memcg, node, deferred_shrinker_id)
>
>         for_each_zone_zonelist_nodemask(restricted_nodes)
>           mem_cgroup_iter()
>             shrink_slab(node, memcg)
>               shrink_slab_memcg(node, memcg)
>                 if test_shrinker_bit(memcg, node, deferred_shrinker_id)
>                   deferred_split_scan()
>                     walks memcg->split_queue
>
> The shrinker bit adds an imperfect guard rail. As soon as the cgroup
> has a single large page on the node of interest, all large pages owned
> by that memcg, including those on other nodes, will be split.
>
> list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
> streamlines a lot of the list operations and reclaim walks. It's used
> widely by other major shrinkers already. Convert the deferred split
> queue as well.
>
> The list_lru per-memcg heads are instantiated on demand when the first
> object of interest is allocated for a cgroup, by calling
> folio_memcg_alloc_deferred(). Add calls to where splittable pages are
> created: anon faults, swapin faults, khugepaged collapse.
>
> These calls create all possible node heads for the cgroup at once, so
> the migration code (between nodes) doesn't need any special care.
>
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/huge_mm.h    |   7 +-
>  include/linux/memcontrol.h |   4 -
>  include/linux/mmzone.h     |  12 --
>  mm/huge_memory.c           | 364 +++++++++++++------------------------
>  mm/internal.h              |   2 +-
>  mm/khugepaged.c            |   5 +
>  mm/memcontrol.c            |  12 +-
>  mm/memory.c                |   4 +
>  mm/mm_init.c               |  15 --
>  mm/swap_state.c            |  10 +
>  10 files changed, 150 insertions(+), 285 deletions(-)

...

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 04f5ce992401..9c3a5cf99778 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -465,6 +465,16 @@ static struct folio *__swap_cache_alloc(struct swap_=
cluster_info *ci,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> +       if (order > 1 && folio_memcg_alloc_deferred(folio)) {
> +               spin_lock(&ci->lock);
> +               __swap_cache_do_del_folio(ci, folio, entry, shadow);
> +               spin_unlock(&ci->lock);
> +               folio_unlock(folio);
> +               /* nr_pages refs from swap cache, 1 from allocation */
> +               folio_put_refs(folio, nr_pages + 1);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +

Thanks!

Nit: I think it would be better if we move the error handling under a
label to be shared with the charge failure above, but it's fine this
way, can be simplified later.

Reviewed-by: Kairui Song <kasong@tencent.com>

