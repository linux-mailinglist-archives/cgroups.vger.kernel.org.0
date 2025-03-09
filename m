Return-Path: <cgroups+bounces-6908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0CA584F4
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4A97A2313
	for <lists+cgroups@lfdr.de>; Sun,  9 Mar 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433721DC994;
	Sun,  9 Mar 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlOLQg3P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BD1C2DC8;
	Sun,  9 Mar 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531005; cv=none; b=pk3ncBXmjm2ABdo3MCl6QbLxnLai8pBkNhFi9OuUXkpRLAl7AkEvaad7TzmGveHRwKE3yDYSDlGRFUkWEPl7A9Yx0XDVjeAaIOQwwS8gTn2S9FU9ysK22KpjY8ClY8Q1XS8rCt0lLvcDCoW3n+CD4Fdj3hEuiEKvM3adEO/huks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531005; c=relaxed/simple;
	bh=DYe8HUJy8kkP+7yQkU7dXVRL2fEX/sK2cxo3m1sVBZ0=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEtWkx1JEamnYWJBHN9RuJDIln4LoTJwmhrMG4xvFHXfJG37itnDpxfsrgze4vFiZKEmYFg7Z1bWc42b8OQDBeOLQ4pNCRNv/Iektyir5XYK0bWRkaVPvlHxShlbSWndmXIEdlBxp7/0AzPR9AJ0Mp5a8prdw2/76N1krXqrvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlOLQg3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7F1C4CEE3;
	Sun,  9 Mar 2025 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741531003;
	bh=DYe8HUJy8kkP+7yQkU7dXVRL2fEX/sK2cxo3m1sVBZ0=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=YlOLQg3Pfr5rPOiqsOgcXPYxWoi6EOfz0ffZPeOgQeSIPZSyl04RGttxrXIgpxD8Y
	 dtF3lqztalSnxpkp7ZUqfT7WuCZCwJe40agWk8hE1naPT24GHuY7gw8HDSZV2B65OJ
	 HpyrobADB5/Y0G6mMiylDM3GQ6EhQIbLJi2gqhKLv0nZlGV4R0nhkUYoChTKEOjNNv
	 ABYTituRn62KGX3B6YYEMyF5HNmrvmLhq8nIn+yWXqTKzOl35WD5cuWTBOX4itFFZT
	 40VAKVlLDLMPHPLdfsvAsCeLrAoSaomd4Y6t+fEzMf1mtzkEbtwCwYbpQ5d5OfHTxm
	 aEYzYxGQDGe4Q==
Date: Sun, 9 Mar 2025 04:36:42 -1000
From: Tejun Heo <tj@kernel.org>
Cc: kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	cgroups@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo
 API to retreive socket's peer cgroup id
Message-ID: <Z82neltmT_hbEpYy@slm.duckdns.org>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
84;0;0cTo: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

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
> 
> Git tree:
> https://github.com/mihalicyn/linux/tree/so_peercgroupid

From cgroup POV:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

