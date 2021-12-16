Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1032476B37
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhLPHvz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Dec 2021 02:51:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhLPHvz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Dec 2021 02:51:55 -0500
Date:   Thu, 16 Dec 2021 08:51:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639641113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7M0mhRgQajj4JooEekItEmeezbDQdgPBX9TAoVx0FJ4=;
        b=fFIBCwWplbZ0Rdcm9iQ+R/u7UmGMd+qS7fmMP6RWtHq2X8wxzfHokIcFxQk9Fn/xFZhpbC
        y8equxQrn8WrWM1R7Gi3s3ux6ycuV3Qkj5ssXxfeeymw20UjYrIQgkb+cYxDzaOERm1bxj
        4X7xN0c1x9kj99x6vQz5HPLAbf6ou+LeBW17X6oyt4bg8GWjTBR6jWBAggamBoAC5nq8f1
        6o7IDHjfrLH2NAIlK/N5Bv94kXywaz+BJR62yeM+5cEjB9ELtIvEgqxJRkY6e6v3nrifC2
        wDKOhtt1p9VpK4ujtNK79ZdyRcvms2BvgRcRzVBFvpIAFAW3fIXnJ9Gtv2ekmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639641113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7M0mhRgQajj4JooEekItEmeezbDQdgPBX9TAoVx0FJ4=;
        b=4DYVkaQQzSIvUTNyOabyRGRff4LFhI6EsnuFBJ/cD/VnzcEAIm2QGCrJVDH5iYiwhF6UQt
        Q3hC1ZsoHK26A5Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <YbrwGCoklB+IOqH0@linutronix.de>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
 <YbNwmUMPFM/MO0cX@linutronix.de>
 <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
 <YbocOh+h3o/Yc5Ag@linutronix.de>
 <YboeI1aTFdQpN0TI@dhcp22.suse.cz>
 <YboiRA1znig/cbCt@linutronix.de>
 <Ybo3cAkyg0SrUyJJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybo3cAkyg0SrUyJJ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-15 19:44:00 [+0100], Michal Hocko wrote:
> On Wed 15-12-21 18:13:40, Sebastian Andrzej Siewior wrote:
> > Okay. What do I gain by doing this / how do I test this? Is running
> > tools/testing/selftests/cgroup/test_*mem* sufficient to test all corner
> > cases here?
> 
> I am not fully aware of all the tests but my point is that if the soft
> limit is not configured then there are no soft limit tree manipulations
> ever happening and therefore the code is effectivelly dead. Is this
> sufficient for the RT patchset to ignore the RT incompatible parts?

So if that softlimit is not essential and makes things easier by simply
disabling it, yes I could try that. I will keep that in mind.

Sebastian
