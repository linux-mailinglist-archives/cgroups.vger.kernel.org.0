Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850856EE7A7
	for <lists+cgroups@lfdr.de>; Tue, 25 Apr 2023 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDYSnk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Apr 2023 14:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjDYSnk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Apr 2023 14:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D84865A9
        for <cgroups@vger.kernel.org>; Tue, 25 Apr 2023 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682448173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVdh3EskhXvSNgkkcnc90XfD4jl5qJEnnEfhoKtnoTY=;
        b=Bp1B/HqRkNxqgs7x1H0vIpg1qHP22vA6kYFqoT3HGRj+7YFuae1SO7F8gMa8Y+NCMGZa5n
        NTqK9rCSeFMspub0CIy6E/14RBkkxRscWU4XGiTWoTEBhiyksNVXZ1X0zyut8tuZJpHFt9
        1HsI4OSGoNsguhzq/I7WGJ1dLubsEAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-KfNHFgMyN6mZnY5l4BRKRQ-1; Tue, 25 Apr 2023 14:42:50 -0400
X-MC-Unique: KfNHFgMyN6mZnY5l4BRKRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68C08A0F397;
        Tue, 25 Apr 2023 18:42:49 +0000 (UTC)
Received: from [10.22.8.189] (unknown [10.22.8.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 467CC2022ECD;
        Tue, 25 Apr 2023 18:42:47 +0000 (UTC)
Message-ID: <27e15be8-d0eb-ed32-a0ec-5ec9b59f1f27@redhat.com>
Date:   Tue, 25 Apr 2023 14:42:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        "T.J. Mercier" <tjmercier@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <CAJD7tkZw9uVPe5KH2xrihsv5nDmExJmkmsUPYP6Npvv6Q0NcVw@mail.gmail.com>
 <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/25/23 07:36, Yosry Ahmed wrote:
>   +David Rientjes +Greg Thelen +Matthew Wilcox
>
> On Tue, Apr 11, 2023 at 4:48 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>> On Tue, Apr 11, 2023 at 4:36 PM T.J. Mercier <tjmercier@google.com> wrote:
>>> When a memcg is removed by userspace it gets offlined by the kernel.
>>> Offline memcgs are hidden from user space, but they still live in the
>>> kernel until their reference count drops to 0. New allocations cannot
>>> be charged to offline memcgs, but existing allocations charged to
>>> offline memcgs remain charged, and hold a reference to the memcg.
>>>
>>> As such, an offline memcg can remain in the kernel indefinitely,
>>> becoming a zombie memcg. The accumulation of a large number of zombie
>>> memcgs lead to increased system overhead (mainly percpu data in struct
>>> mem_cgroup). It also causes some kernel operations that scale with the
>>> number of memcgs to become less efficient (e.g. reclaim).
>>>
>>> There are currently out-of-tree solutions which attempt to
>>> periodically clean up zombie memcgs by reclaiming from them. However
>>> that is not effective for non-reclaimable memory, which it would be
>>> better to reparent or recharge to an online cgroup. There are also
>>> proposed changes that would benefit from recharging for shared
>>> resources like pinned pages, or DMA buffer pages.
>> I am very interested in attending this discussion, it's something that
>> I have been actively looking into -- specifically recharging pages of
>> offlined memcgs.
>>
>>> Suggested attendees:
>>> Yosry Ahmed <yosryahmed@google.com>
>>> Yu Zhao <yuzhao@google.com>
>>> T.J. Mercier <tjmercier@google.com>
>>> Tejun Heo <tj@kernel.org>
>>> Shakeel Butt <shakeelb@google.com>
>>> Muchun Song <muchun.song@linux.dev>
>>> Johannes Weiner <hannes@cmpxchg.org>
>>> Roman Gushchin <roman.gushchin@linux.dev>
>>> Alistair Popple <apopple@nvidia.com>
>>> Jason Gunthorpe <jgg@nvidia.com>
>>> Kalesh Singh <kaleshsingh@google.com>
> I was hoping I would bring a more complete idea to this thread, but
> here is what I have so far.
>
> The idea is to recharge the memory charged to memcgs when they are
> offlined. I like to think of the options we have to deal with memory
> charged to offline memcgs as a toolkit. This toolkit includes:
>
> (a) Evict memory.
>
> This is the simplest option, just evict the memory.
>
> For file-backed pages, this writes them back to their backing files,
> uncharging and freeing the page. The next access will read the page
> again and the faulting process’s memcg will be charged.
>
> For swap-backed pages (anon/shmem), this swaps them out. Swapping out
> a page charged to an offline memcg uncharges the page and charges the
> swap to its parent. The next access will swap in the page and the
> parent will be charged. This is effectively deferred recharging to the
> parent.
>
> Pros:
> - Simple.
>
> Cons:
> - Behavior is different for file-backed vs. swap-backed pages, for
> swap-backed pages, the memory is recharged to the parent (aka
> reparented), not charged to the "rightful" user.
> - Next access will incur higher latency, especially if the pages are active.
>
> (b) Direct recharge to the parent
>
> This can be done for any page and should be simple as the pages are
> already hierarchically charged to the parent.
>
> Pros:
> - Simple.
>
> Cons:
> - If a different memcg is using the memory, it will keep taxing the
> parent indefinitely. Same not the "rightful" user argument.

Muchun had actually posted patch to do this last year. See

https://lore.kernel.org/all/20220621125658.64935-10-songmuchun@bytedance.com/T/#me9dbbce85e2f3c4e5f34b97dbbdb5f79d77ce147

I am wondering if he is going to post an updated version of that or not. 
Anyway, I am looking forward to learn about the result of this 
discussion even thought I am not a conference invitee.

Thanks,
Longman


