Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078575FF15
	for <lists+cgroups@lfdr.de>; Mon, 24 Jul 2023 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGXSbI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXSbH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 14:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D3A6;
        Mon, 24 Jul 2023 11:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE9561309;
        Mon, 24 Jul 2023 18:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D3DC433C7;
        Mon, 24 Jul 2023 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690223465;
        bh=VYtMyHmTjfqRNqrGlaslEXmtuJkxe6wetxm/yy7dEvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IMhdN1V+KZF00P6hoKJX2tFLxgM5UA9dcRRI6pwyjwKF9aiDNJHJNlMHzyCOnn1d+
         2oQpxdGmHvtLO7jB1HOLpLMtFmtcQ67BKJJH1qJ0ytJZRTyZYoQZKKi2BJcvsCvYuh
         10MseRD2bM18o525xvpf+5RgkOcgjQ1VCFYGA7SY=
Date:   Mon, 24 Jul 2023 11:31:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
Message-Id: <20230724113104.6994bd471fb926ceeaf46707@linux-foundation.org>
In-Reply-To: <20230719174613.3062124-1-yosryahmed@google.com>
References: <20230719174613.3062124-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 19 Jul 2023 17:46:13 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> Currently, memcg uses rstat to maintain hierarchical stats. The rstat
> framework keeps track of which cgroups have updates on which cpus.
> 
> For non-hierarchical stats, as memcg moved to rstat, they are no longer
> readily available as counters. Instead, the percpu counters for a given
> stat need to be summed to get the non-hierarchical stat value. This
> causes a performance regression when reading non-hierarchical stats on
> kernels where memcg moved to using rstat. This is especially visible
> when reading memory.stat on cgroup v1. There are also some code paths
> internal to the kernel that read such non-hierarchical stats.
> 
> It is inefficient to iterate and sum counters in all cpus when the rstat
> framework knows exactly when a percpu counter has an update. Instead,
> maintain cpu-aggregated non-hierarchical counters for each stat. During
> an rstat flush, keep those updated as well. When reading
> non-hierarchical stats, we no longer need to iterate cpus, we just need
> to read the maintainer counters, similar to hierarchical stats.
> 
> A caveat is that we now a stats flush before reading
> local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> or memcg_events_local(), where we previously only needed a flush to
> read hierarchical stats. Most contexts reading non-hierarchical stats
> are already doing a flush, add a flush to the only missing context in
> count_shadow_nodes().
> 
> With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> machine with 256 cpus on cgroup v1:
>  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
>  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
>  real	 0m0.125s
>  user	 0m0.005s
>  sys	 0m0.120s
> 
> After:
>  real	 0m0.032s
>  user	 0m0.005s
>  sys	 0m0.027s
> 

I'll queue this for some testing, pending reviewer input, please.
