Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6253DF93
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 04:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbiFFB76 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Jun 2022 21:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241408AbiFFB75 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Jun 2022 21:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E73614F475
        for <cgroups@vger.kernel.org>; Sun,  5 Jun 2022 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654480795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bvyf6sQjmkfCDLNK49ZrMJaEbj0blM3ELQjytG3RjZU=;
        b=ZR9ufxC6N1Y13Eirk3u3Gst0VjJeo476OD2r15OPjBIMkoP3dBxBdwovJX2BVuRni+hzgN
        Us1Mfkm+jF6djfpSanZJ2eTDi0omp/ZYi0z6H7Rlp/4CA4mpKgG2iXqN0DbWJuBDwFs9a/
        yke8+MviJfIqWdcpeKMKTvzbIGKIoG0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-ctW413vmOo2SsU0iXf4QNg-1; Sun, 05 Jun 2022 21:59:50 -0400
X-MC-Unique: ctW413vmOo2SsU0iXf4QNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EC52801228;
        Mon,  6 Jun 2022 01:59:50 +0000 (UTC)
Received: from [10.22.32.31] (unknown [10.22.32.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA4140EC001;
        Mon,  6 Jun 2022 01:59:50 +0000 (UTC)
Message-ID: <c9ab0e91-76db-430f-272c-558c269d62ce@redhat.com>
Date:   Sun, 5 Jun 2022 21:59:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com> <YprYgdV0IxAeJZsz@T590>
 <ee754359-cefd-7d4b-7861-1405860bba9b@redhat.com> <Yp1atoLkZPvA1Zd3@T590>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yp1atoLkZPvA1Zd3@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/5/22 21:39, Ming Lei wrote:
> On Sun, Jun 05, 2022 at 07:15:27PM -0400, Waiman Long wrote:
>> On 6/3/22 23:58, Ming Lei wrote:
>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index abec50f31fe6..8c4f204dbf5b 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -622,7 +622,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>>>    {
>>>    	unsigned int x;
>>> -	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>>> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id(), NULL);
>>>    	x = __this_cpu_add_return(stats_updates, abs(val));
>>>    	if (x > MEMCG_CHARGE_BATCH) {
>> I think the rstat set of functions are doing that already. So flush will
>> only call CPUs that have called cgroup_rstat_updated() before. However, one
> Yeah, I guess the detail is in cgroup_rstat_cpu_pop_updated(), but the
> percpu lock(raw_spin_lock_irqsave) is still required, and cgroup_rstat_cpu_pop_updated()
> is still called even through there isn't any update on this CPU.
Yes, I think we may need to add a bitmask of what controllers have 
updates in cgroup_rstat_cpu structure.
>
>> deficiency that I am aware of is that there is no bitmap of which controller
>> have update. The problem that I saw in cgroup v2 is that in a cgroup with
>> both memory controller and block controller enabled, a
>> cgroup_rstat_updated() call from memory cgroup later causes the rstat
>> function to call into block cgroup flush method even though there is no
>> update in the block controller. This is an area that needs improvement.
>>
>> Your code does allow the block controller to be aware of that and avoid
>> further action, but I think it has to be done in the rstat code to be
>> applicable to all controllers instead of just specific to block controller.
> I guess it can be done by adding one percpu variable to 'struct cgroup'.
>
>> There is another problem that this approach. Suppose the system have 20
>> block devices and one of them has an IO operation. Now the flush method
>> still needs to iterate all the 20 blkg's to do an update. The block
>> controller is kind of special that the number of per-cgroup IO stats depends
>> on the number of block devices present. Other controllers just have one set
>> of stats per cgroup.
> Yeah, and this one is really blkio specific issue, and your patch does
> cover this one. Maybe you can add one callback to
> cgroup_rstat_updated(), so the "blkg_iostat_set" instance is added into
> percpu list under percpu lock of cgroup_rstat_cpu_lock, then the lockless
> list isn't needed.

The rstat API is generic. It may not be a good idea to put controller 
specific information into it. Yes, cgroup_rstat_cpu_lock is taken at the 
read side (flush). It may not taken on the write side (update). So it 
may not be easy to rely on this lock for synchronization between the 
read and write side.

Cheers,
Longman

