Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975A78C848
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjH2PG2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjH2PGV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 11:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9D1B7
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693321534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZA14b/tmA/wTpAgcSwxLG1sI93f6oKp/7oBZg84XpyU=;
        b=armjlI/aeAzGEG1+k5MO+52MyJGrdP2n+l/aDtGiPuYLNmWOZ3XquIYP+P2cuVNvYhhS+m
        YbaeIK8ZjVhJyGU949DNdL8RHSEDzXtUT2LMZ8Sx7gk/X7utWmKf6GAulp5eNI7GZX5PXO
        1h18k3ZCfNUGUT1bfbdFEvZru1jicgQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-3ooSx6BrNa-TgUQ_eCcCgw-1; Tue, 29 Aug 2023 11:05:30 -0400
X-MC-Unique: 3ooSx6BrNa-TgUQ_eCcCgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 536141C0CCB6;
        Tue, 29 Aug 2023 15:05:29 +0000 (UTC)
Received: from [10.22.16.214] (unknown [10.22.16.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94F54140E950;
        Tue, 29 Aug 2023 15:05:28 +0000 (UTC)
Message-ID: <5906501e-4dff-4c66-7ab3-e9193d312270@redhat.com>
Date:   Tue, 29 Aug 2023 11:05:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
 <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
 <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
 <ZO2d7dT8gulMyb8g@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZO2d7dT8gulMyb8g@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/29/23 03:27, Michal Hocko wrote:
> On Mon 28-08-23 13:27:23, Waiman Long wrote:
>> On 8/28/23 13:07, Yosry Ahmed wrote:
>>>> Here I agree with you. Let's go with the approach which is easy to
>>>> undo for now. Though I prefer the new explicit interface for flushing,
>>>> that step would be very hard to undo. Let's reevaluate if the proposed
>>>> approach shows negative impact on production traffic and I think
>>>> Cloudflare folks can give us the results soon.
>>> Do you prefer we also switch to using a mutex (with preemption
>>> disabled) to avoid the scenario Michal described where flushers give
>>> up the lock and sleep resulting in an unbounded wait time in the worst
>>> case?
>> Locking with mutex with preemption disabled is an oxymoron.
> I believe Yosry wanted to disable preemption _after_ the lock is taken
> to reduce the time spent while it is held. The idea to use the mutex is
> to reduce spinning and more importantly to get rid of lock dropping
> part. It is not really clear (but unlikely) we can drop it while
> preserving the spinlock as the thing scales with O(#cgroups x #cpus)
> in the worst case.

As I have said later in my email, I am not against disabling preemption 
selectively on some parts of the lock critical section where preemption 
is undesirable. However, I am against disabling preemption for the whole 
duration of the code where the mutex lock is held as it defeats the 
purpose of using mutex in the first place.

Cheers,
Longman

