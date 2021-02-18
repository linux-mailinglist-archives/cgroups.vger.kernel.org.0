Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E387931EF1F
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 20:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhBRTAm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 14:00:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:47036 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhBRSiT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 18 Feb 2021 13:38:19 -0500
IronPort-SDR: OaEJHUpjNaMZwe5N5kbFFW2c7vyWdzewFPtA8KVCuevQCLgaM3QrYu5eazSE4ixungQ6oyGOwT
 i8ucj0sJGA8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="170740653"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="170740653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 10:30:26 -0800
IronPort-SDR: K3prdcyMQiILvxrHbSlBhLyrBhdsusQb3Ie+7kLhrXL3PlDG9elq+aDuhFcd4h4iwFlph3eae9
 lRpPRtrwhOkQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="428315976"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.101.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 10:30:26 -0800
Subject: Re: [PATCH v2 1/3] mm: Fix dropped memcg from mem cgroup soft limit
 tree
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com>
 <YC4kV7dkJpxjW+df@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <c3ffa2cb-cb2c-20b7-d722-c875934992e9@linux.intel.com>
Date:   Thu, 18 Feb 2021 10:30:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC4kV7dkJpxjW+df@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/18/21 12:24 AM, Michal Hocko wrote:

> 
> I have already acked this patch in the previous version along with Fixes
> tag. It seems that my review feedback has been completely ignored also
> for other patches in this series.

Michal,

My apology.  Our mail system screwed up and there are some mail missing
from our mail system that I completely missed your mail.  
Only saw them now after I looked into the lore.kernel.org.

Responding to your comment:

>Have you observed this happening in the real life? I do agree that the
>threshold based updates of the tree is not ideal but the whole soft
>reclaim code is far from optimal. So why do we care only now? The
>feature is essentially dead and fine tuning it sounds like a step back
>to me.

Yes, I did see the issue mentioned in patch 2 breaking soft limit
reclaim for cgroup v1.  There are still some of our customers using
cgroup v1 so we will like to fix this if possible.

For patch 3 regarding the uncharge_batch, it
is more of an observation that we should uncharge in batch of same node
and not prompted by actual workload.
Thinking more about this, the worst that could happen
is we could have some entries in the soft limit tree that overestimate
the memory used.  The worst that could happen is a soft page reclaim
on that cgroup.  The overhead from extra memcg event update could
be more than a soft page reclaim pass.  So let's drop patch 3
for now.

Let me know if you will like me to resend patch 1 with the fixes tag
for commit 4e41695356fb ("memory controller: soft limit reclaim on contention")
and if there are any changes I should make for patch 2.

Thanks.

Tim

