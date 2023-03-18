Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF36BF738
	for <lists+cgroups@lfdr.de>; Sat, 18 Mar 2023 02:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCRBge (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Mar 2023 21:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRBgd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Mar 2023 21:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E1C5607
        for <cgroups@vger.kernel.org>; Fri, 17 Mar 2023 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679103346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXGU9grUyOEEZr4lmDbjI1nN/h/jed2HEhYFOagp+3w=;
        b=GmA9tAr5QSzDM41ybAivU3go58Pk1OMBz5jwEmDJ9UfoLGbdutkzkpHE3EmntnfBvJAa5x
        JVuotBn2nAEt9pPd82lGqiNHHn+BF6hyhgeGBoybZGluYs01DYsZr+sxlqXbxd8AFFdycc
        2P7HOI6Dr/K+J2cCI39hdT2g2HTgMRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-vzt3oDUsOu-7kkhKWBuVKQ-1; Fri, 17 Mar 2023 21:35:41 -0400
X-MC-Unique: vzt3oDUsOu-7kkhKWBuVKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8BFC101A531;
        Sat, 18 Mar 2023 01:35:40 +0000 (UTC)
Received: from [10.22.10.238] (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D890492B02;
        Sat, 18 Mar 2023 01:35:40 +0000 (UTC)
Message-ID: <299c9c34-0c07-ae52-61d7-6332f35c6245@redhat.com>
Date:   Fri, 17 Mar 2023 21:35:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cpuset: Clean up cpuset_node_allowed
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <20230228083537.102665-1-haifeng.xu@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230228083537.102665-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/28/23 03:35, Haifeng Xu wrote:
> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
> has used __cpuset_node_allowed() instead of cpuset_node_allowed() to check
> whether we can allocate on a memory node. Now this function isn't used by
> anyone, so we can do the follow things to clean up it.
>
> 1. remove unused codes
> 2. rename __cpuset_node_allowed() to cpuset_node_allowed()
> 3. update comments in mm/page_alloc.c
>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>   include/linux/cpuset.h | 16 ++--------------
>   kernel/cgroup/cpuset.c |  4 ++--
>   mm/page_alloc.c        |  4 ++--
>   3 files changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..980b76a1237e 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -80,18 +80,11 @@ extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   void cpuset_init_current_mems_allowed(void);
>   int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>   
> -extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
> -
> -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
> -{
> -	if (cpusets_enabled())
> -		return __cpuset_node_allowed(node, gfp_mask);
> -	return true;
> -}
> +extern bool cpuset_node_allowed(int node, gfp_t gfp_mask);
>   
>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>   {
> -	return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
> +	return cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>   }
>   
>   static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
> @@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>   	return 1;
>   }
>   
> -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
> -{
> -	return true;
> -}
> -

Sorry for the late reply as I apparently drop the ball.

You need to keep the above cpuset_node_allowed() inline function or you 
will get compilation error when compiling with a config without 
CONFIG_CPUSETS. Other than that, the other changes look good.

Cheers,
Longman

