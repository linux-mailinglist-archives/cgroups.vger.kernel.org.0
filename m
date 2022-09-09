Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637FE5B41B2
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIVxM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Sep 2022 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIIVxL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Sep 2022 17:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB870E57;
        Fri,  9 Sep 2022 14:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3CC61FF5;
        Fri,  9 Sep 2022 21:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F78C433D6;
        Fri,  9 Sep 2022 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662760389;
        bh=0JcE0DLdNzQm3AF+ZqlE39XNCX4d5bRLfNDfq0UT/g4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MBWJF+Ae7WdYf68cBxuz+A7rZmgFkpzsf5z3e0zEWKuLYcSLhPtI2YV1SGKHOY3oC
         Luy2cPNFoakNi7qC+zQaeo5I81q7yZDg3ogVrDFGH9CAIvXo278uOnjET+AEwkAjdl
         j/pOtTVmax8W40oStXD8ZsmUhesodTnlrMEBtlAM=
Date:   Fri, 9 Sep 2022 14:53:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] mm/memcontrol: use kstrtobool for swapaccount param
 parsing
Message-Id: <20220909145308.f2f61d6992f00ef6977f833b@linux-foundation.org>
In-Reply-To: <20220909084647.3598299-1-liushixin2@huawei.com>
References: <20220909084647.3598299-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 9 Sep 2022 16:46:47 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Use kstrtobool which is more powerful to handle all kinds of parameters
> like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".
> 
> ...
>
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6037,10 +6037,11 @@
>  			Execution Facility on pSeries.
>  
>  	swapaccount=	[KNL]
> -			Format: [0|1]
> +			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 }
>  			Enable accounting of swap in memory resource
> -			controller if no parameter or 1 is given or disable
> -			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
> +			controller if no parameter or [oO][Nn]/Y/y/1 is given
> +			or disable it if [oO][Ff]/N/n/0 is given
> +			(See Documentation/admin-guide/cgroup-v1/memory.rst)
>  
>  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
>  			Format: { <int> [,<int>] | force | noforce }

mhocko suggested dropping this change as well.

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

And I agree.  See, the risk with this patch is that someone will
develop userspace code which relies upon the new behaviour.  Then when
someone tries to use that code on an older kernel, whoops, it doesn't
work.  In other words, we're encouraging development of
non-backward-compatible userspace code.

Leaving the documentation as it was (just "0|1") will help to prevent
that situation.
