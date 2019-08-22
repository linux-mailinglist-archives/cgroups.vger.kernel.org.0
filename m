Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9FB98D71
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfHVIUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 04:20:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59153 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfHVIUi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Aug 2019 04:20:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0iKe-0004wo-UP; Thu, 22 Aug 2019 10:20:33 +0200
Date:   Thu, 22 Aug 2019 10:20:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de
Subject: Re: [PATCH 1/4] cgroup: Remove ->css_rstat_flush()
Message-ID: <20190822082032.qyy2isvvtj5waymx@linutronix.de>
References: <20190816111817.834-1-bigeasy@linutronix.de>
 <20190816111817.834-2-bigeasy@linutronix.de>
 <20190821155329.GJ2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821155329.GJ2263813@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2019-08-21 08:53:29 [-0700], Tejun Heo wrote:
> On Fri, Aug 16, 2019 at 01:18:14PM +0200, Sebastian Andrzej Siewior wrote:
> > I was looking at the lifetime of the the ->css_rstat_flush() to see if
> > cgroup_rstat_cpu_lock should remain a raw_spinlock_t. I didn't find any
> > users and is unused since it was introduced in commit
> >   8f53470bab042 ("cgroup: Add cgroup_subsys->css_rstat_flush()")
> > 
> > Remove the css_rstat_flush callback because it has no users.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Yeah, I'd rather keep it.  The patch which used this didn't get merged
> but the use case is valid and it will likely be used for different
> cases.

I was afraid that the inner while loop in cgroup_rstat_flush_locked()
could get too long with the css_rstat_flush() here. Especially if it
acquires spin locks. But since this is not currently happening...
Any objections to the remaining series if I drop this patch?

> Thanks.
> 

Sebastian
