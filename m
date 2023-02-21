Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189A69E6BB
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBUSDM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 13:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBUSDM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 13:03:12 -0500
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [IPv6:2001:41d0:203:375::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE96FF0C
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 10:03:11 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677002589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMsd45Umu3YuXLOVUwNN2b4uIloC4nQS/PME1ZUx4QY=;
        b=SHxsvZwyD5BmnUlPUsuusjZp3+TIl7ZqP0jdYYQwCKbWrkJ5vCHsFzPZQfPOB9oXXIDMOY
        YDC9T3cOn/usAilO1GAUxTsMoEZsSW9jal21ISKN04+sEI1olhWLV+lwwVv3QF5kklCJF+
        Q210mi7PR6nlOH1EM4T9+fTSiLRE8gA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Martin Zhao <findns94@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/UHS0QYWoBmVrR9@P9FQF9L96D.corp.robot.car>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CADfL_jBDNZiEWbnn+w9+FhSRPzVwP872XBbhYTZwny8Jzr4bDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADfL_jBDNZiEWbnn+w9+FhSRPzVwP872XBbhYTZwny8Jzr4bDw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 22, 2023 at 01:00:00AM +0800, Martin Zhao wrote:
> On Tue, Feb 21, 2023 at 1:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > >>> will be read and written simultaneously by user space
> > >>> programs, thus we'd better change memcg->oom_group access
> > >>> with atomic operations to avoid concurrency problems.
> > >>>
> > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > >>
> > >> Hi Yue!
> > >>
> > >> I'm curious, have any seen any real issues which your patch is solving?
> > >> Can you, please, provide a bit more details.
> > >>
> > >
> > > IMHO such details are not needed. oom_group is being accessed
> > > concurrently and one of them can be a write access. At least
> > > READ_ONCE/WRITE_ONCE is needed here.
> >
> > Needed for what?
> >
> > I mean it’s obviously not a big deal to put READ_ONCE()/WRITE_ONCE() here, but I struggle to imagine a scenario when it will make any difference. IMHO it’s easier to justify a proper atomic operation here, even if it’s most likely an overkill.
> >
> > My question is very simple: the commit log mentions “… to avoid concurrency problems”, so I wonder what problems are these.
> 
> Thanks for your watching!
> This topic is found in code review by coincidence, so no real issues
> recorded for now. I checked other read/write callbacks about other knobs,
> most of them use READ_ONCE/WRITE_ONCE on the user setting variable.

Sorry, which knobs are you talking about? I actually don't see any user knobs
in mm/memcontrol.c which are using WRITE_ONCE(). I see some of them using
xchg(), but it's a different thing.

> Actually I am curious as well why this interface doesn't use
> READ_ONCE/WRITE_ONCE, is there any other synchronization mechanism I
> didn't notice yet?

Because nobody saw any issues with the current code?

And again if it's something that makes any automated verifiers/tooling unhappy,
I'm totally fine for fixing it, just let make it clear (and also fix the commit
title, which is not true).

Thanks!
