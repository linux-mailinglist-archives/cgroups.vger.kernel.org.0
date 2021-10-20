Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A6434AE3
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTMOU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:14:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:41610 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhJTMOR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 08:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Ogt0vQ4+gupep/lvDlFo1PXQW0DADnBHbHdATcZzm20=; b=bAVEJIxgSYk7Fvn45dl
        zabDL0FPXFzAupZNKZRT+F3njJTT6tY9TEmQJfiWXuyPNfiAgrA40jD02Ij0xywkyAmFyWwkgp9WE
        ArvtFI3nv6lb059uOy/T3Eck744pZCN7U6fYnWGjpyp72IRxDyJtspl6cWMLMCGZo3CyD2VdEsg=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdARo-006b83-7l; Wed, 20 Oct 2021 15:11:56 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg RFC 0/3] memcg: prohibit unconditional exceeding the
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
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
Message-ID: <fe1d45a1-276d-b0f4-fb71-8f5c1a9e8872@virtuozzo.com>
Date:   Wed, 20 Oct 2021 15:11:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Michal,
as you requested, I splited v4 patch version into 3 separate parts.
Let's discuss each of them.

Open questions/ToDo:

- Update patch descriptions (and add some comments) 

- in part 2 aka "memcg: remove charge forcinig for dying tasks":
  should we keep task_is_dying() in mem_cgroup_out_of_memory() ?

- in part 3 aka "memcg: handle memcg oom failures"
   what is the best way to notify pagefault_out_of_memory() about 
    mem_cgroup_out_of_memory failure ?
    
- what is the best way to handle memcg failure doe to kmem limit,
    it can trigger false global OOM

Vasily Averin (3):
  mm: do not firce global OOM from inside dying tasks
  memcg: remove charge forcinig for dying tasks
  memcg: handle memcg oom failures

 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++---------------------
 mm/oom_kill.c   |  3 +++
 2 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.32.0

