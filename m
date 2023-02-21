Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A369E1B4
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjBUNvl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 08:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjBUNvj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 08:51:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB225E3D;
        Tue, 21 Feb 2023 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NEdXprvhxHyHHSPQOtkKZLXBLzv1Cy2bQgCVUfMHYac=; b=bH66sA8fhWiJwQgo9PIB7tMy5k
        CksVVbZTIHgCQSPNdPeVxN0HKxQ1+pV9FYrnABQ3mTEqaH7e1DRPYTwHZYBtSYyXZZWkl8y3Z68zq
        uQFaZrRSGbPJjxA/REMS6x8QUqcbMZ8qJeQKFzvwdyFT8wL5o/x2mhz5dHl2YFUDSnfQyymSPy8lx
        FAkT6yQ9vuZLtc5WTQoo3oTYkHeGORlrSkJhFeNKSLbHLDY9ayuIgtw7AEwx/Pb4/9QHd+lXRXmHn
        rVqTpfRYBenwXyzvbVqvMDx7Sk/DmvQdOJO+34bkSxQdt7ZAIvHFZ7eOl0ME9lDFuAn9uvJ+fpjNG
        0W6/FiLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUT3J-00CeYG-Ir; Tue, 21 Feb 2023 13:51:29 +0000
Date:   Tue, 21 Feb 2023 13:51:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/TMYa8DrocppXRu@casper.infradead.org>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
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
> 
> For this particular case, documenting such an access. Though I don't
> think there are any architectures which may tear a one byte read/write
> and merging/refetching is not an issue for this.

Wouldn't a compiler be within its rights to implement a one byte store as:

	load-word
	modify-byte-in-word
	store-word

and if this is a lockless store to a word which has an adjacent byte also
being modified by another CPU, one of those CPUs can lose its store?
And WRITE_ONCE would prevent the compiler from implementing the store
in that way.

