Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E660E326AE5
	for <lists+cgroups@lfdr.de>; Sat, 27 Feb 2021 01:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhB0A6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Feb 2021 19:58:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:34606 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhB0A6R (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 26 Feb 2021 19:58:17 -0500
IronPort-SDR: R9HHtZKp2Ee0WknCguH9utQOmOqPD0Bv/8fldCtNZZbd455FZq15KANag6MHd1QBhDZKYd8VxX
 rSk/N2A1ChGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="185348032"
X-IronPort-AV: E=Sophos;i="5.81,210,1610438400"; 
   d="scan'208";a="185348032"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 16:56:29 -0800
IronPort-SDR: gsUOB9ZTOZYp/ns1WJT9bxRzgmff3p+kS3YpgPsI5tSgngoDM1o3s3cwHqZfjZ4aEv/4PvaL40
 qsVKiq5yeGLQ==
X-IronPort-AV: E=Sophos;i="5.81,210,1610438400"; 
   d="scan'208";a="584781614"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.14.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 16:56:28 -0800
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
 <cf5ca7a1-7965-f307-22e1-e216316904cf@linux.intel.com>
 <YDY+PydRUGQpHNaJ@dhcp22.suse.cz>
 <b5b1944d-846b-3212-fe4a-f10f5fcb87d7@linux.intel.com>
 <YDi2udQqIML6Vdpo@dhcp22.suse.cz>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <781634ee-ffb9-598d-fdb6-0ae6067448b7@linux.intel.com>
Date:   Fri, 26 Feb 2021 16:56:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YDi2udQqIML6Vdpo@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/26/21 12:52 AM, Michal Hocko wrote:

>>
>> Michal,
>>
>> Let's take an extreme case where memcg 1 always generate the
>> first event and memcg 2 generates the rest of 128*8-1 events
>> and the pattern repeat.
> 
> I do not follow. Events are per-memcg, aren't they?
> 	__this_cpu_read(memcg->vmstats_percpu->targets[target]);
> 	[...]
> 	__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
> 

You are right. My previous reasoning is incorrect as the sampling is done per memcg.
I'll do some additional debugging on why memcg is not on the tree.

Tim 
