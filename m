Return-Path: <cgroups+bounces-17199-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id njqpFU7YOmqrIQgAu9opvQ
	(envelope-from <cgroups+bounces-17199-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 21:02:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DC6B9943
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 21:02:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WgWyZwwj;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17199-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17199-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A110302D13F
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFE34AB14;
	Tue, 23 Jun 2026 19:02:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC92E7F39
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 19:02:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241324; cv=none; b=qxcmy/rRUOuMZXOPPuyppiqwdKZt3AHjUH2tD67KbzHogg5Ztuh+UXHx66uveBeeYeKWsNDhvGVQLT2SQODjWQ3DCipZK7c2bBzM/W7i7VOPSGLCrS48mwdBunMevueSwe9DeNvxohukNA0PCGULFuVAem9a2h4goUkMANzOGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241324; c=relaxed/simple;
	bh=+mCZWcOPRBcplABWFgR7V0EjMlKdQycKXHxAG0KA1kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ry2/BhWWKPdw0+X6qe+0W0rVJCBAq2E6Eb5qo3w7/tC7WpuKeKUTgiqvyjAaiddlUwC08QOrsi1ZzXNSTWD6gL7Lb0YZKaK3bWsPLPCbJLzAr4sigg5CBg1KvMrF6fw+o9NACblRe6hYMABzPsd/TGP8vB++14v/YRhmjsgYHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgWyZwwj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EAA1F00A3E
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782241322;
	bh=y0u6nVtK/qnX+X7yL0jwUT2bDPnwgnxx/Mcp9KbGIeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WgWyZwwjocbxiwbsfkw8IuWztr3YfbY15fMNWJ37Z23Zkc7NA3jpaSd6zhxlIZL9M
	 jJB7MsNwc6ThiBC8POBmIPCXfLrjXjmIJPQhSQsD9P1oAVfRdjhTSVqH0YH4nCcQCX
	 i1U9uIr2DASjbrmOiZnWsqsHC6BVfRbGGX/e+NdUhcjNOtuqKZIn/uc3HePQnl2lc9
	 r2T3pr1VY5JZ+70JLDNHb6HCVrksr+7t1JaB67WVdOCOmxwXr8KUqKbgFx1jDuUa2i
	 ouFqMOZBhIuH4DBBrSDfSOh0wHXX7gJzVhT37l2Gpf4aAD//rsWDDkVIKxVriUUDGs
	 evQw5R0Dfrc/g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso315895a12.0
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 12:02:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+HuC8M8cv3ubP2dk6O5rKa0ALq2El/etIojKggzBHcloe1prmRCZvBIbRNL34xUj6j/iisM6v@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbCUPZE7ANFLtIZSSbwk9aPqQBQaJNHH2c/KqYX5JmZOFIgFn
	cZNcwzx7l4MW9vY50rSeJXGhztH2Z2p51kNbIAR+gjS/K0h4TbFffLgGCyWXnZDvteJfHjIHhvN
	K0KGsgiuLeUWZHanaWvtBl9LTS7+U8Jc=
X-Received: by 2002:a17:906:9fc5:b0:c06:1310:21cc with SMTP id
 a640c23a62f3a-c09901dce24mr1220373466b.47.1782241321011; Tue, 23 Jun 2026
 12:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-4-nphamcs@gmail.com>
In-Reply-To: <20260612193738.2183968-4-nphamcs@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 23 Jun 2026 12:01:49 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPXk2eRbVcEMQDTCH1j-w241h189=p04FenAfKAjkkQtA@mail.gmail.com>
X-Gm-Features: AVVi8CeMEsmSPhPPFsXFa4O7MYG4Joyu2sWMWrZwPnhH3H9VtouH8kf4mAa2ZTQ
Message-ID: <CAO9r8zPXk2eRbVcEMQDTCH1j-w241h189=p04FenAfKAjkkQtA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap backend
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, 
	youngjun.park@lge.com, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17199-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F1DC6B9943

> diff --git a/mm/zswap.c b/mm/zswap.c
> index 466f8a182716..5daff7a25f67 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -993,6 +993,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>         struct folio *folio;
>         struct mempolicy *mpol;
>         struct swap_info_struct *si;
> +       swp_entry_t phys = {};
>         int ret = 0;
>
>         /* try to allocate swap cache folio */
> @@ -1000,16 +1001,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>         if (!si)
>                 return -EEXIST;
>
> -       /*
> -        * Vswap entries have no physical backing - writeback would fail
> -        * and SIGBUS the caller. Bail before we waste a swap-cache folio
> -        * allocation.
> -        */
> -       if (si->flags & SWP_VSWAP) {
> -               put_swap_device(si);
> -               return -EINVAL;
> -       }
> -
>         mpol = get_task_policy(current);
>         folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
>                                        NO_INTERLEAVE_INDEX);
> @@ -1028,40 +1019,78 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>         /*
>          * folio is locked, and the swapcache is now secured against
>          * concurrent swapping to and from the slot, and concurrent
> -        * swapoff so we can safely dereference the zswap tree here.
> -        * Verify that the swap entry hasn't been invalidated and recycled
> -        * behind our backs, to avoid overwriting a new swap folio with
> -        * old compressed data. Only when this is successful can the entry
> -        * be dereferenced.
> +        * swapoff so we can safely dereference the zswap tree (or vswap
> +        * vtable) here. Verify that the swap entry hasn't been
> +        * invalidated and recycled behind our backs, to avoid overwriting
> +        * a new swap folio with old compressed data. Only when this is
> +        * successful can the entry be dereferenced.
>          */
> -       tree = swap_zswap_tree(swpentry);
> -       if (entry != xa_load(tree, offset)) {
> -               ret = -ENOMEM;
> -               goto out;
> +       if (swap_is_vswap(si)) {
> +               if (entry != vswap_zswap_load(swpentry)) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +               /*
> +                * Allocate physical backing BEFORE decompress - if it fails,
> +                * no wasted work. folio_realloc_swap sets vtable to PHYS,
> +                * overwriting ZSWAP - the old entry pointer is only held
> +                * by the caller now.
> +                */
> +               phys = folio_realloc_swap(folio);
> +               if (!phys.val) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +       } else {
> +               tree = swap_zswap_tree(swpentry);
> +               if (entry != xa_load(tree, offset)) {
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }

There's a lot of divergence in the code (in this patch and previous
ones). Seems like a lot of it is to do xarray operations vs vswap
operations. I wonder if we can abstract these into helpers, e.g.
zswap_tree_store(), zswap_tree_load(), etc. Maybe the name is not the
best, but you get the point :)

Here we can then do zswap_tree_load() for both code paths and only the
folio_realloc_swap() needs to be different for vswap. We can do
similar cleanups for the load/store paths as well.

>         }
>
>         if (!zswap_decompress(entry, folio)) {
>                 ret = -EIO;
> +               /*
> +                * For vswap: folio_realloc_swap already moved the entry
> +                * out of the vtable. Restore it via vswap_zswap_store so
> +                * the entry stays tracked (and the just-allocated PHYS
> +                * slot is freed). For non-vswap: entry is still in the
> +                * zswap tree.
> +                */
> +               if (swap_is_vswap(si) && phys.val)
> +                       vswap_zswap_store(swpentry, entry);

Should this go in the cleanup path instead (i.e. in the 'out' label?).

>                 goto out;
>         }
>
> -       xa_erase(tree, offset);
> +       if (!swap_is_vswap(si))
> +               xa_erase(tree, offset);

Maybe this can also be abstracted into a helper, but I wonder what the
corresponding vswap operation would be. I think folio_realloc_swap()
will have already "erased" the zswap entry from vswap. Maybe have a
vswap helper that will only remove it if it's a zswap entry? We can
probably do a lockless check first to make it cheap?

It's probably silly to do this, and maybe there's a better way.
Generally, I think the code would be easier to follow if we abstract
away the xarray vs. vswap stuff into helpers (where it's reasonable).

>
>         count_vm_event(ZSWPWB);
>         if (entry->objcg)
>                 count_objcg_events(entry->objcg, ZSWPWB, 1);
>
> -       zswap_entry_free(entry);
> -
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
>         /* move it to the tail of the inactive list after end_writeback */
>         folio_set_reclaim(folio);
>
> -       /* start writeback */
> -       ret = __swap_writepage(folio, NULL);
> -       WARN_ON_ONCE(ret);
> +       /*
> +        * Start writeback. __swap_writepage_phys is void; __swap_writepage
> +        * returns 0 today (async IO errors surface in the bio end_io
> +        * callback). Either way the entry has been moved out of its prior
> +        * location (vtable PHYS for vswap, removed from tree otherwise),
> +        * so we own the free.
> +        */
> +       if (swap_is_vswap(si)) {
> +               __swap_writepage_phys(folio, NULL, phys);
> +       } else {
> +               ret = __swap_writepage(folio, NULL);
> +               WARN_ON_ONCE(ret);
> +       }
> +
> +       zswap_entry_free(entry);
>
>  out:
>         if (ret) {
> @@ -1212,6 +1241,18 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>         if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
>                 return 0;
>
> +       /*
> +        * With CONFIG_VSWAP, vswap-backed zswap entries need a physical
> +        * swap slot allocated on demand (via folio_realloc_swap) for
> +        * writeback. If no physical slots are available, writeback will
> +        * fail - skip the shrinker to avoid spinning on entries we cannot
> +        * drain. Vanilla zswap-on-swapfile is unaffected because every
> +        * zswap entry already has a backing slot; gate on CONFIG_VSWAP so
> +        * the check compiles out there.
> +        */
> +       if (IS_ENABLED(CONFIG_VSWAP) && !get_nr_swap_pages())
> +               return 0;
> +
>         /*
>          * The shrinker resumes swap writeback, which will enter block
>          * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
> @@ -1558,7 +1599,7 @@ bool zswap_store(struct folio *folio)
>          * writeback could overwrite the new data in the swapfile.
>          */
>         if (partial_store && is_vswap_entry(swp))
> -               folio_release_vswap_backing(folio);
> +               folio_release_non_phys_swap_backing(folio);
>         else if (!ret && !is_vswap_entry(swp)) {
>                 unsigned type = swp_type(swp);
>                 pgoff_t offset = swp_offset(swp);
> --
> 2.53.0-Meta
>

