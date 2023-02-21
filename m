Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791769E768
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 19:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBUSYF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 13:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBUSYE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 13:24:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638D3CDFA;
        Tue, 21 Feb 2023 10:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23195B80E9D;
        Tue, 21 Feb 2023 18:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A54C433D2;
        Tue, 21 Feb 2023 18:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677003839;
        bh=9ofw9kmJ1/A9L4elUMt/ZOXxCnVJ5NivStbIGbYhioE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=juAEGmzdsgfKKLgLJNn+Inn1X4C1M6/sxFFCnpsa66BydSQlHcBhJQ8BZlWZl3izN
         bJTP6eMwLJEaw0CGN50rbbw8xLUi/3lalJm/AvX09Ta6xCwYX3Pr82beAkwouT76FA
         xnGh8ybiK7K3uCfExn2Gc6EOOFLNJP9FgHRMCK+98Tqi/xWZJXK0fmnltLX+GTkqs4
         6LIv2HfpocPjQckppEZF9KSI5oITDttJW3l387+BkEOXlkf47QskdX1KRRysWBJ/4Q
         6sQF3JbaGB5hwfhVHYJr3WVojohK9l6pSGDnvFJ8qWFNExnhUmDpzEQZJi1PHPm4RV
         YNn+/e5k6iegg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79FF65C065D; Tue, 21 Feb 2023 10:23:59 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:23:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <20230221182359.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
 <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 08:56:59AM -0800, Shakeel Butt wrote:
> +Paul & Marco
> 
> On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > > >>> will be read and written simultaneously by user space
> > > > >>> programs, thus we'd better change memcg->oom_group access
> > > > >>> with atomic operations to avoid concurrency problems.
> > > > >>>
> > > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > > >>
> > > > >> Hi Yue!
> > > > >>
> > > > >> I'm curious, have any seen any real issues which your patch is solving?
> > > > >> Can you, please, provide a bit more details.
> > > > >>
> > > > >
> > > > > IMHO such details are not needed. oom_group is being accessed
> > > > > concurrently and one of them can be a write access. At least
> > > > > READ_ONCE/WRITE_ONCE is needed here.
> > > >
> > > > Needed for what?
> > >
> > > For this particular case, documenting such an access. Though I don't
> > > think there are any architectures which may tear a one byte read/write
> > > and merging/refetching is not an issue for this.
> >
> > Wouldn't a compiler be within its rights to implement a one byte store as:
> >
> >         load-word
> >         modify-byte-in-word
> >         store-word
> >
> > and if this is a lockless store to a word which has an adjacent byte also
> > being modified by another CPU, one of those CPUs can lose its store?
> > And WRITE_ONCE would prevent the compiler from implementing the store
> > in that way.
> 
> Thanks Willy for pointing this out. If the compiler can really do this
> then [READ|WRITE]_ONCE are required here. I always have big bad
> compiler lwn article open in a tab. I couldn't map this transformation
> to ones mentioned in that article. Do we have name of this one?

No, recent compilers are absolutely forbidden from doing this sort of
thing except under very special circumstances.

Before C11, compilers could and in fact did do things like this.  This is
after all a great way to keep the CPU's vector unit from getting bored.
Unfortunately for those who prize optimization above all else, doing
this can introduce data races, for example:

	char a;
	char b;
	spin_lock la;
	spin_lock lb;

	void change_a(char new_a)
	{
		spin_lock(&la);
		a = new_a;
		spin_unlock(&la);
	}

	void change_b(char new_b)
	{
		spin_lock(&lb);
		b = new_b;
		spin_unlock(&lb);
	}

If the compiler "optimized" that "a = new_a" so as to produce a non-atomic
read-modify-write sequence, it would be introducing a data race.
And since C11, the compiler is absolutely forbidden from introducing
data races.  So, again, no, the compiler cannot invent writes to
variables.

What are those very special circumstances?

1.	The other variables were going to be written to anyway, and
	none of the writes was non-volatile and there was no ordering
	directive between any of those writes.

2.	The other variables are dead, as in there are no subsequent
	reads from them anywhere in the program.  Of course in that case,
	there is no need to read the prior values of those variables.

3.	All accesses to all of the variables are visible to the compiler,
	and the compiler can prove that there are no concurrent accesses
	to any of them.  For example, all of the variables are on-stack
	variables whose addresses are never taken.

Does that help, or am I misunderstanding the question?

							Thanx, Paul
