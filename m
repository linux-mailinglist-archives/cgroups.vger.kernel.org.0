Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7469E63F
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjBURrj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjBURre (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:47:34 -0500
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80B2F7A8
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 09:47:24 -0800 (PST)
Date:   Tue, 21 Feb 2023 09:47:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677001642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Vle9DIVimy94+UNgGowfW4NEcOWHtMED9QUramsCw=;
        b=tGJQqG2SnvFiAeIRPoeutMXJ8iZZtSxdJyku+xpxaxa3+Dvk2zq/YT7AMOnbj3PvaMVaXy
        ifTNdgxKhi/ObJVbavXqJsmPBJKDW6C1p0zbbIQPbpBYy9Z9dPsMuBJP2UunxLKJh8myrw
        MH2cdrdcc1F8cKP3K+ah8r2/B03ZsRc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/UDmc3+uIErpanS@P9FQF9L96D.corp.robot.car>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/TMYa8DrocppXRu@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 01:51:29PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > >>> will be read and written simultaneously by user space
> > > >>> programs, thus we'd better change memcg->oom_group access
> > > >>> with atomic operations to avoid concurrency problems.
> > > >>>
> > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > >>
> > > >> Hi Yue!
> > > >>
> > > >> I'm curious, have any seen any real issues which your patch is solving?
> > > >> Can you, please, provide a bit more details.
> > > >>
> > > >
> > > > IMHO such details are not needed. oom_group is being accessed
> > > > concurrently and one of them can be a write access. At least
> > > > READ_ONCE/WRITE_ONCE is needed here.
> > >
> > > Needed for what?
> > 
> > For this particular case, documenting such an access. Though I don't
> > think there are any architectures which may tear a one byte read/write
> > and merging/refetching is not an issue for this.
> 
> Wouldn't a compiler be within its rights to implement a one byte store as:
> 
> 	load-word
> 	modify-byte-in-word
> 	store-word
> 
> and if this is a lockless store to a word which has an adjacent byte also
> being modified by another CPU, one of those CPUs can lose its store?
> And WRITE_ONCE would prevent the compiler from implementing the store
> in that way.

Even then it's not an issue in this case, as we end up with either 0 or 1,
I don't see how we can screw things up here.

Thanks!
