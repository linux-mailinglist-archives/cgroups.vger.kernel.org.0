Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84813C8911
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhGNQ5Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Jul 2021 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGNQ5Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Jul 2021 12:57:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64187C06175F;
        Wed, 14 Jul 2021 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q0twLm1z1R0272a0gO8MDKn0VGtCaKOLX5zeaoDfy7Y=; b=fyvXzPlxhF3nWWnznUlnq4Dikm
        hX2wJaaNocJtshQ0ww0fN1B4flWR1WAf9fv6REtMnCM11+TFwu72WK17oDrcLSDc9pOww0UZFQvGq
        nk5K1LrOAyuAEF880y7lGv2O5lk6CYX5cz+rNEM4jAooUOPr0uzxpRDDd6VqmrTpu9OvzsM/Y0NpJ
        vpK9G3MPxB49hQERwFqvHF2RBPArImxE4GZooADG7gXFSiBMWUIxP5xPDGYW8YLQyG9shv3Gfex64
        9L7P98EIfUwgbPdWp075MRNcR5MBJFoGs28h/co7WlWPYfzKj3mMTFhyn1QWxCuwG5uZy9PqS/fpP
        Qq3IMuyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3i7r-002OGM-KU; Wed, 14 Jul 2021 16:53:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29748300056;
        Wed, 14 Jul 2021 18:52:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6195020141192; Wed, 14 Jul 2021 18:52:44 +0200 (CEST)
Date:   Wed, 14 Jul 2021 18:52:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
Message-ID: <YO8WWxWBmNuI0iUW@hirez.programming.kicks-ass.net>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714135420.69624-7-frederic@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 14, 2021 at 03:54:20PM +0200, Frederic Weisbecker wrote:
> Add a new cpuset.isolation_mask file in order to be able to modify the
> housekeeping cpumask for each individual isolation feature on runtime.
> In the future this will include nohz_full, unbound timers,
> unbound workqueues, unbound kthreads, managed irqs, etc...
> 
> Start with supporting domain exclusion and CPUs passed through
> "isolcpus=".
> 
> The cpuset.isolation_mask defaults to 0. Setting it to 1 will exclude
> the given cpuset from the domains (they will be attached to NULL domain).
> As long as a CPU is part of any cpuset with cpuset.isolation_mask set to
> 1, it will remain isolated even if it overlaps with another cpuset that
> has cpuset.isolation_mask  set to 0. The same applies to parent and
> subdirectories.
> 
> If a cpuset is a subset of "isolcpus=", it automatically maps it and
> cpuset.isolation_mask will be set to 1. This subset is then cleared from
> the initial "isolcpus=" mask. The user is then free to override
> cpuset.isolation_mask to 0 in order to revert the effect of "isolcpus=".
> 
> Here is an example of use where the CPU 7 has been isolated on boot and
> get re-attached to domains later from cpuset:
> 
> 	$ cat /proc/cmdline
> 		isolcpus=7
> 	$ cd /sys/fs/cgroup/cpuset
> 	$ mkdir cpu7
> 	$ cd cpu7
> 	$ cat cpuset.cpus
> 		0-7
> 	$ cat cpuset.isolation_mask
> 		0
> 	$ ls /sys/kernel/debug/domains/cpu7	# empty because isolcpus=7
> 	$ echo 7 > cpuset.cpus
> 	$ cat cpuset.isolation_mask	# isolcpus subset automatically mapped
> 		1
> 	$ echo 0 > cpuset.isolation_mask
> 	$ ls /sys/kernel/debug/domains/cpu7/
> 		domain0  domain1
> 

cpusets already has means to create paritions; why are you creating
something else?
