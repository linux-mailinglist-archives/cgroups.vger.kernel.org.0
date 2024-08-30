Return-Path: <cgroups+bounces-4620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41D966010
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833971F288F0
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA0199FB4;
	Fri, 30 Aug 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGiWByJk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9815C153;
	Fri, 30 Aug 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016014; cv=none; b=K3dpGnN9PxHb8dE7F0OINdDWah3/Nz3ppG8RTl884voHtZhs2t2VfqftGtLwBYQh8VnS4zK+TYP9HV9ZzJCVsrje0SHCEbptigpeTuub0OkIymCp6WAvnhh5/zD8FMT1cUsqLsRTStiG3+X4WMCydAn1Pps0+fajaZofYPSPAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016014; c=relaxed/simple;
	bh=zidPzPAWhV07kEXgyrT1WmbLrzldnbGPEyASdiaK8Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPFrmA7JcXYWq5Vs1jAsPFcdtZ/3XJXtVFosvPXeASKvn9CfYIbV6YwfWsKOQUdXkep+glBN039cwkBy4MLXFrrW1NiCICgJMEx62nQl3gMlX0qJm1PJaRlURYLVFP+vOOGyNkohKgoGSjSDfC0+edAOa4NQnJlpYkNuva6x208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGiWByJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6474C4CEC2;
	Fri, 30 Aug 2024 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725016013;
	bh=zidPzPAWhV07kEXgyrT1WmbLrzldnbGPEyASdiaK8Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGiWByJkH5+Cv8a35yJy2SbUIgoM3HpCkqZZob8eiVKSGQUtwP8s1J1B/x/zn5mgG
	 G94Y28L0KyFT6wr9aSfbtkkjvTddaPMGmcpTNiw/p7HNk4MqzARy3GOrfDndxc46kw
	 6nJtIyPNWaCr6zoGKTK3v8V7zsppt4knoZXGSd2G1vBDIWjoq3ySRos7hPG3K0Zc6R
	 bqYqyGkMaYg8tjY7+s2u3rJi/V3FMjUIhXB32nHFMG/NThEq0n8QOynKwavTz4jzhq
	 wbfsA+ePUoScxXrBUo4qrJs5SMN/L83wfmGxzzoFydyl+gNyFBIDUreD1MGZsu2RFc
	 34784x5EbxzGw==
Date: Fri, 30 Aug 2024 01:06:52 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org, mingo@redhat.com
Cc: cgroups@vger.kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mkoutny@suse.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-6.12] sched_ext: Add cgroup support
Message-ID: <ZtGnzJsP8Smzx7JX@slm.duckdns.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>

On Mon, Aug 26, 2024 at 12:57:38PM -1000, Tejun Heo wrote:
> This is v2 of sched_ext cgroup support patchset. Changes from v1
> (http://lkml.kernel.org/r/20240808002550.731248-1-tj@kernel.org) are:
> 
> - cgroup interface file visiblity toggling based on SCX_OPS flags is dropped
>   as it caused more confusion than helping anything. sched_ext now just
>   warns when unimplemented features are used.
> 
> This was originally taken from the cgroup integration part of the sched_ext
> v6 patchset:
> 
>   http://lkml.kernel.org/r/20240501151312.635565-1-tj@kernel.org
> 
> This patchset is on top of sched_ext/for-6.12 (9ad2861b773d ("sched_ext:
> Allow dequeue_task_scx to fail")) and contains the following patches:
> 
>  0001-sched-Expose-css_tg.patch
>  0002-sched-Make-cpu_shares_read_u64-use-tg_weight.patch
>  0003-sched-Introduce-CONFIG_GROUP_SCHED_WEIGHT.patch
>  0004-sched_ext-Add-cgroup-support.patch
>  0005-sched_ext-Add-a-cgroup-scheduler-which-uses-flattene.patch
> 
>  0001-0003 are sched core preparations. Straightforward. No functional
>  changes.
> 
>  0004 adds cgroup support to sched_ext.
> 
>  0005 implements an example scheduler which uses the cgroup support.

The sched core part is minimal with this series. Peter, unless you object,
I'll route these through sched_ext/for-6.12.

Thanks.

-- 
tejun

