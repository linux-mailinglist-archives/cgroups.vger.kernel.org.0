Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2D3A677C
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhFNNMl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhFNNMk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 09:12:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB3BC061574;
        Mon, 14 Jun 2021 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yYnDg3XToeuw/icgLCU3YUeHSV1eO6Orp2u9I1YQxLs=; b=L7QQyEqUDnpT2CTnWsfdUKnPOb
        UMJRkNXbgGIfiJcsKyywlJBymn+sxZ3HEfKWmlCuDltILhkt+ClJyX7MThKpn7+gCfubqLnKuqf47
        FER5eFzqEN8SiDqXpTGZuq/fAjtJHKwkOmcySBz0gaAXWXbZYuzknI+seEnPFh2G/gFzNKoOOCwx/
        TjH/a3dhLJ48zCIwadnjBcaEspyHnf5wNNQcVzJGuK39FBDeZe5D/BoWD6Svmx+aJbMdy6pvv+c2Q
        W9ro17JNLHq7fJM3TuVq+t8o4+k8jFti4sd7002OXI0JUZnLOl+wQmT3O2goZFZUJj2cjnGbcAAZj
        5JDQgg+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsmM4-0072Dk-Oo; Mon, 14 Jun 2021 13:10:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D08D3002FB;
        Mon, 14 Jun 2021 15:10:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3E542CB7A561; Mon, 14 Jun 2021 15:10:21 +0200 (CEST)
Date:   Mon, 14 Jun 2021 15:10:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] sched/fair: Correctly insert cfs_rq's to list on
 unthrottle
Message-ID: <YMdVPVMByhGjCUdl@hirez.programming.kicks-ass.net>
References: <20210612112815.61678-1-odin@uged.al>
 <CAKfTPtCMqZZnbwfhw0gz1Bne4j7PcG-Ma02a=gmcGbjY1bHk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCMqZZnbwfhw0gz1Bne4j7PcG-Ma02a=gmcGbjY1bHk=g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 14, 2021 at 02:01:55PM +0200, Vincent Guittot wrote:
> On Sat, 12 Jun 2021 at 13:31, Odin Ugedal <odin@uged.al> wrote:
> >
> > This fixes an issue where fairness is decreased since cfs_rq's can
> > end up not being decayed properly. For two sibling control groups with
> > the same priority, this can often lead to a load ratio of 99/1 (!!).
> >
> > This happen because when a cfs_rq is throttled, all the descendant cfs_rq's
> 
> s/happen/happens/
> 
> > will be removed from the leaf list. When they initial cfs_rq is
> > unthrottled, it will currently only re add descendant cfs_rq's if they
> > have one or more entities enqueued. This is not a perfect heuristic.
> >
> > Instead, we insert all cfs_rq's that contain one or more enqueued
> > entities, or it its load is not completely decayed.
> >
> > Can often lead to situations like this for equally weighted control
> > groups:
> >
> > $ ps u -C stress
> > USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> > root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
> > root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1
> >
> > Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> > Signed-off-by: Odin Ugedal <odin@uged.al>
> 
> minor typo in the commit message otherwise
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
