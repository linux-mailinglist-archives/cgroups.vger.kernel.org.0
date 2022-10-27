Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19E260F091
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0GsM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiJ0GsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 02:48:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3631213E6;
        Wed, 26 Oct 2022 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666853289; x=1698389289;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=bNTVcZUk3EGA9xSMZhWo1dSEwPloZHZhSf6kjCFBv2U=;
  b=c3yTwbuvKl22m9bW7iJtZFwb45N45ynGrPEBCqBpuh3qN9KQdPrsHrlu
   1v2NL59UVftOYu7aCRex4SS3DPdw1M+D50ikHo2/Bpmf61eVaOFxNhdWG
   fx1wktEP6B/X+Lt/h4V0+BF8wdz3Sf395MCgVJZYWARFh5s5Fibvv36Qq
   O3wJicFQxu/RCpvzeLWqMdVDvHOyeS2hcNoqg0UtwGDoOWKPnjwK7OGg1
   YgVciiD/O1H1llNugNQvaxwjWfGy+00FCQzA7o25g/ljHiobHVH3xhu/V
   BSzu+XbHHnWXesunjlF5YpKM0868xwnwQBd0Fv8dju+T0Y1nGMlvui521
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309236626"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309236626"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:48:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="807339311"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="807339311"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 23:48:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
References: <20221026074343.6517-1-feng.tang@intel.com>
        <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
        <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
        <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
Date:   Thu, 27 Oct 2022 14:47:22 +0800
In-Reply-To: <Y1lZV6qHp3gIINGc@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 26 Oct 2022 17:59:19 +0200")
Message-ID: <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 26-10-22 20:20:01, Feng Tang wrote:
>> On Wed, Oct 26, 2022 at 05:19:50PM +0800, Michal Hocko wrote:
>> > On Wed 26-10-22 16:00:13, Feng Tang wrote:
>> > > On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
>> > > > On 10/26/22 1:13 PM, Feng Tang wrote:
>> > > > > In page reclaim path, memory could be demoted from faster memory tier
>> > > > > to slower memory tier. Currently, there is no check about cpuset's
>> > > > > memory policy, that even if the target demotion node is not allowd
>> > > > > by cpuset, the demotion will still happen, which breaks the cpuset
>> > > > > semantics.
>> > > > > 
>> > > > > So add cpuset policy check in the demotion path and skip demotion
>> > > > > if the demotion targets are not allowed by cpuset.
>> > > > > 
>> > > > 
>> > > > What about the vma policy or the task memory policy? Shouldn't we respect
>> > > > those memory policy restrictions while demoting the page? 
>> > >  
>> > > Good question! We have some basic patches to consider memory policy
>> > > in demotion path too, which are still under test, and will be posted
>> > > soon. And the basic idea is similar to this patch.
>> > 
>> > For that you need to consult each vma and it's owning task(s) and that
>> > to me sounds like something to be done in folio_check_references.
>> > Relying on memcg to get a cpuset cgroup is really ugly and not really
>> > 100% correct. Memory controller might be disabled and then you do not
>> > have your association anymore.
>>  
>> You are right, for cpuset case, the solution depends on 'CONFIG_MEMCG=y',
>> and the bright side is most of distribution have it on.
>
> CONFIG_MEMCG=y is not sufficient. You would need to enable memcg
> controller during the runtime as well.
>  
>> > This all can get quite expensive so the primary question is, does the
>> > existing behavior generates any real issues or is this more of an
>> > correctness exercise? I mean it certainly is not great to demote to an
>> > incompatible numa node but are there any reasonable configurations when
>> > the demotion target node is explicitly excluded from memory
>> > policy/cpuset?
>> 
>> We haven't got customer report on this, but there are quite some customers
>> use cpuset to bind some specific memory nodes to a docker (You've helped
>> us solve a OOM issue in such cases), so I think it's practical to respect
>> the cpuset semantics as much as we can.
>
> Yes, it is definitely better to respect cpusets and all local memory
> policies. There is no dispute there. The thing is whether this is really
> worth it. How often would cpusets (or policies in general) go actively
> against demotion nodes (i.e. exclude those nodes from their allowes node
> mask)?
>
> I can imagine workloads which wouldn't like to get their memory demoted
> for some reason but wouldn't it be more practical to tell that
> explicitly (e.g. via prctl) rather than configuring cpusets/memory
> policies explicitly?

If my understanding were correct, prctl() configures the process or
thread.  How can we get process/thread configuration at demotion time?

Best Regards,
Huang, Ying
