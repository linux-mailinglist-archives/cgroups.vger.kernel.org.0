Return-Path: <cgroups+bounces-5519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97F9C63E6
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 22:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0046BC5EAF
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BF218305;
	Tue, 12 Nov 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG6f5wnL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF2217F47;
	Tue, 12 Nov 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437959; cv=none; b=bOpURvjSFHnZMJ6UwbWWgC5Fz+624o5eetnMWrJyDYt1r7+s4Q5Yefa3R+sDFY8c+uo3A1fqMjw72hdGN8vU79lg87iXvU/4rQUIz6TmgJL1CeCY68S2MHO1LqK9BcWi3EU0k+RQTZgSx3huKsgmH/7BCgQIlJu4mF3KoVlNlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437959; c=relaxed/simple;
	bh=XsivP3IDYZago+Kj/5QC40N14e4R7jSG15dl3Bzg7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b35ju5HwVVlyHXA1XII6keb2GQWJsc+b03x/fb8ZFmsrYcTCGi/Cfl8uYWLZYNUaCu+EtvJqLTDvyPti1CijHOWGdYTJIviOPCDU+vgbGYKB+nh4DEIJTQ3EWCV4/2zuRJ5t9/Yh2GcTGs+8A8uK6iy9+E4uxnro8PFgDA9f/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG6f5wnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35BFC4CECD;
	Tue, 12 Nov 2024 18:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731437958;
	bh=XsivP3IDYZago+Kj/5QC40N14e4R7jSG15dl3Bzg7ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mG6f5wnLG109pDTsCaZ4QERU9nRGxqcmPWHRSxCi3u61cpP4ZlEP0/qCItjYYVXOE
	 6R97g1f2yApo9+ybbSpCxO3ZLWAT/I9b1gyIIrz9Vub7LAdUcQSSvsKOK3eb5pBBrC
	 dh5H1mkuHzMiYtpugHYLtzInFPTC9KnKUSQeAjKWXuiBz1Zdp8pqbRLhaTTI3a2Au9
	 ZG9b3cl8LvKvXOtrvFDVXpw1p5a5lffay+MOx/I3Sar+TodHjx0EX8TPVcQFLyd40t
	 ITv72r93sWEmnDoCDlnt3fsJV3pqHBWmdbBIlJg22HPHwyKah3OJqXcEeVxcgeWy//
	 sqIR+70rE/X+w==
Date: Tue, 12 Nov 2024 08:59:16 -1000
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
	tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface
 for name lookups
Message-ID: <ZzOlhANLYxFaIix2@slm.duckdns.org>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112155713.269214-3-bigeasy@linutronix.de>

Hello,

On Tue, Nov 12, 2024 at 04:52:39PM +0100, Sebastian Andrzej Siewior wrote:
...
>  /**
> - * pr_cont_kernfs_name - pr_cont name of a kernfs_node
> + * pr_cont_kernfs_name_rcu - pr_cont name of a kernfs_node
>   * @kn: kernfs_node of interest
>   *
> - * This function can be called from any context.
> + * This function can be called from any context. The root node must be with
> + * KERNFS_ROOT_SAME_PARENT.
>   */
> -void pr_cont_kernfs_name(struct kernfs_node *kn)
> +void pr_cont_kernfs_name_rcu(struct kernfs_node *kn)

Having to split the interface all the way up isn't great. While there are
also downsides, I wonder whether a better approach here is just making the
backend function (kernfs_path_from_node()) automatically use RCU locking if
the flag is set rather than propagating the difference by splitting the
interface. The distinction doesn't mean anything to most users after all.

Thanks.

-- 
tejun

