Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557E66A6825
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCAHcL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 02:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCAHcK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 02:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5A392A4
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677655885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=huiTwHgDQStD+M4CgUQLO4CEet/PJO5tAO4wYQhZ83U=;
        b=Q9pVsrebw1qz7n5FCGfsCAmjYfNIaPeFIt+G0RBXq2TtA1530e3pwz9KgsHVqSeMFMe6Mj
        YHiaJeU1WKk/nHhcVu+hmwzsLLfupPFZXcPx3236GmsQd08gwnp24yBUYw4RYZyC4K3oiz
        140VUGbboXHGQ8J/5b+cqZ/sJTGr2CU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-imC3oH6jOM2C_1M3CZl4tw-1; Wed, 01 Mar 2023 02:31:24 -0500
X-MC-Unique: imC3oH6jOM2C_1M3CZl4tw-1
Received: by mail-wr1-f71.google.com with SMTP id d14-20020adfa34e000000b002bfc062eaa8so2306726wrb.20
        for <cgroups@vger.kernel.org>; Tue, 28 Feb 2023 23:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huiTwHgDQStD+M4CgUQLO4CEet/PJO5tAO4wYQhZ83U=;
        b=uaPOfx1r4TBlMWvKm/ou117+goTebiAJvRGFK4fpWS8oYH2LtIHrvuAzntehSydHxj
         LGtuRqJVO5AzzWPC2F2vByLMqgJNV3SQSlXClEuIrNdHeaC6rl33IXW8m0478Vt36l7A
         IV5NudNBa7JDaubfgTSquu5urEFaiixFC6v6loVEMAxfdvjkjvG9xtL4ghriD1RtMFU2
         pWZw05PSzdHrAlAf1xuKtHdXMVpOSh6g0yhxMVo3FcVDBp+ayNij6oeWkdo2oaEYhJxv
         FNkF5XNJ93JnT4weUAEwbxzI+NTPgCPY0a3mBCT207BW8VfVIfKLiOe/JlUMxgwMrHSm
         uWKA==
X-Gm-Message-State: AO0yUKUjswtbs/7qAEj15fbkD3djQ0HVDWF2L8G17yHu7m4L6RkBxCH6
        0Jz0Jc5CLfBaoix9coWIKIgZSQNGKSEv4U17L9psCv+wX37Mq+S2LF6xKIszysd0VvzvW26DWIz
        ZqBSUFz0KhONh4HquoA==
X-Received: by 2002:adf:f603:0:b0:2c5:4db8:3dde with SMTP id t3-20020adff603000000b002c54db83ddemr3571353wrp.70.1677655883407;
        Tue, 28 Feb 2023 23:31:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/W8Me3oWoLep3XRAVhyE9lkl0eIQed4Xsa6ilM5XT8imnytf9cj4NExqyL25EBmHcU6xRzWg==
X-Received: by 2002:adf:f603:0:b0:2c5:4db8:3dde with SMTP id t3-20020adff603000000b002c54db83ddemr3571324wrp.70.1677655883050;
        Tue, 28 Feb 2023 23:31:23 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id fj10-20020a05600c0c8a00b003e7c89b3514sm18812818wmb.23.2023.02.28.23.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:31:22 -0800 (PST)
Date:   Wed, 1 Mar 2023 08:31:20 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <Y/7/SLzvK8LfB29z@localhost.localdomain>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228174627.vja5aejq27dsta2u@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 28/02/23 17:46, Qais Yousef wrote:
> On 02/28/23 15:09, Dietmar Eggemann wrote:
> 
> > > IIUC you're suggesting to introduce some new mechanism to detect if hotplug has
> > > lead to a cpu to disappear or not and use that instead? Are you saying I can
> > > use arch_update_cpu_topology() for that? Something like this?
> > > 
> > > 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > 	index e5ddc8e11e5d..60c3dcf06f0d 100644
> > > 	--- a/kernel/cgroup/cpuset.c
> > > 	+++ b/kernel/cgroup/cpuset.c
> > > 	@@ -1122,7 +1122,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > > 	 {
> > > 		mutex_lock(&sched_domains_mutex);
> > > 		partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > 	-       if (update_dl_accounting)
> > > 	+       if (arch_update_cpu_topology())
> > > 			update_dl_rd_accounting();
> > > 		mutex_unlock(&sched_domains_mutex);
> > > 	 }
> > 
> > No, this is not what I meant. I'm just saying the:
> > 
> >   partition_sched_domains_locked()
> >     new_topology = arch_update_cpu_topology();
> > 
> > has to be considered here as well since we do a
> > `dl_clear_root_domain(rd)` (1) in partition_sched_domains_locked() for
> > !new_topology.
> 
> Ah you're referring to the dl_clear_root_domain() call there. I thought this
> doesn't trigger.
> 
> > 
> > And (1) requires the `update_tasks_root_domain()` to happen later.
> > 
> > So there are cases now, e.g. `rebuild_sched_domains_energy()` in which
> > `new_topology=0` and `update_dl_accounting=false` which now clean the rd
> > but don't do a new DL accounting anymore.
> > rebuild_root_domains() itself cleans the `default root domain`, not the
> > other root domains which could exists as well.
> > 
> > Example: Switching CPUfreq policy [0,3-5] performance to schedutil (slow
> > switching, i.e. we have sugov:X DL task(s)):
> > 
> > [  862.479906] CPU4 partition_sched_domains_locked() new_topology=0
> > [  862.499073] Workqueue: events rebuild_sd_workfn
> > [  862.503646] Call trace:
> > ...
> > [  862.520789]  partition_sched_domains_locked+0x6c/0x670
> > [  862.525962]  rebuild_sched_domains_locked+0x204/0x8a0
> > [  862.531050]  rebuild_sched_domains+0x2c/0x50
> > [  862.535351]  rebuild_sd_workfn+0x38/0x54                        <-- !
> > ...
> > [  862.554047] CPU4 dl_clear_root_domain() rd->span=0-5 total_bw=0
> > def_root_domain=0                                                  <-- !
> > [  862.561597] CPU4 dl_clear_root_domain() rd->span= total_bw=0
> > def_root_domain=1
> > [  862.568960] CPU4 dl_add_task_root_domain() [sugov:0 1801]
> > total_bw=104857 def_root_domain=0 rd=0xffff0008015f0000            <-- !
> > 
> > The dl_clear_root_domain() of the def_root_domain and the
> > dl_add_task_root_domain() to the rd in use won't happen.
> > 
> > [sugov:0 1801] is only a simple example here. I could have spawned a
> > couple of DL tasks before this to illustrate the issue more obvious.
> > 
> > ---
> > 
> > The same seems to happen during suspend/resume (system with 2 frequency
> > domains, both with slow switching schedutil CPUfreq gov):
> > 
> > [   27.735821] CPU5 partition_sched_domains_locked() new_topology=0
> > ...
> > [   27.735864] Workqueue: events cpuset_hotplug_workfn
> > [   27.735894] Call trace:
> > ...
> > [   27.735984]  partition_sched_domains_locked+0x6c/0x670
> > [   27.736004]  rebuild_sched_domains_locked+0x204/0x8a0
> > [   27.736026]  cpuset_hotplug_workfn+0x254/0x52c                  <-- !
> > ...
> > [   27.736155] CPU5 dl_clear_root_domain() rd->span=0-5 total_bw=0
> > def_root_domain=0                                                  <-- !
> > [   27.736178] CPU5 dl_clear_root_domain() rd->span= total_bw=0
> > def_root_domain=1
> > [   27.736296] CPU5 dl_add_task_root_domain() [sugov:0 80]         <-- !
> >  total_bw=104857 def_root_domain=0 rd=0xffff000801728000
> > [   27.736318] CPU5 dl_add_task_root_domain() [sugov:1 81]
> > total_bw=209714 def_root_domain=0 rd=0xffff000801728000            <-- !
> > ...
> > 
> > > I am not keen on this. arm64 seems to just read a value without a side effect.
> > 
> > Arm64 (among others) sets `update_topology=1` before
> > `rebuild_sched_domains()` and `update_topology=0` after it in
> > update_topology_flags_workfn(). This then makes `new_topology=1` in
> > partition_sched_domains_locked().
> > 
> > > But x86 does reset this value so we can't read it twice in the same call tree
> > > and I'll have to extract it.
> > > 
> > > The better solution that was discussed before is to not iterate through every
> > > task in the system and let cpuset track when dl tasks are added to it and do
> > > smarter iteration. ATM even if there are no dl tasks in the system we'll
> > > blindly go through every task in the hierarchy to update nothing.
> > 
> > Yes, I can see the problem. And IMHO this solution approach seems to be
> > better than parsing update_dl_accounting` through the stack of involved
> > functions.
> 
> The best I can do is protect this dl_clear_root_domain() too. I really don't
> have my heart in this but trying my best to help, but it has taken a lot of my
> time already and would prefer to hand over to Juri to address this regression
> if what I am proposing is not good enough.
> 
> FWIW, there are 0 dl tasks in the system where this was noticed. And this delay
> is unbounded because it'll depend on how many tasks there are in the hierarchy.

Not ignoring you guys here, but it turns out I'm quite bogged down with
other stuff at the moment. :/ So, apologies and I'll try to get to this
asap. Thanks a lot for all your efforts and time reviewing so far!

Best,
Juri

