Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806B62250D
	for <lists+cgroups@lfdr.de>; Wed,  9 Nov 2022 09:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiKIIFc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Nov 2022 03:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIIFb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Nov 2022 03:05:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7081CB3C;
        Wed,  9 Nov 2022 00:05:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF4E71F8C4;
        Wed,  9 Nov 2022 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667981128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtpuDwdakbsSweUDnOE8zAX0zXuYtEwWTzH9ZnpMCs8=;
        b=lViDlySknjzjl7K3UwqMWkFkLRCXSNasuR0ZF0+MldKSfQJZ3QyiiPpUXRzAJg95iSXXIn
        fdbGXvK8zzgSbxslolLq7XdBqXTtd0E5KCtQHOyy2Nn2/3EBrfweJRkiBn44TId/IZOOzo
        WCspmBuikEMQfpAIci0sYwXsNfU9Aig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8E91139F1;
        Wed,  9 Nov 2022 08:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zTxfJkhfa2PCRgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 09 Nov 2022 08:05:28 +0000
Date:   Wed, 9 Nov 2022 09:05:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Message-ID: <Y2tfSAgt/lBVcdvf@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
 <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
 <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
 <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
 <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
 <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
 <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
 <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
 <4a4a6c73f3776d65f70f7ca92eb26fc90ed3d51a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a4a6c73f3776d65f70f7ca92eb26fc90ed3d51a.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-11-22 20:09:25, Leonardo Brás wrote:
[...]
> > Yes, with a notable difference that with your spin lock option there is
> > still a chance that the remote draining could influence the isolated CPU
> > workload throug that said spinlock. If there is no pcp cache for that
> > cpu being used then there is no potential interaction at all.
> 
> I see. 
> But the slow path is slow for some reason, right?
> Does not it make use of any locks also? So on normal operation there could be a
> potentially larger impact than a spinlock, even though there would be no
> scheduled draining.

Well, for the regular (try_charge) path that is essentially page_counter_try_charge
which boils down to atomic_long_add_return of the memcg counter + all
parents up the hierarchy and high memory limit evaluation (essentially 2
atomic_reads for the memcg + all parents up the hierchy). That is not
whole of a lot - especially when the memcg hierarchy is not very deep.

Per cpu batch amortizes those per hierarchy updates as well as atomic
operations + cache lines bouncing on updates.

On the other hand spinlock would do the unconditional atomic updates as
well and even much more on CONFIG_RT. A plus is that the update will be
mostly local so cache line bouncing shouldn't be terrible. Unless
somebody heavily triggers pcp cache draining but this shouldn't be all
that common (e.g. when a memcg triggers its limit.

All that being said, I am still not convinced that the pcp cache bypass
for isolated CPUs would make a dramatic difference. Especially in the
context of workloads that tend to run on isolated CPUs and rarely enter
kernel.
 
> > It is true true that appart from user
> > space memory which can be under full control of the userspace there are
> > kernel allocations which can be done on behalf of the process and those
> > could be charged to memcg as well. So I can imagine the pcp cache could
> > be populated even if the process is not faulting anything in during RT
> > sensitive phase.
> 
> Humm, I think I will apply the change and do a comparative testing with
> upstream. This should bring good comparison results.

That would be certainly appreciated!
 
> > > On the other hand, compared to how it works now now, this should be a more
> > > controllable way of introducing latency than a scheduled cache drain.
> > > 
> > > Your suggestion on no-stocks/caches in isolated CPUs would be great for
> > > predictability, but I am almost sure the cost in overall performance would not
> > > be fine.
> > 
> > It is hard to estimate the overhead without measuring that. Do you think
> > you can give it a try? If the performance is not really acceptable
> > (which I would be really surprised) then we can think of a more complex
> > solution.
> 
> Sure, I can try that.
> Do you suggest any specific workload that happens to stress the percpu cache
> usage, with usual drains and so? Maybe I will also try with synthetic worloads
> also.

I really think you want to test it on the isolcpu aware workload.
Artificial benchmark are not all that useful in this context.
-- 
Michal Hocko
SUSE Labs
