Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161E64B18A
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiLMIvu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 03:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiLMIvc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 03:51:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE47167C9;
        Tue, 13 Dec 2022 00:51:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4591B22053;
        Tue, 13 Dec 2022 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670921488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJqVpp0rgt2DpLfJteOt1+knopZ57BAnBRXhD56Saew=;
        b=MfMJRehQtolYF5vDu/F2qedFOWN5WjmU9c57R+GI1JCJbJYbMgJO0bjjf4S1YVNy0qGtIo
        u672Fjtmqv/Ii8avOlmNsNaT+W4ZkjnojFEgAYgg+bY/BIy2tr2FefoWzPGm0l/yfl6CEJ
        bn5zrj+XgsAI5VrL7PTa5ET5Aefo6Ok=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 215B2138EE;
        Tue, 13 Dec 2022 08:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qu2dBBA9mGN5LAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 13 Dec 2022 08:51:28 +0000
Date:   Tue, 13 Dec 2022 09:51:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <Y5g9D12uEr7HpP5K@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 13-12-22 14:30:57, Huang, Ying wrote:
> Mina Almasry <almasrymina@google.com> writes:
[...]
> After these discussion, I think the solution maybe use different
> interfaces for "proactive demote" and "proactive reclaim".  That is,
> reconsider "memory.demote".  In this way, we will always uncharge the
> cgroup for "memory.reclaim".  This avoid the possible confusion there.
> And, because demotion is considered aging, we don't need to disable
> demotion for "memory.reclaim", just don't count it.

As already pointed out in my previous email, we should really think more
about future requirements. Do we add memory.promote interface when there
is a request to implement numa balancing into the userspace? Maybe yes
but maybe the node balancing should be more generic than bound to memory
tiering and apply to a more fine grained nodemask control.

Fundamentally we already have APIs to age (MADV_COLD, MADV_FREE),
reclaim (MADV_PAGEOUT, MADV_DONTNEED) and MADV_WILLNEED to prioritize
(swap in, or read ahead) which are per mm/file. Their primary usability
issue is that they are process centric and that requires a very deep
understanding of the process mm layout so it is not really usable for a
larger scale orchestration.
The important part of those interfaces is that they do not talk about
demotion because that is an implementation detail. I think we want to
follow that model at least. From a higher level POV I believe we really
need an interface to age&reclaim and balance memory among nodes. Are
there more higher level usecases?
-- 
Michal Hocko
SUSE Labs
