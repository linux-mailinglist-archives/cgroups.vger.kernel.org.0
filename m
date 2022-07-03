Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50A564A87
	for <lists+cgroups@lfdr.de>; Mon,  4 Jul 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGCXXq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Jul 2022 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGCXXp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Jul 2022 19:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B15FE7;
        Sun,  3 Jul 2022 16:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A8FB80BEB;
        Sun,  3 Jul 2022 23:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FFC341C6;
        Sun,  3 Jul 2022 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656890621;
        bh=EDIwVumbRS+j2biW/LWEapjenLtWMcKX8aj62iSrHFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UGoty1uxOxulUsQC/avpz8A7yZpRuf7BdzfbceCmcdN+XaD+urZDeSlb6tyAxPZfO
         K+dIpKI3tvnIYwdfDirzlucGlozflAtVanLk5BUjPWntuAOYGjHdgLNk2BtL9kDtrk
         IJ+i8dgF7XEGChVK7VyVarTJ4q9rqmJJCYvnN130=
Date:   Sun, 3 Jul 2022 16:23:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, longman@redhat.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-Id: <20220703162340.cb90924355dacbb7437ab595@linux-foundation.org>
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 21 Jun 2022 20:56:47 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This version is rebased on mm-unstable. Hopefully, Andrew can get this series
> into mm-unstable which will help to determine whether there is a problem or
> degradation. I am also doing some benchmark tests in parallel.
> 
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
> 
> 	commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
> 	commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> 
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg direction
> to fix this problem, and then the LRU pages will not pin the memcgs.
> 
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> of the dying cgroups will not increase if we run the following test script.
> 
> ...
>

I don't have reviewer or acker tags on a couple of these, but there is
still time - I plan to push this series into mm-stable around July 8.

