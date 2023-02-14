Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAB69688B
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjBNP44 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 10:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBNP4z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 10:56:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E58193E3;
        Tue, 14 Feb 2023 07:56:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B6102184F;
        Tue, 14 Feb 2023 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676390213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iAggmlF4GOtadtjvHCG9VGU8bit4Xaqy/p0gnj0OK7A=;
        b=RK+XbcmgSb5r0n5e5pwKRqGg012gVMCB/BgpEJ1uGLd83kk2Qp9m3ltJOqPkP9HdoV71ij
        yD8r+HWyxD3FQY7E1msXK+iv/WfYD+Up/+IJfn6AOg6PMsYPTZNikWOPOYu8mVyvx/r+GO
        7shQ7ft20DZTe/p/FIvp82rBcJfEwGA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 594EA138E3;
        Tue, 14 Feb 2023 15:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xb8+FEWv62PSAQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 14 Feb 2023 15:56:53 +0000
Date:   Tue, 14 Feb 2023 16:56:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: Skip high limit check in root memcg
Message-ID: <Y+uvRKo7OQ02yB4K@dhcp22.suse.cz>
References: <20230210094550.5125-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210094550.5125-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 10-02-23 09:45:50, Haifeng Xu wrote:
> The high limit checks the memory usage from given memcg to root memcg.
> However, there is no limit in root memcg. So this check makes no sense
> and we can ignore it.

Is this check actually addining any benefit? Have you measured aby
performance gains by this change?

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/memcontrol.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 73afff8062f9..a31a56598f29 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2780,6 +2780,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	do {
>  		bool mem_high, swap_high;
>  
> +		/* There is no need for root memcg to check high limit */
> +		if (mem_cgroup_is_root(memcg))
> +			break;
> +
>  		mem_high = page_counter_read(&memcg->memory) >
>  			READ_ONCE(memcg->memory.high);
>  		swap_high = page_counter_read(&memcg->swap) >
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
