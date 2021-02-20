Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBD32061F
	for <lists+cgroups@lfdr.de>; Sat, 20 Feb 2021 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBTQZI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 Feb 2021 11:25:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:17962 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhBTQZI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 20 Feb 2021 11:25:08 -0500
IronPort-SDR: tcVOF3jv+LgyBsuwW8JvDcxsSx764QttOgsRqV3I7W6LAKH9ie/1+mMM87QDU/muQpXkrxUUmI
 qtnrdb3w403A==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="180609299"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="180609299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:23:20 -0800
IronPort-SDR: umqKPvJnXSIFFoaWTBibCca5qVsWhPWL6JAy4xcv1E154Rnw1e7JthfFOHL/gwkdxeOeBtTD89
 xRN3KZ6zILFg==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="401566446"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:23:20 -0800
Subject: Re: [PATCH v2 2/3] mm: Force update of mem cgroup soft limit tree on
 usage excess
From:   Tim Chen <tim.c.chen@linux.intel.com>
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
Message-ID: <0f8117ef-c461-e2be-ea7a-6cbf727c9bb5@linux.intel.com>
Date:   Sat, 20 Feb 2021 08:23:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <884d7559-e118-3773-351d-84c02642ca96@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/19/21 10:59 AM, Tim Chen wrote:
> 
> 
> On 2/19/21 1:11 AM, Michal Hocko wrote:

>>
>> Soft limit is evaluated every THRESHOLDS_EVENTS_TARGET * SOFTLIMIT_EVENTS_TARGET.
>> If all events correspond with a newly charged memory and the last event
>> was just about the soft limit boundary then we should be bound by 128k
>> pages (512M and much more if this were huge pages) which is a lot!
>> I haven't realized this was that much. Now I see the problem. This would
>> be a useful information for the changelog.
>>
>> Your fix is focusing on the over-the-limit boundary which will solve the
>> problem but wouldn't that lead to to updates happening too often in
>> pathological situation when a memcg would get reclaimed immediatelly?
> 
> Not really immediately.  The memcg that has the most soft limit excess will
> be chosen for page reclaim, which is the way it should be.  
> It is less likely that a memcg that just exceeded
> the soft limit becomes the worst offender immediately.  With the fix, we make
> sure that it is on the bad guys list and will not be ignored and be chosen
> eventually for reclaim.  It will not sneakily increase its memory usage
> slowly.   
> 

I should also mention that the forced update is only performed once when
the memcg first exceeded the soft limit as we check whether the memcg
is already in the soft limit tree due to the !mz->on_tree check.
+	if (mz && !mz->on_tree && soft_limit_excess(mz->memcg) > 0)
+		force_update = true;

So the update overhead is very low. 

Tim
