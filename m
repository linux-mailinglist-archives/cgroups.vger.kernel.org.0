Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3C6A17DF
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBXIX7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 03:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBXIX6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 03:23:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CCE15C91;
        Fri, 24 Feb 2023 00:23:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7861F37778;
        Fri, 24 Feb 2023 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677227035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AL9X1+yNh4TnR5INv6zRDMmmyJRq44OTuNAoJX2NvEw=;
        b=mr3Ky5jeFRjUgdY6dWt7rZesi83ypE+9L4yARacUWa/Kcq+CP9K7kdFUzIlaB3BC5pl3eX
        r/zrBqwCYEAHmsSa3pPf6706wmMpxxT6ptA0LDGOzH6P0TWwiZO34r/4Ia3wb8ngm5oQSw
        E/Ep32+6vsnuzjqeRYsGj2oEwkR8dsM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 595B013A3A;
        Fri, 24 Feb 2023 08:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iLnaEht0+GNYFwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 24 Feb 2023 08:23:55 +0000
Date:   Fri, 24 Feb 2023 09:23:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Chae <Matthew.Chae@axis.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel <kernel@axis.com>,
        Christopher Wong <Christopher.Wong@axis.com>,
        Muchun Song <muchun.song@linux.dev>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <Y/h0GlmeSQ735DxK@dhcp22.suse.cz>
References: <AM5PR0202MB25167BFBBE892630A2EE3B7DE1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
 <Y/eizTVo8LM70flh@P9FQF9L96D.corp.robot.car>
 <AM5PR0202MB2516BD45CFBC033F9EA3B0A4E1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB2516BD45CFBC033F9EA3B0A4E1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 23-02-23 19:00:57, Matthew Chae wrote:
> Hi Roman,
> 
> I'd like to get the peak memory usage recorded overall time, rather than at a certain time.

Sampling /proc/vmstat should have a minimal overhead and you will get
not only a single value but also a break down to broad cathegory users
(LRU, slab, page tables etc.). Unfortunatelly this doesn't cover all the
users (e.g. direct users of the page allocator are not accounted to any
specific counter) but it should give you a reasonable idea how is memory
utilized. Specific metrics really depend on what you are interested in.

Another approach that might give you a different angle to the memory
consumption is to watch PSI metrics. This will not tell you the peak
memory usage but it will give you an useful cost model for the memory
usage. Being low on free memory itself is not a bad thing, i.e. you are
paying for the amount of memory so it would be rather sub-optimal to not
use it whole, right? If the memory can be reclaimed easily (e.g. by
reclaiming idle caches) then the overhead of a high memory utilization
should be reasonably low so the overal price of the reclaim is worth it.
On the other hand an over utilized system with a working set size larger
than the available memory would spend a lot of time reclaiming so the
performance would drop down.

All that being said the primary question is what is your usecase.
-- 
Michal Hocko
SUSE Labs
