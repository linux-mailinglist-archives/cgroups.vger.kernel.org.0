Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5A47A325
	for <lists+cgroups@lfdr.de>; Mon, 20 Dec 2021 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhLTAr5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Dec 2021 19:47:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhLTAr4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Dec 2021 19:47:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BED61F395;
        Mon, 20 Dec 2021 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639961275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GljbjGESLyxg+ngLc7mhGY1oQBxex2sK+C5XSkEFVyI=;
        b=bXsxoOzcRRIip4e3u7ZMJHBHCqpqGoHvghX+Qod90rITqgkPX6WlwwmBkBzLIQgnPM3M7l
        siGEY6tKIftLy8gm6P7tCtEhJhPH5+N420SWQ7CGJk78g/87i2iR5inofquN9kpBkcJNuF
        Zi+LVig8LSExmO4XED1Ps1yp2oNnfR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639961275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GljbjGESLyxg+ngLc7mhGY1oQBxex2sK+C5XSkEFVyI=;
        b=d+lrN53wSmcr6AJTW2rR1oZX3qGUcCXsDSsgdtTCVT7nNW2HNB8UytrIeq4FK+FkuQdmV5
        dAxQM4ms+6JZ/yCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66B78133A7;
        Mon, 20 Dec 2021 00:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yFyaF7rSv2HcbQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Dec 2021 00:47:54 +0000
Message-ID: <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
Date:   Mon, 20 Dec 2021 01:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
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
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/21 00:38, Roman Gushchin wrote:
> Part 2:
> 
> * mm: Convert check_heap_object() to use struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert detached_freelist to use a struct slab
> How about to convert free_nonslab_page() to free_nonslab_folio()?
> And maybe rename it to something like free_large_kmalloc()?
> If I'm not missing something, large kmallocs is the only way how we can end up
> there with a !slab folio/page.

Good point, thanks! But did at as part of the following patch, where it fits
logically better.

> * mm/slub: Convert kfree() to use a struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>

Didn't add your tag because of the addition of free_large_kmalloc() change.

> * mm/slub: Convert __slab_lock() and __slab_unlock() to struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert print_page_info() to print_slab_info()
> Do we really need to explicitly convert slab_folio()'s result to (struct folio *)?

Unfortunately yes, as long as folio_flags() don't take const struct folio *,
which will need some yak shaving.

> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert alloc_slab_page() to return a struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert __free_slab() to use struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert pfmemalloc_match() to take a struct slab
> Cool! Removing pfmemalloc_unsafe() is really nice.
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert most struct page to struct slab by spatch
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Finish struct page to struct slab conversion
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks again!

> * mm/slab: Convert most struct page to struct slab by spatch
> 
> Another patch with the same title? Rebase error?
> 
> * mm/slab: Finish struct page to struct slab conversion
> 
> And this one too?
> 
> 
> Thanks!
> 
> Roman

