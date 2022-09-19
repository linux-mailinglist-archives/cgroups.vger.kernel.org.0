Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521925BCFC1
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiISPBV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 11:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiISPBU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 11:01:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB76B31372;
        Mon, 19 Sep 2022 08:01:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A6931F74A;
        Mon, 19 Sep 2022 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663599677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDQ4TbeBXa/svhW7EfZleIQJqRglXyx7TDIqISE6yyM=;
        b=QruWER5KDSb+2K6n6HFs/WUurfTkzp5sMxSVkMVrm3lehOt+UtyXCfIE5QlGQ6AB/pQl2H
        bWA7U17LROAZJt8gYCc6PbCQMojyqbCPedL6IdL4/SbV8YQ9RG2aDhG9+P00umlWIFwU4j
        oOEFwRn36kywPKURtqAA8cYTgrgtKb4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02ABA13A96;
        Mon, 19 Sep 2022 15:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SryBOTyEKGOsbgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 19 Sep 2022 15:01:16 +0000
Date:   Mon, 19 Sep 2022 17:01:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3] mm/memcontrol: use kstrtobool for swapaccount param
 parsing
Message-ID: <YyiEPPecoqsinebe@dhcp22.suse.cz>
References: <20220909145308.f2f61d6992f00ef6977f833b@linux-foundation.org>
 <20220913071358.1812206-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913071358.1812206-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 13-09-22 15:13:58, Liu Shixin wrote:
> Use kstrtobool which is more powerful to handle all kinds of parameters
> like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".

the main usefulness is with the code reusability of library functions
rather than ad-hoc stuff.

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0a1a8a846870..5511c0c120d9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7434,10 +7434,10 @@ bool mem_cgroup_swap_full(struct folio *folio)
>  
>  static int __init setup_swap_account(char *s)
>  {
> -	if (!strcmp(s, "1"))
> -		cgroup_memory_noswap = false;
> -	else if (!strcmp(s, "0"))
> -		cgroup_memory_noswap = true;
> +	bool res;
> +
> +	if (!kstrtobool(s, &res))
> +		cgroup_memory_noswap = !res;
>  	return 1;
>  }
>  __setup("swapaccount=", setup_swap_account);
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
