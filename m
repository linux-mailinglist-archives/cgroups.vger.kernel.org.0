Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6618831FF23
	for <lists+cgroups@lfdr.de>; Fri, 19 Feb 2021 20:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSTBK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Feb 2021 14:01:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:31784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhBSTBI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 19 Feb 2021 14:01:08 -0500
IronPort-SDR: PaqsFw1mDJiPp332sbO256QKgggWn8YKVNiusLijRBsPLBLoJMFUqOeI1Ff0Q+h8pmPS7sc4MN
 DWLHf26T2I5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163714562"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="163714562"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 10:59:07 -0800
IronPort-SDR: ydQjHIvRVWQzSbtxEkBhnUQPSo9AYdN4OeN+tifCiaNeCb1Aj2HAAXQSv7DrzF4eB5Hl8v+5wj
 jAl7jBKIZnaw==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="378989329"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.10.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 10:59:07 -0800
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <06f1f92f1f7d4e57c4e20c97f435252c16c60a27.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
Date:   Fri, 19 Feb 2021 10:59:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC+ApsntwnlVfCuK@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/19/21 1:11 AM, Michal Hocko wrote:
> On Wed 17-02-21 12:41:35, Tim Chen wrote:

>> Memory is accessed at a much lower frequency
>> for the second cgroup.  The memcg event update was not triggered for the
>> second cgroup as the memcg event update didn't happened on the 1024th sample.
>> The second cgroup was not placed on the soft limit tree and we didn't
>> try to reclaim the excess pages.
>>
>> As time goes on, we saw that the first cgroup was kept close to its
>> soft limit due to reclaim activities, while the second cgroup's memory
>> usage slowly creep up as it keeps getting missed from the soft limit tree
>> update as the update didn't fall on the modulo 1024 sample.  As a result,
>> the memory usage of the second cgroup keeps growing over the soft limit
>> for a long time due to its relatively rare occurrence.
> 
> Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
> If all events correspond with a newly charged memory and the last event
> was just about the soft limit boundary then we should be bound by 128k
> pages (512M and much more if this were huge pages) which is a lot!
> I haven't realized this was that much. Now I see the problem. This would
> be a useful information for the changelog.
> 
> Your fix is focusing on the over-the-limit boundary which will solve the
> problem but wouldn't that lead to to updates happening too often in
> pathological situation when a memcg would get reclaimed immediatelly?

Not really immediately.  The memcg that has the most soft limit excess will
be chosen for page reclaim, which is the way it should be.  
It is less likely that a memcg that just exceeded
the soft limit becomes the worst offender immediately.  With the fix, we make
sure that it is on the bad guys list and will not be ignored and be chosen
eventually for reclaim.  It will not sneakily increase its memory usage
slowly.   

> 
> One way around that would be to lower the SOFTLIMIT_EVENTS_TARGET. Have
> you tried that? Do we even need a separate treshold for soft limit, why
> cannot we simply update the tree each MEM_CGROUP_TARGET_THRESH?
>  

Lowering the threshold is a band aid that really doesn't fix the problem.
I found that if the cgroup touches the memory infrequently enough, you
could still miss the update of it.  And in the mean time, you are updating
things a lot more frequently with added overhead.

Tim
