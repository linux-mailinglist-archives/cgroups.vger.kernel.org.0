Return-Path: <cgroups+bounces-6422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2647A2723E
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 13:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFCF3A10B3
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D020CCD7;
	Tue,  4 Feb 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnRoKLM3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52063206F3A;
	Tue,  4 Feb 2025 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673084; cv=none; b=rTtRxJ+XlPolHTx3wHmHcWd6k5c8Zp8ou8msQE8FAo9RvArvE/jBnqaiAZVLxMhY3TxusdjK5rPfeXBz1cikj0IDSeBp35WkD+SQrBJL4yDrP+IpzgGktwo/R081DQtSGobw7KFBe7KwFmYOPj+EsxWTJckG+x8oa8wZjVuKZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673084; c=relaxed/simple;
	bh=XOh8D/Fcmx5vkDTj4zW3l2kxG1roebLnJdySXMdiBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5daVAe4l7mIHDHRlg1sUPGo4pqeJcCmoyg2X13bhhMmR8VLM2F/nkoRa+jIAz4QfxCRHJ23rx7G2SmQlC+EHVCWfnHnJcq91ftmky97Ou43uHSaOTx2zDm57gUkXLHujw37omv+E2N2hOBEyN4rotJyDMu7HB1QMBspLyekICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnRoKLM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE39C4CEDF;
	Tue,  4 Feb 2025 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738673083;
	bh=XOh8D/Fcmx5vkDTj4zW3l2kxG1roebLnJdySXMdiBTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnRoKLM30P6T/IAsjQX1z6l1kqzeKWWT//TfzvfTdVpHJrnON9HPUZGHq0EeSOx6C
	 wI+ZAF2UAyKmMlOfHKXdLjza34KMpNUsMO4rN+aYmYf/27LJJaAaWzX+NtxOlZZsoe
	 6IeaviPuC+Xt50cGSCCVtBgrwEhxlHiRcAJ5mgdOAjvlbrjeazatwScgI4pSvNvAX1
	 BW9tWIoCq2vaUWE5XEB82nXrs/XZERvyRWpmarN4V2/EAUhcIvCpppS+whfM7XmOAE
	 a3/pKZK/GTl1SE2lre8aOXv+8dKAKi5Cjtt+wjGUc5j9jMzTJVEsPUCj5vJGm3CUQx
	 OF3S0Evxon/gA==
Date: Tue, 4 Feb 2025 13:44:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: fix race between fork and cgroup.kill
Message-ID: <20250204-willen-aufmachen-69e8a849a5a7@brauner>
References: <20250131000542.1394856-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131000542.1394856-1-shakeel.butt@linux.dev>

On Thu, Jan 30, 2025 at 04:05:42PM -0800, Shakeel Butt wrote:
> Tejun reported the following race between fork() and cgroup.kill at [1].
> 
> Tejun:
>   I was looking at cgroup.kill implementation and wondering whether there
>   could be a race window. So, __cgroup_kill() does the following:
> 
>    k1. Set CGRP_KILL.
>    k2. Iterate tasks and deliver SIGKILL.
>    k3. Clear CGRP_KILL.
> 
>   The copy_process() does the following:
> 
>    c1. Copy a bunch of stuff.
>    c2. Grab siglock.
>    c3. Check fatal_signal_pending().
>    c4. Commit to forking.
>    c5. Release siglock.
>    c6. Call cgroup_post_fork() which puts the task on the css_set and tests
>        CGRP_KILL.
> 
>   The intention seems to be that either a forking task gets SIGKILL and
>   terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
>   don't see what guarantees that k3 can't happen before c6. ie. After a
>   forking task passes c5, k2 can take place and then before the forking task
>   reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
>   What am I missing?
> 
> This is indeed a race. One way to fix this race is by taking
> cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the fork()
> side takes cgroup_threadgroup_rwsem in read mode from cgroup_can_fork()
> to cgroup_post_fork(). However that would be heavy handed as this adds
> one more potential stall scenario for cgroup.kill which is usually
> called under extreme situation like memory pressure.
> 
> To fix this race, let's maintain a sequence number per cgroup which gets
> incremented on __cgroup_kill() call. On the fork() side, the
> cgroup_can_fork() will cache the sequence number locally and recheck it
> against the cgroup's sequence number at cgroup_post_fork() site. If the
> sequence numbers mismatch, it means __cgroup_kill() can been called and
> we should send SIGKILL to the newly created task.
> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Closes: https://lore.kernel.org/all/Z5QHE2Qn-QZ6M-KW@slm.duckdns.org/ [1]
> Fixes: 661ee6280931 ("cgroup: introduce cgroup.kill")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

