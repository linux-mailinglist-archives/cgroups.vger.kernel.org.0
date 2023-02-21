Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398B69E742
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 19:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBUSSQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 13:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBUSSP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 13:18:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F9B744;
        Tue, 21 Feb 2023 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tTqyemmz1pSv74LR4HajXP0tRM9VnFXvQ4hZwbauJIY=; b=aTHEWPY/BN+r5noMxZCmo9iSA1
        Z9IeoyW/C1dX8qm5tPsU2u5j+AQ/AEhI+yMzMaNWzFE1cwZXzPuTpDM2a3cpTh+rJ9tg53kLukUWa
        1Raq91MM6pgzQ18B3/7w2dnnQ/4vw7VRe3x3ALCx09tzgnM7YKGmSNjPqvYGrmmRZDG+B2EfthaKX
        fNj/RnFy+ub0fsZpl6t42kQ5htBwnbD8RQiyCn5tLpfTkOa9cTy6ZTVDCx8QIeUx/6Xdl6chkrflk
        F0Ixpvhu+kwgmwoFV6hu+MTaFi1VQjGIUecpBZdG5kpmzPyzvWpcSpPfnK9smVbeMgkCEVcxswtPw
        zEfhVeDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUXDH-00CoXT-Io; Tue, 21 Feb 2023 18:18:04 +0000
Date:   Tue, 21 Feb 2023 18:18:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/UK2zRi+WNGrWEs@casper.infradead.org>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
 <Y/UDmc3+uIErpanS@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UDmc3+uIErpanS@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 09:47:05AM -0800, Roman Gushchin wrote:
> > Wouldn't a compiler be within its rights to implement a one byte store as:
> > 
> > 	load-word
> > 	modify-byte-in-word
> > 	store-word
> > 
> > and if this is a lockless store to a word which has an adjacent byte also
> > being modified by another CPU, one of those CPUs can lose its store?
> > And WRITE_ONCE would prevent the compiler from implementing the store
> > in that way.
> 
> Even then it's not an issue in this case, as we end up with either 0 or 1,
> I don't see how we can screw things up here.

Thread 1:
	load word containing oom_group and oom_lock

Thread 2:
	store to oom_lock

Thread 1:
	store word containing oom_group and oom_lock

Thread 2's store has been lost.
