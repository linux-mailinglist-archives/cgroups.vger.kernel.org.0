Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A861A1F8
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 21:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKDUNW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKDUNO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 16:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D32C65F
        for <cgroups@vger.kernel.org>; Fri,  4 Nov 2022 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667592730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVw++WwNRhJv9XuMMPj7SE5JUR1Vsk4jmONPY9jqoLM=;
        b=ZVhmLWY04Om8UttXwveHGmaom2XqwiAwdphwSTBMIT34QpFcgs6ToY5HUSGzZHajbXTD2F
        Nq5ZogZoc7qQpBuHWpyi14HfVE/9yuxS5lq95B2RjqlD6yU3se7OG7MAPalnRBEdJrwjXY
        K4wONMRg6mVk0o2ds2Zoj5PIF7uzKrY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-31-ZvFwqPWOwa4ydDYGVig-1; Fri, 04 Nov 2022 16:12:07 -0400
X-MC-Unique: 31-ZvFwqPWOwa4ydDYGVig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C83488039B4;
        Fri,  4 Nov 2022 20:12:06 +0000 (UTC)
Received: from [10.22.34.155] (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E2FEC2C8D9;
        Fri,  4 Nov 2022 20:12:06 +0000 (UTC)
Message-ID: <84fd6656-d133-b9df-c39e-fbb3a1f4a873@redhat.com>
Date:   Fri, 4 Nov 2022 16:12:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v9 3/3] blk-cgroup: Flush stats at blkgs destruction path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <20221104182050.342908-1-longman@redhat.com>
 <20221104182050.342908-4-longman@redhat.com>
 <Y2VvboMSxgF0pYpX@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y2VvboMSxgF0pYpX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/4/22 16:00, Tejun Heo wrote:
> On Fri, Nov 04, 2022 at 02:20:50PM -0400, Waiman Long wrote:
>> +/**
>> + * cgroup_rstat_css_flush - flush stats for the given css and cpu
>> + * @css: target css to be flush
>> + * @cpu: the cpu that holds the stats to be flush
>> + *
>> + * A lightweight rstat flush operation for a given css and cpu.
>> + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
>> + * isn't used.
>> + */
>> +void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu)
>> +{
>> +	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>> +
>> +	raw_spin_lock_irq(cpu_lock);
>> +	rcu_read_lock();
>> +	css->ss->css_rstat_flush(css, cpu);
>> +	rcu_read_unlock();
>> +	raw_spin_unlock_irq(cpu_lock);
>> +}
> Would it make sense to itereate CPUs within the helper rather than asking
> the caller to do it? Also, in terms of patch sequencing, this introduces a
> bug and then fixes it. Prolly better to not introduce the bug in the first
> place.
>
> Thanks.

I should have named the function cgroup_rstat_css_cpu_flush() to 
indicate that the cpu is a needed parameter. We can have a 
cgroup_rstat_css_flush() in the future if the need arises.

It is an optimization to call this function only if the corresponding 
cpu has a pending lockless list. I could do cpu iteration here and call 
the flushing function for all the CPUs. It is less optimized this way. 
Since it is a slow path, I guess performance is not that critical. So I 
can go either way. Please let me know your preference.

Thanks,
Longman

