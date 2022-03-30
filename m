Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2D4EC8F2
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiC3P6z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348462AbiC3P6z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 11:58:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9844B42B
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 08:57:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m21so2764500qtw.8
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2DqrTDJij/+jnL6IguPlfSJVz0YoCK5Qn6m+J92VWzI=;
        b=orgO24LkHCF4EOuz/ab4HIS8kjgemcfoGLDYGu7EWuXlTISEDMSKr4h2nrxRs2PzEc
         EjAshco2pN7gXzRJhW+0+mjZnkG0Xxm5vCR41OHjwj7BNKSAbpspP9aKawjBtJt4ZKKk
         Iat4FhW+5tFjMxnCnwdh8Bfl7HaK837UV+gjMj9/2UCWjyP+V8to1NZzXlrfzbZHkzeX
         WwPTYlpbpMAm35NaEV1dkfMAfyfgI3ZCHwuPlupG2iXlGyuDmKzIaZ/YYwDXbMdDNC9p
         km4O1WETMIikl7k5dpkF/phamL+DERfeGpjhuTN3hR+/OfQDxFYdrJ2a9p8r5UE1gffJ
         TTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2DqrTDJij/+jnL6IguPlfSJVz0YoCK5Qn6m+J92VWzI=;
        b=boYRSEMXBn6Pp+43t8AoXi7CZQP8ObepVEDVn6TXiORHqcGJQM/V5aLammBPTCs8Xf
         fkuc4xwYnXwD8dMGb0S82CUmB6NEybnOwmN0WuP8upzRKpM/p0RXnjSeo6BNjsqNpswK
         zSEUpRsW8lPL31yuCkBsqSX+mRcUxihI6Yh1cpBRuSopGyXB0P/5weBPk/C8LWWkeuga
         8MBqPkfmYKCLp4K+uslaaO8h+3EWnky1oVQYJfefHQs9czdwpfO+i9xiGMR852nR4uz/
         b3DY6yvRV5zZUJPJUEUlzBvDIniuZkUN9533pBmdbaESmLy9zEZI8MOmeU5M9hvnsyeM
         KlAA==
X-Gm-Message-State: AOAM533d8PuDS0ycubwMC3HomDTyzRqB4GB9wdan43RUUlKLzXC0emJX
        C43FDbYhaqoJd8B4iRRJQxzxJEjy2owtCA==
X-Google-Smtp-Source: ABdhPJwis4J+aFI90oZrgLFV575jBY3CiFlk/12EJdxfp3LWn6/dudg9zJuHrQONsGAd5+Dx3cTrPw==
X-Received: by 2002:ac8:7d86:0:b0:2e1:fe79:d602 with SMTP id c6-20020ac87d86000000b002e1fe79d602mr162679qtd.502.1648655828801;
        Wed, 30 Mar 2022 08:57:08 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm10958647qke.122.2022.03.30.08.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:57:08 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:57:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/memcg: move generation assignment and comparison
 together
Message-ID: <YkR902CHgavwleet@cmpxchg.org>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-4-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225003437.12620-4-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 25, 2022 at 12:34:37AM +0000, Wei Yang wrote:
> For each round-trip, we assign generation on first invocation and
> compare it on subsequent invocations.
> 
> Let's move them together to make it more self-explaining. Also this
> reduce a check on prev.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

This makes sense. The function is structured into 1) load state, 2)
advance, 3) save state. The load state is a better fit for
initializing reclaim->generation.

> @@ -996,7 +996,14 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  		mz = root->nodeinfo[reclaim->pgdat->node_id];
>  		iter = &mz->iter;
>  
> -		if (prev && reclaim->generation != iter->generation)
> +		/*
> +		 * On first invocation, assign iter->generation to
> +		 * reclaim->generation.
> +		 * On subsequent invocations, make sure no one else jump in.
> +		 */
> +		if (!prev)
> +			reclaim->generation = iter->generation;
> +		else if (reclaim->generation != iter->generation)
>  			goto out_unlock;

The comment duplicates the code, it doesn't explain why we're doing
this. How about:

		/*
		 * On start, join the current reclaim iteration cycle.
		 * Exit when a concurrent walker completes it.
		 */

With that, please feel free to add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
