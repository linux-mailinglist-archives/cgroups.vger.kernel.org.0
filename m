Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7B4D6EA5
	for <lists+cgroups@lfdr.de>; Sat, 12 Mar 2022 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiCLMU1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Mar 2022 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiCLMU0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Mar 2022 07:20:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70CB87C;
        Sat, 12 Mar 2022 04:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eRnc6vlsmRO1Y1RmkkGHlXz1PK19hiSpeYsvyREcC+Y=; b=N4F02rcgKJXU3K6baufAPA18s8
        cY9MWsekOHh8nU5Og60K8SmZ2I4zD/aAc5sWGjc/MpHo/zzvT5B2n+xQci/A+nwWlvAVOb5/984t6
        D//Kne/vH2JHuKIyyPFR0QTDI8I1NZ4nVgmn+XFt1iYEm3fGzfBY8Rywz1ben3QSef9Ht7y2FBHP3
        H2vqsRPUdmH124JJD6QoZ8BF+USZ3IcMEsTgtKOY7ESVTCW+/XlkCR0s8H4/TxIeXsAkSLZABiTO5
        78SuXQ8OayCXjIIC52np5NRdcI1KQTP6UiFCfRS2kAp4C/JOkl56gllTEofivplmrDHxXxY9Raryf
        6mMYnbUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nT0iI-002PDy-TI; Sat, 12 Mar 2022 12:19:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41A5398791D; Sat, 12 Mar 2022 13:19:13 +0100 (CET)
Date:   Sat, 12 Mar 2022 13:19:13 +0100
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
Message-ID: <20220312121913.GA28057@worktop.programming.kicks-ass.net>
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305034103.57123-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 05, 2022 at 11:41:03AM +0800, Chengming Zhou wrote:
> task_css_set_check() will use rcu_dereference_check() to check for
> rcu_read_lock_held() on the read-side, which is not true after commit
> dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
> commit drop explicit rcu_read_lock(), change to RCU-sched read-side
> critical section. So fix the RCU warning by adding check for
> rcu_read_lock_sched_held().
> 
> Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks, I'll go stick this in sched/core so it's in the same branch that
caused the problem.

