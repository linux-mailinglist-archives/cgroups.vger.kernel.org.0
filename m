Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32426724BA
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjARRV1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 12:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARRV0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 12:21:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4638125AB;
        Wed, 18 Jan 2023 09:21:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 917705BEE9;
        Wed, 18 Jan 2023 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674062483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SCxeVbTpnVsT03pooH2y84Lv1BB7k5KwUYDP0XFyWA=;
        b=qEwVvVWxhxhY1cLo7t+SlFvjG6RhTz/cvVyqd8YUGGhSp6XL9LFdC+ZOgbWgyDTtmahcIT
        PriICH13TJhLwOXC5lOpM2F2BnJ+ohb6blVOOdSIa6wmQbgw3j0OO9trtN7JH/cm3sZZ0d
        zsQ3Pc5PBLVe9jF2xxuP8FlySmS00aQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31513139D2;
        Wed, 18 Jan 2023 17:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MAcLCZMqyGPARQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 17:21:23 +0000
Date:   Wed, 18 Jan 2023 18:21:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, fvdl@google.com,
        bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Proactive reclaim/demote discussion (was Re: [PATCH] Revert "mm:
 add nodes= arg to memory.reclaim")
Message-ID: <Y8gqkub3AM6c+Z5y@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
 <20221216101820.3f4a370af2c93d3c2e78ed8a@linux-foundation.org>
 <Y52Scge3ynvn/mB4@dhcp22.suse.cz>
 <20221219144252.f3da256e75e176905346b4d1@linux-foundation.org>
 <Y7PpYsbv1xC6m/Hu@dhcp22.suse.cz>
 <87lemiitdd.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lemiitdd.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 04-01-23 16:41:50, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> [snip]
> 
> > This really requires more discussion.
> 
> Let's start the discussion with some summary.
> 
> Requirements:
> 
> - Proactive reclaim.  The counting of current per-memcg proactive
>   reclaim (memory.reclaim) isn't correct.  The demoted, but not
>   reclaimed pages will be counted as reclaimed.  So "echo XXM >
>   memory.reclaim" may exit prematurely before the specified number of
>   memory is reclaimed.

This is reportedly a problem because memory.reclaim interface cannot be
used for proper memcg sizing IIRC.

> - Proactive demote.  We need an interface to do per-memcg proactive
>   demote.

For the further discussion it would be useful to reference the usecase
that is requiring this functionality. I believe this has been mentioned
somewhere but having it in this thread would help.

> We may reuse memory.reclaim via extending the concept of
>   reclaiming to include demoting.  Or, we can add a new interface for
>   that (for example, memory.demote).  In addition to demote from fast
>   tier to slow tier, in theory, we may need to demote from a set of
>   nodes to another set of nodes for something like general node
>   balancing.
> 
> - Proactive promote.  In theory, this is possible, but there's no real
>   life requirements yet.  And it should use a separate interface, so I
>   don't think we need to discuss that here.

Yes, proactive promotion is not backed by any real usecase at the
moment. We do not really have to focus on it but we should be aware of
the posibility and alow future extentions towards that functionality.
 
There is one requirement missing here.
 - Per NUMA node control - this is what makes the distinction between
   demotion and charge reclaim really semantically challenging - e.g.
   should demotions constrained by the provided nodemask or they should
   be implicit?

> Open questions:
> 
> - Use memory.reclaim or memory.demote for proactive demote.  In current
>   memcg context, reclaiming and demoting is quite different, because
>   reclaiming will uncharge, while demoting will not.  But if we will add
>   per-memory-tier charging finally, the difference disappears.  So the
>   question becomes whether will we add per-memory-tier charging.

The question is not whether but when IMHO. We've had a similar situation
with the swap accounting. Originally we have considered swap as a shared
resource but cgroupv2 goes with per swap limits because contention for
the swap space is really something people do care about.

> - Whether should we demote from faster tier nodes to lower tier nodes
>   during the proactive reclaiming.

I thought we are aligned on that. Demotion is a part of aging and that
is an integral part of the reclaim.

>   Choice A is to keep as much fast
>   memory as possible.  That is, reclaim from the lowest tier nodes
>   firstly, then the secondary lowest tier nodes, and so on.  Choice B is
>   to demote at the same time of reclaiming.  In this way, if we
>   proactively reclaim XX MB memory, we may free XX MB memory on the
>   fastest memory nodes.
> 
> - When we proactively demote some memory from a fast memory tier, should
>   we trigger memory competition in the slower memory tiers?  That is,
>   whether to wake up kswapd of the slower memory tiers nodes?

Johannes made some very strong arguments that there is no other choice
than involve kswapd (https://lore.kernel.org/all/Y5nEQeXj6HQBEHEY@cmpxchg.org/).

>   If we
>   want to make per-memcg proactive demoting to be per-memcg strictly, we
>   should avoid to trigger the global behavior such as triggering memory
>   competition in the slower memory tiers.  Instead, we can add a global
>   proactive demote interface for that (such as per-memory-tier or
>   per-node).

I suspect we are left with a real usecase and then follow the path we
took for the swap accounting.

Other open questions I do see are
- what to do when the memory.reclaim is constrained by a nodemask as
  mentioned above. Is the whole reclaim process (including aging) bound to
  the given nodemask or does demotion escape from it.
- should the demotion be specific to multi-tier systems or the interface
  should be just NUMA based and users could use the scheme to shuffle
  memory around and allow numa balancing from userspace that way. That
  would imply that demotion is a dedicated interface of course.
- there are other usecases that would like to trigger aging from
  userspace (http://lkml.kernel.org/r/20221214225123.2770216-1-yuanchu@google.com).
  Isn't demotion just a special case of aging in general or should we
  end up with 3 different interfaces?

-- 
Michal Hocko
SUSE Labs
