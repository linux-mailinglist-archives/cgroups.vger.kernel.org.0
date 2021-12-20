Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B358E47A352
	for <lists+cgroups@lfdr.de>; Mon, 20 Dec 2021 02:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhLTBmw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Dec 2021 20:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLTBmv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Dec 2021 20:42:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3776C061574
        for <cgroups@vger.kernel.org>; Sun, 19 Dec 2021 17:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k7fHWgKrjS6NSIvn5a4Jtgxmp/WhT9Wz1heA+PvFHEU=; b=fbUn3fvK/C4lIcfXkF1dhfDZp+
        0ZelBeFgnQYcFnt0EOTirvxdbva/ddh2SL+FntgltRD3RE987l95C52xyYhhRfbE2xb17KwOfKlFs
        5hOrS2+3DKFsP3AzTTFXGdtnAfDlAGiCbxuyVX733jeZZ+d0DD58EAaIyKmbheLpfRjDtShOeT6am
        hg7mxrzy3tJ/5EM0XQThsZ+qE0Zv7Dl2ydMZ44Ueicge/g2XjDjlE+5Q0yijLnkgOFaSa51eA1ivu
        3KHkjCK1aKheaU9DVEJ4MCzqGgtQ+Ndgh2oKwtYQK2wpphRgppBrz+kxZNRgm1Zd6KP6yXdmRMLqn
        IlqHXmWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz7gr-001BXA-DH; Mon, 20 Dec 2021 01:42:13 +0000
Date:   Mon, 20 Dec 2021 01:42:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
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
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Yb/fdYbLunsVYRqQ@casper.infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
 <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 20, 2021 at 01:47:54AM +0100, Vlastimil Babka wrote:
> > * mm/slub: Convert print_page_info() to print_slab_info()
> > Do we really need to explicitly convert slab_folio()'s result to (struct folio *)?
> 
> Unfortunately yes, as long as folio_flags() don't take const struct folio *,
> which will need some yak shaving.

In case anyone's interested ...

folio_flags calls VM_BUG_ON_PGFLAGS() which would need its second
argument to be const.

That means dump_page() needs to take a const struct page, which
means __dump_page() needs its argument to be const.

That calls ...

is_migrate_cma_page()
page_mapping()
page_mapcount()
page_ref_count()
page_to_pgoff()
page_to_pfn()
hpage_pincount_available()
head_compound_mapcount()
head_compound_pincount()
compound_order()
PageKsm()
PageAnon()
PageCompound()

... and at that point, I ran out of motivation to track down some parts
of this tarbaby that could be fixed.  I did do:

    mm: constify page_count and page_ref_count
    mm: constify get_pfnblock_flags_mask and get_pfnblock_migratetype
    mm: make compound_head const-preserving
    mm/page_owner: constify dump_page_owner

so some of those are already done.  But a lot of them just need to be
done at the same time.  For example, page_mapping() calls
folio_mapping() which calls folio_test_slab() which calls folio_flags(),
so dump_page() and page_mapping() need to be done at the same time.

One bit that could be broken off easily (I think ...) is PageTransTail()
PageTail(), PageCompound(), PageHuge(), page_to_pgoff() and
page_to_index().  One wrinkle is needed a temporary
TESTPAGEFLAGS_FALSE_CONST.  But I haven't tried it yet.

