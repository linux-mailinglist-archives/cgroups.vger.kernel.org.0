Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63C161C04
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2020 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgBQT44 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Feb 2020 14:56:56 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40474 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQT4z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Feb 2020 14:56:55 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so15286309ilr.7
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2020 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anZc7OW31U8MO5ygkvDDyIY0GQBGMdLs3iSe01Jj7l0=;
        b=sGkUgr2hS2qh3wTv0ktQzRELdeLNVOJRw8PZLR83DdUf9jRoBChFnzmLtAXvRX0ad9
         C4Vpbg4AjpwXtzZGSDBzumuHuXBm77L3DHxhhI4bCkVQkbZZHcIkB0lMVmzQJM/WKLFk
         YOMXm8H4OMQC1q+U1UmngJUHT7IGElm9QTtHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anZc7OW31U8MO5ygkvDDyIY0GQBGMdLs3iSe01Jj7l0=;
        b=lUJ3FwfX3w24DvoDknKJVR6ipz7ddl63304ThPC7g2vtGdx6rU2gbQ1ckE7qw5+ao/
         DExnPovDgcYBWNBBQA5ACCDjv+kI/cLIXVtoFDIPwF5LNlngqX4wEn9fjO/NXl0uensj
         R+SbHC9iFMj6WBdX/Ndq1blpLLcn2BvARCiKn9g9/svbGI0UCd34MBtyfKLVwsOn1LwN
         G7DuJvM3XDwfH24mk+/UvUhmUSaIcCvgwEt/psp9dw6vrqzgBjr47fLVHFAy/WxlWHKS
         2I68k3k9+9MfFiC699+qg/gY8y/LP1GvMZPeMmeRm8tAL6GOUsIimwlsSKJdBJDKdzbE
         1Szg==
X-Gm-Message-State: APjAAAVOFRDmdA1Jeigo6jG89NmBq2fVXYDXcdCpSu4FEo3f7/UU/SBN
        TPtJgSNOYIfQHYJLptGotaea1ZBxdGNKeIC7SIlK2w==
X-Google-Smtp-Source: APXvYqwBzoyntxTeoQ1/iTsKDa+b39U1AxBVdktu7QkWK/jPttX+KkBytSdqwTI1f4OywKIQ1y1o8mbNHj/TDBXsYEw=
X-Received: by 2002:a92:9c52:: with SMTP id h79mr15265830ili.213.1581969415072;
 Mon, 17 Feb 2020 11:56:55 -0800 (PST)
MIME-Version: 1.0
References: <157476581065.5793.4518979877345136813.stgit@buzz>
 <CAC=E7cU8TeNHDRnrHiFxmiHUKviVU9KaDvMq-U16VRgcohg6-w@mail.gmail.com> <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Mon, 17 Feb 2020 13:56:29 -0600
Message-ID: <CAC=E7cUgALi4g19GsDZQemHafQfaSpjY1XUo3Swrv_g1PaWejQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: add burst to cgroup cpu bandwidth controller
To:     Ben Segall <bsegall@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 12:55 PM <bsegall@google.com> wrote:
> I'm not sure that starting with full burst runtime is best, though it
> definitely seems likely to be one of those things where sometimes it's
> what you want and sometimes it's not.

We (Indeed) definitely want to start with a full burst bank in most
cases, as this would help with slow/throttled start-up times for our
Jitted and interpreter-based language applications.  I agree that it
would be nice to have it be configurable.

Dave.
fyi.  Unfortunately, this e-mail may be temporarily turned off for the
next few weeks, I apologize in advance for any bounced messages to me.
