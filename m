Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F52392FE1
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhE0NjJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhE0NjG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 09:39:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54823C061574;
        Thu, 27 May 2021 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3bZ/LkqfBhJhawvK2heoarmGy4iJoc0yGvgh3vim5Nw=; b=FXZPg1F1fbulTYZ8znR1bssXMq
        dpYlRBnqpR0h7cS53Eg4LcmPAxiBL0BOOdoZR/Hiz5bBrsw29gzEadYLNwOSCoQPG8YcANlxcrASc
        OFmr82sMAAgEpMhlknstrfPqaci2qAi5oUPrA1wihuDgPJ0G2R2qWVwM954Rp6XhPgDQG4mLWqCZI
        sXKtxYdumvMRJcrDKkwKdI/kmbsx74dh9A61k2k1jILx4aTbhC8cBcqNgkAcB9M8bZhqlS6rBsL4q
        ZsQHBgz22fMF0GzFwpiHnPniApiedCiKYQFR7kAeM8PBYnO3NMEaHyC4wv0YeRm4d3S8IVSLoGHp3
        13FhhmAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmGCC-0010fO-86; Thu, 27 May 2021 13:37:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DE8230022C;
        Thu, 27 May 2021 15:37:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A5D0201DEF0D; Thu, 27 May 2021 15:37:13 +0200 (CEST)
Date:   Thu, 27 May 2021 15:37:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: keep load_avg and load_sum synced
Message-ID: <YK+giS1pPECFZ+oU@hirez.programming.kicks-ass.net>
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
 <20210527122916.27683-2-vincent.guittot@linaro.org>
 <YK+ZGlfPxK3JCySS@hirez.programming.kicks-ass.net>
 <CAKfTPtAE6DJTwxZ996BJoUJF++fFHdFk-C2bpUQ8aG0NQusApA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAE6DJTwxZ996BJoUJF++fFHdFk-C2bpUQ8aG0NQusApA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 27, 2021 at 03:18:35PM +0200, Vincent Guittot wrote:
> > -       delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
> > -       delta_avg = load_avg - se->avg.load_avg;
> > -
> >         se->avg.load_sum = runnable_sum;
> >         se->avg.load_avg = load_avg;
> > -       add_positive(&cfs_rq->avg.load_avg, delta_avg);
> > -       add_positive(&cfs_rq->avg.load_sum, delta_sum);
> > +
> > +       add_positive(&cfs_rq->avg.load_avg, (long)(load_avg - se->avg.load_avg));
> 
> you have to keep:
> delta_avg = load_avg - se->avg.load_avg
> or move se->avg.load_avg = load_avg after
> add_positive(&cfs_rq->avg.load_avg, ..);
> because otherwise (load_avg - se->avg.load_avg) == 0

Duh. /me goes fix.
