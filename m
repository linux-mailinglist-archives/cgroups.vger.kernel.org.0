Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2041D321E64
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhBVRnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 12:43:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:29440 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231644AbhBVRmu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 12:42:50 -0500
IronPort-SDR: 5rUtFtpRtc52ko5CY/G0g/JoAVg1aKooRhxgJHyRXgvt+wQylffLpEpmQzkQLDDgxqsMrXwDOC
 PpcaddLlpdYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="164366184"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="164366184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:41:01 -0800
IronPort-SDR: x97tSTHLw4Sn7xuu5atwz6IoejJVqQUYJFViPiDxfERnyagSlf47L+CRxTykHeoiv9PjHZqie/
 loEFB6DK4FDw==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="389941175"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:41:00 -0800
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
 <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
 <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
Date:   Mon, 22 Feb 2021 09:41:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YDNuAIztiGJpLEtw@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/22/21 12:40 AM, Michal Hocko wrote:
> On Fri 19-02-21 10:59:05, Tim Chen wrote:
 occurrence.
>>>
>>> Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
>>> If all events correspond with a newly charged memory and the last event
>>> was just about the soft limit boundary then we should be bound by 128k
>>> pages (512M and much more if this were huge pages) which is a lot!
>>> I haven't realized this was that much. Now I see the problem. This would
>>> be a useful information for the changelog.
>>>
>>> Your fix is focusing on the over-the-limit boundary which will solve the
>>> problem but wouldn't that lead to to updates happening too often in
>>> pathological situation when a memcg would get reclaimed immediatelly?
>>
>> Not really immediately.  The memcg that has the most soft limit excess will
>> be chosen for page reclaim, which is the way it should be.  
>> It is less likely that a memcg that just exceeded
>> the soft limit becomes the worst offender immediately. 
> 
> Well this all depends on when the the soft limit reclaim triggeres. In
> other words how often you see the global memory reclaim. If we have a
> memcg with a sufficient excess then this will work mostly fine. I was more
> worried about a case when you have memcgs just slightly over the limit
> and the global memory pressure is a regular event. You can easily end up
> bouncing memcgs off and on the tree in a rapid fashion. 
> 

If you are concerned about such a case, we can add an excess threshold,
say 4 MB (or 1024 4K pages), before we trigger a forced update. You think
that will cover this concern?

>>>
>>> One way around that would be to lower the SOFTLIMIT_EVENTS_TARGET. Have
>>> you tried that? Do we even need a separate treshold for soft limit, why
>>> cannot we simply update the tree each MEM_CGROUP_TARGET_THRESH?
>>>  
>>
>> Lowering the threshold is a band aid that really doesn't fix the problem.
>> I found that if the cgroup touches the memory infrequently enough, you
>> could still miss the update of it.  And in the mean time, you are updating
>> things a lot more frequently with added overhead.
> 
> Yes, I agree this is more of a workaround than a fix but I would rather
> go and touch the threshold which is simply bad than play more tricks
> which can lead to other potential problems. All that for a feature which
> is rarely used and quite problematic in itself. Not sure what Johannes
> thinks about that.
> 

I actually have tried adjusting the threshold but found that it doesn't work well for
the case with unenven memory access frequency between cgroups.  The soft
limit for the low memory event cgroup could creep up quite a lot, exceeding
the soft limit by hundreds of MB, even
if I drop the SOFTLIMIT_EVENTS_TARGET from 1024 to something like 8.

Tim
