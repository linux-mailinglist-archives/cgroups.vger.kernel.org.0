Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF04ED0CC
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 02:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbiCaAWS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 20:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaAWR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 20:22:17 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1D1FCD1
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 17:20:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648686027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMINQAWO37CD+sVTlC/+ZMx9SRomlyJk24EcdjGWpeg=;
        b=wjiU1M6n3t656w0pWJcX+6aZPo7iWKh4pkJ21tOjlUEuOgNEycFbGfaLRm62qc3jXJ07iB
        dzUoeAh0RFkYRBb+iHMxH/+EuvR6VSeac50J4ncNDTQV3gFlcUfaguwKpQjNF2j7xtxJM2
        9/0/DJH3LBq0RFHj0pVnZZRYglSeoJY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 1/3] mm/memcg: set memcg after css verified and got
 reference
Message-ID: <YkTzxgB85BhNRXjl@carbon.dhcp.thefacebook.com>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
 <20220330234719.18340-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234719.18340-2-richard.weiyang@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 11:47:17PM +0000, Wei Yang wrote:
> Instead of reset memcg when css is either not verified or not got
> reference, we can set it after these process.
> 
> No functional change, just simplified the code a little.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Nice cleanup!

> ---
>  mm/memcontrol.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index dc193e83794d..eed9916cdce5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1057,15 +1057,10 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  		 * is provided by the caller, so we know it's alive
>  		 * and kicking, and don't take an extra reference.
>  		 */
> -		memcg = mem_cgroup_from_css(css);
> -
> -		if (css == &root->css)
> -			break;
> -
> -		if (css_tryget(css))
> +		if (css == &root->css || css_tryget(css)) {
> +			memcg = mem_cgroup_from_css(css);
>  			break;
> -
> -		memcg = NULL;
> +		}
>  	}
>  
>  	if (reclaim) {
> -- 
> 2.33.1
> 
> 
