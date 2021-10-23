Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F44383FB
	for <lists+cgroups@lfdr.de>; Sat, 23 Oct 2021 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJWPEG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Oct 2021 11:04:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64545 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWPEG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Oct 2021 11:04:06 -0400
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19NF18CF008358;
        Sun, 24 Oct 2021 00:01:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 24 Oct 2021 00:01:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19NF17p2008355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Oct 2021 00:01:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from
 the #PF
To:     Vasily Averin <vvs@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
 <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e2a847a2-a414-2535-e3d1-b100a023b9d1@i-love.sakura.ne.jp>
Date:   Sun, 24 Oct 2021 00:01:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/23 22:20, Vasily Averin wrote:
>  /*
> - * The pagefault handler calls here because it is out of memory, so kill a
> - * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
> - * killing is already in progress so do nothing.
> + * The pagefault handler calls here because some allocation has failed. We have
> + * to take care of the memcg OOM here because this is the only safe context without
> + * any locks held but let the oom killer triggered from the allocation context care
> + * about the global OOM.
>   */

Excuse me for a stupid question. I consider

  if (!mutex_trylock(&oom_lock))
    return;
  out_of_memory(&oc);
  mutex_unlock(&oom_lock);

here as the last resort (safeguard) when neither __alloc_pages_may_oom()
nor mem_cgroup_out_of_memory() can make progress. This patch says

  let the oom killer triggered from the allocation context care
  about the global OOM.

but what if the OOM killer cannot be invoked from the allocation context?
Is there a guarantee that all memory allocations which might result in
VM_FAULT_OOM can invoke the OOM killer?
