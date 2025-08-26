Return-Path: <cgroups+bounces-9420-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1EB36099
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57F87B716D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62A1B6D06;
	Tue, 26 Aug 2025 13:02:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7241A23A4;
	Tue, 26 Aug 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213323; cv=none; b=LpEYdAA8IGCS6L73GZ+dpFno5lVS4LPHR3tHr/niOEmg+qqggBm95lQQ3mla62cSwE23sQHZaKmoxjZWsdu1G1Kv60hj7Dhdr1hTE5J9xl//a5wgdC4eKuR2pCg7Ssur8qoXb1j6QUvnOfDU7xtcErJ585lvz6LnqVVcYB7VEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213323; c=relaxed/simple;
	bh=BZENBkY7KxZXwgQQGETVx76avjGsrNPrRhpl9hyDGBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYW4Hya/4OgsKjWqYKWmgwikAiiNLQG7lN/koAbODoS6oEyp8et2TRtfNoGbCnEAowyoVDvdjjeKprGuEbg+lxtcTrez+DwYuwHJTO7Y4QorZ9D5EcrlzUhM+0uP2Ck6VfAuWWOeveEIQcqT21Fvv5DFieruEsV2nJLkRzQ3Zc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cB78X5XsgzYmVyt;
	Tue, 26 Aug 2025 21:01:32 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 21:01:48 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 21:01:48 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <shakeel.butt@linux.dev>
CC: <akpm@linux-foundation.org>, <cgroups@vger.kernel.org>,
	<feng.han@honor.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <mhocko@suse.com>, <rientjes@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v5 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Tue, 26 Aug 2025 21:01:44 +0800
Message-ID: <20250826130144.21522-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <jzzdeczuyraup2zrspl6b74muf3bly2a3acejfftcldfmz4ekk@s5mcbeim34my>
References: <jzzdeczuyraup2zrspl6b74muf3bly2a3acejfftcldfmz4ekk@s5mcbeim34my>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a018.hihonor.com
 (10.68.17.250)

> +cgroups
> 
> On Mon, Aug 25, 2025 at 09:38:54PM +0800, zhongjinji wrote:
> > The OOM reaper can quickly reap a process's memory when the system
> > encounters OOM, helping the system recover. If the victim process is
> > frozen and cannot be unfrozen in time, the reaper delayed by two seconds
> > will cause the system to fail to recover quickly from the OOM state.
> > 
> > When an OOM occurs, if the victim is not unfrozen, delaying the OOM reaper
> > will keep the system in a bad state for two seconds. Before scheduling the
> > oom_reaper task, check whether the victim is in a frozen state. If the
> > victim is frozen, do not delay the OOM reaper.
> > 
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > ---
> >  mm/oom_kill.c | 40 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..4b4d73b1e00d 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -683,6 +683,41 @@ static void wake_oom_reaper(struct timer_list *timer)
> >  	wake_up(&oom_reaper_wait);
> >  }
> >  
> > +/*
> > + * When the victim is frozen, the OOM reaper should not be delayed, because
> > + * if the victim cannot be unfrozen promptly, it may block the system from
> > + * quickly recovering from the OOM state.
> > + */
> > +static bool should_delay_oom_reap(struct task_struct *tsk)
> > +{
> > +	struct mm_struct *mm = tsk->mm;
> > +	struct task_struct *p;
> > +	bool ret;
> > +
> 
> On v2, shouldn't READ_ONCE(tsk->frozen) be enough instead of mm check
> and checks insode for_each_process()?

Thank you.
It is mainly to check the processes created by vfork. I believe no one would
put them into different cgroups, so I also think that READ_ONCE(tsk->frozen)
is enough. I will update it.

> > +	if (!mm)
> > +		return true;
> > +
> > +	if (!frozen(tsk))
> > +		return true;
> > +
> > +	if (atomic_read(&mm->mm_users) <= 1)
> > +		return false;
> > +
> > +	rcu_read_lock();
> > +	for_each_process(p) {

