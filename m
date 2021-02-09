Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42F8315A05
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhBIX0R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 18:26:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:2579 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhBIWgQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Feb 2021 17:36:16 -0500
IronPort-SDR: 7ArKe95l7IrpZ1mQrN6DTQElFgsWpTHg9MwiD4BELc8sxPMVMhv/HmbANfmRtwAVWxxgL4GIqQ
 HTQnVYDb8Chw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161723488"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161723488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:34:08 -0800
IronPort-SDR: +/4lDtE6xcDGA0a9zhq3pbGtdjQUwq7fBvn/8iF/utwH12XhbXOrnCM5APNHhz/h6lNzmZGxvQ
 68gV8XdX8xUg==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="436430938"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.26.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:34:08 -0800
Subject: Re: [PATCH 3/3] mm: Fix missing mem cgroup soft limit tree updates
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
 <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
 <YCMLEB/2IscnaGGh@cmpxchg.org>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <3445ebcd-bc69-ec6e-8995-c95753b5c4a7@linux.intel.com>
Date:   Tue, 9 Feb 2021 14:34:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YCMLEB/2IscnaGGh@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/9/21 2:22 PM, Johannes Weiner wrote:
> Hello Tim,
> 
> On Tue, Feb 09, 2021 at 12:29:47PM -0800, Tim Chen wrote:
>> @@ -6849,7 +6850,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>>  	 * exclusive access to the page.
>>  	 */
>>  
>> -	if (ug->memcg != page_memcg(page)) {
>> +	if (ug->memcg != page_memcg(page) ||
>> +	    /* uncharge batch update soft limit tree on a node basis */
>> +	    (ug->dummy_page && ug->nid != page_to_nid(page))) {
> 
> The fix makes sense to me.
> 
> However, unconditionally breaking up the batch by node can
> unnecessarily regress workloads in cgroups that do not have a soft
> limit configured, and cgroup2 which doesn't have soft limits at
> all. Consider an interleaving allocation policy for example.
> 
> Can you please further gate on memcg->soft_limit != PAGE_COUNTER_MAX,
> or at least on !cgroup_subsys_on_dfl(memory_cgrp_subsys)?
> 

Sure.  Will fix this.

Tim
