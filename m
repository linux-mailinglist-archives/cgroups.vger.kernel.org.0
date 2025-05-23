Return-Path: <cgroups+bounces-8337-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A6CAC2C8A
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0590D1C084C7
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4721EFF91;
	Fri, 23 May 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6IbL15D"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FC1E8320
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748044409; cv=none; b=tju1N+ydCcseD5Ry4MSjQAp0JdJiTFP/0DVfaprcmOPaH52cfOxh9Ftc1irmzMpVNMVcdwQl/gNxAW+hCPKxGxYds4sxH51kHfL0CkMHOqudQH5wYKPhrgPRBMFRvObazLJY2vvY+QiCYcYLJcw/7ViHdVFWyh6OvYgYPF7419k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748044409; c=relaxed/simple;
	bh=FNaoXQ/DWBGXP+tPBYyfn9WkOJ19EQKKbiBGnBrLFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMJxZZhlTN469KWVaZRhvYgk6nxU5EqNQ/LASspZkfLYZj37RgPUtzbV8+zE40aoogH0hHOKTlL5MtslCFNgPv6ShUiXVaCVYk3FP6m2B5wQUnqgyUCFh/jFXBfdfPXkYQI+uirAiXBRYYqo8jaARTQDHBVsavKGPJqTLG03tjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6IbL15D; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 16:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748044395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwhu4z2b7XnDz5DmFRgSfvRvsvme49qnGrnKAviEMhI=;
	b=P6IbL15DSmtaZaqqU1boExvqggqPvwfVbNZr7VVj/axwdnNVCBm52eaJ54bjJBb5h6xlAK
	vWXyo6Z0KCnnLOK9jqyITnUYt8sAYC6drgxLM7j+EwB7fWlRMTAXw9sKtmYdFLp9wY/H73
	rFyMWrg9o7eYVuUzklIREXTjjgdXRlc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Yu <yu.c.chen@intel.com>, peterz@infradead.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 0/2] sched/numa: add statistics of numa balance task
 migration
Message-ID: <qob64enpuewivcne2b7prnuahs3nr6v6kuil7suskcsfgdoqew@pdxpbd4ghrxk>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 03:06:35PM -0700, Andrew Morton wrote:
> On Fri, 23 May 2025 20:48:02 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > Introducing the task migration and swap statistics in the following places:
> > /sys/fs/cgroup/{GROUP}/memory.stat
> > /proc/{PID}/sched
> > /proc/vmstat
> > 
> > These statistics facilitate a rapid evaluation of the performance and resource
> > utilization of the target workload.
> 
> Thanks.  I added this.
> 
> We're late in -rc7 but an earlier verison of this did have a run in
> linux-next.  Could reviewers please take a look relatively soon, let us
> know whether they believe this looks suitable for 6.16-rc1?
> 

The stats seems valuable but I am not convinced that memcg is the right
home for these stats. So, please hold until that is resolved.

