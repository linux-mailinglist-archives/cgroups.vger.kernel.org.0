Return-Path: <cgroups+bounces-17030-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2tRB3yMMmqd1wUAu9opvQ
	(envelope-from <cgroups+bounces-17030-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:01:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291A6996A2
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:00:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dlUmciTH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17030-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17030-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B3C130EF4B6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949363F0A8C;
	Wed, 17 Jun 2026 11:53:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCA368D42
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 11:53:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697193; cv=pass; b=ds7X1kk3P+jYfLHcm7RFSsnDT/H+tRuVObRNT0tIpk7O8FxSW4IEp3kbkuxBeUEaRGceu6N4Q1y00tcp0EyL+Fj+BldUi6HvYaQhA84LnkTozFs1QOa7jG3RdpTBHYREYIQaPJo5Pd32GPE0SSd+1ST0gy/nHc3hfx6/0+kODL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697193; c=relaxed/simple;
	bh=cUDEvLc6wTYr8D5hsHGI1WTFC3szUreAtdaQwP+TXug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZKisdHD7+fWkxXmrxRUKRG8YWoJDAqoKyMuo03TZaSNgurSMcCA0DXEOkH9iTiUT3PibPGrloKGv8w5mgi/3ATbQziYRX9JYly/xiXPl2wgslcLArNQL52fTOhxeFeHBZYKtu1e2UlWxP7aJ0giF3qBDUHu79cN/xXoh6wMi+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlUmciTH; arc=pass smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1363fe80fe8so8066377c88.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 04:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781697188; cv=none;
        d=google.com; s=arc-20240605;
        b=iq+8FF+ts6Kvzc9vVejeVua9O0NJ3kgN4FmHoFMfvRC0Oz6KzwXtKbiR0S64FEBV1+
         nsSnFv2md6ynUP8PFlwKBD7SGj2+Y6MB5YwxTy/DNJceUtSm4NQqQwSP7vybMlQX88YQ
         atqslfOPuHRg8neIaVJ456cKc1K5TEqi5E3fIqmBSercNPzCjt7aWC4Vg15qLWFtdKyN
         k/O5eI5Mlumc53BXbToIK7V9kPycODfure4u4aPVkDi+rApXODQftaSfGM1qud88jePi
         Ydj//MbtCA/YYJ5utx5h0yF824SUyrUZKOT83SMHGI8Zl7hU18NQwpLxc1dr4L5pD0xK
         SzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cGlHWuGXeKrZx4UWzJ913wMAVSNzg6yu/EagxfeXFaY=;
        fh=h4HMeXUJXgHYl/Juqqb4Vr/hsKUcn9h/ThdXNSV34pU=;
        b=StzChe2MUpEXxE5gP0ExGHLpmVWWzmK6cROA5Z8r1JCpPSfCmgyrP+hmbXOUqlQV6k
         Q/ZwGkqXO7/QCYjsFTt5w/0vxxnfbCew64Im/X3EbU1xjWDD1uepFOgXyDY7rrO55kdB
         J0KzQcn3Qscy/gijOWDeE6Hz9MciUUY0wtMafAhG9YG0rsjTkXRs6vyYncp/bG3MQsgb
         HKHcsXhYSVprs/nViR/EdvNV0stQWGHv0Cp/Z5eLa9e0iJXlSeMjidNTmn85ixQNDvWd
         qggo6i+XR6cEj0KbhTf6QNHcgUAR4+X3vuWwvmcG5MLZZLt8FYV8Bibkwzv5rV60Vioj
         pV2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781697188; x=1782301988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGlHWuGXeKrZx4UWzJ913wMAVSNzg6yu/EagxfeXFaY=;
        b=dlUmciTHjpPld4YVPPTj7ZqNxrWhFdcF6ia1O2BU5vuIFWNNeCMKw//AbR9r7NAC0h
         pJ/a3O7qKNzhJBmhZ4Om7rUF8Kim0Mq1tN21POCE7F9f1/YCnehA74QSuUnu9WiRupjW
         7mOdCbSrqUfx6p6Kh3WNr33SME52wZFA+E2q3ZWnR9vT1VCX6/iodGklmMFgA6rDf0hd
         vW8PytlerqaMDuGbdzBQcPY1AEocyp2r6C5VRTB4kxAx9k/lnLcFVnKcS6mQ4fo/sITQ
         5ESdG+uDaQFLRd1GHotyX/bGSRH8jEW6HMXLgv2w7dS78I+E6H3ur4uHbIeKSbNC5Frb
         9yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697188; x=1782301988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGlHWuGXeKrZx4UWzJ913wMAVSNzg6yu/EagxfeXFaY=;
        b=ot6yXMhyU/bvhxzuuQh8sQmx7TASmjYPa73EY0gvKycPS07I07g2gdIRl9I1qe5WV3
         96VyYrVigy022asBuiGS6fAtinV0sCblkDk4y2nyia4OaEvjHs3XplbMxJ5hwM9RD6wO
         HdqKoSkC7PBUZJvmYc3Z/ziUTrYamjgsxhJ7KlIU+ubTXC7ZgHVRgCK8Fy9tPtgvzoGQ
         Ki9HnOK411SuXXZ2Hp/FjXAXPa4TQOxpqJdNi6uP4b4iI9i1BfiIsyPLa1w/1S8guZqU
         rAKW4Bw9D2kqy7lVZ7TCSOacZhg/LM87b+/uaVkLZH/ppKtgB3uzcxbh+wU0RE2lAITO
         4mSA==
X-Forwarded-Encrypted: i=1; AFNElJ/v+5u+rJgrWrQgx1Gdn0fTo1boZY8R3TBRGiOXL1UGA8sNqPO1+NhjtopAHtbSQQZD1F42pQ5I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29OIhK35vkvVt0oaO7Q0qaq/fhl6aRh4DW0CLxL6WtF96qPCf
	W5Rgsa7m/EMJCgSZh438eDB6Kk1aLtms6PKrqmqQ4/1xsRm/C1G9MQnJIFs1bK2GgmmstjMBDtr
	5yRFy78Yo0oCR8mQvkkMssWDqYcwyl8CkGfPhmvQU
X-Gm-Gg: Acq92OETgmkFznQr8VAWF6FQHeSUCGpot6JFVuJbo+4IROnGy6K5wz6IqXoCiuGa+YT
	EoNecB2vHTlkyJzugt2t2/r4pVMMLFpKkv0KHqz8gtYElg0Qoob7VmeD9h5V9En+TpHdnxSi3AF
	R9gLk2rk1h8aRqwAm3+bTJtf5h+V//yAt7xtsF+U4SBdpTmuKDRCPSf8C/ephydW2g+BrkF00I9
	pvZnpJgL7FNrK4QrVpKEbeZIG9mikTU72vHik/w1FJ5iSZl/ERs4S3GjgP/kAnvYMl2tHae1ptR
	ICUghJXgNBAPWb2gbcM13xcG0Q==
X-Received: by 2002:a05:7022:61b:b0:138:43a4:840a with SMTP id
 a92af1059eb24-1398f6de373mr1539573c88.28.1781697187613; Wed, 17 Jun 2026
 04:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org> <20260615-slab_alloc_flags-v3-1-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-1-ce1146d140fb@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 17 Jun 2026 13:52:30 +0200
X-Gm-Features: AVVi8CeSd8DwGdr5fwTjeMrcXBBqYNOxp4cbPTPDwCMkFfaEjjw7vXGVvvRGZ3o
Message-ID: <CANpmjNNm9jwAHDoNO_u156HEHhAYvSmpbD-rHs9OHdnHAWeKSA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] mm/slab: do not init any kfence objects on allocation
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[elver@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17030-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5291A6996A2

On Mon, 15 Jun 2026 at 13:54, Vlastimil Babka (SUSE) <vbabka@kernel.org> wrote:
>
> When init (zeroing) on allocation is requested, for kmalloc() we
> generally have to zero the full object size even if a smaller size is
> requested, in order to provide krealloc()'s __GFP_ZERO guarantees.
>
> When we end up allocating a kfence object, kfence performs the zeroing
> on its own because it has its own redzone beyond the requested size.
> Thus slab_post_alloc_hook() has an 'init' parameter which has to be
> evaluated in all callers (via slab_want_init_on_alloc()) and should be
> false for kfence allocations.
>
> For kfence allocations in slab_alloc_node() this is achieved by subtly
> skipping over the slab_want_init_on_alloc() call. Other callers (i.e.
> kmem_cache_alloc_bulk_noprof()) however evaluate it unconditionally even
> if they do end up with a kfence allocation. This is only subtly not a
> problem, as those are not kmalloc allocations and thus the "requested
> size" equals s->object_size and thus it cannot interfere with kfence's
> redzone. There's just a unnecessary double zeroing (in both kfence and
> slab_post_alloc_hook()), but it's all very fragile and contradicts the
> comment in kfence_guarded_alloc().
>
> Remove this subtlety and simplify the code by eliminating the init
> parameter from slab_post_alloc_hook() and make it call
> slab_want_init_on_alloc() itself. Instead add a is_kfence_address()
> check before performing the memset, which will start doing the right
> thing for all callers of slab_post_alloc_hook().
>
> This potentially adds overhead of the is_kfence_address() check to
> allocation hotpath, but that one is designed to be as small as possible,
> and it's only evaluated if zeroing is about to happen. This means (aside
> from init_on_alloc hardening) only for __GFP_ZERO allocations, and the
> zeroing itself comes with an overhead likely larger than the added
> check.
>
> While at it, refactor the handling of evaluating when KASAN does the
> init instead of SLUB, with no intended functional changes. A
> non-functional change is that we don't pass kasan_init as true to
> kasan_slab_alloc() if kasan has no integrated init, but then the value
> is ignored anyway, so it's theoretically more correct.
>
> Thanks to Harry Yoo for the initial refactoring attempt, and for updated
> comments that are used here.
>
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c |  2 +-
>  mm/slub.c        | 60 ++++++++++++++++++++++++++------------------------------
>  2 files changed, 29 insertions(+), 33 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 655dc5ce3240..5e0b406924e9 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -500,7 +500,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>
>         /*
>          * We check slab_want_init_on_alloc() ourselves, rather than letting
> -        * SL*B do the initialization, as otherwise we might overwrite KFENCE's
> +        * slab do the initialization, as otherwise it might overwrite KFENCE's
>          * redzone.
>          */
>         if (unlikely(slab_want_init_on_alloc(gfp, cache)))
> diff --git a/mm/slub.c b/mm/slub.c
> index e2ee8f1aaccf..d762cbe5d040 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4565,13 +4565,13 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
>
>  static __fastpath_inline
>  bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> -                         gfp_t flags, size_t size, void **p, bool init,
> +                         gfp_t flags, size_t size, void **p,
>                           unsigned int orig_size)
>  {
> +       bool init = slab_want_init_on_alloc(flags, s);
>         unsigned int zero_size = s->object_size;
> -       bool kasan_init = init;
> -       size_t i;
>         gfp_t init_flags = flags & gfp_allowed_mask;
> +       bool kasan_init = false;
>
>         /*
>          * For kmalloc object, the allocated size (object_size) can be larger
> @@ -4588,28 +4588,33 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>                 zero_size = orig_size;
>
>         /*
> -        * When slab_debug is enabled, avoid memory initialization integrated
> -        * into KASAN and instead zero out the memory via the memset below with
> -        * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
> -        * cause false-positive reports. This does not lead to a performance
> +        * ARM64 can set memory tags and zero the memory using a single
> +        * instruction. Since HW_TAGS KASAN uses that while tagging the object,
> +        * separate zeroing is unnecessary.
> +        *
> +        * However, KASAN never zeroes memory when slab_debug is enabled to
> +        * avoid overwriting SLUB redzones. This does not lead to a performance
>          * penalty on production builds, as slab_debug is not intended to be
>          * enabled there.
>          */
> -       if (__slub_debug_enabled())
> -               kasan_init = false;
> +       if (kasan_has_integrated_init() && !__slub_debug_enabled()) {
> +               kasan_init = init;
> +               init = false;
> +       }
>
> -       /*
> -        * As memory initialization might be integrated into KASAN,
> -        * kasan_slab_alloc and initialization memset must be
> -        * kept together to avoid discrepancies in behavior.
> -        *
> -        * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
> -        */
> -       for (i = 0; i < size; i++) {
> +       for (size_t i = 0; i < size; i++) {
>                 p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
> -               if (p[i] && init && (!kasan_init ||
> -                                    !kasan_has_integrated_init()))
> +
> +               /*
> +                * memset and hooks come after KASAN as p[i] might get tagged
> +                *
> +                * kfence zeroes the object instead of SLUB to avoid overwriting
> +                * its own redzone starting at orig_size, which could happen
> +                * with SLUB zeroing full s->object_size
> +                */
> +               if (init && p[i] && !is_kfence_address(p[i]))
>                         memset(p[i], 0, zero_size);
> +
>                 if (gfpflags_allow_spinning(flags))
>                         kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                                  s->flags, init_flags);
> @@ -4910,7 +4915,6 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>                 gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
>  {
>         void *object;
> -       bool init = false;
>
>         s = slab_pre_alloc_hook(s, gfpflags);
>         if (unlikely(!s))
> @@ -4926,16 +4930,13 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>                 object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
>
>         maybe_wipe_obj_freeptr(s, object);
> -       init = slab_want_init_on_alloc(gfpflags, s);
>
>  out:
>         /*
> -        * When init equals 'true', like for kzalloc() family, only
> -        * @orig_size bytes might be zeroed instead of s->object_size
>          * In case this fails due to memcg_slab_post_alloc_hook(),
>          * object is set to NULL
>          */
> -       slab_post_alloc_hook(s, lru, gfpflags, 1, &object, init, orig_size);
> +       slab_post_alloc_hook(s, lru, gfpflags, 1, &object, orig_size);
>
>         return object;
>  }
> @@ -5230,7 +5231,6 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>                                    struct slab_sheaf *sheaf)
>  {
>         void *ret = NULL;
> -       bool init;
>
>         if (sheaf->size == 0)
>                 goto out;
> @@ -5240,10 +5240,8 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>         if (likely(!ret))
>                 ret = sheaf->objects[--sheaf->size];
>
> -       init = slab_want_init_on_alloc(gfp, s);
> -
>         /* add __GFP_NOFAIL to force successful memcg charging */
> -       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, s->object_size);
>  out:
>         trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
>
> @@ -5423,8 +5421,7 @@ void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, in
>
>  success:
>         maybe_wipe_obj_freeptr(s, ret);
> -       slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
> -                            slab_want_init_on_alloc(alloc_gfp, s), orig_size);
> +       slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret, orig_size);
>
>         ret = kasan_kmalloc(s, ret, orig_size, alloc_gfp);
>         return ret;
> @@ -7339,8 +7336,7 @@ bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
>
>  out:
>         /* memcg and kmem_cache debug support and memory initialization */
> -       return likely(slab_post_alloc_hook(s, NULL, flags, size, p,
> -                       slab_want_init_on_alloc(flags, s), s->object_size));
> +       return likely(slab_post_alloc_hook(s, NULL, flags, size, p, s->object_size));
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
>
>
> --
> 2.54.0
>

