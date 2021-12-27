Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE247F9CB
	for <lists+cgroups@lfdr.de>; Mon, 27 Dec 2021 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhL0Cn0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Dec 2021 21:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhL0Cn0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Dec 2021 21:43:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04903C06173E
        for <cgroups@vger.kernel.org>; Sun, 26 Dec 2021 18:43:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p14so10508923plf.3
        for <cgroups@vger.kernel.org>; Sun, 26 Dec 2021 18:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbWmY9NIBHJbspqdt0/iFybWiUNO01ZpzPEk+bSzcIc=;
        b=b6Cjg8EDgami9tihXmahcFs5gZMUl0ofSM1Wj+YZ2Q6XRHsDdBRl90zeF1jbOOSz3+
         9SoQiZ4EdbCG+Jmg4MzA5/6shK8RZg8xrV2gqJVuZDyAYqtXwqlmry/aJAkQ4oiG8ngV
         7rpAaYsMSPY9gaW/AMeOV2RIDPlYhOIi7V3RAasnd56UnpIcH6qs4tNiIeLbz9RuGyMQ
         3rfi/aFyW60zG42gzOC8ll2ZU35Xujv3pg6CUtvkdcaI6VRRKTlNpdBWUeCpGeADhAXG
         JPgrgb5sX7zdu4h1uMAdv/6rtljcukOvJ4HPQR8PbQw3YwGslBNSSpCAuWszimU1l/o9
         DGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbWmY9NIBHJbspqdt0/iFybWiUNO01ZpzPEk+bSzcIc=;
        b=hTvqstJ/QBE+uHamqT0vd3+OiWJL7+mqD8p3E/fKmXeSfdHZqoFCwDntX2UphEyQcj
         gBtUsEjx8p28xk6UYw61eRttKIR87MXp3B0Xbj5///AP9NlNm43Yh7MQvzrdbIMMiaU5
         UEkbrFx2urP2i5cChImb6Ye48o+uFIGzq1ukNhnptSkKbBPNNoY32Ms0+eT/4Lz5/EfJ
         vCstTWDS05Fw4s8TDHzFFeBQr5/xawejvK/fdZ++w53ZoOUbKH5yrXfjhNq4+f55hIep
         vW5H/vgB/6ECKQB870tsU/EWGCWXUvO/nT6bCbXSf35OVPAZDVVLt664PyaJ2p3s+14L
         wM3A==
X-Gm-Message-State: AOAM532qFCmT9v68o90n49FHO1K4AwP3Cbo3pibfJiWDXoHBeJl/Tu8V
        /uljY79vTEnbTDywRCweHu4=
X-Google-Smtp-Source: ABdhPJzoUfrOYauzN001IpqeGAYX2bJEv5XyUjW2AwBsjkOMYSZ/zWgoYr+5IYLFDS8h7503Fgg4YQ==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr18709354pjb.70.1640573005467;
        Sun, 26 Dec 2021 18:43:25 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id s35sm9767113pfw.193.2021.12.26.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 18:43:25 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:43:15 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <YckoQ7tkLgFhJA7u@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <Ycdak5J48i7CGkHU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycdak5J48i7CGkHU@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 05:53:23PM +0000, Matthew Wilcox wrote:
> On Sat, Dec 25, 2021 at 09:16:55AM +0000, Hyeonggon Yoo wrote:
> > # mm: Convert struct page to struct slab in functions used by other subsystems
> > I'm not familiar with kasan, but to ask:
> > Does ____kasan_slab_free detect invalid free if someone frees
> > an object that is not allocated from slab?
> > 
> > @@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> > -       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> > +       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
> >             object)) {
> >                 kasan_report_invalid_free(tagged_object, ip);
> >                 return true;
> > 
> > I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
> > returns false. That will cause NULL pointer dereference in nearest_obj.
> > I don't think this change is intended.
> 
> You need to track down how this could happen.  As far as I can tell,
> it's always called when we know the object is part of a slab.  That's
> where the cachep pointer is deduced from.

Thank you Matthew, you are right. I read the code too narrowly.
when we call kasan hooks, we know that the object is allocated from
the slab cache. (through cache_from_obj)

I'll review that patch again in part 3!

Thanks,
Hyeonggon
