Return-Path: <cgroups+bounces-6618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E923BA3DF6A
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4626219C610F
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2025 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10F1FE45A;
	Thu, 20 Feb 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDv0FUkg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCB8F5B
	for <cgroups@vger.kernel.org>; Thu, 20 Feb 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066665; cv=none; b=N+6h2QRiv9x7cvq8iqNbyHDbiTW29K6yUAFp5mewP+TGaXlPHEiSkYadfBWj0qXe8UwwR0ihjUf6lFKD2sJUOipGxluZwz7IPtmbuOJ8p9uWrL/qBYHB9ndoDVQcB8BmWVYxLi4EEKIIBf55FENH2/Ay6Js7oyhqDWOZcUQ7kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066665; c=relaxed/simple;
	bh=74D4z/8LfODGfOhZKyP3pWUaQ47cVcZEFucwpuFpn2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHcCRbdVX9Zskld8ikLLMKmrRQYZtr3E3GPFsnNnL+EHJDnJwwUSp3mwayx1ffNxnvBODIBesPIbU9tBnD9As8QTTvpfA0tql3xVXoaTIPem/3AjyN2UHwk/WS7N9wgSIZpwWUFs1Ki0xsB6E0LLPTgo5NaIvg61qfZTAlQVVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDv0FUkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57281C4CEDD;
	Thu, 20 Feb 2025 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740066664;
	bh=74D4z/8LfODGfOhZKyP3pWUaQ47cVcZEFucwpuFpn2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDv0FUkgMQbpqiIVJ2jkiT71UOS7AohZ71hzvBNb0EKKVwqe0gufVDyGqAMo+E2k7
	 5qMRSZt6Ncq2fAqTYXSVlQCpZxggVaBVciwfeXNtTDz6a0K+cLtowf8AYnkAte7yd+
	 TxwdYRXHZeg49dpHn0cTlyg5z5DkPa4oiyA4ILykKPMiddmbyjjgx2Fr/gn8CKlDcD
	 YpvATWMzzIZQlOsh2C3qR9rhorUxntKcO1NSS+c+QpF5cp7jnMYboEAeTRuF6gxm4j
	 ETbnQDLteSLlgwHTW0425DaKyYt49d0jYV2cnj+Hrzu82F5Ai1XcMyHBYIJOcTDoVa
	 jpGag1JNbipKQ==
Date: Thu, 20 Feb 2025 05:51:03 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 00/11] cgroup: separate rstat trees
Message-ID: <Z7dPZ9dNcaYuT6SA@slm.duckdns.org>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>

Hello,

On Mon, Feb 17, 2025 at 07:14:37PM -0800, JP Kobryn wrote:
...
> The first experiment consisted of a parent cgroup with memory.swap.max=0
> and memory.max=1G. On a 52-cpu machine, 26 child cgroups were created and
> within each child cgroup a process was spawned to encourage the updating of
> memory cgroup stats by creating and then reading a file of size 1T
> (encouraging reclaim). These 26 tasks were run in parallel.  While this was
> going on, a custom program was used to open cpu.stat file of the parent
> cgroup, read the entire file 1M times, then close it. The perf report for
> the task performing the reading showed that most of the cycles (42%) were
> spent on the function mem_cgroup_css_rstat_flush() of the control side. It
> also showed a smaller but significant number of cycles spent in
> __blkcg_rstat_flush. The perf report for patched kernel differed in that no
> cycles were spent in these functions. Instead most cycles were spent on
> cgroup_base_stat_flush(). Aside from the perf reports, the amount of time
> spent running the program performing the reading of cpu.stats showed a gain
> when comparing the control to the experimental kernel.The time in kernel
> mode was reduced.
> 
> before:
> real    0m18.449s
> user    0m0.209s
> sys     0m18.165s
> 
> after:
> real    0m6.080s
> user    0m0.170s
> sys     0m5.890s
> 
> Another experiment on the same host was setup using a parent cgroup with
> two child cgroups. The same swap and memory max were used as the previous
> experiment. In the two child cgroups, kernel builds were done in parallel,
> each using "-j 20". The program from the previous experiment was used to
> perform 1M reads of the parent cpu.stat file. The perf comparison showed
> similar results as the previous experiment. For the control side, a
> majority of cycles (42%) on mem_cgroup_css_rstat_flush() and significant
> cycles in __blkcg_rstat_flush(). On the experimental side, most cycles were
> spent on cgroup_base_stat_flush() and no cycles were spent flushing memory
> or io. As for the time taken by the program reading cpu.stat, measurements
> are shown below.
> 
> before:
> real    0m17.223s
> user    0m0.259s
> sys     0m16.871s
> 
> after:
> real    0m6.498s
> user    0m0.237s
> sys     0m6.220s
> 
> For the final experiment, perf events were recorded during a kernel build
> with the same host and cgroup setup. The builds took place in the child
> node.  Control and experimental sides both showed similar in cycles spent
> on cgroup_rstat_updated() and appeard insignificant compared among the
> events recorded with the workload.

One of the reasons why the original design used one rstat tree is because
readers, in addition to writers, can often be correlated too - e.g. You'd
often have periodic monitoring tools which poll all the major stat files
periodically. Splitting the trees will likely make those at least a bit
worse. Can you test how much worse that'd be? ie. Repeat the above tests but
read all the major stat files - cgroup.stat, cpu.stat, memory.stat and
io.stat.

Thanks.

-- 
tejun

