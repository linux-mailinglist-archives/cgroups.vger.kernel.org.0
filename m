Return-Path: <cgroups+bounces-198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE597E2E7F
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 21:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D76AB20A90
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38C2E62C;
	Mon,  6 Nov 2023 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HopfvrxU"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03352DF7D
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 20:58:23 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA065F3
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 12:58:21 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c773ac9b15so737866466b.2
        for <cgroups@vger.kernel.org>; Mon, 06 Nov 2023 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699304300; x=1699909100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKl8aQiZoT5/Gc1O1HhE3ZzebbwHEfVwbiUJglhZ9UY=;
        b=HopfvrxUiCnKmh2fP7nl/m5Qjja2uu99EeINNRlzIMJd6oD0+P/rwjX7Zlx/gt7up0
         mV/2blsThcByk50uDc1/Uzr1zSaih7FS66WBE2OZvMIeuGJXdRMW0vjBVfv9UDQxzhnv
         229//6BJatA6JpTCoWIFm1J7iJ3Ulh/ArZwAumKpJCxK4lswmJwnEOC5hMq9u6zKsJrw
         02n7qfpy5nrVkzjPr1Dyy5aGOYp8+wPin0RpxLEIGx+1eBsHpJMOE52N7DQl2gyUQRUY
         PSPIUsizmdyVQCf4tmpwch7+fovEdo3v9xWqqMFWmqQcLC4LRuX+54wEbhajGxF5tHV+
         9omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304300; x=1699909100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKl8aQiZoT5/Gc1O1HhE3ZzebbwHEfVwbiUJglhZ9UY=;
        b=tq8PSckyl2nDR615r14wd+7odgYeU/mHZcsMs2oOCqPkF98TXITdYpXiRJgCJiihsh
         991kG2Ob1r66+OlxRCJEqTY4iB5ovptkgHpflisC4NNbRN6XvikpEX8fWsqjCYoxAFrV
         1YAF9Qa8nFMOOVG/qM775jDnBx+sARKbE5ef1h5S+74UsyAxfd6Ev+3QFcRGygeFUt7m
         U76xzIAMvQnNJprMxcTe/9u7okgHl1TfxNotkzTF1L27kTb+bBJDHK1MUNs1XC9dib/l
         1FKP9YCJcIKaaBIWS0vx76aJNMQk8orRW0BwXMEIWqAxSgEZ86SqAKHY32DqkvIJyTt1
         5bGw==
X-Gm-Message-State: AOJu0Yzf3tepoqVv83Mm6ZhoLidqjQLmfAn7AghyvgqC/JmXu4zyjBdi
	2fNI6vF+53yGX+AD25t6yG30dRdwlJ1/OEkAEzoqxQ==
X-Google-Smtp-Source: AGHT+IFrCXffedtA3mNIcSD9CL5cZrq9gg6yV7X2n90hA137Lzb005Ix2ogp4oXgiw+o+Nq7W19r1UCfCcsA5LCR+3Y=
X-Received: by 2002:a17:906:da87:b0:9b7:37de:601a with SMTP id
 xh7-20020a170906da8700b009b737de601amr15301903ejb.49.1699304299984; Mon, 06
 Nov 2023 12:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <20231106183159.3562879-4-nphamcs@gmail.com>
 <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com> <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com>
In-Reply-To: <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 Nov 2023 12:57:44 -0800
Message-ID: <CAJD7tkY+qdYytVKUjdgPypZthWA57gVKuEtjowuVPMpcOmpdLQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] zswap: make shrinking memcg-aware
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > This lock is only needed to synchronize updating pool->next_shrink,
> > right? Can we just use atomic operations instead? (e.g. cmpxchg()).
>
> I'm not entirely sure. I think in the pool destroy path, we have to also
> put the next_shrink memcg, so there's that.

We can use xchg() to replace it with NULL, then put the memcg ref, no?

We can also just hold zswap_pools_lock while shrinking the memcg
perhaps? It's not a contended lock anyway. It just feels weird to add
a spinlock to protect one pointer.

>
> >
> > > +               if (pool->next_shrink == memcg)
> > > +                       pool->next_shrink =
> > > +                               mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
> > > +               spin_unlock(&pool->next_shrink_lock);
> > > +       }
> > > +       spin_unlock(&zswap_pools_lock);
> > > +}
> > > +
> > >  /*********************************
> > >  * zswap entry functions
> > >  **********************************/
> > >  static struct kmem_cache *zswap_entry_cache;
> > >
> > > -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> > > +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> > >  {
> > >         struct zswap_entry *entry;
> > > -       entry = kmem_cache_alloc(zswap_entry_cache, gfp);
> > > +       entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> > >         if (!entry)
> > >                 return NULL;
> > >         entry->refcount = 1;
> > [..]
> > > @@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
> > >                 zswap_invalidate_entry(tree, dupentry);
> > >         }
> > >         spin_unlock(&tree->lock);
> > > -
> > > -       /*
> > > -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> > > -        * cgroup-aware entry LRU, we will push out entries system-wide based on
> > > -        * local cgroup limits.
> > > -        */
> > >         objcg = get_obj_cgroup_from_folio(folio);
> > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > -               goto reject;
> > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > +               memcg = get_mem_cgroup_from_objcg(objcg);
> > > +               if (shrink_memcg(memcg)) {
> > > +                       mem_cgroup_put(memcg);
> > > +                       goto reject;
> > > +               }
> > > +               mem_cgroup_put(memcg);
> >
> > Can we just use RCU here as well? (same around memcg_list_lru_alloc()
> > call below).
>
> For memcg_list_lru_alloc(): there's potentially sleeping in that piece of
> code I believe? I believe at the very least we'll have to use this gfp_t
> flag for it to be rcu-safe:
>
> GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
> not sure the
>
> Same go for this particular place IIRC - there's some sleeping done
> in zswap_writeback_entry(), correct?

Ah right, I missed this. My bad.

