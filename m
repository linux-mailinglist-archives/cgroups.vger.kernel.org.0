Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC44F77A9
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 09:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiDGHiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbiDGHhd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 03:37:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C74DF4A;
        Thu,  7 Apr 2022 00:35:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0340B21122;
        Thu,  7 Apr 2022 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649316932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4+V8CVr+PsVvoMRvSRXz1QR100B6sh+pY7exh4j2aBc=;
        b=o5iaBUNZARcTgJe1NnxGXMIcqlgmG9bsli9PzpUf7DjbZ8YS1jF7HF8ooX2hVuDm3lyZSN
        2DcYNmsVkwM1UhSNWQUsfsKBwgNocKT+VvJEyTI9AdJ7C8TBU5Lr4WzrxrVrdBGzBPvhW6
        yBNJheAWgva8zVizVPCwPxEe5A7T1F0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F2B1CA3B83;
        Thu,  7 Apr 2022 07:35:26 +0000 (UTC)
Date:   Thu, 7 Apr 2022 09:35:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>, Yosry Ahmed <yosryahmed@google.com>,
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
        Greg Thelen <gthelen@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <Yk6UQrjqSQnePdxe@dhcp22.suse.cz>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
 <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
 <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
 <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u_FVEVE+wTBNYfDibLVKsRuOwEnpigYYRiZ2MbeUs1u8w@mail.gmail.com>
 <877d82vi13.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d82vi13.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 06-04-22 14:32:24, Huang, Ying wrote:
[...]
> I think we should define the interface not from the current
> implementation point of view, but from the requirement point of view.

Agreed!

> For proactive reclaim, per my understanding, the requirement is,
> 
>   we found that there's some cold pages in some workloads, so we can
>   take advantage of the proactive reclaim to reclaim some pages so that
>   other workload can use the freed memory.

We are talking about memcg here so this is not as much a matter of free
memory as it is to decrease the amount of charged memory. Demotion
cannot achieve that.

> For proactive demotion, per my understanding, the requirement could be,
> 
>   We found that there's some cold pages in fast memory (e.g. DRAM) in
>   some workloads, so we can take advantage of the proactive demotion to
>   demote some pages so that other workload can use the freed fast
>   memory.  Given the DRAM partition support Tim (Cced) is working on.

Yes, this is essentially a kernel assisted memory migration. Userspace
can migrate memory but the issue is that it doesn't have any information
on the aging so the migration has hard time to find suitable memory to
migrate. If we really need this functionality then it would deserve a
separate interface IMHO.

-- 
Michal Hocko
SUSE Labs
