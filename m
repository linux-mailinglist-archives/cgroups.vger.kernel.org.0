Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F0F69E218
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBUOQM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 09:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjBUOQM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 09:16:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F202A6E2;
        Tue, 21 Feb 2023 06:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ezhrO5zcxPw5+cqyTN5jzGAr1WfOqENe6I0B5fgvAc=; b=k6n0f41dHDTj1LNeXWdqDPTQKM
        9V7x8Dfz8aRSyJ5mOfngmFuzoLP4aAURHW5SbpIrwkzJYHKm378+p3nbJMa7nJsGAJcUDH0XSMZde
        eralntXxL7EhtJPgYMK7ybkIQUUZ3QKWdLcklvnnjwdrzPUc1UxzEt/fiqcdYLJsIKMAEgJ278s4e
        yMS+XVWoGVrE86BOyZR0dN9aDMEPUSk4E6idknPpwO6f6jRnWkFLB/xXorMFlPwhyG8N/4jql0MGQ
        j4+eQM0+G8+oFl6fgtMp89EM4r2bsWVj0WCFynSY6mrBT5WIqOxcG6NBp6tJGXBJszUl0uA5/wCjW
        /MskH9KQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUTQb-00CBS9-2N;
        Tue, 21 Feb 2023 14:15:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 309493001E5;
        Tue, 21 Feb 2023 15:15:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 052002024969C; Tue, 21 Feb 2023 15:15:30 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:15:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority
 at wakeup
Message-ID: <Y/TSAivRWwm2LaPh@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org>
 <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 01:52:58PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 6c61bde49152..38decae3e156 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -568,6 +568,8 @@ struct sched_entity {
> >  	/* cached value of my_q->h_nr_running */
> >  	unsigned long			runnable_weight;
> >  #endif
> > +	/* preemption offset in ns */
> > +	long				latency_offset;
> 
> I wonder about the type here; does it make sense to have it depend on
> the bitness; that is if s32 is big enough on 32bit then surely it is so
> too on 64bit, and if not, then it should be unconditionally s64.
> 

The cgroup patch has this as 'int'. I'm thinking we ought to be
consistent :-)
