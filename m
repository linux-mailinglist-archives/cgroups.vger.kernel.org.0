Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6D1659A1
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBTIwr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 03:52:47 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43866 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgBTIwr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 03:52:47 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 788632E148B;
        Thu, 20 Feb 2020 11:52:44 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id moNltwzpYg-qhLOh1HB;
        Thu, 20 Feb 2020 11:52:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1582188764; bh=aG3Ei0HHrgrm5hahSqfhzECWrrr1Sfgr3ScUKH/KTBA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=DMtrzoek+TmVbTa6j2DbONx0J+k79QrdkWNyMyV/0sJKcJppkPl2lCC3ecUFzsZYV
         b4hrr8Sf5vN3p2xJyA1xY+YxSViH21C5E+HOXnvmpfVyNQtC51bo1wl0sUpksXW4ga
         jrAUTseUglLkNENA9nvhf8/k8QqFaHdfP09YPiuI=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id swC0L2TyHI-qh1C4eZD;
        Thu, 20 Feb 2020 11:52:43 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] sched/fair: add burst to cgroup cpu bandwidth
 controller
To:     Dave Chiluk <chiluk+linux@indeed.com>,
        Ben Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <157476581065.5793.4518979877345136813.stgit@buzz>
 <CAC=E7cU8TeNHDRnrHiFxmiHUKviVU9KaDvMq-U16VRgcohg6-w@mail.gmail.com>
 <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
 <CAC=E7cUgALi4g19GsDZQemHafQfaSpjY1XUo3Swrv_g1PaWejQ@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <98998672-4fab-2bb2-5f2d-fd6d83025036@yandex-team.ru>
Date:   Thu, 20 Feb 2020 11:52:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAC=E7cUgALi4g19GsDZQemHafQfaSpjY1XUo3Swrv_g1PaWejQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 17/02/2020 22.56, Dave Chiluk wrote:
> On Fri, Feb 14, 2020 at 12:55 PM <bsegall@google.com> wrote:
>> I'm not sure that starting with full burst runtime is best, though it
>> definitely seems likely to be one of those things where sometimes it's
>> what you want and sometimes it's not.
> 
> We (Indeed) definitely want to start with a full burst bank in most
> cases, as this would help with slow/throttled start-up times for our
> Jitted and interpreter-based language applications.  I agree that it
> would be nice to have it be configurable.
> 
> Dave.
> fyi.  Unfortunately, this e-mail may be temporarily turned off for the
> next few weeks, I apologize in advance for any bounced messages to me.
> 

How much burst time you are planning to use?

On our side common setup should be like this:

cpu.cfs_period_us = 100ms
cpu.cfs_quota_us = 100ms * X
cpu.cfs_burst_us = clamp(400ms * X, 100ms, 100ms * NR_CPUS)

Where is X is a cpu power in cpus.
