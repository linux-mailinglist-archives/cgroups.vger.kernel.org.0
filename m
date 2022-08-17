Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFED596B53
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiHQI3I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiHQI3H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 04:29:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803165EDD8;
        Wed, 17 Aug 2022 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTlJGLuQ4NG6KNQCoQOC7/gSl7310i4yFk7PqB4rV+s=; b=rjMORs+SN7ez8CaHKLm3jaIpMm
        LN1p8YNxK9UXtaOs+uqqJsVQDAtkGFMwbYJVIa8G98JzxswW/ncWSqfcXXzIwBWIzoIxfLNyxEfPk
        FwD+d66b1o1jfTKYcVAVruTDccXxuWckQ4XqoE2UwdyMKhu6LBh/pu/N/JN+zRqURjKdLEMOQ5tVn
        kNtmF8YOABm+wvExBC6+3t2UDFKdy/Jo/YKINhg8uzPzCIMSi5xLUxFuRzJtnYhnlusu+CWpjSbV0
        60ZaEc46KLZuKyWX9s+VVAeQTvTBnVVpnI1ujberQ+B0MUZ7PqjS18Lew7b8T8WbGqCh6pWARqgRB
        RIBTWC5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOEQ0-007vim-CO; Wed, 17 Aug 2022 08:28:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2230798007A; Wed, 17 Aug 2022 10:28:50 +0200 (CEST)
Date:   Wed, 17 Aug 2022 10:28:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <YvymwlTkdsVDtmRB@worktop.programming.kicks-ass.net>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192734.67115-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 16, 2022 at 03:27:32PM -0400, Waiman Long wrote:

> This will be some changes in behavior for arm64 systems with asymmetric
> CPUs in some corner cases. For instance, if sched_setaffinity()
> has never been called and there is a cpuset change before
> relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
> follow what the cpuset allows but not what the previous cpu affinity
> setting allows.

That's arguably a correctness fix, no? That is, the save/restore should
not have been allowed to revert to an earlier cpuset state.
