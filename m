Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2704ADFA8
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 18:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378981AbiBHR26 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 12:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiBHR25 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 12:28:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EBC061576
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 09:28:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D175B210E1;
        Tue,  8 Feb 2022 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644341335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=084qkkVKwxLtc8ghPiqPMfhm1DMYA6O/V2WaZEb6smo=;
        b=jqZ9+RlJpu2xYhBXfWYhPVl3HqCHQ+sLPeCxx54h2OdqdT9BuO2wBEqg3+EKf8vnkgkrv8
        jIyrj47WXCn6zHDDWqHfRxMmnscqZEJ/tltl18hFq/wg/C/eXUHkr0z5605D2MYeUOHd58
        IjhYrPIcLOuF28URKVmQ+XnOSJlNO00=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 999A9A3B85;
        Tue,  8 Feb 2022 17:28:55 +0000 (UTC)
Date:   Tue, 8 Feb 2022 18:28:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YgKoVo8e0tZI9zGQ@dhcp22.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
 <Yff69slA4UTz5Q1Y@linutronix.de>
 <e068646f-c7f2-5876-8577-6ddf93df07d0@suse.cz>
 <YgKlr+sHZPayWKUP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgKlr+sHZPayWKUP@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-02-22 18:17:35, Sebastian Andrzej Siewior wrote:
> On 2022-02-03 17:01:41 [+0100], Vlastimil Babka wrote:
> > > Let me know if a revert is preferred or you want to keep that so that I
> > 
> > I see that's discussed in the subthread with Michal Hocko, so I would be
> > also leaning towards revert unless convincing numbers are provided.
> > 
> > > can prepare the patches accordingly before posting.
> > 
> > An acceptable form of this would have to basically replace the bool
> > stock_lock_acquried with two variants of the code paths that rely on it,
> > feel free to read though the previous occurence :)
> > https://lore.kernel.org/all/CAHk-=wiJLqL2cUhJbvpyPQpkbVOu1rVSzgO2=S2jC55hneLtfQ@mail.gmail.com/
> 
> I did that locally already. I was referring to the revert.
> So repost with bool fixed and the revert will be discussed later or
> include the revert at the begin of the series and then rebase these
> patches on top of it? I probably don't get to it before FRI so I don't
> try to rush anyone here ;)

If you start with the revert then you should be able to get rid of a lot
of complexity, right? We still haven't heard from Weiman about his
original optimization reasoning. There might be good reasons for it
which just hasn't been explicitly mentioned yet.

As already said, if the optimization is visible only in microbenchmarks
without any real workload benefiting from it I would rather consider
reverting it and make the RT addoption easier. Micro optimizations can
always be done on top.
-- 
Michal Hocko
SUSE Labs
