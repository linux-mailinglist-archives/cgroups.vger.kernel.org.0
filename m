Return-Path: <cgroups+bounces-6930-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204FA592B9
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C6116C95C
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A321E08D;
	Mon, 10 Mar 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtkeaGIW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501828EA;
	Mon, 10 Mar 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606028; cv=none; b=XjF4QtIr+iWlF0iZYEFPMKZ0POTKcucGk991N3/9WWzpFIfIlyD39g2D7S9ExY5nO3M304JeR8rszX6VwNwQNsJDirKoQqr7OZwZeW23athXV7zYZLfN01Q/4L6kcYJwfATxNxechK14t4gR/YyA9SAUIy/BiMRBG71K3Uy+QEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606028; c=relaxed/simple;
	bh=/MIwqVro98Ug0D/cRSeHQdD3SSd19RiNWyeW/pyUMfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7UgSO0Nu55GIF910iNmMUqaVAh8aUxvARtqU0ofAHJ14a033kY9s/WnZEpK/E2SEH41Xu9a6uuPbQPBIlyUYHokTRcqMCNPQDFl2B4np2i/19pd82K5E28rBmXfjqA/Dj+b82uPtQJk5U6NZkkT1m+QEnx3YhwWdKfEfZLBPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtkeaGIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8DBC4CEE5;
	Mon, 10 Mar 2025 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741606028;
	bh=/MIwqVro98Ug0D/cRSeHQdD3SSd19RiNWyeW/pyUMfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtkeaGIWdUq0zj1BatSHwEJMFaxUh+Th0MCcd/ugd4zMackZUMfik5WTje6eojSuV
	 B1RV+m9yUJiH6ey/OBHpH14oiFpJxFs4wNGtDJjz/25nCXIXIqVpBg5J02/fU74xu5
	 6gvbY+o+ZHEexqZNZmK+yt+Gk6OgEB1/8SQpJwNbCBozfgHhQjLfM+1cC1eosRZWbB
	 wk0krFs2Uz6/nmwR73Z/vUxBKKBN7g9m970HlguhGNuVpTNWpfau1a9uO/sdz9zydv
	 +qSs7xxX5x1TTQ7Qz6epGCebv4GrIpX0AGxF6RgqwmNFapb5y2/oRZTKw0CR3ndF/z
	 9SD+Uw4UEw9+g==
Date: Mon, 10 Mar 2025 12:27:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cgroups@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo
 API to retreive socket's peer cgroup id
Message-ID: <20250310-hinzog-unzweifelhaft-9105447ec12d@brauner>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
 <20250310-ausdruck-virusinfektion-1b0d467b812c@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250310-ausdruck-virusinfektion-1b0d467b812c@brauner>

On Mon, Mar 10, 2025 at 09:52:31AM +0100, Christian Brauner wrote:
> On Sun, Mar 09, 2025 at 02:28:11PM +0100, Alexander Mikhalitsyn wrote:
> > 1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
> > 2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
> > 3. Add SO_PEERCGROUPID kselftest
> > 
> > Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
> > Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
> > is used which is racy.
> > 
> > As we don't add any new state to the socket itself there is no potential locking issues
> > or performance problems. We use already existing sk->sk_cgrp_data.
> > 
> > We already have analogical interfaces to retrieve this
> > information:
> > - inet_diag: INET_DIAG_CGROUP_ID
> > - eBPF: bpf_sk_cgroup_id
> > 
> > Having getsockopt() interface makes sense for many applications, because using eBPF is
> > not always an option, while inet_diag has obvious complexety and performance drawbacks
> > if we only want to get this specific info for one specific socket.
> > 
> > Idea comes from UAPI kernel group:
> > https://uapi-group.org/kernel-features/
> > 
> > Huge thanks to Christian Brauner, Lennart Poettering and Luca Boccassi for proposing
> > and exchanging ideas about this.
> 
> Seems fine to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

One wider conceptual comment.

Starting with v6.15 it is possible to retrieve exit information from
pidfds even after the task has been reaped. So if someone opens a pidfd
via pidfd_open() and that task gets reaped by the parent it is possible
to call PIDFD_INFO_EXIT and you can retrieve the exit status and the
cgroupid of the task that was reaped. That works even after all task
linkage has been removed from struct pid.

The system call api doesn't allow the creation of pidfds for reaped
processes. It wouldn't be possible as the pid number will have already
been released.

Both SO_PEERPIDFD and SO_PASSPIDFD also don't allow the creation of
pidfds for already reaped peers or senders.

But that doesn't have to be the case since we always have the struct pid
available. So it's entirely possible to hand out a pidfd to a reaped
process if it's guaranteed that exit information is available. If it's
not then this would be a bug.

The trick is that when a struct pid is stashed it needs to also allocate
a pidfd inode. That could simply be done by a helper get_pidfs_pid()
which takes a reference to the struct pid and ensures that space for
recording exit information is available.

With that done SO_PEERCGROUPID isn't needed per se as it will be
possible to get the cgroupid and exit status from the pidfd.

From a cursory look that should be possible to do without too much work.
I'm just pointing this out as an alternative.

There's one restriction that this would be subject to that
SO_PEERCGROUPID isn't. The SO_PEERCGROUPID is exposed for any process
whereas PIDFD_GET_INFO ioctls (that includes the PIDFD_INFO_EXIT) option
is only available for processes within the receivers pid namespace
hierarchy.

But in any case, enabling pidfds for such reaped processes might still
be useful since it would mean receivers could get exit information for
pidfds within their pid namespace hierarchy.

