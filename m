Return-Path: <cgroups+bounces-7230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6CA702EF
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B137A541B
	for <lists+cgroups@lfdr.de>; Tue, 25 Mar 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1ED2571B4;
	Tue, 25 Mar 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ARa2KaDk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314E2566DE
	for <cgroups@vger.kernel.org>; Tue, 25 Mar 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910959; cv=none; b=fs6wg+pKF7bwJLcGovXFtxBHMJTSr+vxZBdZ/+kjL7KXDl3+auHjXE1wUkmZZisMrx9nCVuzkyveOJGQgHGC5R9aC9FZwD5TYXjr3gQEcM4JylOhmkQ/tk6tdoo0ujPmmlPJcWizOxoXHP8lxJwz2d4huT/ikWj8AYwcbtCjzdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910959; c=relaxed/simple;
	bh=1P/YRArWpYFTAB2g9OgjJVhGtGJAaop28w4Z5avDHMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeK9tbl3n0RZUpuPmVeiwvJruIOqRCZRaQmBJQcj94BrgoQfsIu2yyXW6p/mHRkyqvrmq9ZfW8gN8TWv4+V5E3sG0JMDW4rEiXxO5JL7fsPHUuI8u1/PZDfyUwlmUtXGMKZjyeYoj7ktFLZ7r8JuTNsmxpfCMbB5H9Sx+HBQxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ARa2KaDk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 25 Mar 2025 06:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742910954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OfNIP+A8iRw3yCU4V1oyNQkWmcwkrFXn4tJUBmku4AI=;
	b=ARa2KaDkO8sB0r2/paA8iOkuUw+B/CSLSHffXQmq5Vk7O3s5ktFQO0NyKsvBYf+T1hGHZY
	gp1IzWiPzAFEyuT2j+81Z/oc+YzjhBLVx2TiyFgRpEv4GTGUN7GHhaor0YY9B60w6TwjJE
	JVsYHXDXZCTq8+SoKBPt32P50Thigwk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, yosryahmed@google.com, mkoutny@suse.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/4 v3] cgroup: save memory by splitting cgroup_rstat_cpu
 into compact and full versions
Message-ID: <4garyoovnhli6sjs5htpg2bkg5q2bvovrqu4y6iagq64jukoxt@j2smc2zf5okb>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-5-inwardvessel@gmail.com>
 <Z9yMMzDo6L7GYGec@slm.duckdns.org>
 <5062846a-7b4d-4c59-a990-ae9f7fd624a9@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5062846a-7b4d-4c59-a990-ae9f7fd624a9@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 21, 2025 at 10:45:29AM -0700, JP Kobryn wrote:
[...]
> 
> In general, I'll wait to see if Yosry, Michal, or Shakeel want any other
> changes before sending out the next rev.
> 

All good from my side.

