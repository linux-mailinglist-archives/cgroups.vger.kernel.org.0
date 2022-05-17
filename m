Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9433152A797
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiEQQFR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 12:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbiEQQFQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 12:05:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B3B50046
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 09:05:15 -0700 (PDT)
Date:   Tue, 17 May 2022 09:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652803513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QRscBrAyYKCcsJKeuDnK4iX4aYhS2tbsgqstU6o6r+0=;
        b=E3i7b2DvMjTaav2SXoJjrd4womnB85IlKuEu0WiUCqZOEn75QMduH1dscInT1mHh0d/X2H
        0jfXW0NcaUEoShRxWykTXdll8ZmIL2hasAGT/f1bR4rCjzHLRtw0/jnJJQshTVZLxaQqBF
        KkiCSxwcLLhNNQrn0+qH6cl7D3G9GSE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
Message-ID: <YoPHtHXzpK51F/1Z@carbon>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 16, 2022 at 03:29:42PM -0700, Yosry Ahmed wrote:
> The discussions on the patch series [1] to add memory.reclaim has
> shown that it is desirable to add an argument to control the type of
> memory being reclaimed by invoked proactive reclaim using
> memory.reclaim.
> 
> I am proposing adding a swappiness optional argument to the interface.
> If set, it overwrites vm.swappiness and per-memcg swappiness. This
> provides a way to enforce user policy on a stateless per-reclaim
> basis. We can make policy decisions to perform reclaim differently for
> tasks of different app classes based on their individual QoS needs. It
> also helps for use cases when particularly page cache is high and we
> want to mainly hit that without swapping out.
> 
> The interface would be something like this (utilizing the nested-keyed
> interface we documented earlier):
> 
> $ echo "200M swappiness=30" > memory.reclaim

What are the anticipated use cases except swappiness == 0 and
swappiness == system_default?

IMO it's better to allow specifying the type of memory to reclaim,
e.g. type="file"/"anon"/"slab", it's a way more clear what to expect.

E.g. what
$ echo "200M swappiness=1" > memory.reclaim
means if there is only 10M of pagecache? How much of anon memory will
be reclaimed?

Thanks!
