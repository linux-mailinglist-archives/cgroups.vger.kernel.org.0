Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6537F86539
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2019 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfHHPK1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Thu, 8 Aug 2019 11:10:27 -0400
Received: from foss.arm.com ([217.140.110.172]:34730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbfHHPK1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Aug 2019 11:10:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8CC1596;
        Thu,  8 Aug 2019 08:10:26 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732293F706;
        Thu,  8 Aug 2019 08:10:23 -0700 (PDT)
References: <20190802090853.4810-1-patrick.bellasi@arm.com> <20190802090853.4810-2-patrick.bellasi@arm.com> <20190806161133.GA18532@blackbody.suse.cz>
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
Subject: Re: [PATCH v13 1/6] sched/core: uclamp: Extend CPU's cgroup controller
Message-ID: <87imr74sfh.fsf@arm.com>
In-reply-to: <20190806161133.GA18532@blackbody.suse.cz>
Date:   Thu, 08 Aug 2019 16:10:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, Aug 06, 2019 at 17:11:34 +0100, Michal Koutný wrote...

> On Fri, Aug 02, 2019 at 10:08:48AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> +static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>> +				size_t nbytes, loff_t off,
>> +				enum uclamp_id clamp_id)
>> +{
>> +	struct uclamp_request req;
>> +	struct task_group *tg;
>> +
>> +	req = capacity_from_percent(buf);
>> +	if (req.ret)
>> +		return req.ret;
>> +
>> +	rcu_read_lock();
> This should be the uclamp_mutex.
>
> (The compound results of the series is correct as the lock is introduced
> in "sched/core: uclamp: Propagate parent clamps".
> This is just for the happiness of cherry-pickers/bisectors.)

Right, will move the uclamp_mutex introduction in this patch instead of
in the following one.

>> +static inline void cpu_uclamp_print(struct seq_file *sf,
>> +				    enum uclamp_id clamp_id)
>> +{
>> [...]
>> +	rcu_read_lock();
>> +	tg = css_tg(seq_css(sf));
>> +	util_clamp = tg->uclamp_req[clamp_id].value;
>> +	rcu_read_unlock();
> Why is the rcu_read_lock() needed here? (I'm considering the comment in
> of_css() that should apply here (and it seems that similar uses in other
> seq_file handlers also skip this).)

So, looks like that since we are in the context of a file operation,
all the cgroup's attribute read/write functions are implicitly save.

IOW, we don't need an RCU lock since the TG data structures are granted
to be always available till the end of the read/write operation.

That seems to make sense... I'm wondering if keeping the RCU look is
still a precaution for possible future code/assumption changes or just
an unnecessary overhead?

>> @@ -7369,6 +7506,20 @@ static struct cftype cpu_legacy_files[] = {
>> [...]
>> +		.name = "uclamp.min",
>> [...]
>> +		.name = "uclamp.max",
> I don't see technical reasons why uclamp couldn't work on legacy
> hierarchy and Tejun acked the series, despite that I'll ask -- should
> the new attributes be exposed in v1 controller hierarchy (taking into
> account the legacy API is sort of frozen and potential maintenance needs
> spanning both hierarchies)?

Not sure to get what you mean here: I'm currently exposing uclamp to
both v1 and v2 hierarchies.

Best,
Patrick

--
#include <best/regards.h>

Patrick Bellasi
