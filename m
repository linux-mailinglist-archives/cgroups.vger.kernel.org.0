Return-Path: <cgroups+bounces-10171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FDB59EF7
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726C37A7C39
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA242FFF87;
	Tue, 16 Sep 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ATr4gjLb"
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D72F5A03;
	Tue, 16 Sep 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042648; cv=none; b=j6T3WvXxl9zc4ZvDoRJOCesPYP/GhziV5Ta2eIN+iZKRF4Y5OiQeiXkAASVURLeiklptf6OqOcaVCjnwIBNOD4B5vpdQvLUL2+oD4r9iWZBGDUHz7S8EUfYhBQPFAq99lCzFwDsk09MTtuWGCIVCeXK+HzngH+6qpoXfLZU52Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042648; c=relaxed/simple;
	bh=52a5khhWywk3mzbTtG/eaLSUFbCkMvNbfSSHenmqqkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz8Nv3db0NtKmIvKmyMK9iE0KMmEcSiHf8ZHkYnFKJZeCQ18XnvD63i4Th3nj3fuUyCyWXat2e6iMisaeLLzIqgKIp1k3UeoCgsYXoXzzx0ijBbSLPjkKhGvIv46KqElCUsOBr5Kn+o7YXaQ4kimOBi63L3DtgoNFRBjJdf55w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ATr4gjLb; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758042646; x=1789578646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yj/co0t5Iw8d47vXLDniXY4H2qDpIH8uba9JHqJdO8s=;
  b=ATr4gjLbGQWyDG4dZXegrRq/p+vS4/Ed4oIHY2fibY11y7PooZEV3iRI
   7cjb6DH4KdrM+V2iK1eyri1Btn2zQXyjCJgi4O7f/mc39scYD5K+yOi3q
   xqoOk35EgqQPtneOkVZ1b701J5I29XkCyy83QS3Q9tBcW6BawJPHTc/Nx
   A1MnXZ3fUvSSuT/Nu7TWT4+aKBjFc/vjLomlk36dWoJvvMMIGaVaOkqx8
   RNLPR6NiwJ8AexYkCBDvsiKKoS/wKG8uNXhTT8Lw/FVybQCDR0DQ4SXLV
   O5c+oazkssFC36dqL3S7Qu+IfFvV5iXSvhbFGEbAQ/+Mzll2bRappf0GT
   g==;
X-CSE-ConnectionGUID: r2MH0a+nShCa9LtTSfPqNg==
X-CSE-MsgGUID: KgO2vHhiQHyJRTkCEVp8IQ==
X-IronPort-AV: E=Sophos;i="6.18,269,1751241600"; 
   d="scan'208";a="3085197"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 17:10:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:56726]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.219:2525] with esmtp (Farcaster)
 id a8e25940-f42e-4026-bea0-0929d2af846d; Tue, 16 Sep 2025 17:10:46 +0000 (UTC)
X-Farcaster-Flow-ID: a8e25940-f42e-4026-bea0-0929d2af846d
Received: from EX19D032UWA001.ant.amazon.com (10.13.139.62) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 17:10:45 +0000
Received: from dev-dsk-ajgja-2a-6a9b5603.us-west-2.amazon.com (172.22.68.79)
 by EX19D032UWA001.ant.amazon.com (10.13.139.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 17:10:45 +0000
From: Andrew Guerrero <ajgja@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <ajgja@amazon.com>, <akpm@linux-foundation.org>,
	<cgroups@vger.kernel.org>, <gunnarku@amazon.com>, <guro@fb.com>,
	<hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mhocko@kernel.org>, <muchun.song@linux.dev>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <stable@vger.kernel.org>, <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix memcg accounting during cpu hotplug
Date: Tue, 16 Sep 2025 17:10:40 +0000
Message-ID: <20250916171040.12436-1-ajgja@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025091216-purveyor-prior-2a81@gregkh>
References: <2025091216-purveyor-prior-2a81@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D032UWA001.ant.amazon.com (10.13.139.62)

On 2025-09-12 12:45 UTC, Greg KH wrote:
> On Mon, Sep 08, 2025 at 09:09:00PM +0000, Andrew Guerrero wrote:
> > On 2025-09-07 13:10 UTC, Greg KH wrote:
> > > On Sat, Sep 06, 2025 at 03:21:08AM +0000, Andrew Guerrero wrote:
> > > > This patch is intended for the 5.10 longterm release branch. It will not apply
> > > > cleanly to mainline and is inadvertantly fixed by a larger series of changes in 
> > > > later release branches:
> > > > a3d4c05a4474 ("mm: memcontrol: fix cpuhotplug statistics flushing").
> > > 
> > > Why can't we take those instead?
> > > 
> > > > In 5.15, the counter flushing code is completely removed. This may be another
> > > > viable option here too, though it's a larger change.
> > > 
> > > If it's not needed anymore, why not just remove it with the upstream
> > > commits as well?
> > 
> > Yeah, my understanding is the typical flow is to pull commits from upstream into
> > stable branches. However, I'm not confident I know the the answer to "which
> > upstream commits?" To get started,
> > 
> > `git log -L :memcg_hotplug_cpu_dead:mm/memcontrol.c linux-5.10.y..linux-5.15.y`
> > 
> > tells me that the upstream changes to pull are:
> > 
> > - https://lore.kernel.org/all/20210209163304.77088-1-hannes@cmpxchg.org/T/#u
> > - https://lore.kernel.org/all/20210716212137.1391164-1-shakeelb@google.com/T/#u
> > 
> > However, these are substantial features that "fix" the issue indirectly by
> > transitioning the memcg accounting system over to rstats. I can pick these 10
> > upstream commits, but I'm worried I may overlook some additional patches from
> > 5.15.y that need to go along with them. I may need some guidance if we go this
> > route.
> 
> Testing is key :)
> 
> > Another reasonable option is to take neither route. We can maintain this patch
> > internally and then drop it once we upgrade to a new kernel version.
> 
> Perhaps just do that for now if you all are hitting this issue?  It
> seems to be the only report I've seen so far.

We are hitting this issue only in a stress test, and I think we got lucky with
experiencing it, so I wouldn't be too surprised if this is the first and only
report.

Thanks for taking a look!

Andrew

