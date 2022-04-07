Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658364F8A56
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 00:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiDGV2Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiDGV2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 17:28:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BDB1965CF;
        Thu,  7 Apr 2022 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649366769; x=1680902769;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mIX/4V9ZQLO5IL2OJQlDG9+qFrwjCz3AEf+UgwstfB4=;
  b=efig7LUJ6sEx58XIFO74VFlE8OEWGX/u5wiEAkXaeVykR93D06CXkXFH
   4mj78yMKAUoDgzgqyQfCV48bycHlHu26ReYGzOv9CgJQszbmI4HQHbwaA
   dITWjIcDVgHe26w/gzrPk+1NkM34CO8tCRzRQ/joCUJPztenP66KjSyj+
   Ie1MlpuAYCijGt63CZ767xmygi4AWHoAJQ21NcmiXNnbUxgziKfG/wf0/
   pI2clGUSB3XpK1tzUoZebin12TN0hGmi6/BS4mdjNcmN8Q2blvh4/yZHW
   Kcp3FJlyt2f/vhC50FF9SR1Z99/s7FBEEVJFPTyPlkJ7sfLL2gPR4hPQJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="324606428"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="324606428"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:26:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="525096736"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.71.23])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:26:01 -0700
Message-ID: <215bd7332aee0ed1092bad4d826a42854ebfd04a.camel@linux.intel.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>, Wei Xu <weixugc@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Date:   Thu, 07 Apr 2022 14:26:01 -0700
In-Reply-To: <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
         <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
         <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
         <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
         <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
         <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2022-04-06 at 10:49 +0800, Huang, Ying wrote:
> 
> > > If so,
> > > 
> > > # echo A > memory.reclaim
> > > 
> > > means
> > > 
> > > a) "A" bytes memory are freed from the memcg, regardless demoting is
> > >    used or not.
> > > 
> > > or
> > > 
> > > b) "A" bytes memory are reclaimed from the memcg, some of them may be
> > >    freed, some of them may be just demoted from DRAM to PMEM.  The total
> > >    number is "A".
> > > 
> > > For me, a) looks more reasonable.
> > > 
> > 
> > We can use a DEMOTE flag to control the demotion behavior for
> > memory.reclaim.  If the flag is not set (the default), then
> > no_demotion of scan_control can be set to 1, similar to
> > reclaim_pages().
> 
> If we have to use a flag to control the behavior, I think it's better to
> have a separate interface (e.g. memory.demote).  But do we really need b)?
> 
> > The question is then whether we want to rename memory.reclaim to
> > something more general.  I think this name is fine if reclaim-based
> > demotion is an accepted concept.
> 

memory.demote will work for 2 level of memory tiers.  But when we have 3 level
of memory (e.g. high bandwidth memory, DRAM and PMEM), 
it gets ambiguous again of wheter we sould demote from high bandwidth memory
or DRAM.

Will something like this be more general?

echo X > memory_[dram,pmem,hbm].reclaim

So echo X > memory_dram.reclaim
means that we want to free up X bytes from DRAM for the mem cgroup.

echo demote > memory_dram.reclaim_policy

This means that we prefer demotion for reclaim instead
of swapping to disk.


Tim


