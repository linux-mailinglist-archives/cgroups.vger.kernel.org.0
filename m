Return-Path: <cgroups+bounces-10753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2FBDBAA8
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B6704EBCCA
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76262D12ED;
	Tue, 14 Oct 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FfwcNndM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A962405FD;
	Tue, 14 Oct 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481664; cv=none; b=q3eYQR9BP0FGeqT9C+Zu/uZFRhQ93RIpdNb2UxOQN8qMVFvk5oZpjpWnoUtUyfsf9H85wWmWqXrXB2ttgGvmc/FbnaWD5WyfQ/MC7gcQtfvsph7Fw2VgbvZ05gpWy6uWQhvJUL8+Aha6fCoYoup6v4EBLlr5VEZO7Eap2PrvM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481664; c=relaxed/simple;
	bh=lqi45363pmRUxpEG13mRbWUtoTyUlnX2IPlDsUyrDB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXzigEj8pD7yuFfLHIZLaaW7tHz5FvBIDS6lvm9oKwovsBTNrQGzCf2uxV5iFmz2WigEqr/mP/zTqbKxD3hl7ARrngirQmgmvPq8p42Pb8nT0TUcwSFE+zLJ7bWRcUq2D0a7G1O2XECfYiSQBCRx43kcgyEvDhiDQYntgswDRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FfwcNndM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 15:40:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760481658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kymx9Ck3BaRbtCBkYGP0422cwTTn/aswqpSO+MgSvA=;
	b=FfwcNndMIvuZehmylvrdGiExadwXIbk3/1qViaC6bJJUUD3T1VC2r18YrQfykTdqEDgD9P
	zIxKqXQNLJrI/n2vxVZxUCW5nl/JKRgAL+N6jCp6AJinamOlQwD7ezvRpGR5qBIe3O1vqK
	gejPMoT7vgJLDMCXCcXTfzw6r372xrI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Message-ID: <j7tcixbgyo5ongfv33d2h4dvmko7ygrwi5fww2nc2op54nmvz4@ofwy5jpcvcrn>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <vdngz65wojqalim4xb6vxb6k7upbzmkfoogmbuswc4lowju3ke@32hgwjlzxibr>
 <df175b09-c0db-4dc3-a0de-e1c38f70147d@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df175b09-c0db-4dc3-a0de-e1c38f70147d@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 14, 2025 at 10:58:25PM +0200, Vlastimil Babka wrote:
> On 10/14/25 22:14, Shakeel Butt wrote:
> > On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
> >> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
> >> >
> >> > From: Hao Ge <gehao@kylinos.cn>
> >> >
> >> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> >> > the same bit position, we cannot determine whether memcg_data still
> >> > points to the slabobj_ext vector simply by checking
> >> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
> >> >
> >> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> >> > and during the release of the associated folio, the BUG check is triggered
> >> > because it was mistakenly assumed that a valid folio->memcg_data
> >> > was not cleared before freeing the folio.
> >> >
> >> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
> >> >
> >> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> >> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> >> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> 
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >> 
> >> nit: I think it would be helpful if the changelog explained why we
> >> need the additional check. We can have the same bit set in two
> >> different situations:
> >> 1. object extension vector allocation failure;
> >> 2. memcg_data pointing to a valid mem_cgroup.
> >> To distinguish between them, we need to check not only the bit itself
> >> but also the rest of this field. If the rest is NULL, we have case 1,
> >> otherwise case 2.
> > 
> > With Suren's suggestion, you can add:
> > 
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks, I added Suren's suggestion and pushed to slab/for-next-fixes:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-next-fixes&id=711c435c89e59ee32bf8bb1c0d875a07931da5a8
> 
> Resisted the impulse to change the single VM_BUG_ON_FOLIO to
> VM_WARN_ON_ONCE_FOLIO because we're still going to do that systematically,
> right?

Oh is there some coordinated effort happening for this conversion?

