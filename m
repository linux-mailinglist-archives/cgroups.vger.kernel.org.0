Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5E52CEB0
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 10:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiESIwA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 04:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiESIv6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 04:51:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A902DA93
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 01:51:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 268931F86A;
        Thu, 19 May 2022 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652950315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCjPr++xl8KWyokuomIbrLcBjRsIcgmfUkDoWFF5TfQ=;
        b=bdEsvTECKnnG+/TGmv9Jm6Uix+LiSfB64gpLouR5lZEGtMlNKGmBc+PQ+c0zUdzWgdnJei
        LV6TEuLx2lhInScjYrlGK5Z60rG2ozef/uM1tvsbAXvmYoHTY3VJjc0edx9JUzLjC9tQji
        dk3ppAYpQPph5pconNU2KexH9Q4yNys=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C84D62C189;
        Thu, 19 May 2022 08:51:54 +0000 (UTC)
Date:   Thu, 19 May 2022 10:51:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
Message-ID: <YoYFKdqayKRw2npp@dhcp22.suse.cz>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
 <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz>
 <CAJD7tkYnBjuwQDzdeo6irHY=so-E8z=Kc_kZe52anMOmRL+8yA@mail.gmail.com>
 <YoQAVeGj19YpSMDb@cmpxchg.org>
 <CAAPL-u8pZ_p+SQZnr=8UV37yiQpWRZny7g9p6YES0wa+g_kMJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u8pZ_p+SQZnr=8UV37yiQpWRZny7g9p6YES0wa+g_kMJw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 18-05-22 22:44:13, Wei Xu wrote:
> On Tue, May 17, 2022 at 1:06 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
[...]
> > But I don't think an anon/file bias will capture this coefficient?
> 
> It essentially provides the userspace proactive reclaimer an ability
> to define its own reclaim policy by adding an argument to specify
> which type of pages to reclaim via memory.reclaim.

I am not sure the swappiness is really a proper interface for that.
Historically this tunable has changed behavior several times and the
reclaim algorithm is free to ignore it completely in many cases. If you
want to build a userspace reclaim policy, then it really has to have a
predictable and stable behavior. That would mean that the semantic would
have to be much stronger than the global vm_swappiness.
-- 
Michal Hocko
SUSE Labs
