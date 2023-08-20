Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62970782035
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 23:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjHTVaF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjHTV3w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 17:29:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D39E6E;
        Sat, 19 Aug 2023 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=c94fHYxIWl9lBifgcspinxKU2QHJURmIgDdd+1otOjo=; b=GDPo+eqAkD2WDQPmJ2y2konEcv
        fp4a5Zv29YS4L903aE7mPxLttTS8765T5saJnuvJPvyLla6eC4H2k15yRLsZk3R7Ki3u/Lvn+Z6zE
        TGWQQ/eEvCNmfI5O51mNrdR+vrat/83NmlbCiG0Fm+d+ri9Km+r67lVW3RYuVeaYKW7ngGHR5K5Si
        zK6NheDXhSjOVaSmWrHbtKSoO6sXELTTK5D77Co26QjB5BuNUzGZ8UtJO7lZS2QwY/IwZQuYup6w+
        GTVhZEM9xaKiFQzvO2CwBclmBFzETmmMymycokOU0UkC254WwvrdvT3PfUFGAUDDFCZPe1AlAbuNf
        YcJfsVmw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qXWfl-00BHp7-1H;
        Sun, 20 Aug 2023 00:52:05 +0000
Message-ID: <df2ec434-69cd-fe3b-50de-462a9c7eda41@infradead.org>
Date:   Sat, 19 Aug 2023 17:52:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] mm: Fix get_mctgt_type() kernel-doc
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
References: <20230818200630.2719595-1-willy@infradead.org>
 <20230818200630.2719595-3-willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230818200630.2719595-3-willy@infradead.org>
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
> Convert the return values to an ReST list and tidy up the wording while
> I'm touching it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

I would s/got/taken/.

> + * * MC_TARGET_SWAP - If the swap entry corresponding to this pte is a
> + *   target for charge migration. if @target is not NULL, the entry is stored

s/if/If/

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

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
