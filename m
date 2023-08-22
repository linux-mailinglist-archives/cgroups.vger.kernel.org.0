Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A870E783C76
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjHVJGL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjHVJGL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 05:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88FCE;
        Tue, 22 Aug 2023 02:06:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D31811F892;
        Tue, 22 Aug 2023 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692695164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjhH5JJ/uYj/hECeKPplzMxBqTx0eSMbwEKi7pYJDLA=;
        b=m2Duffi8ECPm5ogSxiwZKOFctpoO5fB08TMKXwxMq8yjY4G+cG8jzdmMe/oms4pw/lNOlt
        5w9rj/Ky0czINnSBLoieks0aLYxh9a2faKlXMdN9+A2q7jnnzFcmLEeyigE2twSMeg+g3G
        KCx7Wi4jeTs0OyFj8UFIEZm2MZOm3kQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B41AD132B9;
        Tue, 22 Aug 2023 09:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYKaKXx65GRcfAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 22 Aug 2023 09:06:04 +0000
Date:   Tue, 22 Aug 2023 11:06:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821205458.1764662-4-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> Unified flushing allows for great concurrency for paths that attempt to
> flush the stats, at the expense of potential staleness and a single
> flusher paying the extra cost of flushing the full tree.
> 
> This tradeoff makes sense for in-kernel flushers that may observe high
> concurrency (e.g. reclaim, refault). For userspace readers, stale stats
> may be unexpected and problematic, especially when such stats are used
> for critical paths such as userspace OOM handling. Additionally, a
> userspace reader will occasionally pay the cost of flushing the entire
> hierarchy, which also causes problems in some cases [1].
> 
> Opt userspace reads out of unified flushing. This makes the cost of
> reading the stats more predictable (proportional to the size of the
> subtree), as well as the freshness of the stats. Since userspace readers
> are not expected to have similar concurrency to in-kernel flushers,
> serializing them among themselves and among in-kernel flushers should be
> okay.
> 
> This was tested on a machine with 256 cpus by running a synthetic test
> The script that creates 50 top-level cgroups, each with 5 children (250
> leaf cgroups). Each leaf cgroup has 10 processes running that allocate
> memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
> unified flusher). Concurrently, one thread is spawned per-cgroup to read
> the stats every second (including root, top-level, and leaf cgroups --
> so total 251 threads). No regressions were observed in the total running
> time; which means that non-unified userspace readers are not slowing
> down in-kernel unified flushers:

I have to admit I am rather confused by cgroup_rstat_flush (and
cgroup_rstat_flush_locked). The former says it can block but the later
doesn't ever block and even if it drops the cgroup_rstat_lock it merely
cond_rescheds or busy loops. How much of a contention and yielding can
you see with this patch? What is the worst case? How bad a random user
can make the situation by going crazy and trying to flush from many
different contexts?
-- 
Michal Hocko
SUSE Labs
