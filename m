Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5212406C9D
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhIJNG2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 09:06:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53608 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhIJNG2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 09:06:28 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18AD4xAZ078287;
        Fri, 10 Sep 2021 22:04:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 10 Sep 2021 22:04:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18AD4wYq078273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 22:04:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
Date:   Fri, 10 Sep 2021 22:04:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/09/10 21:39, Vasily Averin wrote:
> The kernel currently allows dying tasks to exceed the memcg limits.
> The allocation is expected to be the last one and the occupied memory
> will be freed soon.
> This is not always true because it can be part of the huge vmalloc
> allocation. Allowed once, they will repeat over and over again.
> Moreover lifetime of the allocated object can differ from
> In addition the lifetime of the dying task.

Can't we add fatal_signal_pending(current) test to vmalloc() loop?

> Multiple such allocations running concurrently can not only overuse
> the memcg limit, but can lead to a global out of memory and,
> in the worst case, cause the host to panic.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
