Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313D271353F
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjE0PHf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 May 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE0PHe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 May 2023 11:07:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2868E3;
        Sat, 27 May 2023 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=loxo3o+bCByV7kuxO8tBvwlfDa2341F3CpYgMrLNBcA=; b=AfN7nBhiA+MsFKTyviECPRCgZG
        cji0YDU+jsr87bzmrt10rBcc5NwzjUiNNHINgZV0FeQHCeGKL5PbmI58kQ4wXUPyt7BowsndH05J6
        vKhMd5kdVYhYAWwpr0q7dKn8UFbYqtB8mI9fdOHj9An/K0TpwcUTJ3mrd/HVS5FrPvVOaP7D2Y58s
        HObFa4n4setAY/vRQ5EfL84Rxi1iHLQJUifvZITYUBUrgPNgJGdQ3Q7uNnMLlwahFqDYCX5Lu3TTB
        /1I8RtvxvQRzAUggbAKizv5koVTqUxkvB18EED/l6BseB9iOZQKTQoCymtfBPiewYHl9D1g78AU4M
        yUosG5fg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2vVc-003tkD-Mr; Sat, 27 May 2023 15:07:08 +0000
Date:   Sat, 27 May 2023 16:07:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
Message-ID: <ZHIcnOV/mrkcerlG@casper.infradead.org>
References: <20230527103126.398267-1-linmiaohe@huawei.com>
 <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 26, 2023 at 09:13:05PM -0700, Yosry Ahmed wrote:
> On Fri, May 26, 2023 at 9:01 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
> > > The function mem_cgroup_from_obj() is not used anymore. Remove it and
> > > clean up relevant comments.
> >
> > You should have looked at the git history to see why it was created
> > and who used it.
> >
> > Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?
> 
> That commit did not introduce the function though, no? It was
> introduced before it and replaced by other variants over time (like
> mem_cgroup_from_slab_obj()). It looks like that commit was reverted ~9
> months ago. We can always bring it back if/when needed.

The commit immediately preceding it is fc4db90fe71e.

Of course we can bring it back.  It's just code.  But avoiding
unnecessary churn is also good.  Let's wait to hear from Vasily.

> It also looks to me that 1d0403d20f6c was using mem_cgroup_from_obj()
> on a struct net object, which is allocated in net_alloc() from a slab
> cache, so mem_cgroup_from_slab_obj() should be sufficient, no?

Clearly not.
