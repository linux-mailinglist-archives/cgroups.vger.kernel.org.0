Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98669EA4C
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBUWjl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 17:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBUWjl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 17:39:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F610FD;
        Tue, 21 Feb 2023 14:39:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72409611BD;
        Tue, 21 Feb 2023 22:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E1C433EF;
        Tue, 21 Feb 2023 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677019091;
        bh=2sWLbLiArSRP6fpw1jWyGxHh6cTuTXDv/z4xj7AEoCU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pY3MIzzlKkDv8VwY45izhDjNAY+ObhdNh+vjNO9vrGC9yQZFHvDcLJHeqaY9wx9id
         Z40VsPpdfBACK5xQmjCK2S9pSiLM3h+ubiUvFgZpbQhPOEPjcdYP3YIHKJNMzq65G4
         ziRYyw2WHsrXLVmOTeMznA54RNp9ARr1uHw2vItVi3v8/I7duyDzKLkUvmD/S9Pmkj
         dgiCw4BmXejAerbVKlW3K6tMBQcGbY/A4nQj4we5Qcxdpz8+9PfsknZtyA/VjRCz0t
         ooSDqIFMGC8x6Ffeetko8vMS5nrQfdTVMpitsqqu7Ez0VKXo3pBXfUPsfTUO+Q10XJ
         RAhtTkupb71uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C8FF5C065D; Tue, 21 Feb 2023 14:38:11 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:38:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <20230221223811.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
 <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
 <20230221182359.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/VEY2myhfWvB64+@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/VEY2myhfWvB64+@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 02:23:31PM -0800, Roman Gushchin wrote:
> On Tue, Feb 21, 2023 at 10:23:59AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 21, 2023 at 08:56:59AM -0800, Shakeel Butt wrote:
> > > +Paul & Marco
> > > 
> > > On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > > > > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > > > > > >
> > > > > > > ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > > > > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > > > > >>> will be read and written simultaneously by user space
> > > > > > >>> programs, thus we'd better change memcg->oom_group access
> > > > > > >>> with atomic operations to avoid concurrency problems.
> > > > > > >>>
> > > > > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > > > > >>
> > > > > > >> Hi Yue!
> > > > > > >>
> > > > > > >> I'm curious, have any seen any real issues which your patch is solving?
> > > > > > >> Can you, please, provide a bit more details.
> > > > > > >>
> > > > > > >
> > > > > > > IMHO such details are not needed. oom_group is being accessed
> > > > > > > concurrently and one of them can be a write access. At least
> > > > > > > READ_ONCE/WRITE_ONCE is needed here.
> > > > > >
> > > > > > Needed for what?
> > > > >
> > > > > For this particular case, documenting such an access. Though I don't
> > > > > think there are any architectures which may tear a one byte read/write
> > > > > and merging/refetching is not an issue for this.
> > > >
> > > > Wouldn't a compiler be within its rights to implement a one byte store as:
> > > >
> > > >         load-word
> > > >         modify-byte-in-word
> > > >         store-word
> > > >
> > > > and if this is a lockless store to a word which has an adjacent byte also
> > > > being modified by another CPU, one of those CPUs can lose its store?
> > > > And WRITE_ONCE would prevent the compiler from implementing the store
> > > > in that way.
> > > 
> > > Thanks Willy for pointing this out. If the compiler can really do this
> > > then [READ|WRITE]_ONCE are required here. I always have big bad
> > > compiler lwn article open in a tab. I couldn't map this transformation
> > > to ones mentioned in that article. Do we have name of this one?
> > 
> > No, recent compilers are absolutely forbidden from doing this sort of
> > thing except under very special circumstances.
> > 
> > Before C11, compilers could and in fact did do things like this.  This is
> > after all a great way to keep the CPU's vector unit from getting bored.
> > Unfortunately for those who prize optimization above all else, doing
> > this can introduce data races, for example:
> > 
> > 	char a;
> > 	char b;
> > 	spin_lock la;
> > 	spin_lock lb;
> > 
> > 	void change_a(char new_a)
> > 	{
> > 		spin_lock(&la);
> > 		a = new_a;
> > 		spin_unlock(&la);
> > 	}
> > 
> > 	void change_b(char new_b)
> > 	{
> > 		spin_lock(&lb);
> > 		b = new_b;
> > 		spin_unlock(&lb);
> > 	}
> > 
> > If the compiler "optimized" that "a = new_a" so as to produce a non-atomic
> > read-modify-write sequence, it would be introducing a data race.
> > And since C11, the compiler is absolutely forbidden from introducing
> > data races.  So, again, no, the compiler cannot invent writes to
> > variables.
> > 
> > What are those very special circumstances?
> > 
> > 1.	The other variables were going to be written to anyway, and
> > 	none of the writes was non-volatile and there was no ordering
> > 	directive between any of those writes.
> > 
> > 2.	The other variables are dead, as in there are no subsequent
> > 	reads from them anywhere in the program.  Of course in that case,
> > 	there is no need to read the prior values of those variables.
> > 
> > 3.	All accesses to all of the variables are visible to the compiler,
> > 	and the compiler can prove that there are no concurrent accesses
> > 	to any of them.  For example, all of the variables are on-stack
> > 	variables whose addresses are never taken.
> > 
> > Does that help, or am I misunderstanding the question?
> 
> Thank you, Paul!
> 
> So it seems like READ_ONCE()/WRITE_ONCE() are totally useless here.
> Or I still miss something?

Yes, given that the compiler will already avoid inventing data-race-prone
C-language accesses to shared variables, so if that was the only reason
that you were using READ_ONCE() or WRITE_ONCE(), then READ_ONCE() and
WRITE_ONCE() won't be helping you.

Or perhaps better to put it a different way...  The fact that the compiler
is not permitted to invent data-racy reads and writes is exactly why
you do not normally need READ_ONCE() and WRITE_ONCE() for accesses in
lock-based critical sections.  Instead, you only need READ_ONCE() and
WRITE_ONCE() when you have lockless accesses to the same shared variables.

							Thanx, Paul
