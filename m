Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB2436507
	for <lists+cgroups@lfdr.de>; Thu, 21 Oct 2021 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhJUPIM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Oct 2021 11:08:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:42168 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhJUPIK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 21 Oct 2021 11:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=AYjhXpu3d6kOZxLRp2DlsnHvgXfNmVMqUthXj2mtzdE=; b=SW7BgefMYeIgcg9wr
        tbO/vMTgWtXtJGnhebekO+7U9ELGuifOlYecO7GEMUO4C+EC71xqXSXzmfgl4CEXJ7bB4i9EiKsX5
        ymCQGp9TN7AN3ra6WwRwJRkjbXQ4RQtWOgAC7WEayaqg6QpuvFQ71toI3mt2NHcnRbAjJPIHzi8Po
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdZdd-006kE4-S3; Thu, 21 Oct 2021 18:05:49 +0300
Subject: Re: [PATCH memcg 3/3] memcg: handle memcg oom failures
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
 <YXATW7KsUZzbbGHy@dhcp22.suse.cz>
 <d3b32c72-6375-f755-7599-ab804719e1f6@virtuozzo.com>
 <YXFPSvGFV539OcEk@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <b618ac5c-e982-c4af-ecf3-564b8de52c8c@virtuozzo.com>
Date:   Thu, 21 Oct 2021 18:05:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXFPSvGFV539OcEk@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 21.10.2021 14:49, Michal Hocko wrote:
> I do understand that handling a very specific case sounds easier but it
> would be better to have a robust fix even if that requires some more
> head scratching. So far we have collected several reasons why the it is
> bad to trigger oom killer from the #PF path. There is no single argument
> to keep it so it sounds like a viable path to pursue. Maybe there are
> some very well hidden reasons but those should be documented and this is
> a great opportunity to do either of the step.
> 
> Moreover if it turns out that there is a regression then this can be
> easily reverted and a different, maybe memcg specific, solution can be
> implemented.

Now I'm agree,
however I still have a few open questions.

1) VM_FAULT_OOM may be triggered w/o execution of out_of_memory()
for exampel it can be caused by incorrect vm fault operations, 
(a) which can return this error without calling allocator at all.
(b) or which can provide incorrect gfp flags and allocator can fail without execution of out_of_memory.
(c) This may happen on stable/LTS kernels when successful allocation was failed by hit into limit of legacy memcg-kmem contoller.
We'll drop it in upstream kernels, however how to handle it in old kenrels?

We can make sure that out_of_memory or alocator was called by set of some per-task flags.

Can pagefault_out_of_memory() send itself a SIGKILL in all these cases?

If not -- task will be looped. 
It is much better than execution of global OOM, however it would be even better to avoid it somehow.

You said: "We cannot really kill the task if we could we would have done it by the oom killer already".
However what to do if we even not tried to use oom-killer? (see (b) and (c)) 
or if we did not used the allocator at all (see (a))

2) in your patch we just exit from pagefault_out_of_memory(). and restart new #PF.
We can call schedule_timeout() and wait some time before a new #PF restart.
Additionally we can increase this delay in each new cycle. 
It helps to save CPU time for other tasks.
What do you think about?

Thank you,
	Vasily Averin
