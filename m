Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5794663A1
	for <lists+cgroups@lfdr.de>; Thu,  2 Dec 2021 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhLBM3R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Dec 2021 07:29:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54524 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhLBM3Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Dec 2021 07:29:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D466212B9;
        Thu,  2 Dec 2021 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638447953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrIx4FxLZ15vBR8OhFRI6NkqolHxOQGKVsTXFgnLCBo=;
        b=qAgWGsgshMrO9UnM/+8sSOlYxRa0x1O8XpA8dUD5ZVMGONmJ2RDBkHY6oZHOP/CefUeY2W
        954cBjvCgf3iQ9Fpxo98OPqTwDxSGd46MsfoJM6vU7BOrlGazX/vEuwUWnOFoWTd6XuzaD
        w7H0llUJOCCbq91x7aGxd7WUo+DNpdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638447953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrIx4FxLZ15vBR8OhFRI6NkqolHxOQGKVsTXFgnLCBo=;
        b=ygy8WyNyvVScvOltk0InA2SrhTOtpUcVIav8ZI0IWbEjHGA8DLYGwOXkFQskM4PuCmxvLa
        OJFR6QAwsLLfnrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2F1313D73;
        Thu,  2 Dec 2021 12:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RdqfLlC7qGEUIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 02 Dec 2021 12:25:52 +0000
Message-ID: <3fb4f879-c48b-7f74-c7bd-59ca16c5fe8d@suse.cz>
Date:   Thu, 2 Dec 2021 13:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
        Robin Murphy <robin.murphy@arm.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
In-Reply-To: <20211201181510.18784-1-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/1/21 19:14, Vlastimil Babka wrote:
> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> this cover letter.
> 
> Series also available in git, based on 5.16-rc3:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2

I have pushed a v3, but not going to resent immediately to avoid unnecessary
spamming, the differences is just that some patches are removed and other
reordered, so the current v2 posting should be still sufficient for on-list
review:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v3r1

patch 29/33 iommu: Use put_pages_list
- removed as this version is broken and Robin Murphy has meanwhile
incorporated it partially to his series:
https://lore.kernel.org/lkml/cover.1637671820.git.robin.murphy@arm.com/

patch 30/33 mm: Remove slab from struct page
- removed and postponed for later as this can be only be applied after the
iommu use of page.freelist is resolved

patch 27/33 zsmalloc: Stop using slab fields in struct page
patch 28/33 bootmem: Use page->index instead of page->freelist
- moved towards the end of series, to further separate the part that adjusts
non-slab users of slab fields towards removing those fields from struct page.
