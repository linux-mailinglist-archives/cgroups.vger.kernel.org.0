Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0332207C
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhBVTun (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 14:50:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:41743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhBVTum (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 14:50:42 -0500
IronPort-SDR: AAq4QhssEWHBsgwb2vdNXBfRsBt+5LyCRkyzwBCwYQbGGIOFCDzZoYItryu7acTnsSMApEsLeH
 NAho6/JAKZDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="164410062"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="164410062"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 11:48:38 -0800
IronPort-SDR: HLGDj/ZjJ4XDI023LnEnQh6emWvqS+JOS1yOmF4b+JlIJbHCC+wOhMcHOiyb2gPXJHK5m2xRhI
 ZIdvLJYrFBnw==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="389990117"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 11:48:37 -0800
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
Message-ID: <cf5ca7a1-7965-f307-22e1-e216316904cf@linux.intel.com>
Date:   Mon, 22 Feb 2021 11:48:37 -0800
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

>>
>> I actually have tried adjusting the threshold but found that it doesn't work well for
>> the case with unenven memory access frequency between cgroups.  The soft
>> limit for the low memory event cgroup could creep up quite a lot, exceeding
>> the soft limit by hundreds of MB, even
>> if I drop the SOFTLIMIT_EVENTS_TARGET from 1024 to something like 8.
> 
> What was the underlying reason? Higher order allocations?
> 

Not high order allocation.

The reason was because the run away memcg asks for memory much less often, compared
to the other memcgs in the system.  So it escapes the sampling update and
was not put onto the tree and exceeds the soft limit
pretty badly.  Even if it was put onto the tree and gets page reclaimed below the
limit, it could escape the sampling the next time it exceeds the soft limit.

As long as we are doing sampling update, this problem is baked in unless we
add the check to make sure that the memcg is subjected to page reclaim as long
as it exceeds the soft limit.

Tim

