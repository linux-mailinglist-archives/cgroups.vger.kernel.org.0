Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55047C4F9
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbhLURZP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 12:25:15 -0500
Received: from foss.arm.com ([217.140.110.172]:56786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhLURZP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 Dec 2021 12:25:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EB4D6E;
        Tue, 21 Dec 2021 09:25:14 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27FF13F718;
        Tue, 21 Dec 2021 09:25:06 -0800 (PST)
Message-ID: <db0ba937-8785-a27b-afff-55c55456ae19@arm.com>
Date:   Tue, 21 Dec 2021 17:25:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-GB
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Lameter <cl@linux.com>,
        Will Deacon <will@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        patches@lists.linux.dev, Pekka Enberg <penberg@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        iommu@lists.linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-20 23:58, Vlastimil Babka wrote:
> On 12/16/21 16:00, Hyeonggon Yoo wrote:
>> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>>> On 12/1/21 19:14, Vlastimil Babka wrote:
>>>> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>>>> this cover letter.
>>>>
>>>> Series also available in git, based on 5.16-rc3:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>>>
>>> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>>> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>>
>> Reviewing the whole patch series takes longer than I thought.
>> I'll try to review and test rest of patches when I have time.
>>
>> I added Tested-by if kernel builds okay and kselftests
>> does not break the kernel on my machine.
>> (with CONFIG_SLAB/SLUB/SLOB depending on the patch),
> 
> Thanks!
> 
>> Let me know me if you know better way to test a patch.
> 
> Testing on your machine is just fine.
> 
>> # mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
>>
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> Comment:
>> Works on both SLUB_CPU_PARTIAL and !SLUB_CPU_PARTIAL.
>> btw, do we need slabs_cpu_partial attribute when we don't use
>> cpu partials? (!SLUB_CPU_PARTIAL)
> 
> The sysfs attribute? Yeah we should be consistent to userspace expecting to
> read it (even with zeroes), regardless of config.
> 
>> # mm/slub: Simplify struct slab slabs field definition
>> Comment:
>>
>> This is how struct page looks on the top of v3r3 branch:
>> struct page {
>> [...]
>>                  struct {        /* slab, slob and slub */
>>                          union {
>>                                  struct list_head slab_list;
>>                                  struct {        /* Partial pages */
>>                                          struct page *next;
>> #ifdef CONFIG_64BIT
>>                                          int pages;      /* Nr of pages left */
>> #else
>>                                          short int pages;
>> #endif
>>                                  };
>>                          };
>> [...]
>>
>> It's not consistent with struct slab.
> 
> Hm right. But as we don't actually use the struct page version anymore, and
> it's not one of the fields checked by SLAB_MATCH(), we can ignore this.
> 
>> I think this is because "mm: Remove slab from struct page" was dropped.
> 
> That was just postponed until iommu changes are in. Matthew mentioned those
> might be merged too, so that final cleanup will happen too and take care of
> the discrepancy above, so no need for extra churn to address it speficially.

FYI the IOMMU changes are now queued in linux-next, so if all goes well 
you might be able to sneak that final patch in too.

Robin.

> 
>> Would you update some of patches?
>>
>> # mm/sl*b: Differentiate struct slab fields by sl*b implementations
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Works SL[AUO]B on my machine and makes code much better.
>>
>> # mm/slob: Convert SLOB to use struct slab and struct folio
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> It still works fine on SLOB.
>>
>> # mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> # mm/slub: Convert __free_slab() to use struct slab
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>
>> Thanks,
>> Hyeonggon.
> 
> Thanks again,
> Vlastimil
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
