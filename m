Return-Path: <cgroups+bounces-12483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B289CCACCD
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD51630181A4
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940F2EC561;
	Thu, 18 Dec 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JiH8P5e5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26C2EA158
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045352; cv=none; b=o6As6hAtXsAhoPtDdW+fjOUS235QUDewfyKnHFokH2FC22uQPjsGr9w8g+Aq3VoaAwqaOAD8jX2KJvW2Wtv16Acj82YLxAxk2vLek9c6GxFuKRgE23WZ9ujNf3HEhktIZMrrZEe1o/Al8+ttH/BNroL+1vFfjVbQ5jzCdKDWe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045352; c=relaxed/simple;
	bh=glkZT0mYZGHG6WTxAnhc+9cQuSWoTTBOll0XahKQoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7EVVIFzgNBaA8qxcyEZnG4MVWjchwwGWwa5dWQO0Zs/NH8LLxKuLpyY/SFUsVBkd4xLh+cwPZMi1txjgdFPo712WLx5qCA346gTDCiNYmBRKyNsTnsbCoT8Ki0CyDlOj7sw1Ji8blHODAJyI0zK60djfK5RcUVNaWTro5I0SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JiH8P5e5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 00:08:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766045337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zx7UqAOuwin0dqb+uy4QaGD9HzyrCUqCBoMKpn3Ho6w=;
	b=JiH8P5e584SNbUt7OVXwb/8flTqfcGsam0ywhkxnuG8Skmw1Ha937jhOGrr7hS/+/h4ula
	fCxVEaMVnD/4MeQCtT/TFmx852t/ilSQFihzt/Z91TbiR8ba4C75cxf4FX+l1lgaXVwECl
	PvbesD5wl2qYAbJ2Xx7rBwZg0snDaPU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev
Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in
 try_charge_memcg
Message-ID: <gktuqmvopl7pgbcaw3rwiq77vb2zguae3jfdxmwfgtetf3twu4@gcb5bubhxq64>
References: <hibelxfvkdvm6b2a6vmgdmwcne6e2z2hrshshacepgedduyejn@7kfdegbmwyvs>
 <20251218073613.5145-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218073613.5145-1-kdipendra88@gmail.com>
X-Migadu-Flow: FLOW_OUT

This feels like AI generated responses and giving me the impression that
you are not really understanding what you have written here.

On Thu, Dec 18, 2025 at 07:36:13AM +0000, Dipendra Khadka wrote:
> > Why hopeless?
> 
> Because in this specific path the allocating task is already the OOM
> victim (TIF_MEMDIE set). Any reclaim attempt performed by that task is
> unlikely to make progress for its own allocation, since the kernel has
> already decided that freeing this task’s memory is the resolution
> mechanism. Reclaim may free some pages globally, but the victim itself
> will still be exiting shortly, making retries for its own allocation
> non-actionable.

Beside its own allocation, these retries also keep the usage of the
container below its limit. Under extreme condition we allow allocations
above the limit. Here we are failing the charge request. Will we start
seeing more ENOMEM in the exit path? Do you have a call stack where such
retries are happening?

> 
> > Why optimize for this case?
> 
> I agree this is a narrow case, but it is also a delicate one.

How is it a delicate one and what exactly delicate mean here?

> The
> motivation is not performance in the general sense, but avoiding extra
> complexity and repeated reclaim attempts in a code path that is already
> operating under exceptional conditions. The early exit reduces retry
> churn for a task that is guaranteed to terminate, without affecting
> non-victim allocators.
> 
> > Since oom_reaper will reap the memory of the killed process, do we
> > really care about if killed process is delayed a bit due to reclaim?
> 
> Not strongly from a functional standpoint. The concern is more about
> control flow clarity and avoiding unnecessary reclaim loops while the
> task is already in a terminal state. I agree that this is not a
> correctness issue by itself, but rather an attempt to avoid redundant
> work in an already resolved situation.

How is it a resolved situation? The dying process is in reclaim due to
limit.

> 
> > How is this relevant here?
> 
> This was meant to explain why exiting early does not introduce new
> failure modes for the victim task.

More chances of ENOMEMs?

> Even if the victim still performs
> allocations briefly, the slowpath mechanisms 

What slowpath mechanisms?

> already allow limited
> forward progress. I agree this does not directly justify the reordering
> by itself.
> 
> > Same, how is this relevant to victim safety?
> 
> Same answer here — these mechanisms ensure that the victim does not
> regress functionally if retries are skipped,

How GFP_NOFAIL doing force charge is relevant to the case you are trying
to optimize?


