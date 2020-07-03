Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBC21337C
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 07:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCFYW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 01:24:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCFYW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 3 Jul 2020 01:24:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 73172D5073F92DED88B3;
        Fri,  3 Jul 2020 13:24:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Jul 2020
 13:24:16 +0800
Subject: Re: [PATCH 2/2] arm64: Allocate crashkernel always in ZONE_DMA
To:     Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will@kernel.org>
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
 <1593641660-13254-3-git-send-email-bhsharma@redhat.com>
 <20200702075001.GA16113@willie-the-truck>
 <CACi5LpPn4QUjC692G=5UxLchpi+ZL+xFCcxqLbFvgvvcso28ww@mail.gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <eeea529a-14cd-3e2f-7a1c-c4c940967749@huawei.com>
Date:   Fri, 3 Jul 2020 13:24:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CACi5LpPn4QUjC692G=5UxLchpi+ZL+xFCcxqLbFvgvvcso28ww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Bhupesh,


On 2020/7/3 3:22, Bhupesh Sharma wrote:
> Hi Will,
>
> On Thu, Jul 2, 2020 at 1:20 PM Will Deacon <will@kernel.org> wrote:
>> On Thu, Jul 02, 2020 at 03:44:20AM +0530, Bhupesh Sharma wrote:
>>> commit bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in
>>> ZONE_DMA32") allocates crashkernel for arm64 in the ZONE_DMA32.
>>>
>>> However as reported by Prabhakar, this breaks kdump kernel booting in
>>> ThunderX2 like arm64 systems. I have noticed this on another ampere
>>> arm64 machine. The OOM log in the kdump kernel looks like this:
>>>
>>>   [    0.240552] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>>>   [    0.247713] swapper/0: page allocation failure: order:1, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>>>   <..snip..>
>>>   [    0.274706] Call trace:
>>>   [    0.277170]  dump_backtrace+0x0/0x208
>>>   [    0.280863]  show_stack+0x1c/0x28
>>>   [    0.284207]  dump_stack+0xc4/0x10c
>>>   [    0.287638]  warn_alloc+0x104/0x170
>>>   [    0.291156]  __alloc_pages_slowpath.constprop.106+0xb08/0xb48
>>>   [    0.296958]  __alloc_pages_nodemask+0x2ac/0x2f8
>>>   [    0.301530]  alloc_page_interleave+0x20/0x90
>>>   [    0.305839]  alloc_pages_current+0xdc/0xf8
>>>   [    0.309972]  atomic_pool_expand+0x60/0x210
>>>   [    0.314108]  __dma_atomic_pool_init+0x50/0xa4
>>>   [    0.318504]  dma_atomic_pool_init+0xac/0x158
>>>   [    0.322813]  do_one_initcall+0x50/0x218
>>>   [    0.326684]  kernel_init_freeable+0x22c/0x2d0
>>>   [    0.331083]  kernel_init+0x18/0x110
>>>   [    0.334600]  ret_from_fork+0x10/0x18
>>>
>>> This patch limits the crashkernel allocation to the first 1GB of
>>> the RAM accessible (ZONE_DMA), as otherwise we might run into OOM
>>> issues when crashkernel is executed, as it might have been originally
>>> allocated from either a ZONE_DMA32 memory or mixture of memory chunks
>>> belonging to both ZONE_DMA and ZONE_DMA32.
>> How does this interact with this ongoing series:
>>
>> https://lore.kernel.org/r/20200628083458.40066-1-chenzhou10@huawei.com
>>
>> (patch 4, in particular)
> Many thanks for having a look at this patchset. I was not aware that
> Chen had sent out a new version.
> I had noted in the v9 review of the high/low range allocation
> <https://lists.gt.net/linux/kernel/3726052#3726052> that I was working
> on a generic solution (irrespective of the crashkernel, low and high
> range allocation) which resulted in this patchset.
>
> The issue is two-fold: OOPs in memcfg layer (PATCH 1/2, which has been
> Acked-by memcfg maintainer) and OOM in the kdump kernel due to
> crashkernel allocation in ZONE_DMA32 regions(s) which is addressed by
> this PATCH.
>
> I will have a closer look at the v10 patchset Chen shared, but seems
> it needs some rework as per Dave's review comments which he shared
> today.
> IMO, in the meanwhile this patchset  can be used to fix the existing
> kdump issue with upstream kernel.
Thanks for your work.
There is no progress on the issue for long time, so i sent my solution in v8 comments
and sent v9 recently.

I think direct limiting the crashkernel in ZONE_DMA isn't a good idea:
1. For parameter "crashkernel=Y", reserving crashkernel in first 1G memory will increase
the probability of memory allocation failure.
Previous discuss from https://lkml.org/lkml/2019/10/21/725:
    "With ZONE_DMA=y, this config will fail to reserve 512M CMA on a server"

2. For parameter "crashkernel=Y@X", limiting the crashkernel in ZONE_DMA is unreasonable
for someone really want to reserve crashkernel from specified start address.

I have sent v10: https://www.spinics.net/lists/arm-kernel/msg819408.html, any commets are welcome.

Thanks,
Chen Zhou
>
>>> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: cgroups@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: kexec@lists.infradead.org
>>> Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>>  arch/arm64/mm/init.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 1e93cfc7c47a..02ae4d623802 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -91,8 +91,15 @@ static void __init reserve_crashkernel(void)
>>>       crash_size = PAGE_ALIGN(crash_size);
>>>
>>>       if (crash_base == 0) {
>>> -             /* Current arm64 boot protocol requires 2MB alignment */
>>> -             crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
>>> +             /* Current arm64 boot protocol requires 2MB alignment.
>>> +              * Also limit the crashkernel allocation to the first
>>> +              * 1GB of the RAM accessible (ZONE_DMA), as otherwise we
>>> +              * might run into OOM issues when crashkernel is executed,
>>> +              * as it might have been originally allocated from
>>> +              * either a ZONE_DMA32 memory or mixture of memory
>>> +              * chunks belonging to both ZONE_DMA and ZONE_DMA32.
>>> +              */
>> This comment needs help. Why does putting the crashkernel in ZONE_DMA
>> prevent "OOM issues"?
> Sure, I can work on adding more details in the comment so that it
> explains the potential OOM issue(s) better.
>
> Thanks,
> Bhupesh
>
>
> .
>


