Return-Path: <cgroups+bounces-10220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A616B8205A
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A43B0FE3
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D32E6CCC;
	Wed, 17 Sep 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHaypvwN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459F224B04
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145841; cv=none; b=AbM47WCDFZhGqgKDcuiBor24njE5lqzsSw7KP1QBXSO3WnceXG/UIB+AYZxHEHN341+zEbv9igmyhwlkTdS/shD/RVGJLI5oha7WtqY75xX3DaHx1LZgY5o0xJhKQH/Fq3M5XwMP9UXaHAv3uLkg6ZVVj7zbYXuvg2kcl61ZNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145841; c=relaxed/simple;
	bh=PI8Xd/l8ye6DwfFy3MPo+C1Do/Lt5w3dLjCZrDbRvpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTTelvLJcEz4ikAqxlR00bR6rmUK7jUE3W+Wbdzyh5dr29asiz4HsCrna9CD3ehs16nHR8bV5hOR8Xkuo2OB5BT4dj9NbyjAEd4LYaksef141fAgeHnNc8OA3HRff/uYTI/WZEJ4KNV7e08VoG9T7mydRONgi4AO0dJ7Aoc4eYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHaypvwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4199C4CEE7;
	Wed, 17 Sep 2025 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758145840;
	bh=PI8Xd/l8ye6DwfFy3MPo+C1Do/Lt5w3dLjCZrDbRvpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHaypvwNb8YfyJhz0Bzf2HD0jBCXdV+BPa8TKwZ4bAP4d9B0clPVMoIJ2LdECcuaK
	 vYekqSwdwddF61t2/8IzWsPqAahBL7CKyeA2+GjxOqG/hHC/rT10mSdDgKCdioqSpS
	 jeSb5GIMTVqEbT9mnUNof4LLie2y0gl/If21dzXaw67PaBI/j4ymKyf+1WB46sOubQ
	 qn+LIgjlW3z5eReKvTCxyM0Sw/eNHwUReLk4o/mHB4/hH3C6hxcjv6nhoS61/o3uPU
	 Uj8EXKZsWlWHsrxe3yaOB1CQy8iUsUvBspSvwXz3wcBYfQOGHRsELV1Ko3J0vjKG+d
	 y1dP2ZCiivqLQ==
Date: Wed, 17 Sep 2025 11:50:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	muchun.song@linux.dev, venkat88@linux.ibm.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	akpm@linux-foundation.org
Subject: Re: [PATCH v6] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aMstLw_ccoveLow-@slm.duckdns.org>
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917212959.355656-1-sunjunchao@bytedance.com>

Hello,

On Thu, Sep 18, 2025 at 05:29:59AM +0800, Julian Sun wrote:
...
> The wb_wait_for_completion() here is probably only used to prevent
> use-after-free. Therefore, we manage 'done' separately and automatically
> free it.
> 
> This allows us to remove wb_wait_for_completion() while preventing
> the use-after-free issue.
> 
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

  Acked-by: Tejun Heo <tj@kernel.org>

Minor comments below:

> +/*
> + * This structure exists to avoid waiting for writeback to finish on
> + * memcg release, which could lead to a hang task.
                                           ^
                                           hung

> + * @done.cnt is always > 0 before a memcg is released, so @wq_entry.func
> + * may only be invoked by finish_writeback_work() after memcg is freed.
> + * See mem_cgroup_css_free() for details.
> + */

I'm not sure this gives enough of a picture of what's going on. It'd be
better to expand a bit - briefly describe what the whole mechanism is for
and how hung tasks can happen.

Thanks.

-- 
tejun

