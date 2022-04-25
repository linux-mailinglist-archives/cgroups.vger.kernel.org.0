Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4404150D66F
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 03:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiDYBEs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 24 Apr 2022 21:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiDYBEs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 24 Apr 2022 21:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BCC849F92
        for <cgroups@vger.kernel.org>; Sun, 24 Apr 2022 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650848504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5murYanTtEXbPZyarPU70weW32pWscxaeP6vQe3sXWI=;
        b=Nk8vKt9NxPLVeEFiEA7vFl0oTSwH5ZwQccvGwo1DHDeCyPH0TRKhslpYTflv/KGEuHGdAV
        fmCK2Ny/JcTmrx6lnxQibDqu1ZVbdKaKTaKpw4KkZaWGuOFWEwx11Cmvvd6EM0fO7tB8Gp
        SidHHmOc0aAudZZI5YOdFT4yVuYlIdk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-Cnei6zKlNruIH1kVOzyOwg-1; Sun, 24 Apr 2022 21:01:40 -0400
X-MC-Unique: Cnei6zKlNruIH1kVOzyOwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA4A1E18D44;
        Mon, 25 Apr 2022 01:01:40 +0000 (UTC)
Received: from [10.22.8.132] (unknown [10.22.8.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A437145B96B;
        Mon, 25 Apr 2022 01:01:39 +0000 (UTC)
Message-ID: <cd0b2d8c-1bbb-1da5-89f5-51abf5a8a6ce@redhat.com>
Date:   Sun, 24 Apr 2022 21:01:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220421145845.1044652-1-longman@redhat.com>
 <YmGHYNuAp8957ouq@carbon> <112a4d7f-bc53-6e59-7bb8-6fecb65d045d@redhat.com>
 <YmGbmrH/Hg1VJlUc@carbon> <58c41f14-356e-88dd-54aa-dc6873bf80ff@redhat.com>
 <YmITEEdEbaKCK3BN@FVFYT0MHHV2J.usts.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YmITEEdEbaKCK3BN@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/21/22 22:29, Muchun Song wrote:
> On Thu, Apr 21, 2022 at 02:46:00PM -0400, Waiman Long wrote:
>> On 4/21/22 13:59, Roman Gushchin wrote:
>>> On Thu, Apr 21, 2022 at 01:28:20PM -0400, Waiman Long wrote:
>>>> On 4/21/22 12:33, Roman Gushchin wrote:
>>>>> On Thu, Apr 21, 2022 at 10:58:45AM -0400, Waiman Long wrote:
>>>>>> For systems with large number of CPUs, the majority of the memory
>>>>>> consumed by the mem_cgroup structure is actually the percpu stats
>>>>>> memory. When a large number of memory cgroups are continuously created
>>>>>> and destroyed (like in a container host), it is possible that more
>>>>>> and more mem_cgroup structures remained in the dying state holding up
>>>>>> increasing amount of percpu memory.
>>>>>>
>>>>>> We can't free up the memory of the dying mem_cgroup structure due to
>>>>>> active references in some other places. However, the percpu stats memory
>>>>>> allocated to that mem_cgroup is a different story.
>>>>>>
>>>>>> This patch adds a new percpu_stats_disabled variable to keep track of
>>>>>> the state of the percpu stats memory. If the variable is set, percpu
>>>>>> stats update will be disabled for that particular memcg. All the stats
>>>>>> update will be forward to its parent instead. Reading of the its percpu
>>>>>> stats will return 0.
>>>>>>
>>>>>> The flushing and freeing of the percpu stats memory is a multi-step
>>>>>> process. The percpu_stats_disabled variable is set when the memcg is
>>>>>> being set to offline state. After a grace period with the help of RCU,
>>>>>> the percpu stats data are flushed and then freed.
>>>>>>
>>>>>> This will greatly reduce the amount of memory held up by dying memory
>>>>>> cgroups.
>>>>>>
>>>>>> By running a simple management tool for container 2000 times per test
>>>>>> run, below are the results of increases of percpu memory (as reported
>>>>>> in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.
>>>>> Hi Waiman!
>>>>>
>>>>> I've been proposing the same idea some time ago:
>>>>> https://lore.kernel.org/all/20190312223404.28665-7-guro@fb.com/T/ .
>>>>>
>>>>> However I dropped it with the thinking that with many other fixes
>>>>> preventing the accumulation of the dying cgroups it's not worth the added
>>>>> complexity and a potential cpu overhead.
>>>>>
>>>>> I think it ultimately comes to the number of dying cgroups. If it's low,
>>>>> memory savings are not worth the cpu overhead. If it's high, they are.
>>>>> I hope long-term to drive it down significantly (with lru-pages reparenting
>>>>> being the first major milestone), but it might take a while.
>>>>>
>>>>> I don't have a strong opinion either way, just want to dump my thoughts
>>>>> on this.
>>>> I have quite a number of customer cases complaining about increasing percpu
>>>> memory usages. The number of dying memcg's can go to tens of thousands. From
>>>> my own investigation, I believe that those dying memcg's are not freed
>>>> because they are pinned down by references in the page structure. I am aware
>>>> that we support the use of objcg in the page structure which will allow easy
>>>> reparenting, but most pages don't do that and it is not easy to do this
>>>> conversion and it may take quite a while to do that.
>>> The big question is whether there is a memory pressure on those systems.
>>> If yes, and the number of dying cgroups is growing, it's worth investigating.
>>> It might be due to the sharing of pagecache pages and this will be ultimately
>>> fixed with implementing of the pagecache reparenting. But it also might be due
>>> to other bugs, which are fixable, so it would be great to understand.
>>
>> Pagecache reparenting will probably fix the problem that I have seen. Is
>> someone working on this?
>>
> We also encountered dying cgroup issue on our servers for a long time.
> I have worked on this for a while and proposed a resolution [1] based
> on obj_cgroup APIs to charge the LRU pages.
>
> [1] https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/

Thanks for the pointer. I am interested in this patch series. Please cc 
me if you need to generate a new revision.

Cheers,
Longman

