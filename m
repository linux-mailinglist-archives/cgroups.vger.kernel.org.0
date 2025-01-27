Return-Path: <cgroups+bounces-6343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613FFA1DBC7
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A612D18815A9
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337417C21B;
	Mon, 27 Jan 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BimgoSCN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AB60B8A;
	Mon, 27 Jan 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000912; cv=none; b=naPoEFogXFbbhdVSrxaQm9vExQftlBxGt4QqJKJ3kRDEB02tuNXhNUt1kco+EG4tSrsVEFos47w/4N1W2crNqT7XCjyiDDjCmn96ExWZjiVWbtENwLWalQEiIKxzCnoTKHb5igq5+FdNUvufmkPOMu1KWqwQNqtPl/zOXQoUb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000912; c=relaxed/simple;
	bh=BSr5abFyLWP1OnzrMbKEAaW4TdCMnVBBqHMY5E+HM7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P14HfsAefqFswnMdtyaCjrLCb+HMSzC+SF4Q9hU5Ust9qxBedsTcCU4JCjUv9vFMI0d1XKPCrFhlFXnAcsWHuoIt4RT6NL0SF39jBoWnl6lxBBGxX9o1FVZKIiQ6kWiLMGj0TLrCTQ4jksvPqRZYMn0TbtbkkV3F+a76swzbwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BimgoSCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA2DC4CED2;
	Mon, 27 Jan 2025 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000912;
	bh=BSr5abFyLWP1OnzrMbKEAaW4TdCMnVBBqHMY5E+HM7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BimgoSCNAgC7dCFX2dSJKgCdQ/ekItj7SrEE+Fz7xXfDrc1u3rI9zhtwvlv/eP9lh
	 gCCpdex+L374rQo73bNnK9i0C7yokCG+9buJWvNJsAscZMeJwjyTOzmM9kbN/ZYods
	 AFOaFKNG2QMxJU39tEo1LCfNcSW2WX6+xtjHQhjJI/EVbqmhmV2QKFR2muyqSLkca9
	 +GWYiV0TubUO2jgbJcCPK+DyqoHhD9CvoUQMKy/czo9iKodDaY8uMtumEy/aR/uFPj
	 M+ncG2k8NXsaca/Ll3xVNC0xpSpJnjRSE5TtokRgB1GFHSie8Dt2abwQazqRn9PWEG
	 qcwlAvulVjJlg==
Date: Mon, 27 Jan 2025 08:01:51 -1000
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
Subject: Re: [PATCH v4 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem
 in kernfs_fop_readdir().
Message-ID: <Z5fKD1AsqkgDLjox@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-5-bigeasy@linutronix.de>
 <Z5QfFLaywTAdmHoh@slm.duckdns.org>
 <20250127090200.lEQ2Igag@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127090200.lEQ2Igag@linutronix.de>

On Mon, Jan 27, 2025 at 10:02:00AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-01-24 13:15:32 [-1000], Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Jan 24, 2025 at 06:46:12PM +0100, Sebastian Andrzej Siewior wrote:
> > ...
> > > to avoid holding a global lock during a page fault. The lock drop is
> > > wrong since the support of renames and not a big burden since the lock
> > > is no longer global.
> > 
> > It's still a pretty big lock. Hopefully, at least name accesses can be
> > converted to rcu protected ones later?
> 
> Not sure what you mean by "rcu protected ones". The name is already RCU
> protected which is part of the problem :P
> Assuming an upper length of name to be around 255 and
> kernfs_fop_readdir() to be very early on the chain then we could copy
> the name on stack within the RCU section and do this without
> ::kernfs_rwsem.

Please ignore me on this one. I'll take a better look next round.

Thanks.

-- 
tejun

