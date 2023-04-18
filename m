Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2806E6735
	for <lists+cgroups@lfdr.de>; Tue, 18 Apr 2023 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjDROcT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Apr 2023 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDROcS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Apr 2023 10:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4213FA4
        for <cgroups@vger.kernel.org>; Tue, 18 Apr 2023 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681828297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Obc8o7+Jc2/xwzIMnjHntcd92yYzpwyuQHbYi3m2V4g=;
        b=gBE/jNRMTBVX7TaIAmVeObUB6kaHr1z/bvgPE6Tq1ttFup8l5ZpJNVogf3dI/dafeQ9oY5
        jZ9sJV5F5w2OXBdtxjaS00FA55+BLOqgPdsaqIyhWVjs+7WUibXQbO0YYLpdtNPdOADPS2
        Njrt04Es7F+zotx7qwJ0VjmjbNHS8uE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-JXl42fi3NSi0HJY4UsjPfQ-1; Tue, 18 Apr 2023 10:31:34 -0400
X-MC-Unique: JXl42fi3NSi0HJY4UsjPfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E43D88B7AA;
        Tue, 18 Apr 2023 14:31:29 +0000 (UTC)
Received: from [10.22.34.98] (unknown [10.22.34.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44BD540C6E70;
        Tue, 18 Apr 2023 14:31:27 +0000 (UTC)
Message-ID: <eda74c03-bde2-bb51-2b0d-df2097215696@redhat.com>
Date:   Tue, 18 Apr 2023 10:31:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth
 restoration
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230418141127.zbvsf7lwk27zvipt@airbuntu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230418141127.zbvsf7lwk27zvipt@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/18/23 10:11, Qais Yousef wrote:
> On 03/29/23 14:55, Juri Lelli wrote:
>> Qais reported [1] that iterating over all tasks when rebuilding root
>> domains for finding out which ones are DEADLINE and need their bandwidth
>> correctly restored on such root domains can be a costly operation (10+
>> ms delays on suspend-resume). He proposed we skip rebuilding root
>> domains for certain operations, but that approach seemed arch specific
>> and possibly prone to errors, as paths that ultimately trigger a rebuild
>> might be quite convoluted (thanks Qais for spending time on this!).
>>
>> To fix the problem
>>
>>   01/06 - Rename functions deadline with DEADLINE accounting (cleanup
>>           suggested by Qais) - no functional change
>>   02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
>>           from scheduler operations - and we also fix some problems
>>           associated to percpu_cpuset_rwsem)
>>   03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
>>   04/06 - Create DL BW alloc, free & check overflow interface for bulk
>>           bandwidth allocation/removal - no functional change
>>   05/06 - Fix bandwidth allocation handling for cgroup operation
>>           involving multiple tasks
>>   06/06 - Use this information to only perform the costly iteration if
>>           DEADLINE tasks are actually present in the cpuset for which a
>>           corresponding root domain is being rebuilt
>>
>> With respect to the RFC posting [2]
>>
>>   1 - rename DEADLINE bandwidth accounting functions - Qais
>>   2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
>>   3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
>>       contributed by Dietmar
>>
>> This set is also available from
>>
>> https://github.com/jlelli/linux.git deadline/rework-cpusets
> Is this just waiting to be picked up or still there's something to be addressed
> still?

There are some changes to cpuset code recently and so I believe that 
this patch series may need to be refreshed to reconcile the changes.

Thanks,
Longman

