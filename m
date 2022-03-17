Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFBB4DC549
	for <lists+cgroups@lfdr.de>; Thu, 17 Mar 2022 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiCQMAY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Mar 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiCQMAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Mar 2022 08:00:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87093176D13
        for <cgroups@vger.kernel.org>; Thu, 17 Mar 2022 04:58:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 31AA91F38D;
        Thu, 17 Mar 2022 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647518330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wChL9XS63MYTCqGru1PZgU6kXfV3LAvy/qvsXt5I990=;
        b=h3+TM1ZrSfGxCkXKnqPsDUbK+eHEVAXknuif+p/x7hAdQHZFNK1NeAZO4y21h3OblEiA9R
        OqYeRMTMbn+OoLUt2baZDoi4ptha3Yma20C64NsqA0ksLVxffDpaNs1UsQwQNeOMV1jFk+
        q05bG4BaY7leR0xAACBdJcsddQyxbMk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3879A3BBE;
        Thu, 17 Mar 2022 11:58:49 +0000 (UTC)
Date:   Thu, 17 Mar 2022 12:58:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] memcg: Convert mc_target.page to mc_target.folio
Message-ID: <YjMidqgZbieEyBuF@dhcp22.suse.cz>
References: <YjJJIrENYb1qFHzl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjJJIrENYb1qFHzl@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 16-03-22 20:31:30, Matthew Wilcox wrote:
> This is a fairly mechanical change to convert mc_target.page to
> mc_target.folio.  This is a prerequisite for converting
> find_get_incore_page() to find_get_incore_folio().  But I'm not
> convinced it's right, and I'm not convinced the existing code is
> quite right either.
> 
> In particular, the code in hunk @@ -6036,28 +6041,26 @@ needs
> careful review.  There are also assumptions in here that a memory
> allocation is never larger than a PMD, which is true today, but I've
> been asked about larger allocations.

Could you be more specific about those usecases? Are they really
interested in supporting larger pages for the memcg migration which is
v1 only feature? Or you are interested merely to have the code more
generic?

[...]
> @@ -6036,28 +6041,26 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>  		case MC_TARGET_DEVICE:
>  			device = true;
>  			fallthrough;
> -		case MC_TARGET_PAGE:
> -			page = target.page;
> +		case MC_TARGET_FOLIO:
> +			folio = target.folio;
>  			/*
> -			 * We can have a part of the split pmd here. Moving it
> -			 * can be done but it would be too convoluted so simply
> -			 * ignore such a partial THP and keep it in original
> -			 * memcg. There should be somebody mapping the head.
> +			 * Is bailing out here with a large folio still the
> +			 * right thing to do?  Unclear.
>  			 */
> -			if (PageTransCompound(page))
> +			if (folio_test_large(folio))
>  				goto put;
> -			if (!device && isolate_lru_page(page))
> +			if (!device && folio_isolate_lru(folio))
>  				goto put;
> -			if (!mem_cgroup_move_account(page, false,
> +			if (!mem_cgroup_move_account(folio, false,
>  						mc.from, mc.to)) {
>  				mc.precharge--;
>  				/* we uncharge from mc.from later. */
>  				mc.moved_charge++;
>  			}
>  			if (!device)
> -				putback_lru_page(page);
> -put:			/* get_mctgt_type() gets the page */
> -			put_page(page);
> +				folio_putback_lru(folio);
> +put:			/* get_mctgt_type() gets the folio */
> +			folio_put(folio);
>  			break;
>  		case MC_TARGET_SWAP:
>  			ent = target.ent;

It's been some time since I've looked at this particular code but my
recollection and current understanding is that we are skipping over pte
mapped huge pages for simplicity so that we do not have to recharge
all other ptes from the same huge page. What kind of concern do you see
there?

-- 
Michal Hocko
SUSE Labs
