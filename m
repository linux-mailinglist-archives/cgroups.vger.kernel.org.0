Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7C78E23B
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbjH3WUt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Aug 2023 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbjH3WUo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Aug 2023 18:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338FDCE6
        for <cgroups@vger.kernel.org>; Wed, 30 Aug 2023 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693433910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWMbXQ/6lKzvuk9wmWLP6Zov9vMWJLOe43uW9KJ/WLU=;
        b=Sc9jTOAz+O98u/aZdDHLY8KOqOcwB2lc8aVI5b5oITvCIHqBKkX4lnMKYdnal6Wl/ep5bh
        Zg3mF2v9tvXx/dO7RxFj79dM002hAp+6eemqf2/4BMY+GIaocH5Vz+zWUobVp8e8uPR7RC
        FLO6iCBX4nwwr52/LfSogtNE1MEguYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-oD30n1q1MZyT2nvb1Ws95A-1; Wed, 30 Aug 2023 16:01:17 -0400
X-MC-Unique: oD30n1q1MZyT2nvb1Ws95A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15484185A794;
        Wed, 30 Aug 2023 20:01:16 +0000 (UTC)
Received: from [10.22.10.212] (unknown [10.22.10.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD27C40C6F4C;
        Wed, 30 Aug 2023 20:01:14 +0000 (UTC)
Message-ID: <d0380dfa-ee2e-e492-38e3-31bf6644e511@redhat.com>
Date:   Wed, 30 Aug 2023 16:01:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH-cgroup v7 0/6] cgroup/cpuset: Support remote partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20230817132454.755459-1-longman@redhat.com>
 <ZO-X4KnEtOjhJffR@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZO-X4KnEtOjhJffR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/30/23 15:26, Tejun Heo wrote:
> Hello, Waiman.
>
> On Thu, Aug 17, 2023 at 09:24:48AM -0400, Waiman Long wrote:
>>   v7:
>>    - Fix a compilation problem in patch 1 & a memory allocation bug in
>>      patch 2.
>>    - Change exclusive_cpus type to cpumask_var_t to match other cpumasks
>>      and make code more consistent.
> This overall looks fine to me but I'm afraid we're a bit too late for this
> devel cycle. I'll merge these into cgroup/for-6.7 when it opens.

Yes, I am aware it is too late for v6.6. My current target is v6.7. BTW, 
I do have some minor twists to address some corner case issue. I will 
post a new version before the merge window close.

Thanks,
Longman

