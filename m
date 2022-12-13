Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C664B6B5
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiLMODX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 09:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMODW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 09:03:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E063B2;
        Tue, 13 Dec 2022 06:03:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 799EF22C51;
        Tue, 13 Dec 2022 14:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670940200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKy/NcC13yXOmU25oapyqo2lixJpYFXoptQAq2pSWKk=;
        b=OXYUAfMi2KkrqhWQhsIVfKCRYnn9puhrGfj1DKpChL2k4O+RB+uq/EZhyif4+UQRAMXvNh
        PM2zJr7QsmnppAyzVtHWA6+e2xcA1xU5R6hRRo3HDFKfJZYSdkZ/SkyYWM4bRPZYMh2VoW
        AzNkVq0gLDdu0r4il93PtD7Xrdo8wZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51E73138F9;
        Tue, 13 Dec 2022 14:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vJ3IESiGmGOJYgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Dec 2022 14:03:20 +0000
Date:   Tue, 13 Dec 2022 15:03:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
Message-ID: <Y5iGJ/9PMmSCwqLj@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y5h+gHBneexFQcR3@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5h+gHBneexFQcR3@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 13-12-22 14:30:40, Johannes Weiner wrote:
> On Tue, Dec 13, 2022 at 02:30:57PM +0800, Huang, Ying wrote:
[...]
> > After these discussion, I think the solution maybe use different
> > interfaces for "proactive demote" and "proactive reclaim".  That is,
> > reconsider "memory.demote".  In this way, we will always uncharge the
> > cgroup for "memory.reclaim".  This avoid the possible confusion there.
> > And, because demotion is considered aging, we don't need to disable
> > demotion for "memory.reclaim", just don't count it.
> 
> Hm, so in summary:
> 
> 1) memory.reclaim would demote and reclaim like today, but it would
>    change to only count reclaimed pages against the goal.
> 
> 2) memory.demote would only demote.
> 
>    a) What if the demotion targets are full? Would it reclaim or fail?
> 
> 3) Would memory.reclaim and memory.demote still need nodemasks? Would
>    they return -EINVAL if a) memory.reclaim gets passed only toptier
>    nodes or b) memory.demote gets passed any lasttier nodes?

I would also add
4) Do we want to allow to control the demotion path (e.g. which node to
   demote from and to) and how to achieve that?
5) Is the demotion api restricted to multi-tier systems or any numa
   configuration allowed as well?

-- 
Michal Hocko
SUSE Labs
