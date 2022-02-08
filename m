Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431A14ADF23
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiBHRRk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 12:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiBHRRk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 12:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7AC061576
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 09:17:39 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:17:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644340657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnZWZNhs5o+4JIrFiRfBiatdlnub+aor48OWnJbqbV0=;
        b=CymkxE04oxx3Vqb3s56uVlf3f9DLLTymVburTR9hTaQLVjPWRDQRm4Yl8Vx575ctIQjhZw
        YtTb7yTKlTngkIpydJQMZq/byOer/cLp8FOYtGihKBmOdVR56mU5HojvjDmZVlXjQIp7Gh
        3qwK2BEf/WtEHULr0f9hZZEgsCAlTEMu42yUikIPkTj37jrdKbtQSpJGNO24cpEBq7mACj
        Hh5H2CBmCT2E02gj0rLIwZtyb3HhpghKLCAqQ7vo63/SfflKkv+sYcYigLqjIWLYkdomp/
        zTAF5Yrsel7rMBpk1tWCvRTqLNwpl/98moyDjt3UqCTgft6nYwFZdEt56yRbrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644340657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnZWZNhs5o+4JIrFiRfBiatdlnub+aor48OWnJbqbV0=;
        b=8qEQonLSxr1SCnJLKqM8ZxMFBLrXJjd7eFKJ7HlZr2xJ5R10+LM0X39bq7gU2p6RuwE14j
        0AETUFKDpx+QMwDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YgKlr+sHZPayWKUP@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
 <Yff69slA4UTz5Q1Y@linutronix.de>
 <e068646f-c7f2-5876-8577-6ddf93df07d0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e068646f-c7f2-5876-8577-6ddf93df07d0@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-03 17:01:41 [+0100], Vlastimil Babka wrote:
> > Let me know if a revert is preferred or you want to keep that so that I
> 
> I see that's discussed in the subthread with Michal Hocko, so I would be
> also leaning towards revert unless convincing numbers are provided.
> 
> > can prepare the patches accordingly before posting.
> 
> An acceptable form of this would have to basically replace the bool
> stock_lock_acquried with two variants of the code paths that rely on it,
> feel free to read though the previous occurence :)
> https://lore.kernel.org/all/CAHk-=wiJLqL2cUhJbvpyPQpkbVOu1rVSzgO2=S2jC55hneLtfQ@mail.gmail.com/

I did that locally already. I was referring to the revert.
So repost with bool fixed and the revert will be discussed later or
include the revert at the begin of the series and then rebase these
patches on top of it? I probably don't get to it before FRI so I don't
try to rush anyone here ;)

Sebastian
