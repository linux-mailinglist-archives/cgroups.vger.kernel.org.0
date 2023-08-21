Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E00782CAF
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHUOwJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjHUOwC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84DE7;
        Mon, 21 Aug 2023 07:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEBBE62A8B;
        Mon, 21 Aug 2023 14:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8935C433C8;
        Mon, 21 Aug 2023 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629520;
        bh=o7TMneqKMD7yd3mxtbwuDOYsNFG2NCLJL2n2vsDbDak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M99vuKPwGvKRrYNdVSJYyDlnJ2w+2bMfB7rIbbb0zMav+2u04juf4V+a2CsgqzNDo
         zY6p3etAWgX2q0/22uvpOXZ/Wzv2xTeEA24KwFEji65i1wZTlYystv6gRAw4+2MQyU
         oaEd6VKB8db0tJ0jyQCgDFMURy4ykFZ8qlFZzqlpCL3m5/CT0XKkZ//9TDuKHgVv1B
         1bj5jxEglUDzU7LJyjnLgzdtFv9TCTgkDman9YPVSVaDL/+xpgTfKLthde6DWuRUfj
         mL5fOqnuU3mR99U8NW/yi1PUgJ+e9n5c7OFWa20Kvwh1o+Ql5Jeha1cJb0MI9W7Aaa
         CYGgkZ4MlB+0Q==
Date:   Mon, 21 Aug 2023 17:51:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: Fix kernel-doc warning from tlb_flush_rmaps()
Message-ID: <20230821145134.GB9849@kernel.org>
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818200630.2719595-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 18, 2023 at 09:06:27PM +0100, Matthew Wilcox (Oracle) wrote:
> The vma parameter wasn't described.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.40.1
> 

-- 
Sincerely yours,
Mike.
