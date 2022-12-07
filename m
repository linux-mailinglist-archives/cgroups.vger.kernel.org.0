Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3C64637D
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 22:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGVvN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGVvM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 16:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ACC62EA6;
        Wed,  7 Dec 2022 13:51:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 544F961CAB;
        Wed,  7 Dec 2022 21:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C774C433D6;
        Wed,  7 Dec 2022 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670449869;
        bh=lOzePfG+gfzij5YGhbjycoi2p2PKhj4xCr9a0XLkW7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qAeunG95UWOW53nZ4bn+0tSSku08KCUXDW0eYgErfMITVSEM0r0BgPOUJEwHKCEsw
         Qk1Ug0XI/fjFr1Dr4jnFNUIUdbJpkvdtrW1s/VhUqfkyXF/grfKFD0z/YPBFUy2kCE
         sSQZHlM4fu8tYRGxpXTtq06S1jSnpS2fpOmaaB8g=
Date:   Wed, 7 Dec 2022 13:51:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcontrol: deprecate charge moving
Message-Id: <20221207135108.fe1d51f7581f6ff86dbf9bc8@linux-foundation.org>
In-Reply-To: <CALvZod6WcBifeWJYG_QLr9Uy5aSbpLoCVyOp+FVx0ca1gzq4fA@mail.gmail.com>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
        <20221206171340.139790-4-hannes@cmpxchg.org>
        <CALvZod6WcBifeWJYG_QLr9Uy5aSbpLoCVyOp+FVx0ca1gzq4fA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 6 Dec 2022 16:03:54 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Dec 6, 2022 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Charge moving mode in cgroup1 allows memory to follow tasks as they
> > migrate between cgroups. This is, and always has been, a questionable
> > thing to do - for several reasons.
> >
> > First, it's expensive. Pages need to be identified, locked and
> > isolated from various MM operations, and reassigned, one by one.
> >
> > Second, it's unreliable. Once pages are charged to a cgroup, there
> > isn't always a clear owner task anymore. Cache isn't moved at all, for
> > example. Mapped memory is moved - but if trylocking or isolating a
> > page fails, it's arbitrarily left behind. Frequent moving between
> > domains may leave a task's memory scattered all over the place.
> >
> > Third, it isn't really needed. Launcher tasks can kick off workload
> > tasks directly in their target cgroup. Using dedicated per-workload
> > groups allows fine-grained policy adjustments - no need to move tasks
> > and their physical pages between control domains. The feature was
> > never forward-ported to cgroup2, and it hasn't been missed.
> >
> > Despite it being a niche usecase, the maintenance overhead of
> > supporting it is enormous. Because pages are moved while they are live
> > and subject to various MM operations, the synchronization rules are
> > complicated. There are lock_page_memcg() in MM and FS code, which
> > non-cgroup people don't understand. In some cases we've been able to
> > shift code and cgroup API calls around such that we can rely on native
> > locking as much as possible. But that's fragile, and sometimes we need
> > to hold MM locks for longer than we otherwise would (pte lock e.g.).
> >
> > Mark the feature deprecated. Hopefully we can remove it soon.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>
> 
> I would request this patch to be backported to stable kernels as well
> for early warnings to users which update to newer kernels very late.

Sounds reasonable, but the changelog should have a few words in it
explaining why we're requesting the backport.  I guess I can type those
in.

We're at -rc8 and I'm not planning on merging these up until after
6.2-rc1 is out.  Please feel free to argue with me on that score.
