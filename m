Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14F7546A7
	for <lists+cgroups@lfdr.de>; Sat, 15 Jul 2023 05:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGOD5A (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 23:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGOD47 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 23:56:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834FB358C;
        Fri, 14 Jul 2023 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JCic63O1M6aYkUCxDH6pVswG6w/uXP8H7kVHZUpcD8Y=; b=rn/Rdd3d6xOw3B1ImjQ+HapFxr
        lt/TX5UX1qrW2XM1iHrPMCdLTGZiv1Y8rUHM5NGu2fyDwDJSQ2oFuCoQCaXZPnyXc4nW5sQzNoo9d
        8jZhwNO2CjnUqJzITZFx98Dp0IT6mvhZgCt9pfBx2pBQJU7r4mq9OQaX7VcnJWPKbULpDhiv/TfrB
        qNI6qO4/TPK9QX6y2l3+1J/zQ+dKAvFw/vfI2i0g9bmbHXf6wh4o+pHljfujxg+0bWL8ksL8QrxV4
        4d4/PuiFQFfjvwHnFoKfIUZzCmvP32VBUiqLAoHvS9B7ok7T6oSeyqkzkJ4gtjRK8Mh4ERDPuVvSW
        qR2ycr3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWOf-001nqR-9h; Sat, 15 Jul 2023 03:56:41 +0000
Date:   Sat, 15 Jul 2023 04:56:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: use get_page() for device private pages in
 mc_handle_swap_pte()
Message-ID: <ZLIY+ZwrLvpapGE6@casper.infradead.org>
References: <20230715032802.2508163-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715032802.2508163-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 15, 2023 at 11:28:02AM +0800, Miaohe Lin wrote:
> When page table locked is held, the page can't be freed from under us.

But the page isn't mapped into the page table ... there's a swap entry
in the page table, so I don't think your logic holds.

> So use get_page() to get the extra page reference to simplify the code.
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 93e3cc581b51..4ca382efb1ca 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5670,8 +5670,9 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
>  	 */
>  	if (is_device_private_entry(ent)) {
>  		page = pfn_swap_entry_to_page(ent);
> -		if (!get_page_unless_zero(page))
> -			return NULL;
> +		/* Get a page reference while we know the page can't be freed. */
> +		get_page(page);
> +
>  		return page;
>  	}
>  
> -- 
> 2.33.0
> 
> 
