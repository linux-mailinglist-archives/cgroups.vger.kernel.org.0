Return-Path: <cgroups+bounces-6427-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB7A27CE8
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 21:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FC47A148B
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A8219E98;
	Tue,  4 Feb 2025 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmK/ilgF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61E19E83E;
	Tue,  4 Feb 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702019; cv=none; b=l2nC3f3g8Eb+2x78dxsL6BbXnyOAxVhMnEVWGwg9AaT4ANDyzpXkfoOwNzpGY/dEA1zqEoapF66vhluM2DRONlpBVTFIjbRjfpupE0+S72NxGbokhRHcLBBDe6cAziDtALzWjKRp5N2g0U/eU8viuCSjwB2DajpShNSYFKsKZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702019; c=relaxed/simple;
	bh=A9YOqhr4a3Nfp7dwuX66qDG8uCHnk3oo4CPnj0viI7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwA/OSMcqL/9DQM1oe9z25ZhAavEppphqZ4nS/GY5Tmr8aPuXYXuX/xjXsEK4qekNg9voKh2DkNs2q4f1GtvNtb36dNOwFZZPGG3I/g0KweoTdkRAfaYAs/fVu+CvvXh83MaezjtLWiLjAPj+vld+7F228qaNdn/icX+V3/wwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmK/ilgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601FDC4CEDF;
	Tue,  4 Feb 2025 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738702018;
	bh=A9YOqhr4a3Nfp7dwuX66qDG8uCHnk3oo4CPnj0viI7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmK/ilgFmBaQkMAeDevq13IH6d+Y9jn9NkZ6LJAkZmFMYh9s0GQsCKYyj2qw/ZdlE
	 9X5ZJukB2LLjXiW2k640Mi5XAN6V4/GzBT1ilw1djAv0e5tuHCPegNqDHj4NUkMZBE
	 P60pwKqzZawFIAGBvJB5pnRTVRba06Egswh2/h8P5wat+ks36595Jpnyz5hP1cwrU/
	 JaCusyn1r+I4vsRpiwaYN+CqTluu+cycv8qJl41tdWcvCX1KY8LHQPuIKsHGhlkOhm
	 Bhv/p3gQiNyHpMaWRCVR1iMkJpgvuzYnVsuknscyFKXPjXaRQ7iz8lQsdfn7KlbsXi
	 R6uZL55DHD+kA==
Date: Tue, 4 Feb 2025 10:46:57 -1000
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
	Yury Norov <yury.norov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Fix and cleanup and extend cpu.stat
Message-ID: <Z6J8wbuXgiz_ly-q@slm.duckdns.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <bb16ae49-f591-4ab3-8d27-f649619b266b@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb16ae49-f591-4ab3-8d27-f649619b266b@bytedance.com>

On Mon, Feb 03, 2025 at 04:11:27PM +0800, Abel Wu wrote:
> Ping :)
> 
> On 1/25/25 1:25 PM, Abel Wu Wrote:
> > Patch 1: fixes an issue that forceidle time can be inconsistant with
> > other cputimes.
> > 
> > Patch 2: cleans up the #ifdef mess in cpu.stat.

I wasn't sure whether the new code was materially better than the existing.
Can we try without this patch?

> > Patch 3: extend run_delay accounting to cgroup to show how severely
> > a cgroup is stalled.

I'm not necessarily against adding this. Johannes, what do you think?

Thanks.

-- 
tejun

