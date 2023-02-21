Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103469E64B
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjBURtS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjBURtR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:49:17 -0500
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5F2DE7D
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 09:49:16 -0800 (PST)
Date:   Tue, 21 Feb 2023 09:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677001755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaPQBeAqUbK/3uqJSLJQEsHhoRu/puBJx1HPQm6lT2k=;
        b=k4AQBnnNlebWncyyit/YQ4icinXPdj7y+dPZM0jGb8f0Q87q0GA2cL+WHiURqTE7xqk/LQ
        ZasPA7nfI8VWU2k5NRuBbPxbjzzff5gy14YAPvMueZUMEpggw0lDSCOIidUbvK+0WMuvsj
        ptaJ8q09dJHrgHQOuhx0x3iMvIEFJzI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>, Yue Zhao <findns94@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/UEBc4qyLIqHGIA@P9FQF9L96D.corp.robot.car>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <61CA5FFC-547B-4F56-9238-C9096223BF80@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61CA5FFC-547B-4F56-9238-C9096223BF80@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 03:22:32PM +0800, Muchun Song wrote:
> 
> 
> > On Feb 21, 2023, at 13:17, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > 
> >> On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >> 
> >> ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> >>>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> >>>> The knob for cgroup v2 memory controller: memory.oom.group
> >>>> will be read and written simultaneously by user space
> >>>> programs, thus we'd better change memcg->oom_group access
> >>>> with atomic operations to avoid concurrency problems.
> >>>> 
> >>>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> >>> 
> >>> Hi Yue!
> >>> 
> >>> I'm curious, have any seen any real issues which your patch is solving?
> >>> Can you, please, provide a bit more details.
> >>> 
> >> 
> >> IMHO such details are not needed. oom_group is being accessed
> >> concurrently and one of them can be a write access. At least
> >> READ_ONCE/WRITE_ONCE is needed here.
> > 
> > Needed for what?
> > 
> > I mean it’s obviously not a big deal to put READ_ONCE()/WRITE_ONCE() here, but I struggle to imagine a scenario when it will make any difference. IMHO it’s easier to justify a proper atomic operation here, even if it’s most likely an overkill.
> > 
> > My question is very simple: the commit log mentions “… to avoid concurrency problems”, so I wonder what problems are these.
> 
> I think there is no difference in the assembly code between them in most
> cases. The only intention that I can think of is to avoid the potential
> complaint (data race) emitted by KCSAN.

+1

And it might be a totally good reason for this change, let's just make it clear,
instead of pretending to fix non-existing concurrency problems.

Thanks!
