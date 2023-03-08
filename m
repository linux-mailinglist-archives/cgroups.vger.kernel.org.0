Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B966B11EE
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCHTXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 14:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCHTW6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 14:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D8166D9
        for <cgroups@vger.kernel.org>; Wed,  8 Mar 2023 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678303326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkkE06gPelszJn5ap9H8D6EVIQTTr56lcIKZ6gaWuOU=;
        b=PhdPgdnj+UJTfwEzgRk8a+oJYQh4MlypGh6TcMB0BFCEzr4q7Phkf6zvU/59Mdj1e+ig0t
        gn0xgfx/zUkSn4rDtaRVR37xyUz+umHmkrOEQeHac3CTMyX9sKch53EYcCZ969EfEWs6/Q
        TTya/baCdig3E9UgDPKiI8wCzvtLqSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-WTeL5gRDMDyXkUMFrPIuKg-1; Wed, 08 Mar 2023 14:22:02 -0500
X-MC-Unique: WTeL5gRDMDyXkUMFrPIuKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A116800B23;
        Wed,  8 Mar 2023 19:22:01 +0000 (UTC)
Received: from [10.22.33.96] (unknown [10.22.33.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFCFF1121314;
        Wed,  8 Mar 2023 19:21:59 +0000 (UTC)
Message-ID: <5058560d-f193-971f-501e-1a4d8501dfc7@redhat.com>
Date:   Wed, 8 Mar 2023 14:21:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZAhhGi55BkYkc3ss@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/8/23 05:19, Juri Lelli wrote:
> On 01/03/23 17:03, Qais Yousef wrote:
>> On 03/01/23 15:26, Juri Lelli wrote:
>>> On 01/03/23 12:28, Qais Yousef wrote:
>>>> On 03/01/23 08:31, Juri Lelli wrote:
>>> ...
>>>
>>>>> Not ignoring you guys here, but it turns out I'm quite bogged down with
>>>>> other stuff at the moment. :/ So, apologies and I'll try to get to this
>>>>> asap. Thanks a lot for all your efforts and time reviewing so far!
>>>> Np, I can feel you :-)
>>> Eh. :/
>> I hope I did not offend. That was meant as no pressure, I understand.
> No offence at all! I meant "we are all on the same boat it seems". :)
>
>>> BTW, do you have a repro script of some sort handy I might play with?
>> Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
>> the time around the call and trace_printk'ed the result.
>>
>> I was working on a android phone which just suspends to ram if you turn the
>> screen off and disconnect the usb.
> Looks like I could come up with the following
>
> https://github.com/jlelli/linux.git deadline/rework-cpusets
> https://github.com/jlelli/linux/tree/deadline/rework-cpusets
>
> which I don't think it's at a point that I feel comfortable to propose
> as an RFC (not even sure if it actually makes sense), but it survived my
> very light testing.

I like your patch to revert the cpuset_rwsem change. In fact, I was 
planning to ask you about that. It is causing a lot more latency in 
workloads that need to change cpuset configuration rather frequently.

Cheers,
Longman

