Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A14705CB
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhLJQiL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 11:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhLJQiL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 11:38:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478EC061746;
        Fri, 10 Dec 2021 08:34:35 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:34:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639154074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1optRwnSrbeTPq5hBXQ3ouIMBUA6Hs3VoxqW7Qdr5pQ=;
        b=cnZTbXRHb2RdvBl953YymNVlA/R/XwIkNnZFSBQV7xPgJQJi3k+Ts4wU56zs4hB6gN9Zx9
        zkt/xK85on0ihLpz4acHhJ9xGDUBdYiugnCJEdkk6QsZOj4pG4+ilNS2U9+alljTlyrisS
        /F3LnJ6esbiYZPRMfzrY8Oj/jVgrjByGEsEAFQzC7+K5o/s6JlEgNnvzpdu1+NJtiCQyu/
        kUAB6hG9mSPsbsymczRl189WujmmAsog42aw5+L1RWAx9TlF3JwXJ/Jc/ccjMJr2gWX7x6
        NO0xIYJPypme254pSw/MVWnzfDx9GTXCG/uFfFvZOKvmO+2FU1IqjpgqRTuy+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639154074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1optRwnSrbeTPq5hBXQ3ouIMBUA6Hs3VoxqW7Qdr5pQ=;
        b=F1qbHzysXR9EGrBloIho2z2ExfYszOTiOtQNVU/EQ3u+tFM7ZODd5S9xeyggKtrxBYYpZP
        9AMc1tMvD1ujHmDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH-next v2] mm/memcg: Properly handle memcg_stock access for
 PREEMPT_RT
Message-ID: <YbOBmYrInQVI+VOR@linutronix.de>
References: <20211210025228.158196-1-longman@redhat.com>
 <YbNPrGEjtKjzEjQa@linutronix.de>
 <80ee87bb-f36c-4a16-9095-43ea84818375@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <80ee87bb-f36c-4a16-9095-43ea84818375@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-10 11:29:31 [-0500], Waiman Long wrote:
>=20
> On 12/10/21 08:01, Sebastian Andrzej Siewior wrote:
> > On 2021-12-09 21:52:28 [-0500], Waiman Long wrote:
> > =E2=80=A6
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > =E2=80=A6
> > > @@ -2210,7 +2211,7 @@ static void refill_stock(struct mem_cgroup *mem=
cg, unsigned int nr_pages)
> > >   	struct memcg_stock_pcp *stock;
> > >   	unsigned long flags;
> > > -	local_irq_save(flags);
> > > +	local_lock_irqsave(&memcg_stock.lock, flags);
> > Why is this one using the lock? It isn't accessing irq_obj, right?
> Well, the lock isn't just for irq_obj. It protects the whole memcg_stock
> structure which include irq_obj. Sometimes, data in irq_obj (or task_obj)
> will get transfer to nr_pages and vice versa. So it is easier to use one
> single lock for the whole thing.

This needs way better documentation what protects what any why.
I don't like the quick slapping for RT only usage without any kind of
explanation. Once you think you know it is irq_obj only you end up here
where you have the lock again for no obvious reason.

>=20
> Cheers,
> Longman

Sebastian
