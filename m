Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E13CD631
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbhGSNQv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 09:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237309AbhGSNQu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 19 Jul 2021 09:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F4DD61006;
        Mon, 19 Jul 2021 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626703050;
        bh=+gVq/NFsqZiiPUEMlRTEwLOqGw7ioAT+zNXkcTJwXSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDyz5R+TBMFxLUUYo1IoQTxZpDh1twoMsHUmfL0NQkHCmV9hhtBs/kvJ0JI7WZIaa
         mddj4GV4kxWWR/KJi+/bK8N4FPB9OD0RMAFdfFnTfIYY+47oZ9zCli0GHBv3rm5gRy
         aRyUECiBI9Vhem5Lfq5o09JOb7d7DkR7ON+ceouOITetcG7rM2405gaH/+vX3Be953
         5Bm3FcH0mX1Ek1rGpB+qXz3ZCwCHcdZlqyr472clqvGzJKs/+iwQhi3pLIb/9xLqKW
         0B4C+rb2rxI+Cyx85ZUR3NwT5A37yIMHuNkGO1kmelIzRBkNARj2916Fkou0EjXd/O
         tu1JH1vqPyxKg==
Date:   Mon, 19 Jul 2021 15:57:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Waiman Long <llong@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] cpuset: Allow to modify isolcpus through cpuset
Message-ID: <20210719135728.GD116346@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org>
 <8ea7a78f-948e-75e8-1c4f-59b349c858f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea7a78f-948e-75e8-1c4f-59b349c858f6@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 16, 2021 at 02:02:50PM -0400, Waiman Long wrote:
> On 7/14/21 9:54 AM, Frederic Weisbecker wrote:
> > The fact that "isolcpus=" behaviour can't be modified at runtime is an
> > eternal source of discussion and debate opposing a useful feature against
> > a terrible interface.
> > 
> > I've long since tried to figure out a proper way to control this at
> > runtime using cpusets, which isn't easy as a boot time single cpumask
> > is difficult to map to a hierarchy of cpusets that can even overlap.
> 
> I have a cpuset patch that allow disabling of load balancing in a cgroup-v2
> setting:
> 
> https://lore.kernel.org/lkml/20210621184924.27493-1-longman@redhat.com/
> 
> The idea of cpuset partition is that there will be no overlap of cpus in
> different partitions. So there will be no confusion whether a cpu is
> load-balanced or not.

Oh ok I missed that, time for me to check your patchset.

Thanks!

> 
> > 
> > The idea here is to map the boot-set isolation behaviour to any cpuset
> > directory whose cpumask is a subset of "isolcpus=". I let you browse
> > for details on the last patch.
> > 
> > Note this is still WIP and half-baked, but I figured it's important to
> > validate the interface early.
> 
> Using different cpumasks for different isolated properties is the easy part.
> The hard part is to make different subsystems to change their behavior as
> the isolation masks change dynamically at run time. Currently, they check
> the housekeeping cpumask only at boot time or when certain events happen.
> 
> Cheers,
> Longman
> 
> 
