Return-Path: <cgroups+bounces-5932-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A999F4A99
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 13:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85811891D06
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF031F03CE;
	Tue, 17 Dec 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnzDw66N"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6D1EF0B7;
	Tue, 17 Dec 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437074; cv=none; b=HPlQW8h7cVO4QboWhWHhHWTKU0JFcnFrXESHL64kPYbpVwQjx2tH/XcbKWVdu1V7s8CEq6SjBSpaXmb7SYa2QT7d/0JVQcTPppxWul2GwuxRzmGkMnh40APr/7PzTvKuOVWxudiIgazmwzGAuwOYfRLwsF80eAnjCEcOyz/EqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437074; c=relaxed/simple;
	bh=28IGf/B9Lm3ZvkS0yr+vRjT/zU6RdAuxFU3+rfuQFVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3+18J7HHchHbd50Xfb6EJhq+mDbqpsett+immIEAOjExzuPCp8BX0ullC74YF7Kn4U3RmGnNH1G4/3hWmQTT8/kUnoggOeaR4EDCQGFhHimF6tSuRHmyaVdAhko//tPjJWMXnHYFzHSYgWOSG+Q4YV1mY5u5aEdtkPpG8hvlFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gnzDw66N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kysZcD5KVRfxeStNdXdTjnBhev+WbSWszsxJPlwD7Is=; b=gnzDw66NMjWD3Gt//cEkX3Jmqb
	MLbpIuMfyX33wFirxYdAR2+BRxIHjJzOoMH1V3jE+sWi3Q/KGvOS2RbvbHJE877UsWxi7KRxzsw3e
	4JHlpFrBAXS1ePUMZF8KNTEZC4Cw2aWZjgMF0ABulEz4NEIGZyLgiMIrB2Y1Q/9itFvYBYJp3mRcL
	Bq4icLZw5gy/gzlaa9ihKWqzRSqdedH+Is9qS2xGM6pHDhYxcGv/e7xd4KRXvMxnlw3ZLg9I3HlCw
	VqiAxCZ0s+lbOUYV6t3pih8pnvZMTR3O742j3vKWKApyYfa2Ll6n6YH1SFRkLC+osDdhCLb2TbJwC
	Ga1SfPkw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNWJI-00000006lWu-1r7S;
	Tue, 17 Dec 2024 12:04:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02FB630015F; Tue, 17 Dec 2024 13:04:20 +0100 (CET)
Date: Tue, 17 Dec 2024 13:04:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	mkoutny@suse.com, roman.gushchin@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] freezer, sched: report the frozen task stat as 'D'
Message-ID: <20241217120419.GA2354@noisy.programming.kicks-ass.net>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>

On Tue, Dec 17, 2024 at 12:48:18AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> logic"), the frozen task stat was reported as 'D' in cgroup v1.
> However, after rewriting core freezer logic, the frozen task stat is
> reported as 'R'. This is confusing, especially when a task with stat of
> 'S' is frozen.
> 
> This can be reproduced as bellow step:
> cd /sys/fs/cgroup/freezer/
> mkdir test
> sleep 1000 &
> [1] 739         // task whose stat is 'S'
> echo 739 > test/cgroup.procs
> echo FROZEN > test/freezer.state
> ps -aux | grep 739
> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
> 
> As shown above, a task whose stat is 'S' was changed to 'R' when it was
> frozen. To solve this issue, simply maintain the same reported state as
> before the rewrite.
> 
> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

