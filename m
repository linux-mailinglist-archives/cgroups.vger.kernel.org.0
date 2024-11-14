Return-Path: <cgroups+bounces-5564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC59C9110
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BFFB2C13E
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615417CA17;
	Thu, 14 Nov 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADyLQgF/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386913CA8D;
	Thu, 14 Nov 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602649; cv=none; b=dsfkDRvDbNEhtfOqF3pCfEN5vHJPcjjjKy5NnBmbJn9yhwvQXMj9YEggL8roiPbYxit4DxPc8Bfhjx7RugT6JKGppg7oO3sx5fdWvHzJc06ah51asleZpggpAYldXYoFaNFklq/5An1E2/9xctWEdESMDThOjNuKUh2esEp46i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602649; c=relaxed/simple;
	bh=AbCn1+Yg8W8qTHgWuQBTbKu9X8SgyI1xSbTqtUUWY5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/4Il4tmwRUrxa4akrFPpiw007XpBuqCOTFQfmlA0QBznUsWcXfdGNzndj/N4cu4bj3r3Tx1k8LKcZc7xrIDbiQpZs7aM8f7We3l3yBouCA5VoIKuN8W+lnSkGsdXiWhllDvQUw2h2GFFTF3Nt9W7N994frxltHRgf2adjjQiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADyLQgF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2931C4CECD;
	Thu, 14 Nov 2024 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731602649;
	bh=AbCn1+Yg8W8qTHgWuQBTbKu9X8SgyI1xSbTqtUUWY5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADyLQgF/4/uCjUXv6lUAAcS7vJmeGuMBIRtcbJLEimaJl+nBqy4K9Xw9Ju6Hh6GqM
	 T+8dqL9aT9ynaEx5uVwsUjb4t9223TX1hHUSBqqb+S8Ci4XJSVHYcJBphH5TUOvyJX
	 dgjpoppNJrz0hVQVZT4HShwV88JLR5GgPcJzeUtMcy5pppbO+ensknrWXIWAsvCPZn
	 1vN77UTuUH74bd3BAb72XJm12+/Zs1OYg6DjIBLQPEYAYGj9w0Sl4ibZFPLoOKIqKU
	 PxXSBIRp1sH6eWtAOyz6hBng9DWyyYTf8r7LUk/G4saHWtzaCQSoeKhvsFtKMyg1ls
	 cndUWdBqWeBkg==
Date: Thu, 14 Nov 2024 06:44:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	=?iso-8859-1?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=FD?= <mkoutny@suse.com>,
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
Message-ID: <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>

Hello,

On Thu, Nov 14, 2024 at 03:47:58PM +0800, Chen Ridong wrote:
> On 2024/11/13 22:34, Valentin Schneider wrote:
> > On 11/11/24 13:54, Chen Ridong wrote:
> >> From: Chen Ridong <chenridong@huawei.com>
> >>
> >> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> >> logic"), the frozen task stat was reported as 'D' in cgroup v1.
> >> However, after rewriting core freezer logic, the frozen task stat is
> >> reported as 'R'. This is confusing, especially when a task with stat of
> >> 'S' is frozen.
> >>
> >> This can be reproduced as bellow step:
> >> cd /sys/fs/cgroup/freezer/
> >> mkdir test
> >> sleep 1000 &
> >> [1] 739         // task whose stat is 'S'
> >> echo 739 > test/cgroup.procs
> >> echo FROZEN > test/freezer.state
> >> ps -aux | grep 739
> >> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
> >>
> >> As shown above, a task whose stat is 'S' was changed to 'R' when it was
> >> frozen. To solve this issue, simply maintain the same reported state as
> >> before the rewrite.

The whole point of the freezer rewrite was preventing userspace from causing
arbitrary and indefinite D states which leads to all sorts of problems. The
tasks in cgroup2 freezer are *not* in uninterruptible sleeps. They are in
task stop loops and thus can be killed, ptraced and so on. It *should*
report S.

Thanks.

-- 
tejun

