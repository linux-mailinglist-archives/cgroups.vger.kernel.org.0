Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52B151D7C
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBDPmJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Feb 2020 10:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgBDPmJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 Feb 2020 10:42:09 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6310720674;
        Tue,  4 Feb 2020 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580830928;
        bh=BjJC7k92nscSHgX3QEP5TLsEjNIcUbWPSbm8tJPQCms=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=vDF1etBtRok8p/4+IjEevyVwRJwKpsalx/+GC/Bk2GJ74irf9F6c/odDItuYwXFMI
         1I3YruT5lJl36VvIxUcSqTsUyYzKlMoTqc2uwQEE2UmAQT5DIJPCOT2Xv03TzC57KJ
         RRVAxNfhvxGZP2J/g+wn4CSC7JHif4ES6SMGAnDA=
Date:   Wed, 5 Feb 2020 00:42:00 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        minwoo.im.dev@gmail.com, tglx@linutronix.de, ming.lei@redhat.com,
        edmund.nadolski@intel.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
Message-ID: <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1580786525.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 04, 2020 at 11:30:45AM +0800, Weiping Zhang wrote:
> This series try to add Weighted Round Robin for block cgroup and nvme
> driver. When multiple containers share a single nvme device, we want
> to protect IO critical container from not be interfernced by other
> containers. We add blkio.wrr interface to user to control their IO
> priority. The blkio.wrr accept five level priorities, which contains
> "urgent", "high", "medium", "low" and "none", the "none" is used for
> disable WRR for this cgroup.

The NVMe protocol really doesn't define WRR to be a mechanism to mitigate
interference, though. It defines credits among the weighted queues
only for command fetching, and an urgent strict priority class that
starves the rest. It has nothing to do with how the controller should
prioritize completion of those commands, even if it may be reasonable to
assume influencing when the command is fetched should affect its
completion.

On the "weighted" strict priority, there's nothing separating "high"
from "low" other than the name: the "set features" credit assignment
can invert which queues have higher command fetch rates such that the
"low" is favoured over the "high".

There's no protection against the "urgent" class starving others: normal
IO will timeout and trigger repeated controller resets, while polled IO
will consume 100% of CPU cycles without making any progress if we make
this type of queue available without any additional code to ensure the
host behaves..

On the driver implementation, the number of module parameters being
added here is problematic. We already have 2 special classes of queues,
and defining this at the module level is considered too coarse when
the system has different devices on opposite ends of the capability
spectrum. For example, users want polled queues for the fast devices,
and none for the slower tier. We just don't have a good mechanism to
define per-controller resources, and more queue classes will make this
problem worse.

On the blk-mq side, this implementation doesn't work with the IO
schedulers. If one is in use, requests may be reordered such that a
request on your high-priority hctx may be dispatched later than more
recent ones associated with lower priority. I don't think that's what
you'd want to happen, so priority should be considered with schedulers
too.

But really, though, NVMe's WRR is too heavy weight and difficult to use.
The techincal work group can come up with something better, but it looks
like they've lost interest in TPAR 4011 (no discussion in 2 years, afaics).
