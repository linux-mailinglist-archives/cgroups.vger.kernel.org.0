Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284CC86522
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2019 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfHHPIZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 8 Aug 2019 11:08:25 -0400
Received: from foss.arm.com ([217.140.110.172]:34688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfHHPIZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Aug 2019 11:08:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5121596;
        Thu,  8 Aug 2019 08:08:24 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75D053F706;
        Thu,  8 Aug 2019 08:08:21 -0700 (PDT)
References: <20190802090853.4810-1-patrick.bellasi@arm.com> <20190802090853.4810-3-patrick.bellasi@arm.com> <20190806161153.GA19991@blackbody.suse.cz>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v13 2/6] sched/core: uclamp: Propagate parent clamps
In-reply-to: <20190806161153.GA19991@blackbody.suse.cz>
Date:   Thu, 08 Aug 2019 16:08:10 +0100
Message-ID: <87h86r4rvp.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, Aug 06, 2019 at 17:11:53 +0100, Michal Koutný wrote...

> On Fri, Aug 02, 2019 at 10:08:49AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> @@ -7095,6 +7149,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>>  	if (req.ret)
>>  		return req.ret;
>>  
>> +	mutex_lock(&uclamp_mutex);
>>  	rcu_read_lock();
>>  
>>  	tg = css_tg(of_css(of));
>> @@ -7107,7 +7162,11 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>>  	 */
>>  	tg->uclamp_pct[clamp_id] = req.percent;
>>  
>> +	/* Update effective clamps to track the most restrictive value */
>> +	cpu_util_update_eff(of_css(of));
>> +
>>  	rcu_read_unlock();
>> +	mutex_unlock(&uclamp_mutex);
> Following my remarks to "[PATCH v13 1/6] sched/core: uclamp: Extend
> CPU's cgroup", I wonder if the rcu_read_lock() couldn't be moved right
> before cpu_util_update_eff(). And by extension rcu_read_(un)lock could
> be hidden into cpu_util_update_eff() closer to its actual need.

Well, if I've got correctly your comment in the previous message, I
would say that at this stage we don't need RCU looks at all.

Reason being that cpu_util_update_eff() gets called only from
cpu_uclamp_write() which is from an ongoing write operation on a cgroup
attribute and thus granted to be available.

We will eventually need to move the RCU look only down the stack when
uclamp_update_active_tasks() gets called to update the RUNNABLE tasks on
a RQ... or perhaps we don't need them since we already get the
task_rq_lock() for each task we visit.

Is that correct?

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
