Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E454ED0D0
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 02:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352077AbiCaAXX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaAXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 20:23:22 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07791FCD1
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 17:21:36 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:21:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648686095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWF887DtqFZawSDRTplBMzE6vHE/PS285KJ5U8ZNHwA=;
        b=KrFNO/YnPGeftymOJt04Ki+/yT0lpAC29OMuRJMM2jNsur/jxiBMNdzjv7iuN1pnC6LllH
        /BoKRUYj0SF2GnQmz2mH+G0oM5AKaua0UTXmj4MBQN55I8Q3eTLZfaAQbQGJO+Lop5r3q+
        zFSYyHGuCgzP+mYixT89TQqAwvXZe98=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 2/3] mm/memcg: set pos explicitly for reclaim and
 !reclaim
Message-ID: <YkT0CXIey0a6pPX6@carbon.dhcp.thefacebook.com>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
 <20220330234719.18340-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234719.18340-3-richard.weiyang@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 11:47:18PM +0000, Wei Yang wrote:
> During mem_cgroup_iter, there are two ways to get iteration position:
> reclaim vs non-reclaim mode.
> 
> Let's do it explicitly for reclaim vs non-reclaim mode.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

> 
> ---
> v2: split into two explicit part as suggested by Johannes
> ---
>  mm/memcontrol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index eed9916cdce5..5d433b79ba47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1005,9 +1005,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	if (!root)
>  		root = root_mem_cgroup;
>  
> -	if (prev && !reclaim)
> -		pos = prev;
> -
>  	rcu_read_lock();
>  
>  	if (reclaim) {
> @@ -1033,6 +1030,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  			 */
>  			(void)cmpxchg(&iter->position, pos, NULL);
>  		}
> +	} else if (prev) {
> +		pos = prev;
>  	}
>  
>  	if (pos)
> -- 
> 2.33.1
> 
> 
