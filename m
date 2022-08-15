Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6959300E
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiHONhK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHONhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 09:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F06218358
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660570627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32k6I+/xYZGpQQqB1hUqbRU4UEx2mYMpvxUY9GY4ewM=;
        b=fNtzhiu8kOwvx9XmbFm4YOgsQha1aKsOaWfSU8PyHHTFKuxdPpjm5LX904Etw9YAvcOwYP
        yXHBQWlNU6kGKj1w73B7m+hQXFbxNMIeJ4fFGSEbmNi5ICxvvXtoGYmaKXXRRF62lGiVpG
        knFAs5Fab5Seh8AEc4gjZ92pUhvXjmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-PHusKD7EP0-UqdTUxTXh2g-1; Mon, 15 Aug 2022 09:37:04 -0400
X-MC-Unique: PHusKD7EP0-UqdTUxTXh2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06B28811E80;
        Mon, 15 Aug 2022 13:37:03 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 577BB112131B;
        Mon, 15 Aug 2022 13:37:02 +0000 (UTC)
Message-ID: <a7eb96cd-1d4b-65a5-6213-a2f0df2d9ccc@redhat.com>
Date:   Mon, 15 Aug 2022 09:37:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] sched: Provide copy_user_cpus_mask() to copy out
 user mask
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220812203929.364341-1-longman@redhat.com>
 <20220812203929.364341-3-longman@redhat.com>
 <YvoKy6OdJIkNXbtq@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvoKy6OdJIkNXbtq@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/15/22 04:58, Peter Zijlstra wrote:
> On Fri, Aug 12, 2022 at 04:39:28PM -0400, Waiman Long wrote:
>> Since accessing the content of the user_cpus_ptr requires lock protection
>> to ensure its validity, provide a helper function copy_user_cpus_mask()
>> to facilitate its reading.
> Sure, but this is atrocious.
>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2619,6 +2619,24 @@ void release_user_cpus_ptr(struct task_struct *p)
>>   	kfree(clear_user_cpus_ptr(p));
>>   }
>>   
>> +/*
>> + * Return the copied mask pointer or NULL if user mask not available.
>> + */
>> +struct cpumask *copy_user_cpus_mask(struct task_struct *p,
>> +				    struct cpumask *user_mask)
>> +{
>> +	struct rq_flags rf;
>> +	struct rq *rq = task_rq_lock(p, &rf);
>> +	struct cpumask *mask = NULL;
>> +
>> +	if (p->user_cpus_ptr) {
>> +		cpumask_copy(user_mask, p->user_cpus_ptr);
>> +		mask = user_mask;
>> +	}
>> +	task_rq_unlock(rq, p, &rf);
>> +	return mask;
>> +}
> For reading the mask you only need one of those locks, and I would
> suggest p->pi_lock is much less contended than rq->lock.
>
Right. pi_lock should be enough for read access. Will make the change.

Thanks,
Longman

