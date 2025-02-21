Return-Path: <cgroups+bounces-6640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83445A402C3
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D20188A3F0
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2025 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0B1D5166;
	Fri, 21 Feb 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZK41wm8Q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC142A95
	for <cgroups@vger.kernel.org>; Fri, 21 Feb 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177313; cv=none; b=SNhdHhn3AMhhHsE5++BRr7c1YBBr28NPvWTosJZBmsgMIRf8LX8Ve5UXFd3Ess+JjBDnxH1DwQDs2LgBdv7SChM0CMrKwJu/UjuVIGc3Ukom4Ds5zU5mNS46MNWOoBd6LJUQM7WFtw1SX3W6tLRB2MIBZk21mVdMnDjGvvP/A9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177313; c=relaxed/simple;
	bh=0hS6cK0OUHCYN52VDxVLtn8MIKl1S9YgbImwMXuiWms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4NKnlQGD+t+9dYm/H6tp3CQfVNa6MbMHg8WHXDPiTJUIZs4ztdPF0AAQhlIn1ur4pH7t980Ntk7SkO3p+llUtQz2/bvDFaH4qz44mUdSSnQAKGPf92pxRlh+zOBQ0mPKJBMV6cxzmSSbPv/VE3YmGLIgcdL3i7D2sHgg8HAgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZK41wm8Q; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 14:35:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740177306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xs77vC/PVoARFTdf9n/vZqIqUAf3IrQqyMH7Gt+c4Dk=;
	b=ZK41wm8Qf/wpKZKCYmE6bx6zefFTfuiHUs0BpXUaeMzjI3VmZ9dYzMhWXnixDbqKTQRnyC
	iDTIxb7E3h9veAt+IXeovgBu3WMVj1BHsiEzOq033FwtoM5qHMiIYQjFBLTfuvXzviB1Bq
	oiNjpSGryAZy7rcm9R/yIAyGTAFIJIQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 07/11] cgroup: fetch cpu-specific lock in rstat cpu lock
 helpers
Message-ID: <xxmmvjmsojpsqgntskboqxzfocafhkr2evz465vitmuwmy3jju@syplk7nrxpqf>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
 <20250218031448.46951-8-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218031448.46951-8-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 17, 2025 at 07:14:44PM -0800, JP Kobryn wrote:
> The lock/unlock helper functions for per-cpu locks accept a cpu
> argument. This makes them appear as if the cpu will be used as the
> offset off of the base per-cpu pointer. But in fact, the cpu is only
> used as a tracepoint argument. Change the functions so that the cpu is
> also used primarily for looking up the lock specific to this cpu. This
> means the call sites can be adjusted to not have to perform the offset
> prior to calling this function. Note that this follows suit with other
> functions in the rstat source - functions that accept a cpu argument
> perform the per-cpu pointer lookup within as opposed to having clients
> lookup in advance.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

