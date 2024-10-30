Return-Path: <cgroups+bounces-5347-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EFD9B7073
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3278DB219B9
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79565217456;
	Wed, 30 Oct 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oFUriJg9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210381E8859;
	Wed, 30 Oct 2024 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330788; cv=none; b=AEr2GSf//C3Ps2TBp2okS2EN5jjQOu6hlNZf5g26HpkEmv9xVSEFp8iqaMxPNDzO99KKSqHKtytFPMf6TAtqBak9xc6jTDgHAeCGXJSi7HbesGLG5hqzzwFAGgLJEsCyH50FMu5RHoie0AQ0zPlP/CSLoY1eRCNq5MqSDkrGqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330788; c=relaxed/simple;
	bh=wPMPLo0mta4qVpGzLolACfvuHSWiB6tecr7v0QVNiiE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uoW2mm6jWrWL2rKDMKOLgW9azTpaojFuf1s5t+T8LujTVDg1pCqS0f7LI6Ko036Tu2MXp+PLD+sHWLOMVfvP6+oTNwoVcWv49TroqD97kbdsvqr8Odd9cl5aWpZU+ydXrbNnoyC22IWsMTD+g+CgUXHYCq7Dnw8P3W0NWOTX4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oFUriJg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2DBC4CED4;
	Wed, 30 Oct 2024 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730330785;
	bh=wPMPLo0mta4qVpGzLolACfvuHSWiB6tecr7v0QVNiiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oFUriJg92Dn4a60uaF1IBC3TaNYrQLGQvRPbLY4YNZMSGWLOgpyQrHkE7cN9ybocB
	 EKR7ojApZlS2yHRM5OZq28OKvDu5+jREiU8oD1bwNorRmZh5zdt6zYU4mgpROhQi7w
	 4PJpBrixkESQxiMBDqaU4jqMjqP9/ccGYLRKUlK0=
Date: Wed, 30 Oct 2024 16:26:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 nphamcs@gmail.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
 mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-Id: <20241030162624.2ae779257e68264c4bec99fd@linux-foundation.org>
In-Reply-To: <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
	<ZyIZ_Sq9D_v5v43l@tiehlicka>
	<20241030150102.GA706616@cmpxchg.org>
	<ZyJQaXAZSMKkFVQ2@tiehlicka>
	<20241030183044.GA706387@cmpxchg.org>
	<CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 16:43:42 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> I saw that it was merged into mm-unstable earlier yesterday. Would it
> be possible
> to add this block of text to the patch description right before the footnotes?
> 
> 3. Implementation Details:
> In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
> regardless of whether memcg accounts hugetlb. lruvec_stat_mod_folio
> keys off of folio->memcg which is only set up if the
> CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING cgroup mount option is used, so
> it will not try to accumulate hugetlb unless the flag is set.
> This also ensures that memory.stat::hugetlb is the same as
> the share of memory.current that is used by hugetlb pages.

Thanks, done.

> And could you also update the list of signatures to reflect the
> responses on this version?
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Done2.  I already had all that, plus an ack from Chris Down.

