Return-Path: <cgroups+bounces-10752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248EBDB606
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A34EF9B6
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED26A30C37D;
	Tue, 14 Oct 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9hWH24o"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE451306B32
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476427; cv=none; b=lDl5180dgs2fwGI0LqdVLr99QapAuMmaQofTRroYu3Sn/P+IXBE/fSj9SEZgEfH7kErzHwL2j4PVTz/ZJVDw6z719gGiDhpXN4SO9HmcHbqzj0MbVtN/nnm6L8cOV/KutTe53eEATJ2x90vzlcHoSJzo9zwqeKYuqa5XTnYZXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476427; c=relaxed/simple;
	bh=tPtaf8lPTGhjtr1cuwV2561s2xxD6uNU+oQFmdg0yE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tsw/MX5HqM0OpMWuaH76uJNP+FR8mD99k1/1zch7IiAsGBUE7yioESY1CqSYVvuma4/p1O9PtKxfFRrUKKc6iJJdvAf4Ow7J41K2Tw4sE9DR8N54B6Kqb0Fn0hymkyqAypS+c6H2KPOyFnsXpU+fzNaSlc/5gh5gjmOdoWHBpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9hWH24o; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760476412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axJZtnDZWi6vaVYeCAyW3be+cBc21q2dMi5KM6Ov1x0=;
	b=P9hWH24o8Wx6LHWvdKijhu1xCOvFjsaC/PBwLdkkPa6OAx9qiRsTFFedEOfwaQYzfpWQNq
	mXgym1dK/eMLi9IhC3iu2ILRPW0CBHu0KtGL8WoNaQZ9DupifEEUhWcsd0AxnOzDoYbHp9
	y0qWQHLvNacRjJtYwdmWQjXSaR4Oa1Y=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,  Alexei Starovoitov <ast@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Michal
 Hocko <mhocko@kernel.org>,  Muchun Song <muchun.song@linux.dev>,  Suren
 Baghdasaryan <surenb@google.com>,  Harry Yoo <harry.yoo@oracle.com>,
  cgroups@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
In-Reply-To: <20251014152751.499376-1-hao.ge@linux.dev> (Hao Ge's message of
	"Tue, 14 Oct 2025 23:27:51 +0800")
References: <20251014152751.499376-1-hao.ge@linux.dev>
Date: Tue, 14 Oct 2025 14:13:25 -0700
Message-ID: <87y0pddw5m.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hao Ge <hao.ge@linux.dev> writes:

> From: Hao Ge <gehao@kylinos.cn>
>
> Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> the same bit position, we cannot determine whether memcg_data still
> points to the slabobj_ext vector simply by checking
> folio->memcg_data & MEMCG_DATA_OBJEXTS.
>
> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> and during the release of the associated folio, the BUG check is triggered
> because it was mistakenly assumed that a valid folio->memcg_data
> was not cleared before freeing the folio.
>
> So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
>
> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v3: Simplify the solution, per Harry's suggestion in the v1 comments
>     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

