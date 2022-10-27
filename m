Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE460F13B
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiJ0Hjt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiJ0Hjt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 03:39:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622F2A250;
        Thu, 27 Oct 2022 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666856388; x=1698392388;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=jweFWZMSXgqQ6tBTe/QKSoQxmkPbv29fClDdATqJ80E=;
  b=BdCDXRUb2vVUxO8Smrn4RhyqAaRdb0nRBKtrpMdJ0pJMtGoMcnehdKCL
   voaHKd6tLGBvIk9y9oqpBBntTI8GTf+VdueqLSmpj+nbQlESqqrpMthoJ
   F1h8TRNsl5Qpm3011kaBG8oS5KT1dCjI8njVvIG3ercfnFqmom3cYGT8x
   s7qSumZG6eVdoOgx4IIafpp4MHEQnvuoXdXBCWLVWQL5WlE0azcJEDeJ6
   SjXwb28ZTEqCFstvMzy2iCPwrnN8Y0JZ4sc3obp49JTfTJKHzcSQLE8zJ
   tm3+qV9T2D2YkBTDVNek/3RBtFRQ7ILpRZXtVMn++XspCVfS/lmDv0uRA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="308148216"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="308148216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:39:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737573783"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="737573783"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 00:39:44 -0700
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
        <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
Date:   Thu, 27 Oct 2022 15:39:00 +0800
In-Reply-To: <Y1ou5DGHrEsKnhri@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 27 Oct 2022 09:10:28 +0200")
Message-ID: <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 27-10-22 14:47:22, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
> [...]
>> > I can imagine workloads which wouldn't like to get their memory demoted
>> > for some reason but wouldn't it be more practical to tell that
>> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> > policies explicitly?
>> 
>> If my understanding were correct, prctl() configures the process or
>> thread.
>
> Not necessarily. There are properties which are per adddress space like
> PR_[GS]ET_THP_DISABLE. This could be very similar.
>
>> How can we get process/thread configuration at demotion time?
>
> As already pointed out in previous emails. You could hook into
> folio_check_references path, more specifically folio_referenced_one
> where you have all that you need already - all vmas mapping the page and
> then it is trivial to get the corresponding vm_mm. If at least one of
> them has the flag set then the demotion is not allowed (essentially the
> same model as VM_LOCKED).

Got it!  Thanks for detailed explanation.

One bit may be not sufficient.  For example, if we want to avoid or
control cross-socket demotion and still allow demoting to slow memory
nodes in local socket, we need to specify a node mask to exclude some
NUMA nodes from demotion targets.

From overhead point of view, this appears similar as that of VMA/task
memory policy?  We can make mm->owner available for memory tiers
(CONFIG_NUMA && CONFIG_MIGRATION).  The advantage is that we don't need
to introduce new ABI.  I guess users may prefer to use `numactl` than a
new ABI?

Best Regards,
Huang, Ying
