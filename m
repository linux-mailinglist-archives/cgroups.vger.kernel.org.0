Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A133101A
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfEaOZX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 10:25:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEaOZX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 May 2019 10:25:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so1075368qtk.4;
        Fri, 31 May 2019 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fZWaVhjpibOxsj1kY1++ZHe9aWpiZuSoWAHvFOICpcM=;
        b=b6BLNSf2bJlGFuvSr1KXl2NOJ0txuRLaroAPIMjZLkcXA246GmwAxfvYMmc3gZfclZ
         YPVSwH8w/NBnu/dqN/xpzs5IUWae4jKMa+g2yyXYsmYx54vdEFBYR3aMtBUWslKtCUFN
         NeZPsvXuOBmC4v+VFWF9S7Z7yBIWX+tbhE5O1qyGImwrH6MYA4ycBO8n/Y1D9p2tGelR
         5xT1z8g+e+EIr+kc9V4CiyBzF6zCxCBMMJlvq7k5wSMcucBL76rpVt6L1gyu/M98+1IV
         M1N5N+JB13m49s2t8PQAbteVDY6EEYSQy+C7qH+BEMT7k2yIjUR3Hc7uBywnJoRcH8y4
         qetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZWaVhjpibOxsj1kY1++ZHe9aWpiZuSoWAHvFOICpcM=;
        b=bOG/sL3kV7KlldicIiWd5f+OCPyztZxIgwAPBTXhRP1B1O8WhpS52bC3mY8I5O7DAG
         PoNh1974eHO4YWWkQ3Vn2egPAkhLatadcAVQLEqVRi5p1ZsJ42rGrCdPBKXUJXjeyP1+
         RJlHBlwsEUMNxgme7vBpezWixDgx3JYOWhFSP1fwd2NM0owRHR56oga/TtXndEndPKX2
         UNF+Y82EJy6S+3iNzvPt42MnlqKeCO5GEqI/LICRKN8tGV3XZdz9EEOTKrRpm1bofFmt
         MLGzhtfIGb7NN13LOmSQ4R7Ya5vTptz8ons5/BQMrQvRrK7hLRh+JHfIGaNWomNQ8ddq
         3IDQ==
X-Gm-Message-State: APjAAAX2GWYNl5W7HapolrQItWL+RnAqadUe3828/P33xgLb00xjdWX9
        3vYu2/lmNk96PiFi0Hw8Dd0=
X-Google-Smtp-Source: APXvYqwXfUDOJ5O2H7WEunCtOI6wppddH8ERY0rqo4fkcLaXdF3LttVxXhtl+BV1/t4FLAIGMzJ6iw==
X-Received: by 2002:ac8:614b:: with SMTP id d11mr9046224qtm.329.1559312722448;
        Fri, 31 May 2019 07:25:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39c9])
        by smtp.gmail.com with ESMTPSA id n124sm3290671qkf.31.2019.05.31.07.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:25:21 -0700 (PDT)
Date:   Fri, 31 May 2019 07:25:18 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Xuehan Xu <xxhdx1985126@gmail.com>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>, cgroups@vger.kernel.org,
        Xuehan Xu <xuxuehan@360.cn>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
Message-ID: <20190531142518.GZ374014@devbig004.ftw2.facebook.com>
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
 <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
 <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
 <20190528185604.GK374014@devbig004.ftw2.facebook.com>
 <CAJACTucnCGLTbRAX0V5GBMmCQh4Dh8T9b0in1TUMCOVysJ0wjw@mail.gmail.com>
 <20190530205930.GW374014@devbig004.ftw2.facebook.com>
 <CAJACTuc+B+v0yGFY3L7iS1qTdRsw7b6tw5_e9sP43LuR=P1NWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJACTuc+B+v0yGFY3L7iS1qTdRsw7b6tw5_e9sP43LuR=P1NWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Xuehan.

On Fri, May 31, 2019 at 12:04:57PM +0800, Xuehan Xu wrote:
> The resource that we want to control is the ceph cluster's io
> processing capability usage. And we are planning to control it in
> terms of iops and io bandwidth. We are considering a more
> work-conserving control mechanism that involves server side and are
> more workload self-adaptive. But, for now, as we mostly concern about

I see.

> the scenario that a single client use up the whole cluster's io
> capability, we think maybe we should implement a simple client-side io
> throttling first, like the blkio controller's io throttle policy,
> which would be relatively easy. On the other hand, we should provide
> users io throttling capability even if their servers don't support the
> sophisticated QoS mechanism. Am I right about this? Thanks:-)

My experience with blk-throttle has been pretty abysmal and pretty
much gave up on using it except for some really limited use cases.
The problem is that, on a lot of devices, neither bandwidth or iops
captures the cost of the IOs and there's a really wide band where any
given configuration is both too low and too high - ie. depending on
the particular IO pattern, too low to the point where IO utilization
is significantly impacted while at the same time too high to the point
where it can easily swamp the IO capacity.

It's tempting to go for iops / bps control as they seem obvious and
easy but it's highly unlikely to be a viable long term solution.
Given that, I'm pretty hesistant about adding more facilities towards
this direction.  Can you guys please think more about what the actual
IO resources are and how their costs can be evaulated?  That'll be
necessary for work-conserving control and it's highly likely that
you'd want to use them for non-work-conserving limits too anyway.

Thanks.

-- 
tejun
