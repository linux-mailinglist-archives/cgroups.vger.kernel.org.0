Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B0782033
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 23:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHTVaF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjHTV3v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 17:29:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF2E5E;
        Sat, 19 Aug 2023 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=z6tDJX3iE9WkH16DGbZfC/qfqDY64xLkrMSU2jg2cjI=; b=MN5+pzncrWpz6PLPg4sKOAsFqm
        C3lwrWECiZUOvaPW819HaqQiJzMesSNHsLHNb1xijoV8EgZ8TS8eBN7bLaTrbHD7OyykpU6Z7/2x+
        zUnytDizw77mSs5cUqlDmeE0DFbHDCfgQxXGB7XCUAWPYabT8eRsovW6fRBi2C5Wi6uypuvh/OwGJ
        Ii6kplUNzf6uALPy8Um5g4uP49tmtAXN7bufd0iSK+CNT1DfsFN/qV/H2eHbFmMtn4CHrSJFksLXV
        koqWx+NdEilYR3dLgK0Z4/CMeZ+9/tmLTSPQLogyOgh3+Y8LZgcDklViNPYgkagDZ8k/Ix+hGMWU1
        4hdiTZFA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qXWfV-00BHoH-2i;
        Sun, 20 Aug 2023 00:51:49 +0000
Message-ID: <c9f237da-011c-00fa-77e4-f92141b2d573@infradead.org>
Date:   Sat, 19 Aug 2023 17:51:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/4] mm: Fix kernel-doc warning from tlb_flush_rmaps()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-2-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20230818200630.2719595-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 8/18/23 13:06, Matthew Wilcox (Oracle) wrote:
> The vma parameter wasn't described.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  mm/mmu_gather.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index ea9683e12936..4f559f4ddd21 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -63,6 +63,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
>  /**
>   * tlb_flush_rmaps - do pending rmap removals after we have flushed the TLB
>   * @tlb: the current mmu_gather
> + * @vma: The memory area from which the pages are being removed.
>   *
>   * Note that because of how tlb_next_batch() above works, we will
>   * never start multiple new batches with pending delayed rmaps, so

-- 
~Randy
