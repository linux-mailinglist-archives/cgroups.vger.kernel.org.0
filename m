Return-Path: <cgroups+bounces-6912-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5BA58E9B
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4316C4CD
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776A224243;
	Mon, 10 Mar 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtf3K/bD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB82206B7;
	Mon, 10 Mar 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596753; cv=none; b=OLRGlWmF3KVOnf5JgABctZDWGQESEH/qaLO3fTOGf2inL9wZ7TTqqD15fBBzUzdlvOXSie7tP/VH2PNZ9tUs5s4AlyS3IFSHg+P1dOt6JKEBwouQ1sGqqHwJQ//AbcC8Lfzd2b1qNkSsdMcPwEdogYWGBpI0ciCTqzGadqculNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596753; c=relaxed/simple;
	bh=Mdk+LfaZKzSC91++o4gVAnoOZq6MJx1kOhdc2+tKXFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzEoseR0n27IY7ya8197titUambaBlI/upB7EtEsf4wGteLXrhvpfdLicvhzW/JkhJ2MT93jQasi95m8sLfE+E/ndYjhQjhmbsQz5Tpq3w0xNHAlKY+CkKvFYUxmtZlol/1o2TYfquAG9soteMO9tGfGVjP+2XMh6xB3Vy4rBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtf3K/bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB2C4CEE5;
	Mon, 10 Mar 2025 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741596751;
	bh=Mdk+LfaZKzSC91++o4gVAnoOZq6MJx1kOhdc2+tKXFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jtf3K/bDisJx8+XKAMVgzC52CtUKxkb+9nHEGHASI+wnvIU0ZAxJ3dLYHo3DgWQKi
	 H3qErqiAu5LpK8LHTJCUZvX2VzhfeDgcBUb/XBPEqivxHMgxHxliQQcicVf6JwG3CZ
	 OSCMtSP5tJK0uL8X+jxSkJ5BlOUDoFnYedhYUCs59xQAV+u15eebqwu81GtK7aNog3
	 T6Hyo5O1EUwRQ4I4iF/Uyj7qss3kIY1aI4EWltEhGPmkJKifk5MpoPnrnHZ/boYXfH
	 qeO5B6INwTMBcVrOwVjGNHTjFa846wr4J+JdaMMWcxpEPTOwJLiq7i0FR37U8fgICi
	 MkhX8J+qO2+mQ==
Date: Mon, 10 Mar 2025 09:52:24 +0100
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
Message-ID: <20250310-ausdruck-virusinfektion-1b0d467b812c@brauner>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>

On Sun, Mar 09, 2025 at 02:28:11PM +0100, Alexander Mikhalitsyn wrote:
> 1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
> 2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
> 3. Add SO_PEERCGROUPID kselftest
> 
> Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
> Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
> is used which is racy.
> 
> As we don't add any new state to the socket itself there is no potential locking issues
> or performance problems. We use already existing sk->sk_cgrp_data.
> 
> We already have analogical interfaces to retrieve this
> information:
> - inet_diag: INET_DIAG_CGROUP_ID
> - eBPF: bpf_sk_cgroup_id
> 
> Having getsockopt() interface makes sense for many applications, because using eBPF is
> not always an option, while inet_diag has obvious complexety and performance drawbacks
> if we only want to get this specific info for one specific socket.
> 
> Idea comes from UAPI kernel group:
> https://uapi-group.org/kernel-features/
> 
> Huge thanks to Christian Brauner, Lennart Poettering and Luca Boccassi for proposing
> and exchanging ideas about this.

Seems fine to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

