Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B853D4E5
	for <lists+cgroups@lfdr.de>; Sat,  4 Jun 2022 04:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiFDCr4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jun 2022 22:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiFDCrz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jun 2022 22:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8671DA63
        for <cgroups@vger.kernel.org>; Fri,  3 Jun 2022 19:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654310874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cqh4lNnb8LUprz/k7VVRsZMriLZ9YvGxKq09h6b6YYk=;
        b=C2vNqb23Gc1a1S1UyGj3yIJsGmPBXknp2bQhzHvaCwC1vh2GaXEhLRdMpnrUs733Zm0fzk
        nfUPXpgUh2O8txK5SHDb3/AU0fOMIuMj7lQUbkaXQaJ0rK04Me+beMz/8Kq8TtecmIWELo
        cffa8h1eXuLo9k1BVxu195IVAt1+a6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-wm0ujGPvM8e41O88O94wtA-1; Fri, 03 Jun 2022 22:47:49 -0400
X-MC-Unique: wm0ujGPvM8e41O88O94wtA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FB7C802809;
        Sat,  4 Jun 2022 02:47:49 +0000 (UTC)
Received: from [10.22.11.59] (unknown [10.22.11.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0EB4492C3B;
        Sat,  4 Jun 2022 02:47:48 +0000 (UTC)
Message-ID: <9fe80bd8-7733-066e-d8eb-5e5bab221e45@redhat.com>
Date:   Fri, 3 Jun 2022 22:47:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 1/3] blk-cgroup: Correctly free percpu iostat_cpu in
 blkg on error exit
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-2-longman@redhat.com> <Ypq+sPnh6J14PvIZ@T590>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ypq+sPnh6J14PvIZ@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/3/22 22:08, Ming Lei wrote:
> On Thu, Jun 02, 2022 at 03:20:18PM -0400, Waiman Long wrote:
>> Commit f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup
>> rstat") changes block cgroup IO stats to use the rstat APIs. It added
>> a new percpu iostat_cpu field into blkg. The blkg_alloc() was modified
>> to allocate the new percpu iostat_cpu but didn't free it when an error
>> happened. Fix this by freeing the percpu iostat_cpu on error exit.
>>
>> Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> ---
>>   block/blk-cgroup.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 40161a3f68d0..acd9b0aa8dc8 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -219,11 +219,11 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>>   		return NULL;
>>   
>>   	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
>> -		goto err_free;
>> +		goto err_free_blkg;
>>   
>>   	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
>>   	if (!blkg->iostat_cpu)
>> -		goto err_free;
>> +		goto err_free_blkg;
>>   
>>   	if (!blk_get_queue(q))
>>   		goto err_free;
>> @@ -259,6 +259,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>>   	return blkg;
>>   
>>   err_free:
>> +	free_percpu(blkg->iostat_cpu);
>> +
>> +err_free_blkg:
>>   	blkg_free(blkg);
> Hi Waiman,
>
> But blkg_free() frees blkg->iostat_cpu via blkg_free_workfn(), so I am
> confused where the leak is in failure path?

Yes, you are right. I have overlooked that. So this patch isn't really 
necessary. Thanks for correcting me.

Cheers,
Longman

