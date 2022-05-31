Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48C5396AD
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbiEaTDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiEaTDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 15:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 136E46A06A
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654023793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL2SGtd/DsycKVQbAXVtuQFVW3sDNR72Qll7mqMvf/Y=;
        b=J55oYPZEhll4kTbtxAjzMBM6Zhtkrr3vD7ZgpiHOJCJQogNGJHSdFQQz+X/wm42VQOlnQb
        dxrFcxqP4QhAKFafZ3BOE57OANHq5hwzCzToAcp4H6+U7wSD1ACJZD/4n5Acq0o/BygyDy
        zCqFvTCxtCfDekCmrNew84Kw6e/hxiY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-OauRHQbzP7aEHx3VSA0hZQ-1; Tue, 31 May 2022 15:03:09 -0400
X-MC-Unique: OauRHQbzP7aEHx3VSA0hZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 890853816843;
        Tue, 31 May 2022 19:03:08 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 512E45F245;
        Tue, 31 May 2022 19:03:08 +0000 (UTC)
Message-ID: <70a2763a-f7c4-e161-23e4-33815e76380c@redhat.com>
Date:   Tue, 31 May 2022 15:03:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20220531181821.187834-1-longman@redhat.com>
 <YpZdWNGW1bTGnApp@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpZdWNGW1bTGnApp@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/31/22 14:24, Tejun Heo wrote:
> Hello, Waiman.
>
> On Tue, May 31, 2022 at 02:18:21PM -0400, Waiman Long wrote:
>> For a system with many CPUs and block devices, the time to do
>> blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
>> can be especially problematic as interrupt is disabled during the flush.
>> It was reported that it might take seconds in some extreme cases leading
>> to hard lockup messages.
>>
>> As it is likely that not all the percpu blkg_iostat_set's has been
>> updated since the last flush, those stale blkg_iostat_set's don't need
>> to be flushed in this case. This patch optimizes blkcg_rstat_flush()
>> by checking the current sequence number against the one recorded since
>> the last flush and skip the blkg_iostat_set if the sequence number
>> hasn't changed. There is a slight chance that it may miss an update
>> that is being done in parallel, the new update will just have to wait
>> until the next flush.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   block/blk-cgroup.c | 18 +++++++++++++++---
>>   block/blk-cgroup.h |  1 +
>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 40161a3f68d0..79b89af61ef2 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -864,11 +864,23 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>>   		unsigned long flags;
>>   		unsigned int seq;
>>   
>> +		seq = u64_stats_fetch_begin(&bisc->sync);
>> +		/*
>> +		 * If the sequence number hasn't been updated since the last
>> +		 * flush, we can skip this blkg_iostat_set though we may miss
>> +		 * an update that is happening in parallel.
>> +		 */
>> +		if (seq == bisc->last_seq)
>> +			continue;
> Is this a sufficient solution? The code assumes that there aren't too many
> blkgs for the cgroup, which can be wrong in some cases. Wouldn't it be
> better to create a list of updated blkg's per blkcg so that we don't walk
> all the dormant ones?

It is probably not a sufficient solution, but it is simple. The problem 
with keeping a list of recently updated blkg's is that sequence lock 
does not provide enough synchronization on the read side to guarantee a 
race free reset of the list. It may be doable, but I need to think 
harder on the best way to do it without too much overhead.

Thanks,
Longman

