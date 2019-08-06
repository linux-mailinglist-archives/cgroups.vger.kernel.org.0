Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106598366B
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbfHFQLl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 12:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387634AbfHFQLk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Aug 2019 12:11:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95514AC90;
        Tue,  6 Aug 2019 16:11:38 +0000 (UTC)
Date:   Tue, 6 Aug 2019 18:11:34 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v13 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190806161133.GA18532@blackbody.suse.cz>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
 <20190802090853.4810-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802090853.4810-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 02, 2019 at 10:08:48AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> +static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
> +				size_t nbytes, loff_t off,
> +				enum uclamp_id clamp_id)
> +{
> +	struct uclamp_request req;
> +	struct task_group *tg;
> +
> +	req = capacity_from_percent(buf);
> +	if (req.ret)
> +		return req.ret;
> +
> +	rcu_read_lock();
This should be the uclamp_mutex.

(The compound results of the series is correct as the lock is introduced
in "sched/core: uclamp: Propagate parent clamps".
This is just for the happiness of cherry-pickers/bisectors.)

> +static inline void cpu_uclamp_print(struct seq_file *sf,
> +				    enum uclamp_id clamp_id)
> +{
> [...]
> +	rcu_read_lock();
> +	tg = css_tg(seq_css(sf));
> +	util_clamp = tg->uclamp_req[clamp_id].value;
> +	rcu_read_unlock();
Why is the rcu_read_lock() needed here? (I'm considering the comment in
of_css() that should apply here (and it seems that similar uses in other
seq_file handlers also skip this).)

> @@ -7369,6 +7506,20 @@ static struct cftype cpu_legacy_files[] = {
> [...]
> +		.name = "uclamp.min",
> [...]
> +		.name = "uclamp.max",
I don't see technical reasons why uclamp couldn't work on legacy
hierarchy and Tejun acked the series, despite that I'll ask -- should
the new attributes be exposed in v1 controller hierarchy (taking into
account the legacy API is sort of frozen and potential maintenance needs
spanning both hierarchies)?

