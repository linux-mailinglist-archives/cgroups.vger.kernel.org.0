Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8905B553
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfGAGwj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jul 2019 02:52:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34133 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfGAGwi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jul 2019 02:52:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so13792384wmd.1
        for <cgroups@vger.kernel.org>; Sun, 30 Jun 2019 23:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZanPqiEPVMdySHonMbQBl/5/VvjKUDnA16ZAnUCifwo=;
        b=l8X2QrWaF6FiBgZIHeCKn6TR5dZZU1PBHp4XB8Uzi/bO1CtwwrhErhicZsvnm2baBj
         ZVUFb2Dusj5mWTygCLhMtvY1G/QH1wJ2sEyrPO2/FX7q4ajm/vwg4FxdwkwnHiljNvxy
         xn9pkmRjsOotxW7fl1oG8dcGaO1kSkWoth6MvEHim6C7seeXVFsh+wY75axcjUe3C44d
         3DbMk7uec1C3udDk/phk0sv2ZvYW6IWbYWQOSpQmK+dUHfqBfqp2dKA7tOTz8T8OSyK2
         rpbFlnY7qFy3alQzO16C2Hj0TVHzIR8ePNfPmwftlA4bZb+ji1hp4wf7axA/Uace9wlz
         60Ng==
X-Gm-Message-State: APjAAAV9sRYjiFMXebV7YIKG0m/vhEt2kfcAgSX20l3Lj92UlMMQ68PI
        jthl3Tc5DAf6NjKRcAsQ2xKUO4Umi5s=
X-Google-Smtp-Source: APXvYqyAJZ4botdtSJ3zU9ORTAwwQRPjpGAfhDs9AIdatmN70PBO8LqjP2idy/zV96eTgzly1dbG3w==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr16638183wmg.164.1561963956698;
        Sun, 30 Jun 2019 23:52:36 -0700 (PDT)
Received: from localhost.localdomain ([151.15.224.253])
        by smtp.gmail.com with ESMTPSA id h21sm10492932wmb.47.2019.06.30.23.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 23:52:35 -0700 (PDT)
Date:   Mon, 1 Jul 2019 08:52:33 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190701065233.GA26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628130308.GU3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 28/06/19 15:03, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:16AM +0200, Juri Lelli wrote:
> > cpuset_rwsem is going to be acquired from sched_setscheduler() with a
> > following patch. There are however paths (e.g., spawn_ksoftirqd) in
> > which sched_scheduler() is eventually called while holding hotplug lock;
> > this creates a dependecy between hotplug lock (to be always acquired
> > first) and cpuset_rwsem (to be always acquired after hotplug lock).
> > 
> > Fix paths which currently take the two locks in the wrong order (after
> > a following patch is applied).
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> This all reminds me of this:
> 
>   https://lkml.kernel.org/r/1510755615-25906-1-git-send-email-prsood@codeaurora.org
> 
> Which sadly got reverted again. If we do this now (I've always been a
> proponent), then we can make that rebuild synchronous again, which
> should also help here IIRC.

Why was that reverted? Perf regression of some type?

Thanks,

Juri
