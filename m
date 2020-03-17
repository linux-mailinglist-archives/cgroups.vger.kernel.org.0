Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F05188DE8
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2020 20:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgCQTY1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Mar 2020 15:24:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTY1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Mar 2020 15:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mAb+lK7uiT3ldfeyyLr+kiJibGSBEZhmuX8jrROVGvY=; b=PAbRC8UmjK7Da14hi1EjiZgSxx
        OJRb1TNOFcCb3HMABHjCPKeA3tNzE65fqpxKqBfpRMZgbEAtyeOdEUN+lldTC9RLL0CRyv/FQlYkY
        sTUZV7l8ATDLVp7AONiHPY/pOfUEHfAAdD1MflfG/6rrOh7U1Z7X5MSGybuzH0jcGAXKIkyzGbmlB
        QT9AqrsOjzxsUIJFkgcgNWYBElbplhROrg+e2XL4t9HXeOjtdB53nyTTUiAly3t6dBYnRUx8/7mN2
        OpzxuPZW7p0gldx7C4DHpql4wTFKFPeuHONP62ioXdZLtS4YNuGsJgf6aQ1j2x1/i4Pm13KQQ/CRT
        F5AfgwqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHop-0001Io-MK; Tue, 17 Mar 2020 19:24:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7ABBC30110E;
        Tue, 17 Mar 2020 20:24:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36E85284D7DF3; Tue, 17 Mar 2020 20:24:01 +0100 (CET)
Date:   Tue, 17 Mar 2020 20:24:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched/cpuset: distribute tasks within affinity masks
Message-ID: <20200317192401.GE20713@hirez.programming.kicks-ass.net>
References: <20200311010113.136465-1-joshdon@google.com>
 <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311140533.pclgecwhbpqzyrks@e107158-lin.cambridge.arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 11, 2020 at 02:05:33PM +0000, Qais Yousef wrote:
> On 03/10/20 18:01, Josh Don wrote:
> > From: Paul Turner <pjt@google.com>
> > 
> > Currently, when updating the affinity of tasks via either cpusets.cpus,
> > or, sched_setaffinity(); tasks not currently running within the newly
> > specified mask will be arbitrarily assigned to the first CPU within the
> > mask.
> > 
> > This (particularly in the case that we are restricting masks) can
> > result in many tasks being assigned to the first CPUs of their new
> > masks.
> > 
> > This:
> >  1) Can induce scheduling delays while the load-balancer has a chance to
> >     spread them between their new CPUs.
> >  2) Can antogonize a poor load-balancer behavior where it has a
> >     difficult time recognizing that a cross-socket imbalance has been
> >     forced by an affinity mask.
> > 
> > This change adds a new cpumask interface to allow iterated calls to
> > distribute within the intersection of the provided masks.
> > 
> > The cases that this mainly affects are:
> > - modifying cpuset.cpus
> > - when tasks join a cpuset
> > - when modifying a task's affinity via sched_setaffinity(2)
> > 
> > Co-developed-by: Josh Don <joshdon@google.com>
> > Signed-off-by: Josh Don <joshdon@google.com>
> > Signed-off-by: Paul Turner <pjt@google.com>

> Anyway, for the API.
> 
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Tested-by: Qais Yousef <qais.yousef@arm.com>

Thanks guys!
