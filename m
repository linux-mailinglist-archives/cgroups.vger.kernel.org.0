Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED95A72A5F
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2019 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfGXIpu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Jul 2019 04:45:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXIpt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Jul 2019 04:45:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2ACA337;
        Wed, 24 Jul 2019 01:45:48 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31ACE3F694;
        Wed, 24 Jul 2019 01:45:45 -0700 (PDT)
Subject: Re: [PATCH v9 0/8] sched/deadline: fix cpusets bandwidth accounting
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, cgroups@vger.kernel.org
References: <20190719140000.31694-1-juri.lelli@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bbc98035-f960-f06a-66fc-24509ea51a5c@arm.com>
Date:   Wed, 24 Jul 2019 10:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/19/19 3:59 PM, Juri Lelli wrote:
> Hi,
> 
> v9 of a series of patches, originally authored by Mathieu, with the intent
> of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> As originally reported by Steve [1], when hotplug and/or (certain)
> cpuset reconfiguration operations take place, DEADLINE bandwidth
> accounting information is lost since root domains are destroyed and
> recreated.
> 
> Mathieu's approach is based on restoring bandwidth accounting info on
> the newly created root domains by iterating through the (DEADLINE) tasks
> belonging to the configured cpuset(s).
> 
> Apart from the usual rebase on top of cgroup/for-next, this version
> 
>  - make cpuset_{can,cancel}_attach grab cpuset_rwsem for write (5/8 - Peter)
>  - moves v8 8/8 to 7/8 for bisectability (Peter)
>  - adds comment in changelog regarding normalize_rt_tasks() (8/8 - Peter)
> 
> Set also available at
> 
>  https://github.com/jlelli/linux.git fixes/deadline/root-domain-accounting-v9

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Test description:

Juno-r0 (Arm64 big/Little [L b b L L L]) with 6 DL tasks
(12000/100000/100000).

Rt-app runs DL workload for 10min.

After rt-app launched, start CPU hotplug stress test (random CPU hp
in/out except for CPU1 (CPU orig capacity 1024 (big)) during the entire
rt-app run.

Tests ran with 1 and 2 (exclusive cpusets ([0,3-5], [1-2])) root domains.
