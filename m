Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAA50A716
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 19:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356393AbiDURbU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352322AbiDURbT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 13:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D21BF44766
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650562107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2uOipi3GKnpM62yNx2qLO8Kw4BDhZHaF3HCYYZ6xuI=;
        b=OIdPswRC36WWPIzCIPr5AtdFYC4T8/w+g2KXunJhSvUd9kA8fOigUv9jjZSn4mzwFk9O/i
        Fy4KDwsBDlordBv9DzxiXwh8jovrULaZkTOOSbzZxafpOIRF9K9tIl/6uCtyRT87gbtFrS
        i5K8obDIBhz9B8ViwQOCjj3jBtbCOa8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-osLykL0TPRmq8Lq9ucUMbQ-1; Thu, 21 Apr 2022 13:28:22 -0400
X-MC-Unique: osLykL0TPRmq8Lq9ucUMbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B68981C07386;
        Thu, 21 Apr 2022 17:28:21 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B788C28126;
        Thu, 21 Apr 2022 17:28:21 +0000 (UTC)
Message-ID: <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
Date:   Thu, 21 Apr 2022 13:28:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220421145845.1044652-1-longman@redhat.com>
 <YmGHYNuAp8957ouq@carbon>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YmGHYNuAp8957ouq@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/21/22 12:33, Roman Gushchin wrote:
> On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
>> For systems with large number of CPUs, the majority of the memory
>> consumed by the mem_cgroup structure is actually the percpu stats
>> memory. When a large number of memory cgroups are continuously created
>> and destroyed (like in a container host), it is possible that more
>> and more mem_cgroup structures remained in the dying state holding up
>> increasing amount of percpu memory.
>>
>> We can't free up the memory of the dying mem_cgroup structure due to
>> active references in some other places. However, the percpu stats memory
>> allocated to that mem_cgroup is a different story.
>>
>> This patch adds a new percpu_stats_disabled variable to keep track of
>> the state of the percpu stats memory. If the variable is set, percpu
>> stats update will be disabled for that particular memcg. All the stats
>> update will be forward to its parent instead. Reading of the its percpu
>> stats will return 0.
>>
>> The flushing and freeing of the percpu stats memory is a multi-step
>> process. The percpu_stats_disabled variable is set when the memcg is
>> being set to offline state. After a grace period with the help of RCU,
>> the percpu stats data are flushed and then freed.
>>
>> This will greatly reduce the amount of memory held up by dying memory
>> cgroups.
>>
>> By running a simple management tool for container 2000 times per test
>> run, below are the results of increases of percpu memory (as reported
>> in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.
> Hi Waiman!
>
> I've been proposing the same idea some time ago:
> https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .
>
> However I dropped it with the thinking that with many other fixes
> preventing the accumulation of the dying cgroups it's not worth the added
> complexity and a potential cpu overhead.
>
> I think it ultimately comes to the number of dying cgroups. If it's low,
> memory savings are not worth the cpu overhead. If it's high, they are.
> I hope long-term to drive it down significantly (with lru-pages reparenting
> being the first major milestone), but it might take a while.
>
> I don't have a strong opinion either way, just want to dump my thoughts
> on this.

I have quite a number of customer cases complaining about increasing 
percpu memory usages. The number of dying memcg's can go to tens of 
thousands. From my own investigation, I believe that those dying memcg's 
are not freed because they are pinned down by references in the page 
structure. I am aware that we support the use of objcg in the page 
structure which will allow easy reparenting, but most pages don't do 
that and it is not easy to do this conversion and it may take quite a 
while to do that.

In term of overhead, it is mostly one more memory read from the 
mem_cgroup structure in the update path. I don't expect there will be 
that many updates when the memcg is in an offline state as updates will 
be slower in this case. Freeing the dying memcg will take a bit longer 
though, but its impact on the overall system performance should still be 
negligible.

I am also thinking about using a static_key for turning it on only for 
systems with more than, say, 20 cpus as the percpu memory overhead 
increases linearly with the number of possible cpus.

Any other suggestions and improvements are welcome.

Cheers,
Longman

