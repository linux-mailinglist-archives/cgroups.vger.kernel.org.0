Return-Path: <cgroups+bounces-6959-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFEA5BFF4
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02367A2AA9
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741F2561C7;
	Tue, 11 Mar 2025 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crb7G0MX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD96198E8C;
	Tue, 11 Mar 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694550; cv=none; b=D7theizJAmWb2MbFwQQCh3IbJDvNhAMgCwPdWPhGm4E6T7KJbl8tWYBL/x+AOlW8vqgGOhS7PETt+dcX1cIaWteHzA3L/2DxMO2Nsxc9gSY+lrZXq3XE95zO+2Kbl+c54NeqYZmGA+n9lASDKOVI2Nq55X8AfZKYjPpNgUxiHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694550; c=relaxed/simple;
	bh=lF2Al/HhVZMMOdAFVKzZwkJyoEOGmdDcbfJux9rsQCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUvN8gVHzb6i6aI9F2p1zgMrxwiW6pEjKlVQtOBOZRKYd+pMvnbEjQ8yEPnU70RBnOmgnNCyAJ1GejNRmmXQhNXEC5XmD0lZ8Tdy1T7oEhBAEh5hsoJe50ywaXFDUdilGy7YKBJlBjRQoq2VoU3QmCR8ywv8g8Vk30I88TGL/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crb7G0MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52811C4CEED;
	Tue, 11 Mar 2025 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741694549;
	bh=lF2Al/HhVZMMOdAFVKzZwkJyoEOGmdDcbfJux9rsQCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Crb7G0MXmKUm//SXigG4v9fCtT7UyDKxx5eKXCz3+PUP9fP2lwdmGuflFRKbsTIgF
	 gBJO6gBsheMFMOWqeJUwjStb4uZDdEGWSl/Seei005VQKnTotz540s/FgU3v7F69sk
	 JEU563B+mExRiiN9bPueOsp3Lckphu9YVg0ss0+0Yh/Tq5eX/gwYOpmHRchwG6R8Ac
	 /D+b8Q7QOJVSBON2vxhl5/mdo+5Umu41MM/pMsmYz/mqE3XocSAdynNloNBFQkNmkS
	 PMgCLBO+TZnT0UIZNK/4etC6q4UX9ajCLZHz83Gi3MZq3f728ZMBkH15IAh7PigPaG
	 0IeBK8156kAMQ==
Date: Tue, 11 Mar 2025 13:02:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aleksandr.mikhalitsyn@canonical.com, arnd@arndb.de, bluca@debian.org, 
	cgroups@vger.kernel.org, davem@davemloft.net, edumazet@google.com, hannes@cmpxchg.org, 
	kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	tj@kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo
 API to retreive socket's peer cgroup id
Message-ID: <20250311-umkreisen-versorgen-6388fdf4024e@brauner>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
 <20250311073411.4565-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311073411.4565-1-kuniyu@amazon.com>

On Tue, Mar 11, 2025 at 12:33:48AM -0700, Kuniyuki Iwashima wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Date: Sun,  9 Mar 2025 14:28:11 +0100
> > 1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
> 
> Why do you want to add yet another racy interface ?
> 
> 
> > 2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
> > 3. Add SO_PEERCGROUPID kselftest
> > 
> > Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
> > Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
> > is used which is racy.
> 
> Few more words about the race (recycling pid ?) would be appreciated.
> 
> I somewhat assumed pid is not recycled until all of its pidfd are
> close()d, but sounds like no ?

No, that would allow starving the kernel of pid numbers.
pidfds don't pin struct task_struct for a multitude of reasons similar
to how cred->peer or scm->pid don't stash a task_struct but a struct pid.

> 
> 
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
> 
> If it's limited to the connect()ed peer, I'd add UNIX_DIAG_CGROUP_ID
> and UNIX_DIAG_PEER_CGROUP_ID instead.  Then also ss can use that easily.

