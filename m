Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CFF6412CE
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 01:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiLCAy0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 19:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiLCAyK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 19:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC119015;
        Fri,  2 Dec 2022 16:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E93BFB8232E;
        Sat,  3 Dec 2022 00:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CDBC433D6;
        Sat,  3 Dec 2022 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670028628;
        bh=EKRe6KWYgeFiWWRxv1SzpLFERN+u/q9W6swOVGSf+Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sSnu9b5nlPnsxvsV5oLdBcYxp66/68wU/Y8129B1Zki2o8i1c+P9oj0N2zJ+9Cab7
         fR2cqb0BJlAJQJMJOqRsvdO8UxZ+SHcXtRWqbNffQ7kLiES3gq/0KHqRWG3ohFVjwh
         BxboM1ujg58+y6sF0XSg1BzImFs3wSl3Z0w0MLSc=
Date:   Fri, 2 Dec 2022 16:50:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim
 target memcg
Message-Id: <20221202165027.8d0761724f30f6701a9a5da0@linux-foundation.org>
In-Reply-To: <CAJD7tkapGALWoqrs+cbE8i1w4eDcdj=naHxqybPu6NLAnCZ0iQ@mail.gmail.com>
References: <20221202031512.1365483-1-yosryahmed@google.com>
        <20221202031512.1365483-2-yosryahmed@google.com>
        <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
        <20221202163527.a72646c9d42f3678b20dac7b@linux-foundation.org>
        <CAJD7tkapGALWoqrs+cbE8i1w4eDcdj=naHxqybPu6NLAnCZ0iQ@mail.gmail.com>
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

On Fri, 2 Dec 2022 16:38:12 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> On Fri, Dec 2, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 2 Dec 2022 16:26:05 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > Andrew, does this need to be picked up by stable branches?
> >
> > Does it?  The changelog doesn't have a clear description of the
> > user-visible effects of the flaw, which is the guiding light for a
> > backport?
> >
> >
> 
> There are 2 example scenarios in the changelog that misbehave without
> this fix, cases where the protection of a memcg that is the target of
> reclaim is not ignored as it should be.

Yes.  I found them quite unclear.  How would someone who is
experiencing a particualr runtime issue be able to recognize whether
this patch might address that issue?

