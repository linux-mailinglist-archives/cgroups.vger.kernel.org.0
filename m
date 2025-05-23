Return-Path: <cgroups+bounces-8334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710CEAC2BA6
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 00:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BF63AA973
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84F20FA86;
	Fri, 23 May 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ApTu7dV5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF3EC5;
	Fri, 23 May 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748037998; cv=none; b=cV+8Hys7WSw3PG+cT5lQN5AtAQ1dZ63Cu6yjHgSTlevXHaWKPvabDVsP20dnZUqPx9ee3wHX+x0Vhs8wXO5CMvZ3vLjh2MUCdf+TVaVzwSKD3cdHWaaj8xXDpjL2Up7qBQnashMEg665JkFuOVahaFhg0aVxRZgAWVCw/l52qsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748037998; c=relaxed/simple;
	bh=9j5tlxC9rdno3FMlsu5r9h9OfHHQcZ1zaGT9VEOlFpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=chWnHVj//uYqVSHC6BT8A68V1vfUbvGQdqzbR19YcvRYGzNVDmjOm8POaUp3MEgb4xDFIFYsVa/NTVSZOJoy9pSle2cO28ZEqh57rpO/nIOxgC+E/57CkqgxmUtEMHzI0X0LkRhbzqByQTTxBgTIHfAvSZwjjgc5KM7wbcaRfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ApTu7dV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7546EC4CEE9;
	Fri, 23 May 2025 22:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748037997;
	bh=9j5tlxC9rdno3FMlsu5r9h9OfHHQcZ1zaGT9VEOlFpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApTu7dV5uDOWeMTHCQkL+mjCt1c3VsfCC95+l/gatD5ByaXnCF7A3AITxXV6OAmf4
	 TheeBLzg5+YeuKYtkCmxDkU3gMOpshuv8ZalA9zGHLNm5ImZ/mZp+1gKCOxxe7kckA
	 LPGhzTprtehL92dmLrSfMMw58GiV3bMdEnEhAtck=
Date: Fri, 23 May 2025 15:06:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: peterz@infradead.org, mkoutny@suse.com, mingo@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, corbet@lwn.net, mgorman@suse.de, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com,
 kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com,
 ayushjai@amd.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 0/2] sched/numa: add statistics of numa balance task
 migration
Message-Id: <20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
In-Reply-To: <cover.1748002400.git.yu.c.chen@intel.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 20:48:02 +0800 Chen Yu <yu.c.chen@intel.com> wrote:

> Introducing the task migration and swap statistics in the following places:
> /sys/fs/cgroup/{GROUP}/memory.stat
> /proc/{PID}/sched
> /proc/vmstat
> 
> These statistics facilitate a rapid evaluation of the performance and resource
> utilization of the target workload.

Thanks.  I added this.

We're late in -rc7 but an earlier verison of this did have a run in
linux-next.  Could reviewers please take a look relatively soon, let us
know whether they believe this looks suitable for 6.16-rc1?


