Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3964D6F3B
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 14:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiCLNf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 08:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNf5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 08:35:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084A460EE;
        Sat, 12 Mar 2022 05:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d7N9wsNuqkZgK1+eKcOkZTC3C9GRGbNq5Ad3wwuX278=; b=JAgaT3p5mES5x2vTc50l81A/DB
        EfXJ8ZAn7+PI9x974nNSvog0QkLWoGopkOCd7o7eTeEaaBNbP2v3QilphZ2Rl/SGRB8mVQfV0Ffpj
        OMEG9fkNHugB0DJ7/oHB/HiP984qdWzoySy9d2q+zRTLdUTzKySOyuzUyID2IhePt/k/CFTrHSJ+q
        CAg0hfpNXy4Xd/4j9C+34pNiNr/j5MBP8Kq/lsIad/5QH2Ygn7PYm1i84BIpyeRJ6gZNid+ke9wIv
        BEWXD5rAG4q9Csv1MRUZ7qf4zPX60fwuCOsBAxjFQtoRy8PwYwkXkYrYCwgcAcBawTnfDy427BEOT
        x3Xa8Upw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT1tN-000BDr-Mm; Sat, 12 Mar 2022 13:34:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DB8F987D0D; Sat, 12 Mar 2022 14:34:45 +0100 (CET)
Date:   Sat, 12 Mar 2022 14:34:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next] cgroup: fix suspicious
 rcu_dereference_check() usage warning
Message-ID: <20220312133445.GA28086@worktop.programming.kicks-ass.net>
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
 <20220312121913.GA28057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312121913.GA28057@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 12, 2022 at 01:19:13PM +0100, Peter Zijlstra wrote:
> On Sat, Mar 05, 2022 at 11:41:03AM +0800, Chengming Zhou wrote:
> > task_css_set_check() will use rcu_dereference_check() to check for
> > rcu_read_lock_held() on the read-side, which is not true after commit
> > dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
> > commit drop explicit rcu_read_lock(), change to RCU-sched read-side
> > critical section. So fix the RCU warning by adding check for
> > rcu_read_lock_sched_held().
> > 
> > Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
> > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Thanks, I'll go stick this in sched/core so it's in the same branch that
> caused the problem.

FWIW I never saw this patch because it doesn't instantly look like a
patch I should be interested in. It's classified as 'for-next' and I
don't run -next, sfr does that. Then it's tagged as cgroup, which I also
don't do.

Nowhere does that look like a patch that wants to go in sched/core and
fixes a cpuacct issue.

On top of that, I still don't agree with this, I really think
rcu_dereference_check() itself should be changed.
