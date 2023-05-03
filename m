Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC156F611A
	for <lists+cgroups@lfdr.de>; Thu,  4 May 2023 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjECWPv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWPu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 18:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329228A42
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 15:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F8D863043
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 22:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72809C433EF;
        Wed,  3 May 2023 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683152145;
        bh=+ocrPAkOdQyItdTxvvDTbqSS5GMs2VRphMsyKFbsZMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3duYVZPAF/mrKdE8OyWA9MtJurowlEptwZBbkzO1iXsIfpGROqYKbwRviOgeNhui
         ZQ1inuPL+Ub6XYeT596m6Y+o4ok0jIFutl791I/9eg71Zeq+gW/UCiN8NyoJFuib8F
         gyAPFXtRd6dJ3Gayl3HET/k8/x9kfHDAwH694ypfoT+MoGVVZ3BibDVMtbyORtRl5J
         gOPRl8F2pB4npD5dBtb5/frwPTnt8aZeKhMYfq2/2CtxTj2xBYBpcZmZ3689XXztUD
         ZRsQNikB13XNml3M40l2GSFvelBi9ODM+WY6e5896VnGsEC+GtwvuqNrCQOfYGZJiB
         v6Wr0M5kTiK+A==
Date:   Wed, 3 May 2023 15:15:43 -0700
From:   Chris Li <chrisl@kernel.org>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZFLdDyHoIdJSXJt+@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi T.J.,

On Tue, Apr 11, 2023 at 04:36:37PM -0700, T.J. Mercier wrote:
> When a memcg is removed by userspace it gets offlined by the kernel.
> Offline memcgs are hidden from user space, but they still live in the
> kernel until their reference count drops to 0. New allocations cannot
> be charged to offline memcgs, but existing allocations charged to
> offline memcgs remain charged, and hold a reference to the memcg.
> 
> As such, an offline memcg can remain in the kernel indefinitely,
> becoming a zombie memcg. The accumulation of a large number of zombie
> memcgs lead to increased system overhead (mainly percpu data in struct
> mem_cgroup). It also causes some kernel operations that scale with the
> number of memcgs to become less efficient (e.g. reclaim).
> 
> There are currently out-of-tree solutions which attempt to
> periodically clean up zombie memcgs by reclaiming from them. However
> that is not effective for non-reclaimable memory, which it would be
> better to reparent or recharge to an online cgroup. There are also
> proposed changes that would benefit from recharging for shared
> resources like pinned pages, or DMA buffer pages.

I am also interested in this topic. T.J. and I have some offline
discussion about this. We have some proposals to solve this
problem.

I will share the write up here for the up coming LSF/MM discussion.


Shared Memory Cgroup Controllers

= Introduction

The current memory cgroup controller does not support shared memory objects. For the memory that is shared between different processes, it is not obvious which process should get charged. Google has some internal tmpfs “memcg=” mount option to charge tmpfs data to  a specific memcg that’s often different from where charging processes run. However it faces some difficulties when the charged memcg exits and the charged memcg becomes a zombie memcg.
Other approaches include “re-parenting” the memcg charge to the parent memcg. Which has its own problem. If the charge is huge, iteration of the reparenting can be costly.

= Proposed Solution

The proposed solution is to add a new type of memory controller for shared memory usage. E.g. tmpfs, hugetlb, file system mmap and dma_buf. This shared memory cgroup controller object will have the same life cycle of the underlying  shared memory.

Processes can not be added to the shared memory cgroup. Instead the shared memory cgroup can be added to the memcg using a “smemcg” API file, similar to adding a process into the “tasks” API file.
When a smemcg is added to the memcg, the amount of memory that has been shared in the memcg process will be accounted for as the part of the memcg “memory.current”.The memory.current of the memcg is make up of two parts, 1) the processes anonymous memory and 2) the memory shared from smemcg.

When the memcg “memory.current” is raised to the limit. The kernel will active try to reclaim for the memcg to make “smemcg memory + process anonymous memory” within the limit. Further memory allocation within those memcg processes will fail if the limit can not be followed. If many reclaim attempts fail to bring the memcg “memory.current” within the limit, the process in this memcg will get OOM killed.

= Benefits

The benefits of this solution include:
* No zombie memcg. The life cycle of the smemcg match the share memory file system or dma_buf.
* No reparenting. The shared memory only charge once to the smemcg object. A memcg can include a smemcg to as part of the memcg memory usage. When process exit and memcg get deleted, the charge remain to the smemcg object.
* Much cleaner mental model of the smemcg, each share memory page is charge to one smemcg only once.
* Notice the same smemcg can add to more than one memcg. It can better describe the shared memory relation.

Chris



> Suggested attendees:
> Yosry Ahmed <yosryahmed@google.com>
> Yu Zhao <yuzhao@google.com>
> T.J. Mercier <tjmercier@google.com>
> Tejun Heo <tj@kernel.org>
> Shakeel Butt <shakeelb@google.com>
> Muchun Song <muchun.song@linux.dev>
> Johannes Weiner <hannes@cmpxchg.org>
> Roman Gushchin <roman.gushchin@linux.dev>
> Alistair Popple <apopple@nvidia.com>
> Jason Gunthorpe <jgg@nvidia.com>
> Kalesh Singh <kaleshsingh@google.com>
> 
