Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE7475E4C
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbhLORNn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 12:13:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49292 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhLORNm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 12:13:42 -0500
Date:   Wed, 15 Dec 2021 18:13:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639588421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYXjzbGZlnN964PjJtzgEeX8RXqMVqwrS5n7/IuOGFI=;
        b=REqxSx+V31su26fCsE584O65uicmLycV3UA7QCYU9fdpth3uBkeQoRi4uJDeJLc4JUvAtD
        +PHYJDuMxpxJGiz2JkppXqJZcskLdO4iXoeTIJt/ImE8S72gp2dAA3Cx0sGcR6kGIxStY2
        +52K2rbXYrTAxMSNFYImMHK6G9rpOttoQvCxrLbhK/w7cvjU4ao8Yi3HVfoawP7Ah6/PDg
        nITGvxnemLqPRUlENkSdgr6gzPfPnb5FtV3qPfhrHYXdmE6/4xp/LYaaNoA8VE/+k5EVX1
        +Iwcc+fsW8iKf1R7Q8M/Cxu6iZ9tw48srCmxB4wUd73qxqorCjBGXjGqOFJ6WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639588421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYXjzbGZlnN964PjJtzgEeX8RXqMVqwrS5n7/IuOGFI=;
        b=QJ4AOPazmGLlU6Mdv7IO0XBCvO5u84k/9ccp0EH3VnFLVEfxqOu8XJY74BDcJ7iQQ8AYPB
        RsymUKCJvMZ/QrAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <YboiRA1znig/cbCt@linutronix.de>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
 <YbNwmUMPFM/MO0cX@linutronix.de>
 <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
 <YbocOh+h3o/Yc5Ag@linutronix.de>
 <YboeI1aTFdQpN0TI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YboeI1aTFdQpN0TI@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-15 17:56:03 [+0100], Michal Hocko wrote:
> On Wed 15-12-21 17:47:54, Sebastian Andrzej Siewior wrote:
> > On 2021-12-13 11:08:26 [+0100], Michal Hocko wrote:
> > > On Fri 10-12-21 16:22:01, Sebastian Andrzej Siewior wrote:
> > > [...]
> > > I am sorry but I didn't get to read and digest the rest of the message
> > > yet. Let me just point out this
> > > 
> > > > The problematic part here is mem_cgroup_tree_per_node::lock which can
> > > > not be acquired with disabled interrupts on PREEMPT_RT.  The "locking
> > > > scope" is not always clear to me.  Also, if it is _just_ the counter,
> > > > then we might solve this differently.
> > > 
> > > I do not think you should be losing sleep over soft limit reclaim. This
> > > is certainly not something to be used for RT workloads and rather than
> > > touching that code I think it makes some sense to simply disallow soft
> > > limit with RT enabled (i.e. do not allow to set any soft limit).
> > 
> > Okay. So instead of disabling it entirely you suggest I should take
> > another stab at it? Okay. Disabling softlimit, where should I start with
> > it? Should mem_cgroup_write() for RES_SOFT_LIMIT always return an error
> > or something else?
> 
> Yeah, I would just return an error for RT configuration. If we ever need
> to implement that behavior for RT then we can look at specific fixes.

Okay. What do I gain by doing this / how do I test this? Is running
tools/testing/selftests/cgroup/test_*mem* sufficient to test all corner
cases here?

> Thanks!
Thank you ;)

Sebastian
