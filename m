Return-Path: <cgroups+bounces-5568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF369C91D5
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 19:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A16A1F220BD
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90F19993D;
	Thu, 14 Nov 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQfmrozI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59144197521;
	Thu, 14 Nov 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609900; cv=none; b=q9z/NqfSZxu9S7MrWWEscfJNf6ORWV7Epluao0egUSVae1V1/esJOIKvyjMWr3NivDzxiFNT8KpISpbjLQ5Od9uJlCh6tDKL/z/sLq2XaP2+MuI4bYRvsYt9gJf6Cpmbz5nlenrh3j4blvfbJ1raJZGQ7L1trYduYV1Mtom3Go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609900; c=relaxed/simple;
	bh=5do6qDL9TuXty6Mc70FLBHtfezLZp1QS+cVEkOlzWrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX05ibj6URFZpc/m84qk5uXeu3XRxpoRhViwGJJqfgfCvSyjgtqylMp0iqV4dWPflmdjhp8c/KBWjp30tSWCKhQl58uDEusXLQoyYZKk6gAvuyq3An2Hj7kkv8q+FkX50MFiUGMF+TuE4ePCrlbzNY9sUbKVJIpC4DwousHHWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQfmrozI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C9C4CECD;
	Thu, 14 Nov 2024 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731609899;
	bh=5do6qDL9TuXty6Mc70FLBHtfezLZp1QS+cVEkOlzWrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQfmrozI7s0BkLt5ojkh/j8dDWsRztEejzf3U89usoQWxYBDaxBYe0ZLwxW/ucXU/
	 ypCq7PgnQBqxr7g8YQBJKUD6dcwUrvzR96qYhYTImXoNshmpfBw+C+hb00nSYPpDTI
	 +1z0arezEquuMOAHfqtBOSOFB3Wu53tATjf3ul0WrQRoLkYfkkzlhnzCPDBrr8rNB+
	 W7FkAsnGh5GsKnKd6aOAsI8oT20QfyA33QQRKUMhsMMbC//dlJsgLdwHVAOU2MavrA
	 1LmNJXhFy+4vbapcI5zbgSuZZX5SjOvwKDZ0ROegLihcItX2JMAZvvfqj7jh1SnszP
	 aaCAiBUigBKyA==
Date: Thu, 14 Nov 2024 08:44:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzZFKpuX-edQ1GuO@slm.duckdns.org>
References: <20241114181915.142894-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114181915.142894-1-longman@redhat.com>

On Thu, Nov 14, 2024 at 01:19:15PM -0500, Waiman Long wrote:
> With some recent proposed changes [1] in the deadline server code,
> it has caused a test failure in test_cpuset_prs.sh when a change
> is being made to an isolated partition. This is due to failing
> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
> validate_change().
> 
> This is actually a false positive as the failed test case involves an
> isolated partition with load balancing disabled. The deadline check
> is not meaningful in this case and the users should know what they
> are doing.
> 
> Fix this by doing the cpuset_cpumask_can_shrink() check only when loading
> balanced is enabled. Also change its arguments to use effective_cpus
> for the current cpuset and user_xcpus() as an approiximation for the
> target effective_cpus as the real effective_cpus hasn't been fully
> computed yet as this early stage.
> 
> As the check isn't comprehensive, there may be false positives or
> negatives. We may have to revise the code to do a more thorough check
> in the future if this becomes a concern.
> 
> [1] https://lore.kernel.org/lkml/82be06c1-6d6d-4651-86c9-bcc828cbcb80@redhat.com/T/#t
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun

