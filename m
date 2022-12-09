Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB364860B
	for <lists+cgroups@lfdr.de>; Fri,  9 Dec 2022 16:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLIP7d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Dec 2022 10:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIP7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Dec 2022 10:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80374379D5
        for <cgroups@vger.kernel.org>; Fri,  9 Dec 2022 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670601517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJPm4fwaRggOYMPWB+4OQhr2AoXrB0vtei9ZF45OHV8=;
        b=P/kRoZGJ3sfZDKob9s9hbZmclMguAm+O0rrbTY0xZhUTyjEOHmo9LLqWK93tjeTm5wRYm6
        ooBTX8OoA3twHIRQTvXMkQhnOZpbEZ2YEB9NuAq9TcAHS/HwScBtN7C2KpKDigS9B9zZ1L
        NoFRILfKcGP5Us8OL0tqeU6W4j30GWU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-B696t4EsMfiGoAAspXHKFA-1; Fri, 09 Dec 2022 10:58:36 -0500
X-MC-Unique: B696t4EsMfiGoAAspXHKFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A33E429AA2EF;
        Fri,  9 Dec 2022 15:58:35 +0000 (UTC)
Received: from [10.22.9.164] (unknown [10.22.9.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1AE1401C30;
        Fri,  9 Dec 2022 15:58:34 +0000 (UTC)
Message-ID: <8641d4a4-4d60-0f31-120c-56628f477ba2@redhat.com>
Date:   Fri, 9 Dec 2022 10:58:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block 3/3] blk-cgroup: Flush stats at blkgs destruction
 path
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221208220141.2625775-1-longman@redhat.com>
 <20221208220141.2625775-4-longman@redhat.com>
 <e8a09f5d-afce-608f-220b-6b32b3ae37b9@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e8a09f5d-afce-608f-220b-6b32b3ae37b9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/8/22 18:00, Jens Axboe wrote:
> On 12/8/22 3:01?PM, Waiman Long wrote:
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 793ecff29038..910e633869b0 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -281,6 +281,26 @@ void cgroup_rstat_flush_release(void)
>>   	spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>   
>> +/**
>> + * cgroup_rstat_css_cpu_flush - flush stats for the given css and cpu
>> + * @css: target css to be flush
>> + * @cpu: the cpu that holds the stats to be flush
>> + *
>> + * A lightweight rstat flush operation for a given css and cpu.
>> + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
>> + * isn't used.
>> + */
>> +void cgroup_rstat_css_cpu_flush(struct cgroup_subsys_state *css, int cpu)
>> +{
>> +	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>> +
>> +	raw_spin_lock_irq(cpu_lock);
>> +	rcu_read_lock();
>> +	css->ss->css_rstat_flush(css, cpu);
>> +	rcu_read_unlock();
>> +	raw_spin_unlock_irq(cpu_lock);
>> +}
>> +
>>   int cgroup_rstat_init(struct cgroup *cgrp)
>>   {
>>   	int cpu;
> As I mentioned last time, raw_spin_lock_irq() will be equivalent to an
> RCU protected section anyway, so you don't need to do both. Just add a
> comment on why rcu_read_lock()/rcu_read_unlock() isn't needed inside the
> raw irq safe lock.

Yes, you are right.  We don't need rcu_read_lock() here. I put it there 
to follow the locking pattern in cgroup_rstat_flush_locked(). I will 
remove it in the next version.

Cheers,
Longman

