Return-Path: <cgroups+bounces-8364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48BAC5E28
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 02:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF739E68F9
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AAE487BE;
	Wed, 28 May 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hnu9QoPI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AAC1367;
	Wed, 28 May 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391674; cv=none; b=Npzl4eyOv1EERibZ8wOlCe2Or3Y6fOTnU/EKjaz+4sji1L3VW251J6DcmLSGrG5Md+tCTnRwiGt+UDpUssM5+sqDTg9axDpuXf6beSFrbvAhmdMEWOdDDBj/QJDkZFcn06vgp0XrBALQVpuGMfim+0xO5Sv+bwHHoGjuCgV/3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391674; c=relaxed/simple;
	bh=MiplJaSXo9+qkAJjfFdFOEBgp25rtyEwQyCkvimB9gQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rJF8q2qGyGa+YQdT7cd6sm53Ow3plF767cwAgfnsdwKoiw9tLofeUwYWApfLVF59eI6lHrXh9wP3X3yl31ZDBn3Hrbq3Uxh0ANeh8bC3EGWPUPQqtqRrCZJkNtJexJvU+Fw0vor99o3mXHLali9HmXiH5WBGrhI82UbCg/sndd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hnu9QoPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D46FC4CEE9;
	Wed, 28 May 2025 00:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748391674;
	bh=MiplJaSXo9+qkAJjfFdFOEBgp25rtyEwQyCkvimB9gQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hnu9QoPIsDm/qvQexRpVo4Y2RW0eOPfck2LEZ76NoCdaT5ZNilp1/YhMH2rzmAVcq
	 d95jUYWe56OjtCCL8rWcNfoYpPxtBWzJCQzcIXLlyY81aX+IOGQWys6pm3dyexLN3V
	 jPhHi32H4pklSJgSjZMTejYsJmCHvHQ6r/f5iP3k=
Date: Tue, 27 May 2025 17:21:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Chen Yu <yu.c.chen@intel.com>, peterz@infradead.org, mkoutny@suse.com,
 mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net,
 mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev,
 roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com,
 libo.chen@oracle.com, kprateek.nayak@amd.com, vineethr@linux.ibm.com,
 venkat88@linux.ibm.com, ayushjai@amd.com, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 0/2] sched/numa: add statistics of numa balance task
 migration
Message-Id: <20250527172112.18612286e9a193089d42a027@linux-foundation.org>
In-Reply-To: <qob64enpuewivcne2b7prnuahs3nr6v6kuil7suskcsfgdoqew@pdxpbd4ghrxk>
References: <cover.1748002400.git.yu.c.chen@intel.com>
	<20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
	<qob64enpuewivcne2b7prnuahs3nr6v6kuil7suskcsfgdoqew@pdxpbd4ghrxk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 16:52:46 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Fri, May 23, 2025 at 03:06:35PM -0700, Andrew Morton wrote:
> > On Fri, 23 May 2025 20:48:02 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > > Introducing the task migration and swap statistics in the following places:
> > > /sys/fs/cgroup/{GROUP}/memory.stat
> > > /proc/{PID}/sched
> > > /proc/vmstat
> > > 
> > > These statistics facilitate a rapid evaluation of the performance and resource
> > > utilization of the target workload.
> > 
> > Thanks.  I added this.
> > 
> > We're late in -rc7 but an earlier verison of this did have a run in
> > linux-next.  Could reviewers please take a look relatively soon, let us
> > know whether they believe this looks suitable for 6.16-rc1?
> > 
> 
> The stats seems valuable but I am not convinced that memcg is the right
> home for these stats. So, please hold until that is resolved.

No probs, I'll keep these in mm-new until something changes.

