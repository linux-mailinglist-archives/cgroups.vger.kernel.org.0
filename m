Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4F782CC3
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjHUOzC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjHUOzB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37618E2;
        Mon, 21 Aug 2023 07:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84276398F;
        Mon, 21 Aug 2023 14:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5DC433C7;
        Mon, 21 Aug 2023 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629699;
        bh=48bXFABCG3RekOXEork4KjEus4UPEb02K4FMMIA6aIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw3R69kcL91pV8PMKSoZRXOEtIj7oHZ39cPwDwsQVsiK/fRZKt37Mza2ihKYPDvhz
         KU2WO32msinRqUGwu2iPSRZNx0BPXQpNwSEY0ilytvnKrH6h8MMkqh9dzAFnK079ig
         c5toYLnPdDGJJsdRy2pQTROxMNrxSN+xVUHKZBESQbC24/ZbnKsAkKdSBW/u+4GNtO
         r6NlJzZI5Oq4eDY4a3xNMViUbEGDo11RNo27j3nUcasVlwPr1II0Ctss4iHhRc2Z23
         lBB/R2A5poZz2xF+AjO9c7ygNDG+IZlVe7oyNRxaSjRILKcl+L9l7t3xOO32N819Rb
         9HUcYiYdUWHUw==
Date:   Mon, 21 Aug 2023 17:54:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: Fix clean_record_shared_mapping_range kernel-doc
Message-ID: <20230821145434.GD9849@kernel.org>
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818200630.2719595-4-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 18, 2023 at 09:06:29PM +0100, Matthew Wilcox (Oracle) wrote:
> Turn the a), b) into an unordered ReST list and remove the unnecessary
> 'Note:' prefix.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mapping_dirty_helpers.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index a26dd8bcfcdb..2f8829b3541a 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -288,13 +288,14 @@ EXPORT_SYMBOL_GPL(wp_shared_mapping_range);
>   * @end: Pointer to the number of the last set bit in @bitmap.
>   * none set. The value is modified as new bits are set by the function.
>   *
> - * Note: When this function returns there is no guarantee that a CPU has
> + * When this function returns there is no guarantee that a CPU has
>   * not already dirtied new ptes. However it will not clean any ptes not
>   * reported in the bitmap. The guarantees are as follows:
> - * a) All ptes dirty when the function starts executing will end up recorded
> - *    in the bitmap.
> - * b) All ptes dirtied after that will either remain dirty, be recorded in the
> - *    bitmap or both.
> + *
> + * * All ptes dirty when the function starts executing will end up recorded
> + *   in the bitmap.
> + * * All ptes dirtied after that will either remain dirty, be recorded in the
> + *   bitmap or both.
>   *
>   * If a caller needs to make sure all dirty ptes are picked up and none
>   * additional are added, it first needs to write-protect the address-space
> -- 
> 2.40.1
> 

-- 
Sincerely yours,
Mike.
