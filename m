Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E578B6AB
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjH1RoY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 13:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjH1RoH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 13:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE611A
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693244598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c86heriCzsgHv8Cr404S+ZS20rU8EPrOqgUpkTE5NMI=;
        b=LjpZVQxxDsbtFV37kMU3PTEe17Qpp8E6g1kZirQb/LFu9GgSXWPO2JI+N40ciwe5Iy3WQZ
        Hmnv6qtxnCPypzCDdjm1AOsid1LIO9tYWbHUuh/dF7yeIi0R1KWLiK6HTEmNkbE2nukQih
        xOsJJ5hhdfCzUkO8F0u/DL2gnpcsw/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-mzQJchzgMYO4QXvwT8q-eA-1; Mon, 28 Aug 2023 13:43:10 -0400
X-MC-Unique: mzQJchzgMYO4QXvwT8q-eA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1D52855710;
        Mon, 28 Aug 2023 17:43:09 +0000 (UTC)
Received: from [10.22.18.125] (unknown [10.22.18.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF529401051;
        Mon, 28 Aug 2023 17:43:08 +0000 (UTC)
Message-ID: <820843a5-d7a5-91a9-b861-99e7132ddb98@redhat.com>
Date:   Mon, 28 Aug 2023 13:43:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
 <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
 <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
 <CAJD7tkZsGfYXkWM5aa67v3JytTO04LS7_x+ooMDK82cBZ-C8eQ@mail.gmail.com>
 <307cbcf6-dca2-0b5d-93e8-11368a931d2f@redhat.com>
In-Reply-To: <307cbcf6-dca2-0b5d-93e8-11368a931d2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 8/28/23 13:35, Waiman Long wrote:
> On 8/28/23 13:28, Yosry Ahmed wrote:
>> On Mon, Aug 28, 2023 at 10:27 AM Waiman Long <longman@redhat.com> wrote:
>>>
>>> On 8/28/23 13:07, Yosry Ahmed wrote:
>>>>> Here I agree with you. Let's go with the approach which is easy to
>>>>> undo for now. Though I prefer the new explicit interface for 
>>>>> flushing,
>>>>> that step would be very hard to undo. Let's reevaluate if the 
>>>>> proposed
>>>>> approach shows negative impact on production traffic and I think
>>>>> Cloudflare folks can give us the results soon.
>>>> Do you prefer we also switch to using a mutex (with preemption
>>>> disabled) to avoid the scenario Michal described where flushers give
>>>> up the lock and sleep resulting in an unbounded wait time in the worst
>>>> case?
>>> Locking with mutex with preemption disabled is an oxymoron. Use 
>>> spinlock
>>> if you want to have preemption disabled. The purpose of usiing mutex is
>>> to allow the lock owner to sleep, but you can't sleep with preemption
>>> disabled. You need to enable preemption first. You can disable
>>> preemption for a short time in a non-sleeping section of the lock
>>> critical section, but I would not recommend disabling preemption for 
>>> the
>>> whole critical section.
>> I thought using a mutex with preemption disabled would at least allow
>> waiters to sleep rather than spin, is this not correct (or doesn't
>> matter) ?
>
> Because of optimistic spinning, a mutex lock waiter will only sleep if 
> the lock holder sleep or when its time slice run out. So the waiters 
> are likely to spin for quite a while before they go to sleep.

Perhaps you can add a mutex at the read side so that only 1 reader can 
contend with the global rstat spinlock at any time if this is a concern.

Regards,
Longman

