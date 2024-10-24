Return-Path: <cgroups+bounces-5229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A911F9AED1A
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD95B22F6E
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549E1F9EC8;
	Thu, 24 Oct 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H67NQSuT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC11DD0D9;
	Thu, 24 Oct 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789597; cv=none; b=Mz9eWjmYQC1+BTSX0yL8RYfcrHfqgy1GyWIZ8cRt6VTQsjwtrVTVtP3rMiJiSEq/gwEPjkNPnId3OL1PCIuQpyn9lgMitnsRCrqZ5pVOivo1TBzDCjEWP1v2+cACabyU35JSlylQDgiCk72FfB+CGw2YYMzh0yva/QbS7rSGvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789597; c=relaxed/simple;
	bh=+U29CBBz+qyrBtOdbE4svz7p2WVJRzBvoR7WRuDzFdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNiAlCuSB9RM7IX6auecatC5mFHtuh96f08t9NUBAXquQdDRAtAa8oWmmvy5jFjrPlPSUZrahDfGpMewy3XRFDLhVtI/i+sSz+d4kz4l8zvFRfG8p8eDCYiyjLxiC60crbh68tv7CDEx5gb04NeHUsSVLr1YoNfrqR43u38s0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H67NQSuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58187C4CEC7;
	Thu, 24 Oct 2024 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789597;
	bh=+U29CBBz+qyrBtOdbE4svz7p2WVJRzBvoR7WRuDzFdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H67NQSuT2jRkzudyo8hcBaXGPRd16RtbucKKIBDbfx8FkTwAr4zIhYlZeE6WCQ/kL
	 pOKgojXUIUeRkXcF/JFapYxnKLfLT7nZKbkLAKrxpqPscdWWU/vZjnV9zgg6XNOwgL
	 wzbEkT0znzv5FxmEY4Ik7sEPxZyKemenvHZVbJw9VzPtVg/PgDCFm0JQgIUZq58Or+
	 5DfzEOvuXqappQSjGsEuZ0aK5qCv0QOW0YM94EAZUdRdzXgVozd7QdkrIs0W5Sk+Nu
	 qXaSipjzcAFgRXjcGCCgHoU/+HUqUJSQmpfcF9fFh3O20JLZ5Ja/v/FZVntFobZCnF
	 OY5WfqO8VubRg==
Date: Thu, 24 Oct 2024 07:06:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-beautiful-spaniel-of-youth-f75b61@houat>

Hello,

On Thu, Oct 24, 2024 at 09:20:43AM +0200, Maxime Ripard wrote:
...
> > Yeah, let's not use "dev" name for this. As Waiman pointed out, it conflicts
> > with the devices controller from cgroup1. While cgroup1 is mostly
> > deprecated, the same features are provided through BPF in systemd using the
> > same terminologies, so this is going to be really confusing.
> 
> Yeah, I agree. We switched to dev because we want to support more than
> just DRM, but all DMA-able memory. We have patches to support for v4l2
> and dma-buf heaps, so using the name DRM didn't feel great either.
> 
> Do you have a better name in mind? "device memory"? "dma memory"?

Maybe just dma (I think the term isn't used heavily anymore, so the word is
kinda open)? But, hopefully, others have better ideas.

> > What happened with Tvrtko's weighted implementation? I've seen many proposed
> > patchsets in this area but as far as I could see none could establish
> > consensus among GPU crowd and that's one of the reasons why nothing ever
> > landed. Is the aim of this patchset establishing such consensus?
> 
> Yeah, we have a consensus by now I think. Valve, Intel, Google, and Red
> Hat have been involved in that series and we all agree on the implementation.

That's great to hear.

> Tvrtko aims at a different feature set though: this one is about memory
> allocation limits, Tvrtko's about scheduling.
> 
> Scheduling doesn't make much sense for things outside of DRM (and even
> for a fraction of all DRM devices), and it's pretty much orthogonal. So
> i guess you can expect another series from Tvrtko, but I don't think
> they should be considered equivalent or dependent on each other.

Yeah, I get that this is about memory and that is about processing capacity,
so the plan is going for separate controllers for each? Or would it be
better to present both under the same controller interface? Even if they're
going to be separate controllers, we at least want to be aligned on how
devices and their configurations are presented in the two controllers.

Thanks.

-- 
tejun

