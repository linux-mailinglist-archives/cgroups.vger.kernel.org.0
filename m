Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0370194837
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgCZUFW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 16:05:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZUFW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 16:05:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id b12so8240113wmj.3
        for <cgroups@vger.kernel.org>; Thu, 26 Mar 2020 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfpdmD90qfG4APoootzAo2/56jymRHsiOC00dP4g/fg=;
        b=B8luIsXtML5nPUmmER8cy/dMcB25Mm+18STwz7qhe3LIg5oodvflcMC6OCHR1gLICT
         N8yFdxR4jDyxjIcSflwl86YyKxOX/oUYtpSLJALHbJdvSgg/PObAmPqlFK1dH0xbkUlb
         pFaKp3kabNKrodxQRf4bBD2G0e/8iJ9AVuQvRoGWLlg2mSGrencs1H1/kY+Y6GgpGJ1r
         5rMTvNhLkVYdQfBgefau6Vpj1FYkJx6MTjN3czU8XBIC2eq/HLsL6vKjezqHuVXkkCg3
         MzJkfZIqvUGDSWEV4O9N6YdpF4H2ykDkStRRZ+oWBuFb54n06C01AnX7RLj9kph9dXhG
         b4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfpdmD90qfG4APoootzAo2/56jymRHsiOC00dP4g/fg=;
        b=G6EEEvw7DmZJ6YNn5vUjxNuqvsppJOPJRUNzu95d0jq8g2I+X4nY5ozQ0F3DSyY9uk
         1QaKg2CYUJTPI9/s7LsQeFaIKJH+PpvE/aEErviwfUmONWXj2WyrKCU/7GKQB+ByAM1J
         Hx7uGV/POnpLskhwOyQ8K0quaH/tMJhwRFM5D/reQTlP9JMsypEA83sxRPTmSbm7v1k0
         rCX0qocuzJI4yB5eN9Nne7m0eZWPYqNuYrPGqEOIwuLXhN5ihdTyx5IUQB7ABsGBYe3X
         Y/JpkAxaxVmZGMUz7DVFo4Y3AdVXRmoArkd5h0uHIktSsPHKEJxPfvQjQtsZ+io/0PvJ
         fSIg==
X-Gm-Message-State: ANhLgQ1++WxNLkQR1gBWlAsIgSEf06ZZeaHLgv/cBPUOS9U0RRENe2xV
        W0xIXmsUdC43nVpW+BtkaAQ1abZmqIxHhyXYCYotQA==
X-Google-Smtp-Source: ADFU+vtQbbv3TeNtVzjAtVsjoO3p3Uy4ko24DZfwmQM2yFsTk2lf4la9Hgomr5YsyieTYVmSDDiHTAiPQVXt4cNvEj8=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr10529294wrp.327.1585253118583;
 Thu, 26 Mar 2020 13:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org> <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
In-Reply-To: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
From:   Sonny Rao <sonnyrao@google.com>
Date:   Thu, 26 Mar 2020 13:05:04 -0700
Message-ID: <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Waiman Long <longman@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 12:57 PM Waiman Long <longman@redhat.com> wrote:
>
> On 3/26/20 3:44 PM, Joel Fernandes wrote:
> > Hi Tejun,
> >
> > On Thu, Mar 26, 2020 at 03:20:35PM -0400, Tejun Heo wrote:
> >> On Thu, Mar 26, 2020 at 03:16:23PM -0400, Joel Fernandes (Google) wrote:
> >>> This deliberately changes the behavior of the per-cpuset
> >>> cpus file to not be effected by hotplug. When a cpu is offlined,
> >>> it will be removed from the cpuset/cpus file. When a cpu is onlined,
> >>> if the cpuset originally requested that that cpu was part of the cpuset,
> >>> that cpu will be restored to the cpuset. The cpus files still
> >>> have to be hierachical, but the ranges no longer have to be out of
> >>> the currently online cpus, just the physically present cpus.
> >> This is already the behavior on cgroup2 and I don't think we want to
> >> introduce this big a behavior change to cgroup1 cpuset at this point.
> > It is not really that big a change. Please go over the patch, we are not
> > changing anything with how ->cpus_allowed works and interacts with the rest
> > of the system and the scheduler. We have just introduced a new mask to keep
> > track of which CPUs were requested without them being affected by hotplug. On
> > CPU onlining, we restore the state of ->cpus_allowed as not be affected by
> > hotplug.
> >
> > There's 3 companies that have this issue so that should tell you something.
> > We don't want to carry this patch forever. Many people consider the hotplug
> > behavior to be completely broken.
> >
> I think Tejun is concerned about a change in the default behavior of
> cpuset v1.
>
> There is a special v2 mode for cpuset that is enabled by the mount
> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
> v2 behavior. I introduced this v2 mode a while back to address, I think,
> a similar concern. Could you try that to see if it is able to address
> your problem? If not, you can make some code adjustment within the
> framework of the v2 mode. As long as it is an opt-in, I think we are
> open to further change.

I am surprised if anyone actually wants this behavior, we (Chrome OS)
found out about it accidentally, and then found that Android had been
carrying a patch to fix it.  And if it were a desirable behavior then
why isn't it an option in v2?

>
> Cheers,
> Longman
>
