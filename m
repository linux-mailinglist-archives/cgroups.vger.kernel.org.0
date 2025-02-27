Return-Path: <cgroups+bounces-6728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECDA4866F
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5D71884190
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3F1D934D;
	Thu, 27 Feb 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5LQ7DhA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46C1A841B;
	Thu, 27 Feb 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676796; cv=none; b=EtPJZFHeuFlhdw0koJTKYqB11cP6t8UZE7SMh0BMmRG2HZfg62nD7k7+7xleKWY8nJpdDDxGmrCtpd0y56/NIW9Z0tzuXzNoK3Gksz57OWxYEQpJ9XkgqipXW7j4vZIkZ0cz5B7e3btMGjegscz9LD6/z8Ir3WI9jPPkBUhNFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676796; c=relaxed/simple;
	bh=8bHBmKhpxLHdATQlT2dxBzsHHWjNubWtGHH0l2JvExc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOv4VXvU4TkdgKxHqeBjmO8/LA/u4nRVgiiAICWIzz7O+001/SuN5p4sq+G+3Kbo8lbNrtuUJtohPAy8+Ko6GBrbWOrs42WnW9AtY4hzDy7nyLIUxpwr/HmY2uq1+htWFLRp/v7HMAP4i4Pv1NiFx6MaYCdXKjMOa7kE3oiD9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5LQ7DhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483EC4CEDD;
	Thu, 27 Feb 2025 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740676796;
	bh=8bHBmKhpxLHdATQlT2dxBzsHHWjNubWtGHH0l2JvExc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5LQ7DhAvBkjs04TamTdgPevm+SR6COp6cjAqwYNTWfQ/xS5QrHVMafswC+MurhCD
	 /BqgTQYE35EK4V37Krd7Ob1La/p/dzkmIKMn4yQrSPcEzCwoQWChjYoz/g0cHEuUs6
	 v2iZp+UsbtgXp6ur3orJOaoClYtlIWrqvpo/MRNE2nFjy5qAXWBZODf4ZwX+ehhcpc
	 cAx6JZEoDcjCCxHvS0i12pQUBX7GHt1P4g7/J8Ukng0FHkIFm6XQw1gnkRUwzwC5Mk
	 BQvEongx7DuWGgzAGFCEEusI+lFUJj7bj85qEySguJxO6OyZe5hlf+rVop2FEneC/w
	 xJjx1fkwNplmg==
Date: Thu, 27 Feb 2025 07:19:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Chen Ridong <chenridong@huawei.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] cgroup/rstat: Fix forceidle time in cpu.stat
Message-ID: <Z8Ceu3zXQr7ELXKC@slm.duckdns.org>
References: <20250209061322.15260-1-wuyun.abel@bytedance.com>
 <20250209061322.15260-2-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209061322.15260-2-wuyun.abel@bytedance.com>

On Sun, Feb 09, 2025 at 02:13:11PM +0800, Abel Wu wrote:
> The commit b824766504e4 ("cgroup/rstat: add force idle show helper")
> retrieves forceidle_time outside cgroup_rstat_lock for non-root cgroups
> which can be potentially inconsistent with other stats.
> 
> Rather than reverting that commit, fix it in a way that retains the
> effort of cleaning up the ifdef-messes.
> 
> Fixes: b824766504e4 ("cgroup/rstat: add force idle show helper")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

