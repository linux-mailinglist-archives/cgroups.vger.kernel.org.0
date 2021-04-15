Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A269361576
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhDOWZb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 18:25:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:38286 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235142AbhDOWZa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Apr 2021 18:25:30 -0400
IronPort-SDR: stbwseUmZ4/Y/Rb+MscS0VZi2sOafrBtEwl6UBHa11kWbEXx/azMdw7Nr9DXLJq6VNMIFNX5lJ
 UBGjqqnGUH6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175061684"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175061684"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:25:07 -0700
IronPort-SDR: xUieIgZ5t9XqViXlT/Xiz8pE85lVfU5M29qtbi/LwOuEFY8A6k6mTTSyHnf3AVjmABlszgpu6u
 MWFfbNN9jPMA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="453106552"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.21.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:25:06 -0700
Subject: Re: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered
 memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
 <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <86a6f2e1-8aed-00fc-fbd7-9250277b201f@linux.intel.com>
Date:   Thu, 15 Apr 2021 15:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7StYJCPnWRNLnYQV8S5CBLtE0w4r2rH-wZzNs9jGJSRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 4/8/21 10:18 AM, Shakeel Butt wrote:

> 
> Using v1's soft limit like behavior can potentially cause high
> priority jobs to stall to make enough space on top tier memory on
> their allocation path and I think this patchset is aiming to reduce
> that impact by making kswapd do that work. However I think the more
> concerning issue is the low priority job hogging the top tier memory.
> 
> The possible ways the low priority job can hog the top tier memory are
> by allocating non-movable memory or by mlocking the memory. (Oh there
> is also pinning the memory but I don't know if there is a user api to
> pin memory?) For the mlocked memory, you need to either modify the
> reclaim code or use a different mechanism for demoting cold memory.
> 
> Basically I am saying we should put the upfront control (limit) on the
> usage of top tier memory by the jobs.
> 

Circling back to your comment here.  

I agree that soft limit is deficient in this scenario that you 
have pointed out.  Eventually I was shooting for a hard limit on a 
memory tier for a cgroup that's similar to the v2 memory controller
interface (see mail in the other thread).  That interface should
satisfy the hard constraint you want to place on the low priority
jobs.


Tim
