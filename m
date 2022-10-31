Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A46131F6
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJaIwB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 04:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaIwA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 04:52:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150965C2;
        Mon, 31 Oct 2022 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667206320; x=1698742320;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GJpd8Xm2kiIYix/9b/pSxjuZ+hynXQIIYAwXtN4bVMk=;
  b=AYULtybqnhrIw9RC05HZSf8Gc7Lpj+0vOpILorUOas0iHikw/TQTnmLj
   y8zJv4COZx92nKcm4otcbwtB3thH6yyEv0rm2kLDePbxwk08DsBAUJAgf
   N43upRaTkFO/SgBgI29RT7VRn4ccNN2TYbZXulRk4WR8nI/j2Trk8Ptp4
   iRQeXO9BmNeLH7Jc6Ck2N5KLiFK3Ni6Vdn3wbpbkwkIakezFhMPlA+bEr
   unJTR9uX622oGg5/guUxSVrZ1KJtUIIBM4BZSjWsiaAyYlT8MgYvWlcIF
   6frBrIKy7lSqru3WcO9XAJ4/3kAqIf5UYO+0JCOuzG/Q2YOHIm81dVxma
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="308848698"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="308848698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 01:52:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="722741094"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="722741094"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 01:51:57 -0700
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
References: <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz> <Y1kl8VbPE0RYdyEB@feng-clx>
        <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
        <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
        <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
        <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
        <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
Date:   Mon, 31 Oct 2022 16:51:11 +0800
In-Reply-To: <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 31 Oct 2022 09:40:15 +0100")
Message-ID: <87wn8gcr5s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Fri 28-10-22 07:22:27, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 27-10-22 17:31:35, Huang, Ying wrote:
> [...]
>> >> I think that it's possible for different processes have different
>> >> requirements.
>> >> 
>> >> - Some processes don't care about where the memory is placed, prefer
>> >>   local, then fall back to remote if no free space.
>> >> 
>> >> - Some processes want to avoid cross-socket traffic, bind to nodes of
>> >>   local socket.
>> >> 
>> >> - Some processes want to avoid to use slow memory, bind to fast memory
>> >>   node only.
>> >
>> > Yes, I do understand that. Do you have any specific examples in mind?
>> > [...]
>> 
>> Sorry, I don't have specific examples.
>
> OK, then let's stop any complicated solution right here then. Let's
> start simple with a per-mm flag to disable demotion of an address
> space.

I'm not a big fan of per-mm flag.  Because we don't have users for that
too and it needs to add ABI too.

> Should there ever be a real demand for a more fine grained solution
> let's go further but I do not think we want a half baked solution
> without real usecases.

I'm OK to ignore per-task (and missing per-process) memory policy
support for now.

Best Regards,
Huang, Ying
