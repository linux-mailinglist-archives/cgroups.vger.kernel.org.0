Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5E4ECFE7
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiC3XGS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 19:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiC3XGS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 19:06:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB42D1D8
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:04:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j15so44434239eje.9
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzKZ7ECGkzcFdPQK5M9ncRL/sQmYPUdD+l7iQzUycAA=;
        b=MftjtHFIxELw4IPjIcxy8tjPG26Iq9aW2ed4nF7XZHiDywZb4f2s/BLKMVFS3lWKmm
         9fmTlV+ZpJ8KDPJEtUXaAFySzX5epOxrYuZ/mH4DpCGdxro2jggjgghc/RUbzwlnawP9
         o3XgG435IlPTYm1Xm2n/BvkdW+/nBK6pp4FnWbY2k3fhd69xWmyaLmj8mYrDUMB4djjj
         25nTEL1u5CYdqavAwTnbUNZnKXTfgEzXVGFJw/V6MDfVs0n8+EKD5+9Y95nGENMoGSpj
         ZyYYt4GNVp0A6CHGzJ+kxLhSn7rwgKr41PBNSEOvFSs4mOpwyVo6N1B+jmL56p9z3WFh
         Fa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzKZ7ECGkzcFdPQK5M9ncRL/sQmYPUdD+l7iQzUycAA=;
        b=vZ8aPU/Jy77AlegyHnsv1b50Zijnudx15k8h9tRFcxDjwY2Xvm0XHa4UO0DUXYMcNc
         fiT1OvJPen9uWrIBMzX6FVF4B4RxNZXhCbD+oRA8PURjj1idVYF3OHIOKBgt4c5D9s99
         SIRJyVAuPoHB3LEHV+xCQyt8RsCnFUBgEJTV5bNyZ39v3ZeSE3QAhjdAWWsfvP+4uqxX
         bF4dM1qpG0K04XaWar7UQvVQeHvH3LRysaothcpmi3usJJBtkEtC1HDXFLrb7lT/NIi6
         +T2XB2iOmlPNpWS6WL7JSGOumCL3ic85tZ8Zlo94XfK6D7k8GDSroksMsrh70ftpGaCk
         T18g==
X-Gm-Message-State: AOAM530RP4uQKb6xIfWfBcJWEYBC/wsoG6jQWJjgxegE6Rf5W/bGFMMS
        qzV23dWWauSTk43XLpzddWk=
X-Google-Smtp-Source: ABdhPJxhAIuWULIKpzZ/GYJkv8ySomgFTpP9EX2TyymMMyq59mUwBzURUn/gIkQjQ3V4klCGBZNhDQ==
X-Received: by 2002:a17:906:c0c9:b0:6db:207:c41f with SMTP id bn9-20020a170906c0c900b006db0207c41fmr2208540ejb.292.1648681470183;
        Wed, 30 Mar 2022 16:04:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090664ca00b006df8869d58dsm8730965ejn.100.2022.03.30.16.04.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 16:04:29 -0700 (PDT)
Date:   Wed, 30 Mar 2022 23:04:29 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/memcg: move generation assignment and comparison
 together
Message-ID: <20220330230429.ua5y42cgr3f6crnr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
 <20220225003437.12620-4-richard.weiyang@gmail.com>
 <YkR902CHgavwleet@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkR902CHgavwleet@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 11:57:07AM -0400, Johannes Weiner wrote:
>On Fri, Feb 25, 2022 at 12:34:37AM +0000, Wei Yang wrote:
>> For each round-trip, we assign generation on first invocation and
>> compare it on subsequent invocations.
>> 
>> Let's move them together to make it more self-explaining. Also this
>> reduce a check on prev.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>This makes sense. The function is structured into 1) load state, 2)
>advance, 3) save state. The load state is a better fit for
>initializing reclaim->generation.
>
>> @@ -996,7 +996,14 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>>  		mz = root->nodeinfo[reclaim->pgdat->node_id];
>>  		iter = &mz->iter;
>>  
>> -		if (prev && reclaim->generation != iter->generation)
>> +		/*
>> +		 * On first invocation, assign iter->generation to
>> +		 * reclaim->generation.
>> +		 * On subsequent invocations, make sure no one else jump in.
>> +		 */
>> +		if (!prev)
>> +			reclaim->generation = iter->generation;
>> +		else if (reclaim->generation != iter->generation)
>>  			goto out_unlock;
>
>The comment duplicates the code, it doesn't explain why we're doing
>this. How about:
>
>		/*
>		 * On start, join the current reclaim iteration cycle.
>		 * Exit when a concurrent walker completes it.
>		 */

This one looks better and explain the reclaim model.
Thanks

>
>With that, please feel free to add:
>
>Acked-by: Johannes Weiner <hannes@cmpxchg.org>

-- 
Wei Yang
Help you, Help me
