Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1C4383C4
	for <lists+cgroups@lfdr.de>; Sat, 23 Oct 2021 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhJWNVo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Oct 2021 09:21:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:56328 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhJWNVn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 23 Oct 2021 09:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=8UnnDRqw1eQkdViplyQTAIcge1Yu9hofXdZZzzuk4p0=; b=lrFx+iduxqiGySqgByy
        T0lniizeMHv+jFlBbTcd2TPw3FbwrptbgYNOU6RQPkGI+3qEEgilJNCu2is/MGSSvf2+RFMv71ppi
        2oPcHrmYKnwRhHJ0ns9KfeowxcMTEUe3AXgBk2zuv+cnZ14iTt4Jy7+VFxIuXnYugopxOyL20Bw=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1meGvf-006vPv-Fv; Sat, 23 Oct 2021 16:19:19 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v3 0/3] memcg: prohibit unconditional exceeding the
 limit of dying tasks
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
Message-ID: <20e50917-3589-bcb7-0174-b6fccfd15c66@virtuozzo.com>
Date:   Sat, 23 Oct 2021 16:18:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Memory cgroup charging allows killed or exiting tasks to exceed the hard
limit. It can be misused and allow to trigger global OOM from inside
memcg-limited container. On the other hand if memcg fail allocation,
called from inside #PF handler it trigger global OOM from inside
pagefault_out_of_memory().

To prevent these problems this patch set:
a) removes execution of out_of_memory() from pagefault_out_of_memory(),
   becasue nobody can explain why it is necessary.
b) allow memcg to fail allocation of dying/killed tasks.

v3: resplit, improved patch descriptions
v2: resplit,
    use old patch from Michal Hocko removing out_of_memory() from
      pagefault_out_of_memory()


Michal Hocko (1):
  mm, oom: do not trigger out_of_memory from the #PF

Vasily Averin (2):
  mm, oom: pagefault_out_of_memory: don't force global OOM for dying
    tasks
  memcg: prohibit unconditional exceeding the limit of dying tasks

 mm/memcontrol.c | 27 ++++++++-------------------
 mm/oom_kill.c   | 23 ++++++++++-------------
 2 files changed, 18 insertions(+), 32 deletions(-)

-- 
2.32.0

