Return-Path: <cgroups+bounces-14994-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F5iGK8nwWmbRAQAu9opvQ
	(envelope-from <cgroups+bounces-14994-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 12:44:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93032F163A
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5BD2303276F
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2B39098C;
	Mon, 23 Mar 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BifyUbd3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2oNmWvU"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4D35F169;
	Mon, 23 Mar 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265577; cv=none; b=Tyssj484Ikbaydpf7NRBc0rUFCOfApJVq4RVKQR84x40MqQ/wjd3B+XGx/zIyVs5nJZs7jU56S8o8uHunNrn52sukt/p/2GMWhkKxMalIQvqCV3eIF4wPxqpJd0tQ5gIERzfA75hEy1JAr/HpROCFuHUvQBfDO24V2Ftk0dRJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265577; c=relaxed/simple;
	bh=mDJqRMloJ3NBUZezW6whF3idh6ZlNm3zXpp3r1muV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk+4Wjfd/4KqXDj52ZRpTNjRJti6o/kL0zZ3mhSUuMu63rS4hd09CoURZcHfWDp5nyZTWvISzum0g6dPoWlTT68sWCm4WBC5eydeKNdQnr8ThPkcMyGgQdgJb3M6DFwABOUs0qvGEsyw5SE/SBLtb6U+8EpYvIwJSLqS4Or5r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BifyUbd3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2oNmWvU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Mar 2026 12:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774265574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jtm/lLUOB2ez4Z+Om5po55H772f0PRRvnT4Ebhp4Sc=;
	b=BifyUbd3AoQjKkNpjKKJ4MgyFn1A5ZsjznMvRoCQd+BydSSwksLYVquwZ+9TNDxwtcp55I
	2sdDS1e12Lx5hIEbBU14FgQXhFR/AN6/QNSvY9ajXASNzSxfCX20jT/0Hme+mhW807mXn3
	DhPXUYVHswdX4/6fgo6Jja9/G9LWY6Xqe+PrBEyzkdyvyIv4/rT//1t7MOZWxNF3SYCfMH
	2z4LXzGoVo9yCS5mFKU960ZNSsCGcXmMStW7YTKj/pPDviIBei/zJdH9xtzqnrBXZS2B5P
	gbLhNgnMyWtyg+H7de9zIGYWbNKme+QsziTMtz5wR9qlFN2+DccW8R8CumrAeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774265574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jtm/lLUOB2ez4Z+Om5po55H772f0PRRvnT4Ebhp4Sc=;
	b=n2oNmWvUovocIvaEQlMmFaZEbecNFL42cXhP+BSv9+o3xp2cXssWCk1aFZvZhaEWjbxhlB
	FySQYoA84OsjRHBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] cgroup: Wait for dying tasks to leave on rmdir
Message-ID: <20260323113252.xsuwQA3z@linutronix.de>
References: <20260323035806.724798-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260323035806.724798-1-tj@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14994-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_stress.sh:url,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: B93032F163A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-22 17:58:06 [-1000], Tejun Heo wrote:
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6224,6 +6225,63 @@ static int cgroup_destroy_locked(struct cgroup *cg=
rp)
=E2=80=A6
> +static int cgroup_drain_dying(struct cgroup *cgrp)
> +	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +	DEFINE_WAIT(wait);
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +retry:
> +	if (!cgroup_is_populated(cgrp))
> +		return 0;
> +
> +	/* Same iterator as cgroup.threads - if any task is visible, it's busy =
*/
> +	css_task_iter_start(&cgrp->self, 0, &it);
> +	task =3D css_task_iter_next(&it);
> +	css_task_iter_end(&it);
> +
> +	if (task)
> +		return -EBUSY;
> +
> +	/*
> +	 * All remaining tasks are PF_EXITING and will pass through
> +	 * cgroup_task_dead() shortly. Wait for a kick and retry.
> +	 */
> +	prepare_to_wait(&cgrp->dying_populated_waitq, &wait,
> +			TASK_UNINTERRUPTIBLE);
> +	mutex_unlock(&cgroup_mutex);

I had to add here
	if (cgroup_is_populated(cgrp))

> +	schedule();

I saw instances on PREEMPT_RT where the above cgroup_is_populated()
reported true due to cgrp->nr_populated_csets =3D 1, the following
iterator returned NULL but in that time do_cgroup_task_dead() saw no
waiter and continued without a wake_up and then the following schedule()
hung.
There is no serialisation between this wait/ check and latter wake. An
alternative would be to check and prepare_to_wait() under css_set_lock.

> +	finish_wait(&cgrp->dying_populated_waitq, &wait);
> +	mutex_lock(&cgroup_mutex);
> +	goto retry;
> +}

Then I added my RCU patch. This led to a problem already during boot up
(didn't manage to get to the test suite).

systemd-1 places modprobe-1044 in a cgroup, then destroys the cgroup.
It hangs in cgroup_drain_dying() because nr_populated_csets is still 1.
modprobe-1044 is still there in Z so the cgroup removal didn't get there
yet. That irq_work was quicker than RCU in this case. This can be
reproduced without RCU by
-       irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
+       schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), HZ);

So there is always a one second delay. If I give up waiting after 10secs
then it boots eventually and there are no zombies around. The test_core
seems to complete=E2=80=A6

Having the irq_work as-is, then the "cgroup_dead()" happens on the HZ
tick. test_core then complains just with
| not ok 7 test_cgcore_populated

everything else passes. With schedule_work() (as in right away) all
tests pass including test_stress.sh

Is there another race lurking?

Sebastian

