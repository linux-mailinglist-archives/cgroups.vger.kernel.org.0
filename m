Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02F6BFCF4
	for <lists+cgroups@lfdr.de>; Sat, 18 Mar 2023 22:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjCRVbh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Mar 2023 17:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRVbg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Mar 2023 17:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753A211D9
        for <cgroups@vger.kernel.org>; Sat, 18 Mar 2023 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679175050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJ/cpwwTOsiNZoK2Zi5I+mzUQqbpVfRXw3dozXcgP1o=;
        b=OKlNS5TrBXp+BEEsNJnsuUNoCs6fHy9NyPIm/gRoqhmnu2hi63A4zEr9QJRujp22B33hzK
        ovxnbMTCA4OjaT5kNwX7W0dgcGge/avT6c1JrESFBRVfKyBJ3kj6P0YlE+wF5SOEIgS8jd
        eXlBZKMvgzCdW9yX8shjvDGPjjDPcTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-fNv3JSNRMjKx3ATWG4qSPQ-1; Sat, 18 Mar 2023 17:30:48 -0400
X-MC-Unique: fNv3JSNRMjKx3ATWG4qSPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70EDD8533A2;
        Sat, 18 Mar 2023 21:30:47 +0000 (UTC)
Received: from [10.22.8.46] (unknown [10.22.8.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0325C15BA0;
        Sat, 18 Mar 2023 21:30:46 +0000 (UTC)
Message-ID: <2e71c2bf-9ee3-4ada-e9d9-acb6e422e9af@redhat.com>
Date:   Sat, 18 Mar 2023 17:30:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cpuset: Clean up cpuset_node_allowed
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
 <20230228083537.102665-1-haifeng.xu@shopee.com>
 <299c9c34-0c07-ae52-61d7-6332f35c6245@redhat.com>
In-Reply-To: <299c9c34-0c07-ae52-61d7-6332f35c6245@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/17/23 21:35, Waiman Long wrote:
> On 2/28/23 03:35, Haifeng Xu wrote:
>> Commit 002f290627c2 ("cpuset: use static key better and convert to 
>> new API")
>> has used __cpuset_node_allowed() instead of cpuset_node_allowed() to 
>> check
>> whether we can allocate on a memory node. Now this function isn't 
>> used by
>> anyone, so we can do the follow things to clean up it.
>>
>> 1. remove unused codes
>> 2. rename __cpuset_node_allowed() to cpuset_node_allowed()
>> 3. update comments in mm/page_alloc.c
>>
>> Suggested-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>   include/linux/cpuset.h | 16 ++--------------
>>   kernel/cgroup/cpuset.c |  4 ++--
>>   mm/page_alloc.c        |  4 ++--
>>   3 files changed, 6 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index d58e0476ee8e..980b76a1237e 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -80,18 +80,11 @@ extern nodemask_t cpuset_mems_allowed(struct 
>> task_struct *p);
>>   void cpuset_init_current_mems_allowed(void);
>>   int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>>   -extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
>> -
>> -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>> -{
>> -    if (cpusets_enabled())
>> -        return __cpuset_node_allowed(node, gfp_mask);
>> -    return true;
>> -}
>> +extern bool cpuset_node_allowed(int node, gfp_t gfp_mask);
>>     static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t 
>> gfp_mask)
>>   {
>> -    return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>> +    return cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>>   }
>>     static inline bool cpuset_zone_allowed(struct zone *z, gfp_t 
>> gfp_mask)
>> @@ -223,11 +216,6 @@ static inline int 
>> cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>>       return 1;
>>   }
>>   -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>> -{
>> -    return true;
>> -}
>> -
>
> Sorry for the late reply as I apparently drop the ball.
>
> You need to keep the above cpuset_node_allowed() inline function or 
> you will get compilation error when compiling with a config without 
> CONFIG_CPUSETS. Other than that, the other changes look good.
>
It turns out that cpuset_node_allowed() isn't used anywhere except in 
cpuset.h. So it should be OK to remove the alternate 
cpuset_node_allowed() function.

Acked-by: Waiman Long <longman@redhat.com>

