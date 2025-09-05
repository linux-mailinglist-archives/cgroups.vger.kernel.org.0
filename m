Return-Path: <cgroups+bounces-9717-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCEEB44B9C
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 04:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D253AA023E
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97321ADA7;
	Fri,  5 Sep 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcPPYkbK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311A200113;
	Fri,  5 Sep 2025 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039281; cv=none; b=JVJ84ljQH1Wnihij/d8uG497UBafNH1YgMgZfpxfPl7COsaVRlw7BNDmphSVGZ6OFPVR3SvbpbKOO7k4SWlVlreb1m/dr65JgEsOweoYHMK9eCWXY4rPNX3txuZnto9PDejFKjqKUpFVWaGgb0j4j5dnAooKVcjUqRMMD0zCxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039281; c=relaxed/simple;
	bh=oPqzWmjLUpku7Mb+6rePpAmC62We+Om8XH7mSYeF7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAG0qDzvvl+WAIySnTbqojGOC1DuAZfo1on7gJWmlPCc/fiZtD3YCqMxAdrKUqLeS+7m9J3sAKtAis9u9DToujKBju/5lAyL4stCp1MqyDxbFT0zizgOhShl6/vDNQdTofH88FhEnFopm/C3DW1EI8+vMlG5tyITX1CzRDEl8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcPPYkbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2904C4CEF0;
	Fri,  5 Sep 2025 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757039280;
	bh=oPqzWmjLUpku7Mb+6rePpAmC62We+Om8XH7mSYeF7cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcPPYkbKExL4lsM/ibJaUrthCs9RTQ630El2qX/qRfwfwhLyPlrGCTnpm7TN9bJZv
	 nY/uCWTK1R98aiOKKEcUKHosz2ADfehkzVXBJeeqvmExsY016fgEwB6G30V4NOo2Vy
	 AjB7YKCVVaKss+lYGw2bp2l94wrLKE88f3eC58o0wph8rb16qNjUc3z0Bl2pSmphLr
	 N6RGe6SsuOkm7GtvhTUEQnolfxQu2wdrl9QMKNbqTrAzahJhOBtCoN8Dzqgp5qMTt3
	 BIGTQOZiDQcHOU+YnBvxbTnpvn1bm4COW0ABU4+OK8CWwu2D1fCRo9bdvTGmImr0WC
	 PpisJmAzSmCsA==
Date: Thu, 4 Sep 2025 16:27:59 -1000
From: Tejun Heo <tj@kernel.org>
To: escape <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLpKr6_r5exdc3EQ@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1756985260.git.escape@linux.alibaba.com>
 <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
 <aLm-2Lcnu602AB85@slm.duckdns.org>
 <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>

Hello,

On Fri, Sep 05, 2025 at 10:16:30AM +0800, escape wrote:
> > > +	if (have_favordynmods)
> > > +		up_read(&tsk->signal->group_rwsem);
> > >   	percpu_up_read(&cgroup_threadgroup_rwsem);
> > Hmm... I wonder whether turning on/off the flag is racy. ie. what prevents
> > have_favordynmods flipping while a task is between change_begin and end?
>
> have_favordynmods is read-only after initialization and will not change
> during runtime.

I don't think that's necessarily true. favordynmods can also be specified as
a mount option and mount can race against forks, execs and exits. Also,
IIRC, cgroup2 doesn't allow remounts but there's nothing preventing someone
from unmounting and mounting it again with different options.

> > > @@ -3010,15 +3008,27 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
> > >   	 */
> > >   	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
> > >   		tsk = ERR_PTR(-EINVAL);
> > > -		goto out_unlock_threadgroup;
> > > +		goto out_unlock_rcu;
> > >   	}
> > > -
> > >   	get_task_struct(tsk);
> > > -	goto out_unlock_rcu;
> > > -out_unlock_threadgroup:
> > > -	cgroup_attach_unlock(*threadgroup_locked);
> > > -	*threadgroup_locked = false;
> > > +	rcu_read_unlock();
> > > +
> > > +	/*
> > > +	 * If we migrate a single thread, we don't care about threadgroup
> > > +	 * stability. If the thread is `current`, it won't exit(2) under our
> > > +	 * hands or change PID through exec(2). We exclude
> > > +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> > > +	 * callers by cgroup_mutex.
> > > +	 * Therefore, we can skip the global lock.
> > > +	 */
> > > +	lockdep_assert_held(&cgroup_mutex);
> > > +	*threadgroup_locked = pid || threadgroup;
> > > +
> > > +	cgroup_attach_lock(tsk, *threadgroup_locked);
> > I'm not sure this relocation is safe. What prevents e.g. @tsk changing its
> > group leader or signal struct before lock is grabbed?
>
> When a non-leader thread in a thread group executes the exec system call,
> the thread group leader is updated, but the signal_struct remains unchanged,
> so this part is safe.

But the leader can change, right? So, we can end up in a situation where
threadgroup is set but the task is not the leader which I think can lead to
really subtle incorrect behaviors like write succeeding but nothing
happening when racing against exec.

Thanks.

-- 
tejun

