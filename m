Return-Path: <cgroups+bounces-6286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4EA1BEEB
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB293A1DFF
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC121E7C0C;
	Fri, 24 Jan 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzyMX2d2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1B1662E9;
	Fri, 24 Jan 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760357; cv=none; b=XvqJ8zFtAkUTz275nGUCBP/3m+gkPL6AuwZ/foqY/P5C1SW4mP25mST5WxMZYuBbT3nOWwyELKr2lk7UgmXQHqRDL944VhMdlNOiNcU6cWPL43afaXGOy6J+K1yVg9S9tx5emeyiiFNO2CryAzRicH/Ig1GZpByYlrSDIlLl3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760357; c=relaxed/simple;
	bh=L3WHI39ub+IfOmYLfZG/D8gWhGc5d6UctRzp5hqrnA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIGfAJXmhTXhu5HmVsTU9Tu802u5Gy34hTJE07DFf+KPVLju74rNlmpmdlAeF1S1Yyd9ynCOqnuIfHBs25eyDk4dOqZOm4AwmquhpLm2Whc2dmiDznegDr9UGLWDDqfQIk0rP122018GGoasCYfDazZeaei8DRutzxuGdnEwPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzyMX2d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE18C4CED2;
	Fri, 24 Jan 2025 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737760357;
	bh=L3WHI39ub+IfOmYLfZG/D8gWhGc5d6UctRzp5hqrnA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzyMX2d2pyO5yqSGCnxldsMAAR5wJjsQGckAC4Dyvmsf9OaSuQ7c5ruUVa1qmm0aI
	 DHt4BXzhqakQQPoQjd6GuSmK7UJ3XAhDqjKbaRHuicigvZr0f+6Dkq10jOQcfqjhft
	 ToMhWZ6bqMjUeHuz58hHx8rmDQeyyQQPRTvzVeIQpQuoo3ZJTvyGl3JwZ7lFMtZwah
	 BFZQ1h2ULdbHqzraZfmv1spR5oP6mKfWXnPMv1ooGlDTbsSklrBQkKbLpxaDBNBdYC
	 4z5PPpju+0iDrBjRwUKFuQX4Hp7Vm6Us+jp/TjIMFdUME8WXD91kA1vG19grbB1SgI
	 64soyhlV9ewFw==
Date: Fri, 24 Jan 2025 13:12:36 -1000
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
Subject: Re: [PATCH v4 3/6] kernfs: Acquire kernfs_rwsem in
 kernfs_node_dentry().
Message-ID: <Z5QeZBnBKgV9qKpJ@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-4-bigeasy@linutronix.de>

On Fri, Jan 24, 2025 at 06:46:11PM +0100, Sebastian Andrzej Siewior wrote:
> kernfs_node_dentry() passes kernfs_node::name to
> lookup_positive_unlocked().
> 
> Acquire kernfs_root::kernfs_rwsem to ensure the node is not renamed
> during the operation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

