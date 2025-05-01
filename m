Return-Path: <cgroups+bounces-7968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFDAA61E5
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CBF18920CB
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B542A87;
	Thu,  1 May 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXGls3im"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875C1A314A;
	Thu,  1 May 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118836; cv=none; b=fxi0Gpp7pKuIajAFZulh4KPvNLPIeox6NPHtqTdTtYXyKXKvQixMKZ83vUa0Nun+aVgelquMMcyR8xJXjec2f4a1yHXfrwOD+reLheAkxLHAoie2z295AE404LiuPK5mQP/YJbUOhnobGNTigXhm+s0nXvdP1Lr6b/fdatCOxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118836; c=relaxed/simple;
	bh=OMA0eH9KcaDe8ZVYZIdJjVrB3QO1xkNDa2/W/DkYQIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7iBSNx+JeT10pA7QiSnCABNjnUUeVnb/sR8wfZJowIjx1wsWHYYE/DOXGb84fDPXqQBYn3xX6RpiulcRUoPmJ597YuH+1jOXV4KUXtG8Y7IVhDXkSUyV79otUNxSeIcPL1S4FzdMN5yT3nZdv/EOIXVfdFYWT5ir6KQY+G2qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXGls3im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2FDC4CEE3;
	Thu,  1 May 2025 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746118835;
	bh=OMA0eH9KcaDe8ZVYZIdJjVrB3QO1xkNDa2/W/DkYQIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXGls3imxlHtKUicGqPwKOtx3jWz3zlkNesvyfv182mdRSnPL/GPWqLV98OVLz+Z6
	 E6jQ3Mkjed131tNt3+uFlw0YT3BAhw6e1jUmwKOOpI4UySFbBBY5RbYXFLv3Rzc17f
	 zfIzAsvJiMp5nw/LzC1TnUZFGqO6iIZnYeOHsR7yQaNeu5He2C22G6V9eewzZlnaWr
	 fgX9h1CR763aQqU0R1gTSGAotfnnwDvo7xi3CXBJi84wnAVAKrXXJt7GHO22rUSAEQ
	 cvcNTxEZCaanvFI4Mb6gLWh1F7NrS4kGCzX/Te+j99e+SgMwrzZJ7E0h3fTF82E9PQ
	 JoR6hyhzV2LiQ==
Date: Thu, 1 May 2025 07:00:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [RESEND] Circular locking dependency involving, elevator_lock,
 rq_qos_mutex and pcpu_alloc_mutex
Message-ID: <aBOosuedqt15xS1K@slm.duckdns.org>
References: <Z_QjW7zJLsuO0xp6@slm.duckdns.org>
 <Z_QjxCZW7dh_v22Z@slm.duckdns.org>
 <16ed195d-7f26-41bb-86d6-ea961b3fa691@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ed195d-7f26-41bb-86d6-ea961b3fa691@linux.ibm.com>

Hello,

On Tue, Apr 08, 2025 at 12:32:50PM +0530, Nilay Shroff wrote:
> Thanks for the report! This is now a known issue. And we're currently working on
> it to cut dependency of q->io_lockdep_map (or queue freeze-lock) on q->elevator_lock. 
> Please see below :https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
> https://lore.kernel.org/all/20250403105402.1334206-1-ming.lei@redhat.com/

Any progress on this? The last activity on the threads seems to be back on
Apr 10th and we're getting close to rc5. If we need to revert, I think it's
about time to decide.

Thanks.

-- 
tejun

