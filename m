Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB5782CBF
	for <lists+cgroups@lfdr.de>; Mon, 21 Aug 2023 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjHUOyU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjHUOyU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 10:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83395E2;
        Mon, 21 Aug 2023 07:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1944363A62;
        Mon, 21 Aug 2023 14:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB6C433C9;
        Mon, 21 Aug 2023 14:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692629657;
        bh=XXk4gJYl5yxoJ2sva9Ggeq+caYpVLV0EPr+AedA8LNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ry1vjrSYbat+DrNaJTNdYxqc8kp0Ft1J4x7PVUSo2JrI6QgKZWkP3Ga0jbriyqqj/
         ieBXSM6HA3xGieSNUdpnwgpiw78B74VfiwlIZcyQORI3rUehrKT2Sxy3pddASr5KuB
         wLtXaflvI4LtbYj2u4clQ6cDuPjuEJLiChTB/jFsJn81EWzOQq2rQjAHXiJR/jgVLd
         +m9ftFi7qiCVOigKLZwNxlQqqw234ZOTtLFLMPqfubSOvOEMp1SBXJYYjOwN8UWg95
         2iTqDRZ5wK0HhJxT1iUoQJ6aKT+ROaIN6bicw/ET7yz3cqWgKKzq5EOxXf6c26/Fcw
         fJqXaGSlzkaLw==
Date:   Mon, 21 Aug 2023 17:53:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: Fix get_mctgt_type() kernel-doc
Message-ID: <20230821145352.GC9849@kernel.org>
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818200630.2719595-3-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 18, 2023 at 09:06:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert the return values to an ReST list and tidy up the wording while
> I'm touching it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memcontrol.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e041ba827e59..cd8b3ae6b8d9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5850,25 +5850,20 @@ static int mem_cgroup_move_account(struct page *page,
>   * @ptent: the pte to be checked
>   * @target: the pointer the target page or swap ent will be stored(can be NULL)
>   *
> - * Returns
> - *   0(MC_TARGET_NONE): if the pte is not a target for move charge.
> - *   1(MC_TARGET_PAGE): if the page corresponding to this pte is a target for
> - *     move charge. if @target is not NULL, the page is stored in target->page
> - *     with extra refcnt got(Callers should handle it).
> - *   2(MC_TARGET_SWAP): if the swap entry corresponding to this pte is a
> - *     target for charge migration. if @target is not NULL, the entry is stored
> - *     in target->ent.
> - *   3(MC_TARGET_DEVICE): like MC_TARGET_PAGE  but page is device memory and
> - *   thus not on the lru.
> - *     For now we such page is charge like a regular page would be as for all
> - *     intent and purposes it is just special memory taking the place of a
> - *     regular page.
> - *
> - *     See Documentations/vm/hmm.txt and include/linux/hmm.h
> - *
> - * Called with pte lock held.
> + * Context: Called with pte lock held.
> + * Return:
> + * * MC_TARGET_NONE - If the pte is not a target for move charge.
> + * * MC_TARGET_PAGE - If the page corresponding to this pte is a target for
> + *   move charge. If @target is not NULL, the page is stored in target->page
> + *   with extra refcnt got (Callers should handle it).
> + * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
> + *   target for charge migration. if @target is not NULL, the entry is stored
> + *   in target->ent.
> + * * MC_TARGET_DEVICE - Like MC_TARGET_PAGE but page is device memory and
> + *   thus not on the lru.  For now such page is charged like a regular page
> + *   would be as it is just special memory taking the place of a regular page.
> + *   See Documentations/vm/hmm.txt and include/linux/hmm.h
>   */
> -
>  static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t ptent, union mc_target *target)
>  {
> -- 
> 2.40.1
> 

-- 
Sincerely yours,
Mike.
