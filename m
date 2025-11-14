Return-Path: <cgroups+bounces-11965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1466AC5ED00
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3083AFD32
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E433C539;
	Fri, 14 Nov 2025 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXxbszAS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361BA288510;
	Fri, 14 Nov 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144295; cv=none; b=R1GgzigVRcabihbtrMWuUCYP1N88eV5cX/F7mgPVsNzs21t9X8chdG1qyRWiNYMfkEp5ZCe++wyzd/thi+y4NSD0rdIp8RY7oMVaJ3ocqxB9E+XyNvM/a3p31X10W3Ab3VTi/bicv4ECEWGrCuqphBDTtHJu/vAi/561IsvTKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144295; c=relaxed/simple;
	bh=XY9atLms4KYRBNVfIQqn5bsYkrUyjK3shIky6prvR6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwhQgl6OFePnDiohPbs7U1aLe7IQhE3Sm89oPn6359E3F4twHlr1AKXrNp4/51VALEFEW4uRVrlaqaRxsdLhxsm+3zXIuesUzB6Jd6pCjuw56vwC8gGTz/zBLs36bbOVJ7fPcRxMewoWlQ04a/+MDkrIrkqHvDQupTUK5i+IogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXxbszAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B669C19424;
	Fri, 14 Nov 2025 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144294;
	bh=XY9atLms4KYRBNVfIQqn5bsYkrUyjK3shIky6prvR6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXxbszASbfeRqyTOENk6GzNl+iMrTuibhM2dGftxyOUlAZ4TCFKvP7a8I4ZxJEtgF
	 ++ywq62dct2C2GTud32ZkKnG0TmXRFbpoo9p7hoHbWhMhC5iN7Ct2AV00LBq7FbOgl
	 IW92Cvh1+Iek2c3x7jvEcCXdq/NR2E0tJ8qOzU5W38SkCakCha0t7Z4PcBV5SdkQqT
	 zBpEaziUSKozKmtqlP7IJUAbUGkDxj82aKNdJrYkR6597xoSaT0yA8tYtaW2A2RoyR
	 yKFNQUXc7NpxmpIb+davt7nWqeT+F2/1smBaDMgK+29HJLm+EX3NarRUdTQsCyCSKr
	 dU1sw++QY86Cw==
Date: Fri, 14 Nov 2025 08:18:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] cgroup: Move dying_tasks cleanup from
 cgroup_task_release() to cgroup_task_free()
Message-ID: <aRdyZZ9xHk5dLQxG@slm.duckdns.org>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-3-tj@kernel.org>
 <acjwpiayukusza5tybuhg7edwu2hjea3vpopxgukoc7pqc4d2s@qtcptnu44vyf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acjwpiayukusza5tybuhg7edwu2hjea3vpopxgukoc7pqc4d2s@qtcptnu44vyf>

Hello,

On Fri, Nov 14, 2025 at 06:48:17PM +0100, Michal Koutný wrote:
> On Tue, Oct 28, 2025 at 08:19:16PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > An upcoming patch will defer the dying_tasks list addition, moving it from
> > cgroup_task_exit() (called from do_exit()) to a new function called from
> > finish_task_switch().
> > However, release_task() (which calls
> > cgroup_task_release()) can run either before or after finish_task_switch(),
> 
> Just for better understanding -- when can release_task() run before
> finish_task_switch()?

I didn't test explicitly, so please take it with a grain of salt, but I
think both autoreap and !autoreap cases can run before the final task
switch.

- When autoreap, the dying task calls exit_notify() and eventually calls
  release_task() on self. This is obviously before the final switch.

- When !autoreap, it's a race. After exit_notify(), the parent can wait the
  zombie task anytime which will call release_task() through
  wait_task_zombie(). This can happen either before or after
  finish_task_switch().

> > creating a race where cgroup_task_release() might try to remove the task from
> > dying_tasks before or while it's being added.
> > 
> > Move the list_del_init() from cgroup_task_release() to cgroup_task_free() to
> > fix this race. cgroup_task_free() runs from __put_task_struct(), which is
> > always after both paths, making the cleanup safe.
> 
> (Ah, now I get the reasoning of more likely pids '0' for CSS_TASK_ITER_PROCS.)

Yeah, I thought about filtering it out better but if we can already show 0
pid for foreign ns tasks, maybe this is okay. What do you think?

Thanks.

-- 
tejun

