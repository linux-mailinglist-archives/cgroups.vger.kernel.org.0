Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9627DA39
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2019 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfHALZd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Aug 2019 07:25:33 -0400
Received: from foss.arm.com ([217.140.110.172]:34312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHALZc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Aug 2019 07:25:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291EC1570;
        Thu,  1 Aug 2019 04:25:32 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 912893F575;
        Thu,  1 Aug 2019 04:25:29 -0700 (PDT)
Date:   Thu, 1 Aug 2019 12:25:27 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v12 0/6] Add utilization clamping support (CGroups API)
Message-ID: <20190801112527.3cmogmb5vrzqjwzn@e110439-lin>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
 <20190729200606.GA136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729200606.GA136335@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 29-Jul 13:06, Tejun Heo wrote:
> Hello,

Hi Tejun,

> Looks good to me.  On cgroup side,
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

Happy we converged toward something working for you.

I'll add the two small changes suggested by Michal and respin a v13
with your ACK on the series.

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
