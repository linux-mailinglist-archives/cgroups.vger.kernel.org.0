Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11189475DD7
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 17:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhLOQr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 11:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbhLOQr5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 11:47:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEDC061574
        for <cgroups@vger.kernel.org>; Wed, 15 Dec 2021 08:47:57 -0800 (PST)
Date:   Wed, 15 Dec 2021 17:47:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639586875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWKQmVaUmlhlu4LBLW0y54JVGs+emTP6yYulZAfEBlg=;
        b=2IFozc2UCxRwnxaxcLhssB5iej7201xbCCVh3mTjGNBMlWNimNqL7TkMlTvKyGFxza0wth
        PyNePnpWcaCgpgpYKdzHl9bzT1M9BO/3eF1UmmO+4+cmsF1t+7/oVp4M+cSY8O64//i9dP
        kYR02Dg4IhK8BEvyds5Ex1knUiQ5Oa/LxRn8BWMgFhswIKoanv+4/94SkrsTeeXAzetmo3
        lECFr4EbWVuF9LZBzWs9zGRYm+QZ76vGw+xCBBhTS5o17FB7atEJn2kDBCOWy0eYyuAF3T
        LoUr8FQaYsOnNZlMsrxgagkHtCbgn54lnXB7SJyJeTHTVlGEJXUSJnIdKHO3Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639586875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWKQmVaUmlhlu4LBLW0y54JVGs+emTP6yYulZAfEBlg=;
        b=0Siez4oA1M3vHIh4cpe9gkN+9TKepZa4ecFRf7RzuKjMHsn5DxCtj3g7bRl6LFklw2Q0k5
        b3xLWqKEywIERQAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <YbocOh+h3o/Yc5Ag@linutronix.de>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
 <YbNwmUMPFM/MO0cX@linutronix.de>
 <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YbcbmvQk+Sgdsi9G@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-13 11:08:26 [+0100], Michal Hocko wrote:
> On Fri 10-12-21 16:22:01, Sebastian Andrzej Siewior wrote:
> [...]
> I am sorry but I didn't get to read and digest the rest of the message
> yet. Let me just point out this
>=20
> > The problematic part here is mem_cgroup_tree_per_node::lock which can
> > not be acquired with disabled interrupts on PREEMPT_RT.  The "locking
> > scope" is not always clear to me.  Also, if it is _just_ the counter,
> > then we might solve this differently.
>=20
> I do not think you should be losing sleep over soft limit reclaim. This
> is certainly not something to be used for RT workloads and rather than
> touching that code I think it makes some sense to simply disallow soft
> limit with RT enabled (i.e. do not allow to set any soft limit).

Okay. So instead of disabling it entirely you suggest I should take
another stab at it? Okay. Disabling softlimit, where should I start with
it? Should mem_cgroup_write() for RES_SOFT_LIMIT always return an error
or something else?
In the meantime I try to swap in my memcg memory=E2=80=A6

Sebastian
