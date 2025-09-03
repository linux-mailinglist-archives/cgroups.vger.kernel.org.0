Return-Path: <cgroups+bounces-9641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE47B41B87
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342C71BA5A7E
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E092C15B0;
	Wed,  3 Sep 2025 10:18:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B327056A
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894695; cv=none; b=SFIydzrPdiGkosOHzvFBOFC8djHAaAsEcLnnBJG2wJjHCwRg7IqhHHpkuMVJojq7lgtiuRqL3oicmN3zcsuhFrcYtTzPuw/idNIuncsbjnX6rZUReRULGcswbVYAerYNAPFHOd79ThIYp3BFD/HEXolUTJ85xhI3rL14738IVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894695; c=relaxed/simple;
	bh=JTAdy5ooCiF98ATSrVgfVIiPe1LVEOpn0Bo4qlQvPk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLb3e9575w9D7cgZvaArhEk0gb9+pZxys4169mwbFudKckDePtwwYRJYscPMXo7jau5THYMxRD9lOpB7aZllWCRb81lpb/kx8zI+F6zvHQ8YxUr4xRBorPfASqsX9QtVDr7MsbXAEMwi3kAKkxVMSLMthi+DlCwSMnfuURHYf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 3 Sep 2025 19:18:05 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 3 Sep 2025 19:18:05 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <aLgV3YF9uds7LC9T@yjaykim-PowerEdge-T330>
References: <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330>
 <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330>
 <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330>
 <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
 <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
 <CACePvbU2iqLyjc2uR3d=56S4A-N4P7k3oUnwA-6D=TFfQ17jBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbU2iqLyjc2uR3d=56S4A-N4P7k3oUnwA-6D=TFfQ17jBA@mail.gmail.com>

> Please accept the sincere apology from me.  I was grumpy, sorry about
> that. I was under pressure to be somewhere else but this email is
> taking longer than I expected to write. I let my bad temper get the
> better of me and I am sorry about that.
> 
> You might not have realized that the proposal you made has the same
> kind of buggy behavior for the usage case where the change of the
> parent and the child gets it.
> 
> One side note, I do want to rate limit the new proposals I have to
> defend against. On the other hand, when you make a proposal to change,
> you have no way to predict where I will consider it good or bad.
> Otherwise we don't need to have this discussion. My hash reply is
> uncalled for and I realized that now.
> 
> I am over it now, let's put this behind us and continue our discussion.
> 
> Best regards,
> 
> Chris

Hello Chris Li,

I received your mail and have been taking more time to think through the
discussion you raised, so I had not replied immediately.

Looking back at my proposals, I realized I kept sending out questions as
I was trying to align fully with your view and bring things up to patch
level quality. Considering you also have many other topics to think
about, I will take some time to review this subject myself and focus on
reducing communication overhead.

Over the past week you have been quick to review and very engaged, which
I greatly appreciate. I feel happy that our ideation has aligned to a
good extent, and my frequent questions came from being motivated to
bring this up to the same level of patch work as before as quickly as
possible. In hindsight, I realize this also reflected my own impatience.

I am also in the process of clarifying my thoughts by working out the
aligned parts at the code level. At the same time, I am considering how
this connects with the points we have discussed so far and the areas
where alignment is still incomplete.

Once my thoughts on your last review settle, I will send you my ideas
and any remaining questions. (almost done!)

Thank you again for your thoughtful reviews, and the respect I
have for your guidance throughout this discussion. 

Best regards,
Youngjun Park

