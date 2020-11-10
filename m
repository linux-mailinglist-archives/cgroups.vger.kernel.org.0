Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC42ADB51
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 17:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgKJQKN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 11:10:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKJQKN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 11:10:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kcWDT-00082u-L6; Tue, 10 Nov 2020 16:09:55 +0000
Subject: Re: [PATCH v2 0/4] support for global CPU list abbreviations
To:     paulmck@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        rdunlap@infradead.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Li Zefan <lizefan@huawei.com>
References: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
 <20201110153211.GU3249@paulmck-ThinkPad-P72>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <6d3f4fbf-3d40-20a4-5c14-145906bf6c0f@canonical.com>
Date:   Tue, 10 Nov 2020 16:09:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110153211.GU3249@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/11/2020 15:32, Paul E. McKenney wrote:
> On Mon, Nov 09, 2020 at 11:07:21PM -0500, Paul Gortmaker wrote:
>> RFC/v1 ---> v2:
>>
>> commit #1:
>>    leave one line stub behind for !SMP solving build failures.
>>    Reported by Randy Dunlap and various build bots.
>>
>> commit #4
>>    manage to remember '\0' char in strlen from one line to the next.
>>    Reported by Colin King.

shouldn't that be "Reported and fixed by Colin King"? ;-)

>>
>> Original description from v1/RFC below remains unchanged...
> 
> Queued and this time kicking off testing that actually includes your
> patches!  ;-)
> 
> 							Thanx, Paul
> 
>>  ---
>>
>> The basic objective here was to add support for "nohz_full=8-last" and/or
>> "rcu_nocbs="4-last" -- essentially introduce "last" as a portable
>> reference evaluated at boot/runtime for anything using a CPU list.
>>
>> The thinking behind this, is that people carve off a few early CPUs to
>> support housekeeping tasks, and perhaps dedicate one to a busy I/O
>> peripheral, and then the remaining pool of CPUs out to the end are a
>> part of a commonly configured pool used for the real work the user
>> cares about.
>>
>> Extend that logic out to a fleet of machines - some new, and some
>> nearing EOL, and you've probably got a wide range of core counts to
>> contend with - even though the early number of cores dedicated to the
>> system overhead probably doesn't vary.
>>
>> This change would enable sysadmins to have a common bootarg across all
>> such systems, and would also avoid any off-by-one fencepost errors that
>> happen for users who might briefly forget that core counts start at
>> zero.
>>
>> Looking around before starting, I noticed RCU already had a short-form
>> abbreviation "all" -- but if we want to treat CPU lists in a uniform
>> matter, then tokens shouldn't be implemented at a subsystem level and
>> hence be subsystem specific; each with their own variations.
>>
>> So I moved "all" to global use - for boot args, and for cgroups.  Then
>> I added the inverse "none" and finally, the one I wanted -- "last".
>>
>> The use of "last" isn't a standalone word like "all" or "none".  It will
>> be a part of a complete range specification, possibly with CSV separate
>> ranges, and possibly specified multiple times.  So I had to be a bit
>> more careful with string matching - and hence un-inlined the parse
>> function as commit #1 in this series.
>>
>> But it really is a generic support for "replace token ABC with known at
>> boot value XYZ" - for example, it would be trivial to extend support to
>> add "half" as a dynamic token to be replaced with 1/2 the core count,
>> even though I wouldn't suggest that has a use case like "last" does.
>>
>> I tested the string matching with a bunch of intentionally badly crafted
>> strings in a user-space harness, and tested bootarg use with nohz_full
>> and rcu_nocbs, and also the post-boot cgroup use case as per below:
>>
>>    root@hackbox:/sys/fs/cgroup/cpuset# mkdir foo
>>    root@hackbox:/sys/fs/cgroup/cpuset# cd foo
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>>    
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-last > cpuset.cpus
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>>    10-15
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all > cpuset.cpus
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>>    0-15
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none > cpuset.cpus
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>>    
>>    root@hackbox:/sys/fs/cgroup/cpuset/foo#
>>
>> This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.
>>
>> Note that the two use cases (boot and runtime) are why you see "early"
>> parameter in the code - I entertained just sticking the string copy on
>> the stack vs. the early alloc dance, but this felt more correct/robust.
>> The cgroup and modular code using cpulist_parse() are runtime cases.
>>
>> ---
>>
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Li Zefan <lizefan@huawei.com>
>>
>> Paul Gortmaker (4):
>>   cpumask: un-inline cpulist_parse for SMP; prepare for ascii helpers
>>   cpumask: make "all" alias global and not just RCU
>>   cpumask: add a "none" alias to complement "all"
>>   cpumask: add "last" alias for cpu list specifications
>>
>>  .../admin-guide/kernel-parameters.rst         |  20 +++
>>  .../admin-guide/kernel-parameters.txt         |   4 +-
>>  include/linux/cpumask.h                       |   8 ++
>>  kernel/rcu/tree_plugin.h                      |  13 +-
>>  lib/cpumask.c                                 | 132 ++++++++++++++++++
>>  5 files changed, 165 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.25.1
>>

