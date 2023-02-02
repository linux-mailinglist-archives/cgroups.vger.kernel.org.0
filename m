Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BC6873DF
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 04:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBBDfC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 22:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBBDfA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 22:35:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5439B976A
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 19:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675308853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J25aygLZYRtVKk3o+FCXZY8yPzqAyLq7HmtB3PexRQI=;
        b=U7jCvQtD8i3cdXcJ+fzSDfxKKEAXAOXsojcbqwsg91gOuQ/N8c8CAn8D+xoKfowCSTeuJs
        zdu4w5sZWGkAdvp21YrdyZvIP49s2NJeG5EZXQhCx11TLuWqGewgD/HoJQUf8zT7ilWCJV
        3m6AnyF9qBuA1sgCV47FQkQKGYsJvRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-QuSs4DsHPryOBrRHSCGjEQ-1; Wed, 01 Feb 2023 22:34:03 -0500
X-MC-Unique: QuSs4DsHPryOBrRHSCGjEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EEAA811E6E;
        Thu,  2 Feb 2023 03:34:02 +0000 (UTC)
Received: from [10.22.32.115] (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8238492B06;
        Thu,  2 Feb 2023 03:34:00 +0000 (UTC)
Message-ID: <773e2f22-211e-163f-64bb-15ae29ad161b@redhat.com>
Date:   Wed, 1 Feb 2023 22:34:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9rVVldS19oyIZ+g@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/1/23 16:10, Peter Zijlstra wrote:
> On Wed, Feb 01, 2023 at 01:46:11PM -0500, Waiman Long wrote:
>
>> Note that using cpus_allowed directly in cgroup v2 may not be right because
>> cpus_allowed may have no relationship to effective_cpus at all in some
>> cases, e.g.
>>
>>     root
>>      |
>>      V
>>      A (cpus_allowed = 1-4, effective_cpus = 1-4)
>>      |
>>      V
>>      B (cpus_allowed = 5-8, effective_cpus = 1-4)
>>
>> In the case of cpuset B, passing back cpus 5-8 as the allowed_cpus is wrong.
> I think my patch as written does the right thing here. Since the
> intersection of (1-4) and (5-8) is empty it will move up the hierarchy
> and we'll end up with (1-4) from the cgroup side of things.
>
> So the purpose of __cs_cpus_allowed() is to override the cpus_allowed of
> the root set and force it to cpu_possible_mask.
>
> Then cs_cpus_allowed() computes the intersection of cs->cpus_allowed and
> all it's parents. This will, in the case of B above, result in the empty
> mask.
>
> Then cpuset_cpus_allowed() has a loop that starts with
> task_cpu_possible_mask(), intersects that with cs_cpus_allowed() and if
> the intersection of that and cpu_online_mask is empty, moves up the
> hierarchy. Given cs_cpus_allowed(B) is the empty mask, we'll move to A.
>
> Note that since we force the mask of root to cpu_possible_mask,
> cs_cpus_allowed(root) will be a no-op and if we guarantee (in arch code)
> that cpu_online_mask always has a non-empty intersection with
> task_cpu_possible_mask(), this loop is guaranteed to terminate with a
> viable mask.

I will take a closer look at that tomorrow. I will be more comfortable 
ack'ing that if this is specific to v1 cpuset instead of applying this 
in both v1 and v2 since it is only v1 that is problematic.

Cheers,
Longman

