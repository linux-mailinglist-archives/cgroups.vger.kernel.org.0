Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADB61ECBA
	for <lists+cgroups@lfdr.de>; Mon,  7 Nov 2022 09:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKGIRl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Nov 2022 03:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKGIRj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Nov 2022 03:17:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D40B7FF;
        Mon,  7 Nov 2022 00:17:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C07A11F88F;
        Mon,  7 Nov 2022 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667809057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yhWHJ2J3mSTc7a4l8DLtwjtj9XcPdTj9FcFSpoWpr2c=;
        b=t8ZU6zp1GfpIYKpTERHBEmxxZa1ZI6WSDt+HtNFMqEM9YuuAhN7Wf8M0WRha9BmexJQ1Hx
        BeGVslsxal3j4CZgzDRp2e2bavLZV1suFz3jlmJaCyOpqMA6D0iyMIxDeAtZLOiFCJIZKX
        37ufVDxAE4xTtaolcw6E4ze1Q1exgJI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EF4413AC7;
        Mon,  7 Nov 2022 08:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9viDJCG/aGPWIwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 07 Nov 2022 08:17:37 +0000
Date:   Mon, 7 Nov 2022 09:17:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
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
Message-ID: <Y2i/IMs/KWpppQtS@dhcp22.suse.cz>
References: <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
 <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
 <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
 <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1+J7+1V1nJXF+3b@dhcp22.suse.cz>
 <Y1/XC+witPxFj04T@feng-clx>
 <Y1/cgrgdVP+KdYzf@dhcp22.suse.cz>
 <Y2i8UbaOjGyqwJQ6@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2i8UbaOjGyqwJQ6@feng-clx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 07-11-22 16:05:37, Feng Tang wrote:
> On Mon, Oct 31, 2022 at 03:32:34PM +0100, Michal Hocko wrote:
> > > > OK, then let's stop any complicated solution right here then. Let's
> > > > start simple with a per-mm flag to disable demotion of an address space.
> > > > Should there ever be a real demand for a more fine grained solution
> > > > let's go further but I do not think we want a half baked solution
> > > > without real usecases.
> > > 
> > > Yes, the concern about the high cost for mempolicy from you and Yang is
> > > valid. 
> > > 
> > > How about the cpuset part?
> > 
> > Cpusets fall into the same bucket as per task mempolicies wrt costs. Geting a
> > cpuset requires knowing all tasks associated with a page. Or am I just
> > missing any magic? And no memcg->cpuset association is not a proper
> > solution at all.
> 
> No, you are not missing anything. It's really difficult to find a
> solution for all holes. And the patch is actually a best-efforts
> approach, trying to cover cgroup v2 + memory controller enabled case,
> which we think is a common user case for newer platforms with tiering
> memory.

Best effort is OK but it shouldn't create an unexpected behavior and
this approach does that.

I thought I have already explained that. But let me be more
explicit this time.  Please have a look at how controllers can be
enabled/disabled at different levels of the hierarchy. Unless memcg
grows a hard dependency on another controller (as it does with the blk
io controller) then this approach can point to a wrong cpuset. See my
point?

Really, solution for this is not going to be cheap and also I am not
sure all the hessles is really worth it until there is a clear usecase
in sight.
-- 
Michal Hocko
SUSE Labs
