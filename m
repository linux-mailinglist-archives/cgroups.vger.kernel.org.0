Return-Path: <cgroups+bounces-15018-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEyOBjpXwmmGbwQAu9opvQ
	(envelope-from <cgroups+bounces-15018-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:19:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265E305797
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7E5F303F0AE
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF43D9DDC;
	Tue, 24 Mar 2026 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQQQKxK9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCObufxV"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEB3DA5B2;
	Tue, 24 Mar 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343048; cv=none; b=Yq+Y+06E4AQbj6Hu82kPg89kSXU8tW+LxxQoXnRwn6H9p7u0PpIz8KlwFGXBGVDsL0V6FXRPLOBJQoUKkp05A+wRRS5sinSvVWXBISG8ASr7Oo8K4oP336JDnQw/ownT5RZka9zA6ulQ+5vP/yVoZ1lfMfIdnhfJnq2+11ev8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343048; c=relaxed/simple;
	bh=paDYndNyF/ktkwHvWl3WWRcnb0Ou8qEIswBQKOuS5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU4gsMiddJwm8H7y1msS1EgKA/ubKs3rNaIPU6AN5AMs5ao/DKzt9tB5FXbUzDmol1HtoQ6B0wdKa84nTnF5O8FF2k6RQy352tpi2CV2z18z8SM1ujQV0ZFTivjZVENhbkoszb+iBhkUX19pxoyuLGYo+YD9C22iJQzeflqviKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JQQQKxK9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCObufxV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Mar 2026 10:04:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774343043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf1hInTI+IU03KBjiECZqpTqp1SJp9zzrcwmlyR8hTc=;
	b=JQQQKxK9+8ObL6XTwkmbXzkSDwTeVjtxv1PR92aq8+ygYkoXl4JPYFeTzVcFUR/uwdFP57
	cdKmuaLChbtEzOlEz7ACpYcRqHXUcy/eIpoxZjHYYNRW8IzH4ihWc6fVMRCX6n47Dr+qxg
	OzEWLipDrLvkrY8x5jFsXT/TAFpP3PKR+g6Kzumso9XOyGMDlHEu+/pTbyr9Jsnjacq3YD
	NIo3a6v/ZMp2rPn2RffjgA48iZc8QbCtPDgaltsCT2EGqQbW4ygkiYQCbCwH6JEQLk6mFL
	YpjyD1S2WOq15hmJMhCkUD20Nlw1TJcmlxcpTQ8/LaOU6OmAQJHUNmv3ioinRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774343043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf1hInTI+IU03KBjiECZqpTqp1SJp9zzrcwmlyR8hTc=;
	b=xCObufxVgqnkJlWVRM/lGq6ClDKxVLcgY8CF1UI+4MHlBnJ70BJGgn2vSd/q+VlCK0KGuv
	uz+OxAGAGT2fmiAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] cgroup: Wait for dying tasks to leave on rmdir
Message-ID: <20260324090402.k7NkNcEp@linutronix.de>
References: <20260323200205.1063629-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323200205.1063629-1-tj@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	TAGGED_FROM(0.00)[bounces-15018-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2265E305797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 10:02:05 [-1000], Tejun Heo wrote:
> a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup") hid PF_EXITING
> tasks from cgroup.procs so that systemd doesn't see tasks that have already
> been reaped via waitpid(). However, the populated counter (nr_populated_csets)
> is only decremented when the task later passes through cgroup_task_dead() in
> finish_task_switch(). This means cgroup.procs can appear empty while the
> cgroup is still populated, causing rmdir to fail with -EBUSY.
> 
> Fix this by making cgroup_rmdir() wait for dying tasks to fully leave. If the
> cgroup is populated but all remaining tasks have PF_EXITING set (the task
> iterator returns none due to the existing filter), wait for a kick from
> cgroup_task_dead() and retry. The wait is brief as tasks are removed from the
> cgroup's css_set between PF_EXITING assertion in do_exit() and
> cgroup_task_dead() in finish_task_switch().
> 
> v2: cgroup_is_populated() true to false transition happens under css_set_lock
>     not cgroup_mutex, so retest under css_set_lock before sleeping to avoid
>     missed wakeups (Sebastian).
> 
> Fixes: a72f73c4dd9b ("cgroup: Don't expose dead tasks in cgroup")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202603222104.2c81684e-lkp@intel.com
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: Michal Koutny <mkoutny@suse.com>
> Cc: cgroups@vger.kernel.org

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

As mentioned in the other email, if I 
-       irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
+       schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), 1 * HZ);

then I hung at boot because it rmdir() a cgroup with a task in Z. It
might suggest a race because systemd might missed a task.
But this fixes the other issue so.

Sebastian

