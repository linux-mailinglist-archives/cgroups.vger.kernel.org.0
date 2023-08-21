Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E02782CC8
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjHUO4R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHUO4Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F688E2;
        Mon, 21 Aug 2023 07:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DEF6137C;
        Mon, 21 Aug 2023 14:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5023C433C7;
        Mon, 21 Aug 2023 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629774;
        bh=JzR+Jr/LbLcg3R+8alMuMPEoX/4+6Yrco6xCCTNqmmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6PRd1kpuLk4oe04CIlvYkbQxfyIIYRNqOxLmMc04/9+2rjj6g6Ut6iZXGnB5Ldva
         v78sy92rfrpcA9dkV2fWwK5KAxV63wElUa1P0Kz0SrgZ+C6WLBADa9pHaMiWpzUjeP
         pDXYif0syTetoV2/u3tD8eHuoHSSF3puadWCBKN5fCxji6kkL+FwQK2d7WRKj3Pzpl
         XmjCoW66X28u7nHPxmdleBUquaXrn/OPV3d4YcEYIKUYKRD6tO/vOKVN0YopTn9mSS
         q0HT2omqz5fVrqL+HOfrcvit2vpzIfJDMcJyWlW+Oii9WwU4w9pvdaLBeFZgvxadqr
         5eExUI6OVyqHQ==
Date:   Mon, 21 Aug 2023 17:55:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: Add orphaned kernel-doc to the rst files.
Message-ID: <20230821145548.GE9849@kernel.org>
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818200630.2719595-5-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 18, 2023 at 09:06:30PM +0100, Matthew Wilcox (Oracle) wrote:
> There are many files in mm/ that contain kernel-doc which is not
> currently published on kernel.org.  Some of it is easily categorisable,
> but most of it is going into the miscellaneous documentation section to
> be organised later.
> 
> Some files aren't ready to be included; they contain documentation with
> build errors.  Or they're nommu.c which duplicates documentation from
> "real" MMU systems.  Those files are noted with a # mark (although really
> anything which isn't a recognised directive would do to prevent inclusion)
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  Documentation/core-api/mm-api.rst | 25 +++++++++++++++++++++++++
>  Documentation/mm/highmem.rst      |  1 +
>  Documentation/mm/zsmalloc.rst     |  5 +++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
> index f5dde5bceaea..2d091c873d1e 100644
> --- a/Documentation/core-api/mm-api.rst
> +++ b/Documentation/core-api/mm-api.rst
> @@ -115,3 +115,28 @@ More Memory Management Functions
>  .. kernel-doc:: include/linux/mmzone.h
>  .. kernel-doc:: mm/util.c
>     :functions: folio_mapping
> +
> +.. kernel-doc:: mm/rmap.c
> +.. kernel-doc:: mm/migrate.c
> +.. kernel-doc:: mm/mmap.c
> +.. kernel-doc:: mm/kmemleak.c
> +.. #kernel-doc:: mm/hmm.c (build warnings)
> +.. kernel-doc:: mm/memremap.c
> +.. kernel-doc:: mm/hugetlb.c
> +.. kernel-doc:: mm/swap.c
> +.. kernel-doc:: mm/zpool.c
> +.. kernel-doc:: mm/memcontrol.c
> +.. #kernel-doc:: mm/memory-tiers.c (build warnings)
> +.. kernel-doc:: mm/shmem.c
> +.. kernel-doc:: mm/migrate_device.c
> +.. #kernel-doc:: mm/nommu.c (duplicates kernel-doc from other files)
> +.. kernel-doc:: mm/mapping_dirty_helpers.c
> +.. #kernel-doc:: mm/memory-failure.c (build warnings)
> +.. kernel-doc:: mm/percpu.c
> +.. kernel-doc:: mm/maccess.c
> +.. kernel-doc:: mm/vmscan.c
> +.. kernel-doc:: mm/memory_hotplug.c
> +.. kernel-doc:: mm/mmu_notifier.c
> +.. kernel-doc:: mm/balloon_compaction.c
> +.. kernel-doc:: mm/huge_memory.c
> +.. kernel-doc:: mm/io-mapping.c
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index fe68e02fc8ff..9d92e3f2b3d6 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -209,4 +209,5 @@ Functions
>  =========
>  
>  .. kernel-doc:: include/linux/highmem.h
> +.. kernel-doc:: mm/highmem.c
>  .. kernel-doc:: include/linux/highmem-internal.h
> diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> index a3c26d587752..76902835e68e 100644
> --- a/Documentation/mm/zsmalloc.rst
> +++ b/Documentation/mm/zsmalloc.rst
> @@ -263,3 +263,8 @@ is heavy internal fragmentation and zspool compaction is unable to relocate
>  objects and release zspages. In these cases, it is recommended to decrease
>  the limit on the size of the zspage chains (as specified by the
>  CONFIG_ZSMALLOC_CHAIN_SIZE option).
> +
> +Functions
> +=========
> +
> +.. kernel-doc:: mm/zsmalloc.c
> -- 
> 2.40.1
> 

-- 
Sincerely yours,
Mike.
