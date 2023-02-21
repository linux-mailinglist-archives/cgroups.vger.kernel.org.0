Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175CB69EB8D
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 00:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBUX6Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 18:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBUX6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 18:58:24 -0500
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65A25E10
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 15:58:22 -0800 (PST)
Date:   Tue, 21 Feb 2023 15:57:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677023899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0w2q1+fgkXM8VqGxzCmpXcrJt8lRH7j7myHhNUQUFhc=;
        b=e3iOG7gVb1rYOmpMnUAF4daiLb4LdLdCSXjubiHfiSkJkv33MuwWdFg80gcmHfFGQtv+4f
        7ffeHmGTYooclzjURTnuwUVAhKJY5hQrPEd1/oishU5tNFMrWRwiLWqtmzuO0nxawSHfS8
        3NCSH8KSbZylrUo1nUmXqgTxAweW634=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/VahsJO3xNXi4CG@P9FQF9L96D.corp.robot.car>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
 <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
 <20230221182359.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y/VEY2myhfWvB64+@P9FQF9L96D.corp.robot.car>
 <20230221223811.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <CALvZod7DaFeXFjYpnuP8U3QOjsQmKFHDMruB1-cm3Ly0HOH2FQ@mail.gmail.com>
 <20230221233824.GM2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221233824.GM2948950@paulmck-ThinkPad-P17-Gen-1>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 03:38:24PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 21, 2023 at 03:13:36PM -0800, Shakeel Butt wrote:
> > On Tue, Feb 21, 2023 at 2:38 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Tue, Feb 21, 2023 at 02:23:31PM -0800, Roman Gushchin wrote:
> > > > On Tue, Feb 21, 2023 at 10:23:59AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Feb 21, 2023 at 08:56:59AM -0800, Shakeel Butt wrote:
> > > > > > +Paul & Marco
> > > > > >
> > > > > > On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > > > > > > > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > > > > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > ﻿On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > > > > > > > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > > > > > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > > > > > > > >>> will be read and written simultaneously by user space
> > > > > > > > > >>> programs, thus we'd better change memcg->oom_group access
> > > > > > > > > >>> with atomic operations to avoid concurrency problems.
> > > > > > > > > >>>
> > > > > > > > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > > > > > > > >>
> > > > > > > > > >> Hi Yue!
> > > > > > > > > >>
> > > > > > > > > >> I'm curious, have any seen any real issues which your patch is solving?
> > > > > > > > > >> Can you, please, provide a bit more details.
> > > > > > > > > >>
> > > > > > > > > >
> > > > > > > > > > IMHO such details are not needed. oom_group is being accessed
> > > > > > > > > > concurrently and one of them can be a write access. At least
> > > > > > > > > > READ_ONCE/WRITE_ONCE is needed here.
> > > > > > > > >
> > > > > > > > > Needed for what?
> > > > > > > >
> > > > > > > > For this particular case, documenting such an access. Though I don't
> > > > > > > > think there are any architectures which may tear a one byte read/write
> > > > > > > > and merging/refetching is not an issue for this.
> > > > > > >
> > > > > > > Wouldn't a compiler be within its rights to implement a one byte store as:
> > > > > > >
> > > > > > >         load-word
> > > > > > >         modify-byte-in-word
> > > > > > >         store-word
> > > > > > >
> > > > > > > and if this is a lockless store to a word which has an adjacent byte also
> > > > > > > being modified by another CPU, one of those CPUs can lose its store?
> > > > > > > And WRITE_ONCE would prevent the compiler from implementing the store
> > > > > > > in that way.
> > > > > >
> > > > > > Thanks Willy for pointing this out. If the compiler can really do this
> > > > > > then [READ|WRITE]_ONCE are required here. I always have big bad
> > > > > > compiler lwn article open in a tab. I couldn't map this transformation
> > > > > > to ones mentioned in that article. Do we have name of this one?
> > > > >
> > > > > No, recent compilers are absolutely forbidden from doing this sort of
> > > > > thing except under very special circumstances.
> > > > >
> > > > > Before C11, compilers could and in fact did do things like this.  This is
> > > > > after all a great way to keep the CPU's vector unit from getting bored.
> > > > > Unfortunately for those who prize optimization above all else, doing
> > > > > this can introduce data races, for example:
> > > > >
> > > > >     char a;
> > > > >     char b;
> > > > >     spin_lock la;
> > > > >     spin_lock lb;
> > > > >
> > > > >     void change_a(char new_a)
> > > > >     {
> > > > >             spin_lock(&la);
> > > > >             a = new_a;
> > > > >             spin_unlock(&la);
> > > > >     }
> > > > >
> > > > >     void change_b(char new_b)
> > > > >     {
> > > > >             spin_lock(&lb);
> > > > >             b = new_b;
> > > > >             spin_unlock(&lb);
> > > > >     }
> > > > >
> > > > > If the compiler "optimized" that "a = new_a" so as to produce a non-atomic
> > > > > read-modify-write sequence, it would be introducing a data race.
> > > > > And since C11, the compiler is absolutely forbidden from introducing
> > > > > data races.  So, again, no, the compiler cannot invent writes to
> > > > > variables.
> > > > >
> > > > > What are those very special circumstances?
> > > > >
> > > > > 1.  The other variables were going to be written to anyway, and
> > > > >     none of the writes was non-volatile and there was no ordering
> > > > >     directive between any of those writes.
> > > > >
> > > > > 2.  The other variables are dead, as in there are no subsequent
> > > > >     reads from them anywhere in the program.  Of course in that case,
> > > > >     there is no need to read the prior values of those variables.
> > > > >
> > > > > 3.  All accesses to all of the variables are visible to the compiler,
> > > > >     and the compiler can prove that there are no concurrent accesses
> > > > >     to any of them.  For example, all of the variables are on-stack
> > > > >     variables whose addresses are never taken.
> > > > >
> > > > > Does that help, or am I misunderstanding the question?
> > > >
> > > > Thank you, Paul!
> > > >
> > > > So it seems like READ_ONCE()/WRITE_ONCE() are totally useless here.
> > > > Or I still miss something?
> > >
> > > Yes, given that the compiler will already avoid inventing data-race-prone
> > > C-language accesses to shared variables, so if that was the only reason
> > > that you were using READ_ONCE() or WRITE_ONCE(), then READ_ONCE() and
> > > WRITE_ONCE() won't be helping you.
> > >
> > > Or perhaps better to put it a different way...  The fact that the compiler
> > > is not permitted to invent data-racy reads and writes is exactly why
> > > you do not normally need READ_ONCE() and WRITE_ONCE() for accesses in
> > > lock-based critical sections.  Instead, you only need READ_ONCE() and
> > > WRITE_ONCE() when you have lockless accesses to the same shared variables.
> > 
> > This is lockless access to memcg->oom_group potentially from multiple
> > CPUs, so, READ_ONCE() and WRITE_ONCE() are needed, right?
> 
> Agreed, lockless concurrent accesses should use READ_ONCE() and WRITE_ONCE().
> And if either conflicting access is lockless, it is lockless.  ;-)

Now I'm confused, why we should use it here?
Writing is happening from a separate syscall (a single write from a syscall),
reading is happening from a oom context. The variable is boolean, it's either
0 or 1. What difference READ_ONCE()/WRITE_ONCE() will make here?
Thanks!
