Return-Path: <cgroups+bounces-7369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7493A7C4DE
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858D33AF67C
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFF16F8E5;
	Fri,  4 Apr 2025 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY12MSrY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4394DDC1
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798490; cv=none; b=fG31Ucd9D7opaqzZ/bw3W/WNO0hUhwlFqzkr0aCj5caZcJscSWHBlx0zbvgDypA+3r3X8NunXm6Hd7AjqbqO+1K4XpiKAH/SIXDTZV5T34XKZB/9V91I1BKyPOw1SuKPUnk3GpiXoWsEx6Ar+Al4+WRtuOq5M1oAthlpftxWPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798490; c=relaxed/simple;
	bh=DqzdL/iprk03uQavgGf8iocfOIxoRFPwA6bxRoFrnWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjjcXOT93SevIBI0dLVRTlQVP8u6byFsg8lC5AoFcrhzgW6qzEnzrmZOFzmgOR0aSpoggUT/4+JiAJtmP1N+WFMB4bo2QbyOHirqFAWgrRXkzN+doFO2vTmFrBG/lji0Flytk63YpKNT77W92qCBalz2+9jpXfZ7Ml3jkcVwMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY12MSrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34082C4CEDD;
	Fri,  4 Apr 2025 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743798490;
	bh=DqzdL/iprk03uQavgGf8iocfOIxoRFPwA6bxRoFrnWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gY12MSrYiF7ZFPGPWuBSsRYuDDQQU/MldkijLY99i6TgTrw5qv+PeKD7HGMtHqk6H
	 0icKww8oZ4Kxl3ZPt3ULLaNh/gNQb0XZlJC12DOwrujgvJ8NCM3CXm+6+sBI+gZFVx
	 a/WGytXD8jk04DYQ8TTWbTisWpTT2Kim2T6pUeqaBiQ8QwXGnycDQY1Wqshr19Ys4P
	 R3HjmwQ7npqV97H7q2xq5Jj6jXC9T+MHcL3Y9S2nQzOFsz4SQ8qpxKCVW1IANvaTNT
	 AXD8whfGpIPmFuVsLxUMrvMLgivDVIgxA7rA5jil6VO3qIqOOgi3eqx85CzrL3fits
	 WqBgH97kGMXyg==
Date: Fri, 4 Apr 2025 10:28:09 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <Z_BA2UD8jHCpvz4B@slm.duckdns.org>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-6-inwardvessel@gmail.com>

On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn wrote:
> It is possible to eliminate contention between subsystems when
> updating/flushing stats by using subsystem-specific locks. Let the existing
> rstat locks be dedicated to the cgroup base stats and rename them to
> reflect that. Add similar locks to the cgroup_subsys struct for use with
> individual subsystems.
> 
> Lock initialization is done in the new function ss_rstat_init(ss) which
> replaces cgroup_rstat_boot(void). If NULL is passed to this function, the
> global base stat locks will be initialized. Otherwise, the subsystem locks
> will be initialized.
> 
> Change the existing lock helper functions to accept a reference to a css.
> Then within these functions, conditionally select the appropriate locks
> based on the subsystem affiliation of the given css. Add helper functions
> for this selection routine to avoid repeated code.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

4-5 look fine to me. I'll wait for others to chime in before applying.

Thanks.

-- 
tejun

