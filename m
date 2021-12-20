Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548747B657
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhLTX6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 18:58:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38560 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhLTX6R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 18:58:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9C5D1F3B4;
        Mon, 20 Dec 2021 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640044695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJEE0BI+qmu1Y2XQPzW4LyX87NylVjyFwU3a62yJMoM=;
        b=wJXxRniAryvtExwgE9oymzn2Fa+5ZF0CYgPiteubNJHY+MADFnIidh13cVDvzvhXwpwolX
        FhhJAY1kWsxf0TZ6UC1tXKB8DjkFqHP8d8PYYxMXv/Vwc8jdNnYUlQcxCD96S/mn6YMoPN
        Ahvvc6+YeJG+4OUNMaNkVg3zzJ5KNpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640044695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJEE0BI+qmu1Y2XQPzW4LyX87NylVjyFwU3a62yJMoM=;
        b=J6OX02taWYPyGUcQXMthSq6c0YbIRbJKFXTo2zhLxG/xZx+d5n7EYwmO2bYwthPVUxnFPr
        Jn2VvHjpbKV6s+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 469C213BCC;
        Mon, 20 Dec 2021 23:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C/mKEJcYwWFkfAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Dec 2021 23:58:15 +0000
Message-ID: <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
Date:   Tue, 21 Dec 2021 00:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
In-Reply-To: <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/21 16:00, Hyeonggon Yoo wrote:
> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>> On 12/1/21 19:14, Vlastimil Babka wrote:
>> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> > this cover letter.
>> > 
>> > Series also available in git, based on 5.16-rc3:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> 
>> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 
> Reviewing the whole patch series takes longer than I thought.
> I'll try to review and test rest of patches when I have time.
> 
> I added Tested-by if kernel builds okay and kselftests
> does not break the kernel on my machine.
> (with CONFIG_SLAB/SLUB/SLOB depending on the patch),

Thanks!

> Let me know me if you know better way to test a patch.

Testing on your machine is just fine.

> # mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
> 
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Comment:
> Works on both SLUB_CPU_PARTIAL and !SLUB_CPU_PARTIAL.
> btw, do we need slabs_cpu_partial attribute when we don't use
> cpu partials? (!SLUB_CPU_PARTIAL)

The sysfs attribute? Yeah we should be consistent to userspace expecting to
read it (even with zeroes), regardless of config.

> # mm/slub: Simplify struct slab slabs field definition
> Comment:
> 
> This is how struct page looks on the top of v3r3 branch:
> struct page {
> [...]
>                 struct {        /* slab, slob and slub */
>                         union {
>                                 struct list_head slab_list;
>                                 struct {        /* Partial pages */
>                                         struct page *next;
> #ifdef CONFIG_64BIT
>                                         int pages;      /* Nr of pages left */
> #else
>                                         short int pages;
> #endif
>                                 };
>                         };
> [...]
> 
> It's not consistent with struct slab.

Hm right. But as we don't actually use the struct page version anymore, and
it's not one of the fields checked by SLAB_MATCH(), we can ignore this.

> I think this is because "mm: Remove slab from struct page" was dropped.

That was just postponed until iommu changes are in. Matthew mentioned those
might be merged too, so that final cleanup will happen too and take care of
the discrepancy above, so no need for extra churn to address it speficially.

> Would you update some of patches?
> 
> # mm/sl*b: Differentiate struct slab fields by sl*b implementations
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Works SL[AUO]B on my machine and makes code much better.
> 
> # mm/slob: Convert SLOB to use struct slab and struct folio
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> It still works fine on SLOB.
> 
> # mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> # mm/slub: Convert __free_slab() to use struct slab
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Thanks,
> Hyeonggon.

Thanks again,
Vlastimil
