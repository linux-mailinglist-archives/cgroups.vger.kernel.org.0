Return-Path: <cgroups+bounces-13264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41AD29703
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527F33010FE2
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5530748B;
	Fri, 16 Jan 2026 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vmDbA6Mt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064D1548C;
	Fri, 16 Jan 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524188; cv=none; b=UfewN4qWGDr1VPLHPi/m4fh+EjaDeCIKtEf2S7smuagijJGGkEYvgDasWXJbwNhv0I7aQtcnB//mYQ6gWMDqR3rPpgIPzsLaacLcr+Q2LUJQCv6T/2rvN58OOblYPU1Md480VvAR1yBkyoFW0iz5l+XUAGuM+y5hGMsQcf+tYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524188; c=relaxed/simple;
	bh=fBG1PD1bCRFzFRAlxECdYmAe0bpJ0YaafnJU65vARWE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D0Su+vL9PVK1j0bwy0+3AlXUAWCejtdK6RNhVjisKrEJ67mX/G5TyGTXBgp4Pd0devHsDmCwjoK87gNILdnwdHL8qM9YnnrY1DoiQCQNoPL9z9efUTSfdc9qPp2ZGfCudUBSC00BxaLrGVu+L8dnyRU53schgpnMnhuzg9G09YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vmDbA6Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F3C116D0;
	Fri, 16 Jan 2026 00:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768524187;
	bh=fBG1PD1bCRFzFRAlxECdYmAe0bpJ0YaafnJU65vARWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vmDbA6MtFqwo35iaeesiHLhJecnjpBfk3K5wu0pcSuJqU/DzFn5SuD267N77HNO25
	 kUCId0VGDnqJldx/uJsMrr14LUMSgvv/k1OpBTb2R9XCy0lGKs/Clbd8PYBkYb/Anv
	 0lvu2I6ATviw5P4f9nr3CLwAj0QURqDgl6uitqo0=
Date: Thu, 15 Jan 2026 16:43:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Message-Id: <20260115164306.58a9a010de812e7ac649d952@linux-foundation.org>
In-Reply-To: <0a5af01f-2bb3-4dbe-8d16-f1b56f016dee@lucifer.local>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
	<20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
	<0a5af01f-2bb3-4dbe-8d16-f1b56f016dee@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 12:40:12 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Wed, Jan 14, 2026 at 09:58:39AM -0800, Andrew Morton wrote:
> > On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> >
> > > This patchset is intended to transfer the LRU pages to the object cgroup
> > > without holding a reference to the original memory cgroup in order to
> > > address the issue of the dying memory cgroup.
> >
> > Thanks.  I'll add this to mm.git for testing.  A patchset of this
> > magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> > so let's see.
> >
> > I'll suppress the usual added-to-mm email spray.
> 
> Since this is so large and we are late on in the cycle can I in this case
> can I explicitly ask for at least 1 sub-M tag on each commit before
> queueing for Linus please?

Well, kinda.

fs/buffer.c
fs/fs-writeback.c
include/linux/memcontrol.h
include/linux/mm_inline.h
include/linux/mmzone.h
include/linux/swap.h
include/trace/events/writeback.h
mm/compaction.c
mm/huge_memory.c
mm/memcontrol.c
mm/memcontrol-v1.c
mm/memcontrol-v1.h
mm/migrate.c
mm/mlock.c
mm/page_io.c
mm/percpu.c
mm/shrinker.c
mm/swap.c
mm/vmscan.c
mm/workingset.c
mm/zswap.c

That's a lot of reviewers to round up!  And there are far worse cases -
MM patchsets are often splattered elsewhere.  We can't have MM
patchsets getting stalled because some video driver developer is on
leave or got laid off.  Not suggesting that you were really suggesting
that!

As this is officially a memcg patch, I'd be looking to memcg
maintainers for guidance while viewing acks from others as
nice-to-have, rather than must-have.

> We are seeing kernel bot reports here so let's obviously stabilise this for
> a while also.

Yeah, I'm not feeling optimistic about getting all this into the next
merge window.  But just one day in mm-new led to David's secret ci-bot
discovering a missed rcu_unlock due to a cross-tree integration thing.

I'll keep the series around for at least a few days, see how things
progress.


