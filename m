Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA167670F5
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2019 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfGLOER (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jul 2019 10:04:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfGLOEQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jul 2019 10:04:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so8164759qtl.5
        for <cgroups@vger.kernel.org>; Fri, 12 Jul 2019 07:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qOSLjOC0a6pOm0G5m4ewIw/B4m7qP1LrJ+Nw6hOt0Ks=;
        b=AUBNqrdRHeQwYmzGfiuq6mv+qLVSpn+q6VdVOgvBjJM6vBiu2OXeq4T3z1Z1w77Qju
         XMb+3sI5iuA0yc/j8ss5D8GGnwzNB1h7yzIkC13Xgotzxmo6LaoqMxBKf7Pk7EQ99giL
         FRENvWonBp8+H4WMX494VcYC3eGnVq8eWW/DM8fBELYhXaNBujTPPo+YT8omK7NtapZB
         hX7QdNk2IFuWzTlrUv0vAcDHn3N7bxOVqDdGZBJIs6BWhGqNbA4BdCraCeJLEcP8fRFY
         KM0WAlWkDhYH2IhAsVB2d3tuQb0AlV3VMW8WFdyYeqUYkx5nc/kC/IydlMF8lqMqwPCo
         C4QA==
X-Gm-Message-State: APjAAAWX+EGw6odLUEGXsUEeL/vLe7rnP4k09bIUEFSSYAQ6LUV3on47
        rc6eL2TxBJqrltmntC6ZbztZNYkU9cE=
X-Google-Smtp-Source: APXvYqw058I4WeqHkGmyQaJoOr3NNaqT1eRI4pdNh/6ynAM4gYk2cFoMchjCUD/MQuh7OK/ujczBLA==
X-Received: by 2002:aed:2241:: with SMTP id o1mr6518892qtc.233.1562940255726;
        Fri, 12 Jul 2019 07:04:15 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id n184sm3643754qkc.114.2019.07.12.07.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 07:04:14 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:04:09 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190712140409.GB13885@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
 <20190701065233.GA26005@localhost.localdomain>
 <20190701082731.GP3402@hirez.programming.kicks-ass.net>
 <20190701145107.GY657710@devbig004.ftw2.facebook.com>
 <20190704084924.GC9099@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704084924.GC9099@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 04/07/19 10:49, Juri Lelli wrote:
> Hi,
> 
> On 01/07/19 07:51, Tejun Heo wrote:
> > Hello,
> > 
> > On Mon, Jul 01, 2019 at 10:27:31AM +0200, Peter Zijlstra wrote:
> > > IIRC TJ figured it wasn't strictly required to fix the lock invertion at
> > > that time and they sorted it differently. If I (re)read the thread
> > > correctly the other day, he didn't have fundamental objections against
> > > it, but wanted the simpler fix.
> > 
> > Yeah I've got no objections to the change itself, it just wasn't
> > needed at the time.  We've had multiple issues there tho, so please
> > keep an eye open after the changes get merged.
> 
> Should I take this as an indication that you had a look at the set and
> (apart from Peter's comments) you are OK with them?
> 
> If that's the case I will send a v9 out soon. Otherwise I'd kindly ask
> you to please have a look.

Gentle ping.

Thanks,

Juri
