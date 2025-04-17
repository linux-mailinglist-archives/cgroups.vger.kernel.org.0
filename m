Return-Path: <cgroups+bounces-7629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D6A92C0E
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 22:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C9F7B5510
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DCE2066FE;
	Thu, 17 Apr 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0ap1dEvM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAB2AD0C;
	Thu, 17 Apr 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920758; cv=none; b=gcmkD1pZ+unE8X34FVls7OkRInyX1SyHTvXZUSEpkdpwOhBL8vKX6plwOZux9WiTJdrAfskjPYj8V9lerHI51PPBkrkcECZHgjAIAngh0eabD6rvPHJSxbp+m0jZ38sJcq7fIk/H+x9ktwRKzCIFj9n+uGhd4htR1uChOjEQzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920758; c=relaxed/simple;
	bh=0YpGtHMUawX1ATSiuC8hsCCXgN6stiffyM1wwPmYrys=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ks2WMM8e6g5Fm9S/ho1dS7P3PRjQDMCq4bzlp+LQd3Zr4mhfNj45YyPTCIHIC3llcuCpVTJCylC0TtAsIxBRy0OaKwIBkRQoGT+7b4ueHE2u8zKUSnJ0ojNfd1ldcu/SEU3s+Uh0n3MBdMmySLiGf9qNbsOu8p+sCQ8thmh9ZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0ap1dEvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB23C4CEE4;
	Thu, 17 Apr 2025 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744920758;
	bh=0YpGtHMUawX1ATSiuC8hsCCXgN6stiffyM1wwPmYrys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0ap1dEvMcMQhNVxw8JwbcsNMW5gQ1fyqZjG3esAIQOfcmxlBgSLnL42sB0lUOnwuZ
	 5FM+yPY45aQR8283cPYigHYzb7wepQtQ4JTBjD821nQ8hPxHOjUerUbt+w3uG2cjBE
	 38hpEmeDqmBXHe4Q4x22IRrMJtAiq7fJwVooNd3s=
Date: Thu, 17 Apr 2025 13:12:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
 rostedt@goodmis.org, llong@redhat.com, kprateek.nayak@amd.com,
 raghavendra.kt@amd.com, yu.c.chen@intel.com, tim.c.chen@intel.com,
 vineethr@linux.ibm.com, chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
 lorenzo.stoakes@oracle.com, mkoutny@suse.com, Dhaval.Giani@amd.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] sched/numa: Skip VMA scanning on memory pinned
Message-Id: <20250417131236.c47ce477c0e68dbb06a4fabb@linux-foundation.org>
In-Reply-To: <20250417191543.1781862-1-libo.chen@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 12:15:41 -0700 Libo Chen <libo.chen@oracle.com> wrote:

> v1->v2:
> 1. add perf improvment numbers in commit log. Yet to find perf diff on
> will-it-scale, so not included here. Plan to run more workloads.
> 2. add tracepoint.
> 3. To peterz's comment, this will make it impossible to attract tasks to
> those memory just like other VMA skippings. This is the current
> implementation, I think we can improve that in the future, but at the
> moment it's probabaly better to keep it consistent.
> 
> v2->v3:
> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
> redundant
> 2. print out nodemask with %*p.. format in the tracepoint

I do agree with Mel - bitmap_weight() is somewhat expensive and
cpusets_enabled() is super fast.  So the benefit to
cpusets_enabled()=false kernels will exceed to cost to
cpusets_enabled()=true kernels.

This isn't traditionally mm.git material, but it's close.  I'll grab
the patchset for some testing.  and shall drop it again if it turns up
via another tree.

