Return-Path: <cgroups+bounces-4191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4994DA2E
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 04:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AE8282608
	for <lists+cgroups@lfdr.de>; Sat, 10 Aug 2024 02:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0E13213E;
	Sat, 10 Aug 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qAZCCvTN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FC1799F
	for <cgroups@vger.kernel.org>; Sat, 10 Aug 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257571; cv=none; b=Fj8IkZ6gUkua2uRuFf2Po4UtmETRjVE3EhlZi8UcwyRdL5lAEMdoAdKKHsTys5AyWGnvFTLyEtRM2oylbupzPJ5XFnxoxlUvohTM4K1TSIVZCzYpNaf8Urlr1xiDqWEQf3UGY+giOUaIn0QZt3aRWsO9+bqzSLk1dlAYKEqwpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257571; c=relaxed/simple;
	bh=+weEgowa/sf3AGpmMQCdg5onlZflD/OQ1Rk7FS6GN4A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AsedP66nwSZL7YA+GiXyN8Sp6mee9+kHncj6yx0oahpwJ0tO8glk/ft/dDrkVfS44vFqSSK4yhp1M5fZO019imVnASn0WyDzpNJrBYzRCmnAtWbtTn0eO7Vz5V7izzH8oMzZ2/A+LtuD2DgF/87xiug6sqe0i+iaXknURjkLRSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qAZCCvTN; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723257566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI+Vi4pbj0gTCrjL7DMWl6AgcfOJvlF0DoxzDvU62co=;
	b=qAZCCvTN+nVPafsEp6qVwXKPq06wHrt4RBcMMu7V+s7rzc1tzF7VlhTLNgg8wqeK4awn8Q
	l93xiM3ku8MTrGEowOu+XmXcm0jLvQv7VINKf6if/UjuSDBbgOSin4YgpHzitU85jEBZ7v
	sQ9SgslhesrDKyrfPL1z2CsAR1ynrfg=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] memcg: replace memcg ID idr with xarray
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240809172618.2946790-1-shakeel.butt@linux.dev>
Date: Sat, 10 Aug 2024 10:38:50 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C0B6D310-2EE0-4DCC-B41A-E682C1E018AA@linux.dev>
References: <20240809172618.2946790-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 10, 2024, at 01:26, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> At the moment memcg IDs are managed through IDR which requires external
> synchronization mechanisms and makes the allocation code a bit awkward.
> Let's switch to xarray and make the code simpler.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


