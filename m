Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C6321E73
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 18:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBVRrD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 12:47:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:3383 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhBVRrB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 12:47:01 -0500
IronPort-SDR: 6DbAzOjQGdPPd6tAiFPw0/tokR3zHFUF8XwfYnnc944MPDRBowono0goBgmZIla/m337dBr+wl
 5bJ5DtRe6WEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="245954072"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="245954072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:45:13 -0800
IronPort-SDR: JY/PWzxEGyxqu/7pjSpHmBwJ1805Kcb5WA3ULltjKaUFxNP0jB3W68JvxDoI/TrIi9t0/6i+K5
 gPUzcXSZVpGQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="389942411"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:45:12 -0800
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
 <YC+B2KvJVSgfVDTe@dhcp22.suse.cz>
 <1ecd277e-c236-08e1-f068-3dd65ee0e640@linux.intel.com>
 <YDNuRFgJPH4bPEbq@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <fdc2a811-0a05-b706-a6f5-b686507caf56@linux.intel.com>
Date:   Mon, 22 Feb 2021 09:45:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YDNuRFgJPH4bPEbq@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/22/21 12:41 AM, Michal Hocko wrote:

>>
>>
>> Ah, that's true.  The added check for soft_limit_excess is not needed.
>>
>> Do you think it is still a good idea to add patch 3 to
>> restrict the uncharge update in page batch of the same node and cgroup?
> 
> I would rather drop it. The less the soft limit reclaim code is spread
> around the better.
> 

Let's drop patch 3 then.  I find patch 2 is the most critical one in this series.  
Without that patch some cgroups exceeds the soft limit excess very badly.

Tim
