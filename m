Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC60261438D
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 04:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKADR6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 23:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKADR4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 23:17:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF112751;
        Mon, 31 Oct 2022 20:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667272674; x=1698808674;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gXFkpBk6Mk0KHfml+Hm4uAnHyTOnb+ioyvEbwdWn2Rs=;
  b=PXMFohgf/aBI22iMcxphpQV+UqVuVgaERxSquUi/8HDS10v4TsG/HWBK
   5tPmvvQb4a0OkGDWnRntpV6pIalLegwsFzls/WDZK06Wr6XcqZRonOmJe
   LUAxa7AvutrUASpOiu16eDyqxMaeiaMhnsvS5zxkyPOwC1zb11Ibobqsr
   sRVF3Rl5+CELkcVcsrWmynqis9qSUyYTdnAhaw0mDnoblSgeiUDeFvD+V
   d7GM3dFaoa4zASTICGEM+BkvrBR3c57g5eRqYR6orR/Vodr6XgRlIqW/e
   sFykm+VEyZyeFNy6qBojWHm2eEsdiCN3lnSX/GdhYavgMFa0AlI25dCTI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296480115"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="296480115"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 20:17:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="878961560"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="878961560"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 20:17:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
References: <20221026074343.6517-1-feng.tang@intel.com>
        <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
        <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
        <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
        <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
        <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
        <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Tue, 01 Nov 2022 11:17:04 +0800
In-Reply-To: <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
        message of "Thu, 27 Oct 2022 17:31:35 +0800")
Message-ID: <87r0yncqj3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Michal Hocko <mhocko@suse.com> writes:
>
>> On Thu 27-10-22 15:39:00, Huang, Ying wrote:
>>> Michal Hocko <mhocko@suse.com> writes:
>>> 
>>> > On Thu 27-10-22 14:47:22, Huang, Ying wrote:
>>> >> Michal Hocko <mhocko@suse.com> writes:
>>> > [...]
>>> >> > I can imagine workloads which wouldn't like to get their memory demoted
>>> >> > for some reason but wouldn't it be more practical to tell that
>>> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>>> >> > policies explicitly?
>>> >> 
>>> >> If my understanding were correct, prctl() configures the process or
>>> >> thread.
>>> >
>>> > Not necessarily. There are properties which are per adddress space like
>>> > PR_[GS]ET_THP_DISABLE. This could be very similar.
>>> >
>>> >> How can we get process/thread configuration at demotion time?
>>> >
>>> > As already pointed out in previous emails. You could hook into
>>> > folio_check_references path, more specifically folio_referenced_one
>>> > where you have all that you need already - all vmas mapping the page and
>>> > then it is trivial to get the corresponding vm_mm. If at least one of
>>> > them has the flag set then the demotion is not allowed (essentially the
>>> > same model as VM_LOCKED).
>>> 
>>> Got it!  Thanks for detailed explanation.
>>> 
>>> One bit may be not sufficient.  For example, if we want to avoid or
>>> control cross-socket demotion and still allow demoting to slow memory
>>> nodes in local socket, we need to specify a node mask to exclude some
>>> NUMA nodes from demotion targets.
>>
>> Isn't this something to be configured on the demotion topology side? Or
>> do you expect there will be per process/address space usecases? I mean
>> different processes running on the same topology, one requesting local
>> demotion while other ok with the whole demotion topology?
>
> I think that it's possible for different processes have different
> requirements.
>
> - Some processes don't care about where the memory is placed, prefer
>   local, then fall back to remote if no free space.
>
> - Some processes want to avoid cross-socket traffic, bind to nodes of
>   local socket.
>
> - Some processes want to avoid to use slow memory, bind to fast memory
>   node only.

Hi, Johannes, Wei, Jonathan, Yang, Aneesh,

We need your help.  Do you or your organization have requirements to
restrict the page demotion target nodes?  If so, can you share some
details of the requirements?  For example, to avoid cross-socket
traffic, or to avoid using slow memory.  And do you want to restrict
that with cpusets, memory policy, or some other interfaces.

Best Regards,
Huang, Ying
