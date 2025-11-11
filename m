Return-Path: <cgroups+bounces-11820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEC8C4F822
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE114E9EC3
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333329BDB3;
	Tue, 11 Nov 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJaY3/c4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AB3AA19B;
	Tue, 11 Nov 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887122; cv=none; b=VtJFgxERkUY8fXmYKiFV/g/cqoTVlU+Ip2m3Opa0YeQDuPTnZOvAkBXk3h+PdkXV+4QRD42MVv73KDBAKVBKr0sZScmBMvPy9wvVstETFVflehksF1XosrabAH5vR/A9CVpwuTLgaoMEdhqHw9N63oyRCroyvk629CDGF8UohJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887122; c=relaxed/simple;
	bh=wKqIegUi0DiJka0SaYsAR82k/GO5oanlw/ZrqT+rYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRaEEZ6x8DL4YFhO/aFSbo6J4lErvPaKMJtsAoEeFK2d6bX/f3ZyGdp8UI+oKpujdUwwrln5M1ZrJXjgTrApI7uqU+yqi3YQB9r+50sAM3R8lYq5mnIXiYKjB1IYvcXcWV9a7N5Ro0Evyz78wEZ0iVodakjanUCgqQBbJjPWKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJaY3/c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDF5C2BC86;
	Tue, 11 Nov 2025 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762887121;
	bh=wKqIegUi0DiJka0SaYsAR82k/GO5oanlw/ZrqT+rYI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJaY3/c4Hz0IicNy9MoLgjQ72hFd73LWM4TMqP63GTIdB5LtGou1hjNDUDGl+e7zD
	 AT6j1WygoT+efMp5+V2fSzW03Cm+yUOQUbt42/hpdA2H4tZckgvVxWisb1xdKNSWal
	 f/bPa+DZO92VdcbG49H/eXwNxeehNe6TnMde639i1q9Un8Jq0i+x5usTEbtkDlYX/S
	 Pb1PB14S2v+U/XSQt8C6/C+niFgrViOBm/icjKuwBROUgkWHgCALRlB6UybWi9e4GJ
	 fXObnVEmiXEAFwUpr/hOzM6bwlPNmfXhiDxOGdi/z40pF6S6E/XfkVvN4u02zuI/yo
	 mkVtoSvrX+DQA==
Date: Tue, 11 Nov 2025 08:52:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: mkoutny@suse.com, akpm@linux-foundation.org, cgroups@vger.kernel.org,
	corbet@lwn.net, hannes@cmpxchg.org, jack@suse.cz,
	joel.granados@kernel.org, kyle.meyer@hpe.com, lance.yang@linux.dev,
	laoar.shao@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mclapinski@google.com, mhocko@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aROF0BXEJtCM7c12@slm.duckdns.org>
References: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
 <20251111061343.71045-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111061343.71045-1-leon.huangfu@shopee.com>

On Tue, Nov 11, 2025 at 02:13:42PM +0800, Leon Huang Fu wrote:
> We are going to run kernels on 224/256 cores machines, and the flush threshold
> is 16384 on a 256-core machine. That means we will have stale statistics often,
> and we will need a way to improve the stats accuracy.

The thing is that these machines are already common and going to be more and
more common. These are cases that aren't all that special, so I really hope
this could be solved in a more generic manner.

Thanks.

-- 
tejun

