Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C237D982
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2019 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHAKkW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Aug 2019 06:40:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfHAKkW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Aug 2019 06:40:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60AD1570;
        Thu,  1 Aug 2019 03:40:21 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FAC3F575;
        Thu,  1 Aug 2019 03:40:18 -0700 (PDT)
Date:   Thu, 1 Aug 2019 11:40:14 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v12 1/6] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190801104014.amwvjdvabedsd5t7@e110439-lin>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
 <20190718181748.28446-2-patrick.bellasi@arm.com>
 <20190725114104.GA32159@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190725114104.GA32159@blackbody.suse.cz>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 25-Jul 13:41, Michal Koutný wrote:
> On Thu, Jul 18, 2019 at 07:17:43PM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > +static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
> > +				    char *buf, size_t nbytes,
> > +				    loff_t off)
> > +{
> > [...]
> > +static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
> > +				    char *buf, size_t nbytes,
> > +				    loff_t off)
> > +{
> > [...]
> These two functions are almost identical yet not trivial. I think it
> wouldn be better to have the code at one place only and distinguish by
> the passed clamp_id.

Good point, since the removal of the boundary checks on values we now
have two identical methods. I'll factor our the common code in a
single function.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
