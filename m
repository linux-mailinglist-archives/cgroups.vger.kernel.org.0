Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A926A1E4A
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBXPPo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBXPPf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 10:15:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC0166CF0C;
        Fri, 24 Feb 2023 07:15:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F13D7113E;
        Fri, 24 Feb 2023 07:15:43 -0800 (PST)
Received: from [192.168.178.92] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81BBB3FB75;
        Fri, 24 Feb 2023 07:14:57 -0800 (PST)
Message-ID: <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
Date:   Fri, 24 Feb 2023 16:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
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
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230223153859.37tqoqk33oc6tv7o@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 23/02/2023 16:38, Qais Yousef wrote:

IMHO the patch title is misleading since what you want to avoid in
certain cases is that the RD DL accounting is updated.

> On 02/06/23 22:14, Qais Yousef wrote:
>> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
>> enabled rebuilding root domain on cpuset and hotplug operations to
>> correct deadline accounting.
>>
>> Rebuilding root domain is a slow operation and we see 10+ of ms delays
>> on suspend-resume because of that (worst case captures 20ms which
>> happens often).
>>
>> Since nothing is expected to change on suspend-resume operation; skip
>> rebuilding the root domains to regain the some of the time lost.
>>
>> Achieve this by refactoring the code to pass whether dl accoutning needs
>> an update to rebuild_sched_domains(). And while at it, rename
>> rebuild_root_domains() to update_dl_rd_accounting() which I believe is
>> a more representative name since we are not really rebuilding the root
>> domains, but rather updating dl accounting at the root domain.
>>
>> Some users of rebuild_sched_domains() will skip dl accounting update
>> now:
>>
>> 	* Update sched domains when relaxing the domain level in cpuset
>> 	  which only impacts searching level in load balance

This one is cpuset related. (1)

>> 	* update sched domains when cpufreq governor changes and we need
>> 	  to create the perf domains

This one is drivers/base/arch_topology.c [arm/arm64/...] related. (2)

There are several levels of passing this `update_dl_accounting`
information through. I guess it looks like this:

					update_dl_accounting

arm/arm64/riscv/parisc specific:
update_topology_flags_workfn()		true
rebuild_sched_domains_energy()		false (2)

cpuset_hotplug_workfn()                 cpus_updated ||
                         force_rebuild == CPUSET_FORCE_REBUILD_PRS_ERROR

->rebuild_sched_domains(update_dl_accounting)

  update_cpumasks_hier()		true
  update_relax_domain_level()		false (1)
  update_flag()				true
  update_prstate()			true

  ->rebuild_sched_domains_locked(update_dl_accounting)

    ->partition_and_rebuild_sched_domains(..., update_dl_accounting)

        if (update_dl_accounting)
          update_dl_rd_accounting()


There is already a somehow hidden interface for `sd/rd rebuild`

  int __weak arch_update_cpu_topology(void)

which lets partition_sched_domains_locked() figure out whether sched
domains have to be rebuild..

But in your case it is more on the interface `cpuset/hotplug -> sd/rd
rebuild` and not only `arch -> `sd/rd rebuild``.

IMHO, it would be still nice to have only one way to tell `sd/rd
rebuild` what to do and what not to do during sd/rd/(pd) rebuild.

[...]

