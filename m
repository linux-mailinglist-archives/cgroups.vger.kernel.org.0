Return-Path: <cgroups+bounces-5518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DA9C60D5
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D158283F89
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866B218331;
	Tue, 12 Nov 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axeVZoYn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6168217455;
	Tue, 12 Nov 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437532; cv=none; b=n270ioK9e9kRYJBAGBQgZJgjuyqQzmH69TSCiLwk0yZ28rzYQ1muIYVH6rhQA2R1UuEyUEIr+s9uaYKmLwQPgLyCrV9RDsNDYuhCiTgDf0HuQNZc3I2Im8MAUA5OQQt/WSNN6eOFW2/785gVGl9bFWSQfrUDuZT298HS/qnvcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437532; c=relaxed/simple;
	bh=lKpYDs3gx8HV/ktP6SJhRTmHZUBnTT2faH7Jw5atD6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7n6RDL+Q6MQiLYmNm2KCj3cGWs0PxOmoHapVuHYPQ+vTmtSNhrZTXWL1Q9FubPNhRblFsQ1SPZTnSpe5hnKs+TZ08VXzUa6hUF7crAWh/XKFM4rzilJq/KRYlkRKcVCkuzhk3GKfO7wInezyCqv3njX4m+db/uVDR+bo7ru2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axeVZoYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE55C4CECD;
	Tue, 12 Nov 2024 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731437532;
	bh=lKpYDs3gx8HV/ktP6SJhRTmHZUBnTT2faH7Jw5atD6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axeVZoYnVhXVzTtc/qwb+dFMqZ92LqT9qo0W+++qcjEzaXdJcnzJ7WHvrGhqKtNbM
	 Dd5FmIihyXANhHN8tZ7uAnuuG6JoHWc+J4+kz0wzGOzvUIinbnOkVbkzl+VZnLjujo
	 RkUsr1mfwsgFNvVc+2ZG8bADzn5mR0qDQrg9XY6YTTyX3JJO8fF4u/a0SBQnNWDsco
	 WFSKQzX2aAgbtNgMqM+uU8AkK8SNlaXqw0/4hOVSvBvXsbNmDY0HDRt7aSVJkBNxMj
	 9bv5oFeGMPx10+8Rao+jJxColh096D/2Dek9NQ/rDlFebm+T0uOWj+y12qfyi5vPU1
	 PHhwhAf0vWVOw==
Date: Tue, 12 Nov 2024 08:52:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] kernfs: Make it possible to use RCU for
 kernfs_node::name lookup.
Message-ID: <ZzOj2z4g7nzWnCBb@slm.duckdns.org>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112155713.269214-2-bigeasy@linutronix.de>

Hello,

On Tue, Nov 12, 2024 at 04:52:38PM +0100, Sebastian Andrzej Siewior wrote:
...
> KERNFS_ROOT_SAME_PARENT is added to signal that the parent never

Maybe KERNFS_ROOT_INVARIANT_PARENT captures it better?

...
> @@ -195,13 +191,47 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>   */
>  int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
>  {
> +	struct kernfs_root *root;
>  
> +	guard(read_lock_irqsave)(&kernfs_rename_lock);
> +	if (kn) {
> +		root = kernfs_root(kn);
> +		if (WARN_ON_ONCE(root->flags & KERNFS_ROOT_SAME_PARENT))
> +			kn = NULL;

Hmm... does kn need to be set to NULL here?

> +	}
> +
> +	if (!kn)
> +		return strscpy(buf, "(null)", buflen);
> +
> +	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
...
> +int kernfs_name_rcu(struct kernfs_node *kn, char *buf, size_t buflen)
> +{
> +	struct kernfs_root *root;
> +
> +	if (kn) {
> +		root = kernfs_root(kn);
> +		if (WARN_ON_ONCE(!(root->flags & KERNFS_ROOT_SAME_PARENT)))
> +			kn = NULL;

Ah, I suppose it's to keep things symmetric. That's fine.

> +	}
> +	if (!kn)
> +		return strscpy(buf, "(null)", buflen);
> +
> +	guard(rcu)();

Also, why are guards in different locations? Even when !SAME_PARENT, kn's
can't jump across roots, so guard there can also be in the same location as
this one?

...
> @@ -200,7 +205,10 @@ struct kernfs_node {
>  	 * parent directly.
>  	 */
>  	struct kernfs_node	*parent;
> -	const char		*name;
> +	union {
> +		const char		__rcu *name_rcu;
> +		const char		*name;
> +	};

Wouldn't it be simpler if ->name is always __rcu and !SAME_PARENT just
requires further protection on the read side?

Thanks.

-- 
tejun

