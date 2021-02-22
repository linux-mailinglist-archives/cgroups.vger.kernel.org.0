Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB0321F43
	for <lists+cgroups@lfdr.de>; Mon, 22 Feb 2021 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhBVSkv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 13:40:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:65104 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhBVSkV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 13:40:21 -0500
IronPort-SDR: i54tMhGVkfVazDupSPUSQrubSX+R14TNYd3BqplGE2B2sbz0u5ewJ7mnxoYA/gxtcyOQBc5xbq
 zUosS8gw9rlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="248604546"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="248604546"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:38:29 -0800
IronPort-SDR: K25ijc2ixE1JNZWZB66mWJ4ZdE0FII9vDWen8txowUjhmclpeg2toWWWFDqz3XnBN3+69ECDow
 o6Cz8fMw7CLg==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="389966258"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.12.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:38:28 -0800
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
 <YC4BcsNFEmW7XeqB@cmpxchg.org>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <d141f9ec-5502-b011-167f-e24d891b0dfe@linux.intel.com>
Date:   Mon, 22 Feb 2021 10:38:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YC4BcsNFEmW7XeqB@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/17/21 9:56 PM, Johannes Weiner wrote:

>>  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
>> @@ -6849,7 +6850,13 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>>  	 * exclusive access to the page.
>>  	 */
>>  
>> -	if (ug->memcg != page_memcg(page)) {
>> +	if (ug->memcg != page_memcg(page) ||
>> +	    /*
>> +	     * Update soft limit tree used in v1 cgroup in page batch for
>> +	     * the same node. Relevant only to v1 cgroup with a soft limit.
>> +	     */
>> +	    (ug->dummy_page && ug->nid != page_to_nid(page) &&
>> +	     ug->memcg->soft_limit != PAGE_COUNTER_MAX)) {
> 
> Sorry, I used weird phrasing in my last email.
> 
> Can you please preface the checks you're adding with a
> !cgroup_subsys_on_dfl(memory_cgrp_subsys) to static branch for
> cgroup1? The uncharge path is pretty hot, and this would avoid the
> runtime overhead on cgroup2 at least, which doesn't have the SL.
> 
> Also, do we need the ug->dummy_page check? It's only NULL on the first
> loop - where ug->memcg is NULL as well and the branch is taken anyway.
> 
> The soft limit check is also slightly cheaper than the nid check, as
> page_to_nid() might be out-of-line, so we should do it first. This?
> 
> 	/*
> 	 * Batch-uncharge all pages of the same memcg.
> 	 *
> 	 * Unless we're looking at a cgroup1 with a softlimit
> 	 * set: the soft limit trees are maintained per-node
> 	 * and updated on uncharge (via dummy_page), so keep
> 	 * batches confined to a single node as well.
> 	 */
> 	if (ug->memcg != page_memcg(page) ||
> 	    (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> 	     ug->memcg->soft_limit != PAGE_COUNTER_MAX &&
> 	     ug->nid != page_to_nid(page)))
> 

Johannes,

Thanks for your feedback.  Since Michal has concerns about the overhead
this patch could incur, I think we'll hold the patch for now.  If later
on Michal think that this patch is a good idea, I'll incorporate these
changes you suggested.

Tim
