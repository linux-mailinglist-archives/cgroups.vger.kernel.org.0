Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADA322022
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 20:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBVT26 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 14:28:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:41387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233094AbhBVTZn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 14:25:43 -0500
IronPort-SDR: EltXaYKtY04X2/3G4XuYWqwr7L7SVyLWUHR5vzkmF0ihH36CgMp0CcRm8/ewhg7fpIi6RT4pG0
 xfpysCpUSbhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="183847440"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="183847440"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 11:23:52 -0800
IronPort-SDR: RaY9gAVM1BH1UuQYP8Jx5AilW/WXuGS+KiwNANxgZWgz+mUuyJqDSIxVwt4albE5cAyFj+1M5s
 oPtfz/AT7Khw==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="389981629"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 11:23:51 -0800
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
 <e132f836-b5d5-3776-22d6-669e713983e4@linux.intel.com>
 <YDQBh5th9txxEFUm@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <1d8d4ec6-e97d-b7e5-695e-f189404a80fd@linux.intel.com>
Date:   Mon, 22 Feb 2021 11:23:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YDQBh5th9txxEFUm@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/22/21 11:09 AM, Michal Hocko wrote:
> On Mon 22-02-21 09:41:00, Tim Chen wrote:
>>
>>
>> On 2/22/21 12:40 AM, Michal Hocko wrote:
>>> On Fri 19-02-21 10:59:05, Tim Chen wrote:
>>  occurrence.
>>>>>
>>>>> Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
>>>>> If all events correspond with a newly charged memory and the last event
>>>>> was just about the soft limit boundary then we should be bound by 128k
>>>>> pages (512M and much more if this were huge pages) which is a lot!
>>>>> I haven't realized this was that much. Now I see the problem. This would
>>>>> be a useful information for the changelog.
>>>>>
>>>>> Your fix is focusing on the over-the-limit boundary which will solve the
>>>>> problem but wouldn't that lead to to updates happening too often in
>>>>> pathological situation when a memcg would get reclaimed immediatelly?
>>>>
>>>> Not really immediately.  The memcg that has the most soft limit excess will
>>>> be chosen for page reclaim, which is the way it should be.  
>>>> It is less likely that a memcg that just exceeded
>>>> the soft limit becomes the worst offender immediately. 
>>>
>>> Well this all depends on when the the soft limit reclaim triggeres. In
>>> other words how often you see the global memory reclaim. If we have a
>>> memcg with a sufficient excess then this will work mostly fine. I was more
>>> worried about a case when you have memcgs just slightly over the limit
>>> and the global memory pressure is a regular event. You can easily end up
>>> bouncing memcgs off and on the tree in a rapid fashion. 
>>>
>>
>> If you are concerned about such a case, we can add an excess threshold,
>> say 4 MB (or 1024 4K pages), before we trigger a forced update. You think
>> that will cover this concern?
> 
> Yes some sort of rate limiting should help. My understanding has been
> that this is the main purpose of the even counting threshold. The code
> as we have doesn't seem to work properly so there are two ways, either
> tune the existing threshold or replace it by something else. Having both
> a force update and non-functional threshold is not a great outcome.
> 

The event counting threshold's purpose is to limit the *rate*  of event update.  The
side effect is we will miss some update by the sampling nature.  However, we can't
afford to let the sampling go to frequent or the overhead will be too much.

The forced update makes sure that a needed update happens 
to put the memcg on the tree happens and we don't allow the
memcg to escape page reclaim even if the update happens relatively rarely.  Lowering
the threshold does not guarantee that the update happens, resulting in a runaway
memcg.  The forced update and threshold serves different purpose. In my opinion
the forced update is necessary.  We can keep the update overhead low with
low update rate, and yet make sure that a needed update happens.  I think both
are necessary for proper function.  The overhead from the forced update
is negligible and I don't a downside adding it. 

Tim
