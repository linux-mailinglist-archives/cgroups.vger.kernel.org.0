Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA05A5C06
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiH3GpE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 02:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3GpD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 02:45:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7113E39;
        Mon, 29 Aug 2022 23:44:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EEE1E1F991;
        Tue, 30 Aug 2022 06:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661841897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqwnetj8xbUKp5QppMH6N1q9Y/Y7o7+y1Plx+97UHPo=;
        b=HdWK9N8YSyfzISyC1zORz7jOWzLnPpeT8qKNYhP08SyMyCS/7i/QILKBq6O1dwotIJOHl2
        mI34yRsJHN4QT79t3hxHFsnK35Vtajheuv5CeJ/t4XhboAuFlz4WBBiaSUfpDyJvRuZPhN
        /mlH4FOLyd5WRp/ArheHZ/Gk6E1XNmE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDB7813ACF;
        Tue, 30 Aug 2022 06:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ofHiL+mxDWObJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 30 Aug 2022 06:44:57 +0000
Date:   Tue, 30 Aug 2022 08:44:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memcontrol: remove mem_cgroup_kmem_disabled
Message-ID: <Yw2x6T3xchjpzX7j@dhcp22.suse.cz>
References: <20220830055949.12640-1-ryncsn@gmail.com>
 <20220830055949.12640-2-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830055949.12640-2-ryncsn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 30-08-22 13:59:48, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently two helpers for checking if cgroup kmem
> accounting is enabled:
> 
> - mem_cgroup_kmem_disabled
> - memcg_kmem_enabled

Yes, this is a bit confusing indeed!

> mem_cgroup_kmem_disabled is a simple helper that returns true if
> cgroup.memory=nokmem is specified, otherwise returns false.
> 
> memcg_kmem_enabled is a bit different, it returns true if
> cgroup.memory=nokmem is not specified and there is at least one
> non-root cgroup ever created. And once there is any non-root memcg
> created, it won't go back to return false again.
> 
> This may help improve performance for some corner use cases where
> the user enables memory cgroup and kmem accounting globally but never
> create any cgroup.
> 
> Considering that corner case is rare, especially nowadays cgroup is
> widely used as a standard way to organize services.

Is it really that rare? Most configurations would use a default setup, so
both MEMCG enabled and without nokmem on cmd line yet the memory
controller is not enabled in their setups.

> And the "once
> enabled never disable" behavior is kind of strange. This commit simplifies
> the behavior of memcg_kmem_enabled, making it simply the opposite of
> mem_cgroup_kmem_disabled, always true if cgroup.memory=nokmem is
> not specified. So mem_cgroup_kmem_disabled can be dropped.
> 
> This simplifies the code, and besides, memcg_kmem_enabled makes use
> of static key so it has a lower overhead.

I agree that this is slightly confusing and undocumented. The first step
would be finding out why we need both outside of the memcg proper.

E.g. it doesn't make much sense to me that count_objcg_event uses the
command line variant when it should be using the dynamic (and more
optimized no branch) variant.

On the other hand pcpu_alloc_chunk seems to be different because it can
be called before the controller is enabled but maybe we do not need to
waste memory before that? Similarly new_kmalloc_cache. I suspect these
are mostly to simplify the code and reduce special casing.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/memcontrol.h |  8 +-------
>  mm/memcontrol.c            | 17 +++++++----------
>  mm/percpu.c                |  2 +-
>  mm/slab_common.c           |  2 +-
>  4 files changed, 10 insertions(+), 19 deletions(-)

I do not think that saving 9 LOC and sacrifice optimization that might
be useful is a good justification.

-- 
Michal Hocko
SUSE Labs
