Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C284D47F42C
	for <lists+cgroups@lfdr.de>; Sat, 25 Dec 2021 18:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhLYRxz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Dec 2021 12:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhLYRxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Dec 2021 12:53:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC2C061401
        for <cgroups@vger.kernel.org>; Sat, 25 Dec 2021 09:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DsB14TIFCiBAdP7rD7EHBmZ2vEchTQE1iQvq9NRvB9w=; b=P8eHkVObvPl/+oE4RPc6QOntRY
        /de/u2l0W5mC3WRBpFK4be27bPrWJfdkv1FuPLbMrayZv+0guT03DnIrQ/xL3ldKXn+hP73WRranJ
        BzynHSKSXf1ouyx0LrktgopeQyRdndjcLtl7c/XkqALfMs9N7wE6eV9QGeWSvaR3pq7XUuXx2IYyP
        iN7kRcmN7F4B5szTaLh5wURmvRCOqzWou5PnMz2K4MRAAWjoExqrZE1+3Ev5rn5sBWZqpj5Oq7sda
        DGBdHlvxWH9UnXyu0o4m5b7pRDFJ0SNAdOIkV/egmPglIrpj5BKAwgN6thX544+NOaU1tHVYkZSQs
        /2BQ/rBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1BER-005yjd-Ai; Sat, 25 Dec 2021 17:53:23 +0000
Date:   Sat, 25 Dec 2021 17:53:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, cgroups@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        kasan-dev@googlegroups.com, Lu Baolu <baolu.lu@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Ycdak5J48i7CGkHU@casper.infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 09:16:55AM +0000, Hyeonggon Yoo wrote:
> # mm: Convert struct page to struct slab in functions used by other subsystems
> I'm not familiar with kasan, but to ask:
> Does ____kasan_slab_free detect invalid free if someone frees
> an object that is not allocated from slab?
> 
> @@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> -       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> +       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
>             object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
> 
> I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
> returns false. That will cause NULL pointer dereference in nearest_obj.
> I don't think this change is intended.

You need to track down how this could happen.  As far as I can tell,
it's always called when we know the object is part of a slab.  That's
where the cachep pointer is deduced from.

