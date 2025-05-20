Return-Path: <cgroups+bounces-8278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F6ABE49B
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 22:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB01C4C7952
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A228C5A0;
	Tue, 20 May 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7FBA7cw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8B1D54E2;
	Tue, 20 May 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772202; cv=none; b=F1n19Mj5LGBGXpohJgAkGmXlZsOZse/wnnTglHQ5dyX/tRUZDhVFJ+NfwiEy1ni2h257pY1l46/AS3lWMMDZPU8jI4kduWoyXogymbAFlkEho8LGACizRJgSSLCQvI6BoUo/HAIamtOL+Gn4C2X/1cYvGXh/Bna83PiMKZUYbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772202; c=relaxed/simple;
	bh=vcTNhZndcqpAjXKFEWnY03tRam60uwe7XxAlmMNyOE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4afbVfhVhrn2Dx5svZh5NGbA2cd4Kzrc/2Wyq5+t/PZ8d5ulF7IJGPg23OGpGOod35g2iT2LoLZvszcv7ZKDr2LHb4Pf9+cA7k9VCDfWEQGEgdwiIzP8nskpSFOMe+2aGPqv7q7ebS+qMstJZb+3se0CohPjxTaEHrpgyDKheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7FBA7cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED8FC4CEE9;
	Tue, 20 May 2025 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747772200;
	bh=vcTNhZndcqpAjXKFEWnY03tRam60uwe7XxAlmMNyOE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7FBA7cwfq9DuWQK7nFrjnJmhQKp1FkpZCXRtjqdqRM465svg0dHLCiKplaU+087M
	 E5x3xSNdlOV3qAGykZ4YIfFjtoKztHeZRA2TsFbx44qDSHZb0Pr0bZ/LPOt87/v4C0
	 EVzH7PeS8PmvTkYQwNBpuRuL8n5bgA19HNGvaDL8MWfWav2rCpUYLRvg7injNsNG+0
	 np7LfU4nWX4xkwQkAIkc0fPFrty9jOyEwsFYbL/W4x3Ijhh1Ol7+1pgfHMNClW02/K
	 OT5p6U33HSUemeerej5M0B48mVSvi3ByRnHs9vs+zGF4e4DCZM9S022BXSCgX4zqfj
	 VphREBNKlIPSw==
Date: Tue, 20 May 2025 10:16:38 -1000
From: Tejun Heo <tj@kernel.org>
To: shashank.mahadasyam@sony.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2 3/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Message-ID: <aCzjJp1ovS6kCqHj@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-3-70a2b6a1b703@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-3-70a2b6a1b703@sony.com>

Hello,

On Tue, May 20, 2025 at 11:07:47PM +0900, Shashank Balaji via B4 Relay wrote:
...
> +The interaction of a process with the cpu controller depends on its scheduling
> +policy. We have the following scheduling policies: ``SCHED_IDLE``, ``SCHED_BATCH``,
> +``SCHED_OTHER``, ``SCHED_EXT`` (if ``CONFIG_SCHED_CLASS_EXT`` is enabled), ``SCHED_FIFO``,
> +``SCHED_RR``, and ``SCHED_DEADLINE``. ``SCHED_{IDLE,BATCH,OTHER,EXT}`` can be scheduled
> +either by the fair-class scheduler or by a BPF scheduler::
> +
> +    CONFIG_SCHED_CLASS_EXT
> +    ├─ Disabled
> +    |   └─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
> +    └─ Enabled
> +        ├─ BPF scheduler disabled
> +        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> fair-class scheduler
> +        ├─ BPF scheduler without SCX_OPS_SWITCH_PARTIAL enabled
> +        |   └─ SCHED_{IDLE,BATCH,OTHER,EXT} -> BPF scheduler
> +        └─ BPF scheduler with SCX_OPS_SWITCH_PARTIAL enabled
> +            ├─ SCHED_{IDLE,BATCH,OTHER} -> fair-class scheduler
> +            └─ SCHED_EXT -> BPF scheduler
> +
> +For more details on ``SCHED_EXT``, check out :ref:`Documentation/scheduler/sched-ext.rst. <sched-ext>`
> +From the point of view of the cpu controller, processes can be categorized as
> +follows:
> +
> +* Processes under the fair-class scheduler
> +* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
> +* Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
> +  without the ``cgroup_set_weight`` callback
> +
> +Note that the ``cgroup_*`` family of callbacks require ``CONFIG_EXT_GROUP_SCHED``
> +to be enabled. For each of the following interface files, the above categories
> +will be referred to. All time durations are in microseconds.

Can we document the above in sched_ext documentation and point to it from
here? Documenting sched_ext details here seems a bit out of place and prone
to becoming stale over time.

...
>    cpu.uclamp.min
> -        A read-write single value file which exists on non-root cgroups.
> -        The default is "0", i.e. no utilization boosting.
> +	A read-write single value file which exists on non-root cgroups.
> +	The default is "0", i.e. no utilization boosting.

Can you please separate out indentation changes to a separate patch? These
usually make reviewing tricky.

Thanks.

-- 
tejun

