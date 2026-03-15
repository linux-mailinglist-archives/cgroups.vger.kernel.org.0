Return-Path: <cgroups+bounces-14824-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHqqDHQTt2krMQEAu9opvQ
	(envelope-from <cgroups+bounces-14824-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 15 Mar 2026 21:15:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D262924F7
	for <lists+cgroups@lfdr.de>; Sun, 15 Mar 2026 21:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA7E3022570
	for <lists+cgroups@lfdr.de>; Sun, 15 Mar 2026 20:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5937AA88;
	Sun, 15 Mar 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dszn9Mk4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7023EA8A;
	Sun, 15 Mar 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605743; cv=none; b=JnrUZRN3HZpdopgyR73dSb5Bq032Iacoxrun+oJm0EHVxBIYGIPR+DEhUPnZzUhSFi/0vxptBC+MnTHCHlpN6/rIuj5ZNxDFuO/ZkXeZIEq9K2lvhxvcLziOe56Vps73B3cyyS47eyqm+BS7bLanPcaxiJ3bYbBb5cQqHp2rUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605743; c=relaxed/simple;
	bh=7MdwhcSr64gXXav3Nd139ZAzwF1wbFY211yV/ZhdCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1q1xxCDwx7kt/0w6v57R/rZoOEVUSJzEG0M/ejJGfEg5QWC0NCRqQeb/oXY01hiFBl/UGYw7Li9Y7UnMZd1V+ErqV90geIf5c4BaI6kz9n6La422UidNUnSRlhj7c38Vy4bj2F0TloU7wLdZDOEssZqj2/8KZq/2CdsVyfeK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dszn9Mk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE11C4CEF7;
	Sun, 15 Mar 2026 20:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773605742;
	bh=7MdwhcSr64gXXav3Nd139ZAzwF1wbFY211yV/ZhdCwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dszn9Mk4LROcAuM6KaacfiarW9DyjxB9saY919tSfpSfjX1FQtLeiEcsgSQgng+mb
	 A4hr2kNsOFuEP55Yy6ayfw8PS7VIEqUkyYGdfNHgjKkpMXdFafy8z2gO47wLrRqv8z
	 TJjIvccNY/KBFanu/4FoIRMoQEyp1hwfcVlLFSKLFW0nJpS5+9cIHOl8ZCyjRWCO5N
	 fCQo3qFR4Xo/WxS3o2Dv1XPRTVMXJXkCfxUAEzoqnF9V7HoREzAcUH0VfxanDkJK+2
	 d/xCoaBznXSAgnW/jCJ084Byn5A1/N+yAwqM7GF/g2C+PUQemX/YQ1GXUI7KH1VThK
	 i7plIvvfO83Fw==
Date: Sun, 15 Mar 2026 10:15:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <abcTbSznpQ1qxJdj@slm.duckdns.org>
References: <20260311120829.rEHY-xh9@linutronix.de>
 <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
 <20260314091752.B7CXvQxn@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314091752.B7CXvQxn@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14824-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,linutronix.de:email]
X-Rspamd-Queue-Id: A9D262924F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Sat, Mar 14, 2026 at 10:17:52AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-13 18:33:14 [+0100], Michal Koutný wrote:
> > Hello.
> > 
> > On Wed, Mar 11, 2026 at 01:08:29PM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > @@ -7084,6 +7031,7 @@ void cgroup_task_free(struct task_struct *task)
> > >  {
> > >  	struct css_set *cset = task_css_set(task);
> > >  
> > > +	cgroup_task_dead(task);
> > >  	if (!list_empty(&task->cg_list)) {
> > >  		spin_lock_irq(&css_set_lock);
> > >  		css_set_skip_task_iters(task_css_set(task), task);
> > 
> > Erm, isn't this way too late?
> 
> My understanding is that the point is that the cgroup must not be
> exposed to userland once the task is about to die. This has been moved
> after the fine schedule() which is too late because the parent is
> signaled before that and the removal happens after that.
> So now we hide the tasks in the iterator once the task is PF_EXITING.

Yeah, I think it's too late. That's where we tell the cgroup is becoming
empty among other things. cgroup_task_free() waits for all task refcnts to
drop which can take any amount of time. You can also imagine situations
where e.g. userspace pins a specific task through pidfd unitl the cgroup it
belongs becomes empty, which would have worked before but now would
deadlock.

Thanks.

-- 
tejun

