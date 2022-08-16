Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F10596146
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiHPRi0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiHPRiZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 13:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212F04D16C
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660671504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdnOT0e5CEKzDOC4PBc+9OuYz+K252RaUVT9XjoI0RA=;
        b=FaOFm2F4M7N0ML7xSdIGS9j54j10/RRUVdsfyLraeT5pwAzCJq5dQu11MDXfHnhusp+1HP
        K+lO9zZMjRrn7vgNeklKIQ1f76MifN7Ywo8fhyLrgR8rCK+16XVLQrOM4IyPDYmPQx/brt
        yNlV3SluzuDE+LhhqPSWNwDyhHSiXhI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ZQwKywmoMzKnBC7iwCiyhQ-1; Tue, 16 Aug 2022 13:38:19 -0400
X-MC-Unique: ZQwKywmoMzKnBC7iwCiyhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A9C92999B31;
        Tue, 16 Aug 2022 17:38:19 +0000 (UTC)
Received: from [10.22.10.201] (unknown [10.22.10.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D961B945D9;
        Tue, 16 Aug 2022 17:38:17 +0000 (UTC)
Message-ID: <349849aa-937d-8b08-a836-7c5c70168139@redhat.com>
Date:   Tue, 16 Aug 2022 13:38:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/3] cgroup/cpuset: Keep user set cpus affinity
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220816151119.29534-1-longman@redhat.com>
 <20220816151119.29534-4-longman@redhat.com>
 <YvvR2Sa6LxZLwXsJ@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YvvR2Sa6LxZLwXsJ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/16/22 13:20, Tejun Heo wrote:
> Hello,
>
> So, overall I think this is the right direction.
>
>> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
>> +				       const struct cpumask *mask)
>> +{
>> +	if (p->user_cpus_ptr) {
>> +		cpumask_var_t new_mask;
>> +
>> +		if (alloc_cpumask_var(&new_mask, GFP_KERNEL) &&
>> +		    copy_user_cpus_mask(p, new_mask) &&
>> +		    cpumask_and(new_mask, new_mask, mask)) {
>> +			int ret = set_cpus_allowed_ptr(p, new_mask);
>> +
>> +			free_cpumask_var(new_mask);
>> +			return ret;
>> +		}
>> +		free_cpumask_var(new_mask);
>> +	}
>> +
>> +	return set_cpus_allowed_ptr(p, mask);
>> +}
> But this seems racy to me. Let's say attach and setaffinity race. The
> expectation should be that we'd end up with the same eventual mask no matter
> what the operation order may be. The above code wouldn't do that, right?
> There's nothing synchronizing the two and if setaffinity takes place between
> the user_cpus_ptr test and set_cpus_allowed_ptr(), it'd get ignored.

Yes, a race like this is possible. To completely eliminate the race may 
require taking task_rq_lock() and then calling 
__set_cpus_allowed_ptr_locked() which is internal to kernel/sched/core.c.

Alternatively, we can check user_cpus_ptr again after the scond 
set_cpus_allowed_ptr() and retry it with the other path if set. That 
will probably address your concern. Please let me know if you are OK 
with that.

Cheers,
Longman

>
> This gotta be more integrated. There is what the user requested and there
> are restrictions from CPU hotplug state and cpuset. All three should be
> synchronized so that there is one synchronzied way to obtain and apply the
> current effective mask.
>
> Thanks.
>

