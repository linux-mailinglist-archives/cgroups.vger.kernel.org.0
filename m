Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB6211D7B
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2020 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGBHuI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jul 2020 03:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgGBHuI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 2 Jul 2020 03:50:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9EB20936;
        Thu,  2 Jul 2020 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593676207;
        bh=OPwzfImFs/6d/wxmTj/SDF/k3f/jGxD4d+RjrzyjUhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1tzmwO6bBgv8e1nwdoCor7eoYs88C56cCi+b1LCWxsslV3Obsc9H5N3DTD0s4kOVb
         nkn4R3y7DQPj5Agqp5PfpNJs4ca/7dhafI+z0F6Kcb9Mkvdl0vYkOTgV86DU6NajuG
         s2sQPFWem5d6mVKrB7CLIcoWue9AxNGe9AlfXe3E=
Date:   Thu, 2 Jul 2020 08:50:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, bhupesh.linux@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: Allocate crashkernel always in ZONE_DMA
Message-ID: <20200702075001.GA16113@willie-the-truck>
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
 <1593641660-13254-3-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593641660-13254-3-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 02, 2020 at 03:44:20AM +0530, Bhupesh Sharma wrote:
> commit bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in
> ZONE_DMA32") allocates crashkernel for arm64 in the ZONE_DMA32.
> 
> However as reported by Prabhakar, this breaks kdump kernel booting in
> ThunderX2 like arm64 systems. I have noticed this on another ampere
> arm64 machine. The OOM log in the kdump kernel looks like this:
> 
>   [    0.240552] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>   [    0.247713] swapper/0: page allocation failure: order:1, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   <..snip..>
>   [    0.274706] Call trace:
>   [    0.277170]  dump_backtrace+0x0/0x208
>   [    0.280863]  show_stack+0x1c/0x28
>   [    0.284207]  dump_stack+0xc4/0x10c
>   [    0.287638]  warn_alloc+0x104/0x170
>   [    0.291156]  __alloc_pages_slowpath.constprop.106+0xb08/0xb48
>   [    0.296958]  __alloc_pages_nodemask+0x2ac/0x2f8
>   [    0.301530]  alloc_page_interleave+0x20/0x90
>   [    0.305839]  alloc_pages_current+0xdc/0xf8
>   [    0.309972]  atomic_pool_expand+0x60/0x210
>   [    0.314108]  __dma_atomic_pool_init+0x50/0xa4
>   [    0.318504]  dma_atomic_pool_init+0xac/0x158
>   [    0.322813]  do_one_initcall+0x50/0x218
>   [    0.326684]  kernel_init_freeable+0x22c/0x2d0
>   [    0.331083]  kernel_init+0x18/0x110
>   [    0.334600]  ret_from_fork+0x10/0x18
> 
> This patch limits the crashkernel allocation to the first 1GB of
> the RAM accessible (ZONE_DMA), as otherwise we might run into OOM
> issues when crashkernel is executed, as it might have been originally
> allocated from either a ZONE_DMA32 memory or mixture of memory chunks
> belonging to both ZONE_DMA and ZONE_DMA32.

How does this interact with this ongoing series:

https://lore.kernel.org/r/20200628083458.40066-1-chenzhou10@huawei.com

(patch 4, in particular)

> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  arch/arm64/mm/init.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..02ae4d623802 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -91,8 +91,15 @@ static void __init reserve_crashkernel(void)
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	if (crash_base == 0) {
> -		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> +		/* Current arm64 boot protocol requires 2MB alignment.
> +		 * Also limit the crashkernel allocation to the first
> +		 * 1GB of the RAM accessible (ZONE_DMA), as otherwise we
> +		 * might run into OOM issues when crashkernel is executed,
> +		 * as it might have been originally allocated from
> +		 * either a ZONE_DMA32 memory or mixture of memory
> +		 * chunks belonging to both ZONE_DMA and ZONE_DMA32.
> +		 */

This comment needs help. Why does putting the crashkernel in ZONE_DMA
prevent "OOM issues"?

Will
