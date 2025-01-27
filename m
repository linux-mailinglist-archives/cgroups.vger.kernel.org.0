Return-Path: <cgroups+bounces-6344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C18A1DD44
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B718861A5
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDE191F74;
	Mon, 27 Jan 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svuPjgK/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2915746E;
	Mon, 27 Jan 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009029; cv=none; b=JJJVdPghFMbOYwQ36ZIwtyp/TlHc40THl0ldh+ghiNcY1AJ2wvjjyAgOHHboLPKufJo2VeDJsJuN8ZonPczt78EXZI1Nj5qP8iyVNzDnq3k7qfUsgb7qn9ZwklVBayWrKLmpFsSvGeqZhHMpDUoVwSrfWCepThe0m5fkDhG1tgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009029; c=relaxed/simple;
	bh=lJzl9K4ZbQeD7A633jra3qYlM6ilY+TeteUkegQD0iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwAzCBxDevtG6k3PyeTeVaJX50ccy4c/OFFXjnxWD2mcDPu7yqsJIW6T7iJGHu3Dy1WJ9mFWIv3XJQVty8OA1kJS0K/3Co12wAMYM6kkMnAUEfLxdEFDGP7uF7l2eD+HZmAx0r7ncwOxlBN8aABYW7n/QAwND0kN7SSdQd95mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svuPjgK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38226C4CED2;
	Mon, 27 Jan 2025 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738009028;
	bh=lJzl9K4ZbQeD7A633jra3qYlM6ilY+TeteUkegQD0iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svuPjgK/hCFxT8Z1FRyV9EbncFGw3IVs5+oM36HNY6G0joGraQUpigatiDRYFUVt9
	 dRG2DdSiNPVCmnVlrsVC2uhP2TKtL1vK8+QJtLWdkngwyAF4PaRlSpbXSE/3rSyyb2
	 opSRuDH10hlDbphMriNPAmHhswykm9aUbyQPExsxO8kPaFp/1Jt14bYw4t/Wcs3Sa2
	 ER2OuVlw/do+A9ATJ+bIMMCGCXygW1NjST3YndgzkbGEVxFuGN61py/iPFiDVMu14E
	 VScm19/h//Gtgu3kzDXY/tKzkzm5qcOgPHR3DaRD52YiCtulBrDnWXIi23C3YK21Ji
	 uFYX5UufUt1hw==
Date: Mon, 27 Jan 2025 10:17:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Yury Norov <yury.norov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chen Ridong <chenridong@huawei.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Message-ID: <Z5fpw2uVYGP9kf18@slm.duckdns.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-3-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125052521.19487-3-wuyun.abel@bytedance.com>

On Sat, Jan 25, 2025 at 01:25:11PM +0800, Abel Wu wrote:
> There were efforts like b824766504e4 ("cgroup/rstat: add force idle show helper")
> to escape from #ifdef hells, and there could be new stats coming out in
> the future, let's clean it up once for all.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/cgroup/rstat.c | 47 ++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)

Is this materially better? The existing code has ifdef in one place which
the new code can't avoid. The new code is more complex and has more lines.
Does the balance get better with additions of new entries?

Thanks.

-- 
tejun

