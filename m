Return-Path: <cgroups+bounces-916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000180F597
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305061C20BA2
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB85FF17;
	Tue, 12 Dec 2023 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kX3/5sIt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AA10F5
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 18:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254FFC433C8;
	Tue, 12 Dec 2023 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702406636;
	bh=nlynSdmzpDeJ4+c9EM+qpsatuZCr/KLNEXvmbTx2z3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kX3/5sItCGETTmZWXX+yh10B3+D+Df8L8wljrS/HDEa+aEwt0IK1BMEUphHNmNTJh
	 oDL/rJUKzY7PECmK6q+FK0Vzu3anqXz5iAulnT78ISVgKdoUubD4fDvi9tXWwYBLBX
	 6CJDVd2mkAWP+ce8UzejvIHfokPwPyIWZzlleMWM=
Date: Tue, 12 Dec 2023 10:43:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Wei Xu <weixugc@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo
 <tj@kernel.org>, =?ISO-8859-1?Q?"Michal_Koutn=FD"?= <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, Greg Thelen
 <gthelen@google.com>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Message-Id: <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
In-Reply-To: <20231204235856.k4izppfsrpg2rng7@google.com>
References: <20231129032154.3710765-1-yosryahmed@google.com>
	<20231129032154.3710765-6-yosryahmed@google.com>
	<20231202083129.3pmds2cddy765szr@google.com>
	<CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
	<CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
	<CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
	<CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
	<CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
	<20231204235856.k4izppfsrpg2rng7@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 23:58:56 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Dec 04, 2023 at 03:49:01PM -0800, Yosry Ahmed wrote:
> [...]
> > 
> > From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 2001
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Date: Mon, 4 Dec 2023 23:43:29 +0000
> > Subject: [PATCH] mm: memcg: remove stats flushing mutex
> > 
> > The mutex was intended to make the waiters sleep instead of spin, and
> > such that we can check the update thresholds again after acquiring the
> > mutex. However, the mutex has a risk of priority inversion, especially
> > since the underlying rstat lock can de dropped while the mutex is held.
> > 
> > Synthetic testing with high concurrency of flushers shows no
> > regressions without the mutex, so remove it.
> > 
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>
> 

I'd like to move this series into mm-stable soon.  Are we all OK with that?

