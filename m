Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BC649A7E
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiLLIz7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 03:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLIz5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 03:55:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F009C09;
        Mon, 12 Dec 2022 00:55:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6ACF338A2;
        Mon, 12 Dec 2022 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670835354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGVOMJbI5VSuu2tCry8NVGy56zUSkKbZBynEIgKf3Ms=;
        b=e7WlOo+Kk87BEbCBNwskXM7yzdzJaKGsFfe8oyqFNEfXIitKdo5y7ay8NCB+3SVFXff3cJ
        GR5vhrP/1xCsq6oCvRi6mNucyOzWGdMku6SHUqxKcvu0y7JCY81V/IY3luS2NOgA/C0S7+
        YTMgtj+HVc6jHmGNR/MARafPRYQAziM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B449913456;
        Mon, 12 Dec 2022 08:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CQPRKZrslmMoGgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 12 Dec 2022 08:55:54 +0000
Date:   Mon, 12 Dec 2022 09:55:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
Message-ID: <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202223533.1785418-1-almasrymina@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 02-12-22 14:35:31, Mina Almasry wrote:
> The nodes= arg instructs the kernel to only scan the given nodes for
> proactive reclaim. For example use cases, consider a 2 tier memory system:
> 
> nodes 0,1 -> top tier
> nodes 2,3 -> second tier
> 
> $ echo "1m nodes=0" > memory.reclaim
> 
> This instructs the kernel to attempt to reclaim 1m memory from node 0.
> Since node 0 is a top tier node, demotion will be attempted first. This
> is useful to direct proactive reclaim to specific nodes that are under
> pressure.
> 
> $ echo "1m nodes=2,3" > memory.reclaim
> 
> This instructs the kernel to attempt to reclaim 1m memory in the second tier,
> since this tier of memory has no demotion targets the memory will be
> reclaimed.
> 
> $ echo "1m nodes=0,1" > memory.reclaim
> 
> Instructs the kernel to reclaim memory from the top tier nodes, which can
> be desirable according to the userspace policy if there is pressure on
> the top tiers. Since these nodes have demotion targets, the kernel will
> attempt demotion first.
> 
> Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim""), the proactive reclaim interface memory.reclaim does both
> reclaim and demotion. Reclaim and demotion incur different latency costs
> to the jobs in the cgroup. Demoted memory would still be addressable
> by the userspace at a higher latency, but reclaimed memory would need to
> incur a pagefault.
> 
> The 'nodes' arg is useful to allow the userspace to control demotion
> and reclaim independently according to its policy: if the memory.reclaim
> is called on a node with demotion targets, it will attempt demotion first;
> if it is called on a node without demotion targets, it will only attempt
> reclaim.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

After discussion in [1] I have realized that I haven't really thought
through all the consequences of this patch and therefore I am retracting
my ack here. I am not nacking the patch at this statge but I also think
this shouldn't be merged now and we should really consider all the
consequences.

Let me summarize my main concerns here as well. The proposed
implementation doesn't apply the provided nodemask to the whole reclaim
process. This means that demotion can happen outside of the mask so the
the user request cannot really control demotion targets and that limits
the interface should there be any need for a finer grained control in
the future (see an example in [2]).
Another problem is that this can limit future reclaim extensions because
of existing assumptions of the interface [3] - specify only top-tier
node to force the aging without actually reclaiming any charges and
(ab)use the interface only for aging on multi-tier system. A change to
the reclaim to not demote in some cases could break this usecase.

My counter proposal would be to define the nodemask for memory.reclaim
as a domain to constrain the charge reclaim. That means both aging and
reclaim including demotion which is a part of aging. This will allow
to control where to demote for balancing purposes (e.g. demote to node 2
rather than 3) which is impossible with the proposed scheme.

[1] http://lkml.kernel.org/r/20221206023406.3182800-1-almasrymina@google.com
[2] http://lkml.kernel.org/r/Y5bnRtJ6sojtjgVD@dhcp22.suse.cz
[3] http://lkml.kernel.org/r/CAAPL-u8rgW-JACKUT5ChmGSJiTDABcDRjNzW_QxMjCTk9zO4sg@mail.gmail.com
-- 
Michal Hocko
SUSE Labs
