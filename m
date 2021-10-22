Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3443737F
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJVINY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 04:13:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:40340 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbhJVINY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 22 Oct 2021 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=I94JF+1Ykb3U0G26LvnbC6EWbDpqVzT8bJcMB6mWzrA=; b=EmZl+hgNLkbPo1rB/Ms
        dotFtuMe+e6rzOv5Pz5/dmgyjg9fh/DFh2nJnICgZqxYqgNnjzLeZtfoXSMLl8vXc8eAm2Inc4c/z
        /bxHuu8lQdcxpbOB/W0t/hoxUrq6uHRKTBV2ZFvhi8q1U8hqxCRO46JREZtsA3uq+vZgLkaG0xc=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdpdl-006oMy-HF; Fri, 22 Oct 2021 11:11:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v2 0/2] memcg: prohibit unconditional exceeding the
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
References: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
Message-ID: <21d79b86-476c-a8f2-e950-2339606f1253@virtuozzo.com>
Date:   Fri, 22 Oct 2021 11:10:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
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
1) removes execution of out_of_memory() from pagefault_out_of_memory(),
   becasue nobody can explain why it is necessary.
2) allows memcg to fail the allocations of dying/killed tasks. 

v2: resplit,
    use old patch from Michal Hocko removing out_of_memory() from
      pagefault_out_of_memory()

Michal Hocko (1):
  mm, oom: do not trigger out_of_memory from the #PF

Vasily Averin (1):
  memcg: prohibit unconditional exceeding the limit of dying tasks

 mm/memcontrol.c | 27 ++++++++-------------------
 mm/oom_kill.c   | 23 ++++++++++-------------
 2 files changed, 18 insertions(+), 32 deletions(-)

-- 
2.32.0

