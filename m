Return-Path: <cgroups+bounces-5288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C989B1F67
	for <lists+cgroups@lfdr.de>; Sun, 27 Oct 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782DD1F21254
	for <lists+cgroups@lfdr.de>; Sun, 27 Oct 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C7155C8D;
	Sun, 27 Oct 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/HgRXEE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889C17C61;
	Sun, 27 Oct 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730050422; cv=none; b=CsMusxq3VPOSELQLW5X9/STcT9jJnTXiLmeeMTzmnHMe1Cb/z14IlVrwM1drSs9wnQpwexfTHnlL96jeRJmUCOUutgqCG5cZo/C06JmGEnrc8UA6KtvhadKKUZflbI6Az0wtnhDXAaPJ+3fFXM8S2PDHrm/AnnDeGWmzeNwJJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730050422; c=relaxed/simple;
	bh=VWpp83wY/7sIKdkFNIyp1Jg+vorbUuwQIz2kzxgO0PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xyx+Eu9zVHff+B+tKVH90mBhVMf6IkP5QJdxbwYb0SiWc0Hlo7pVS2repLTcf8ZNgmGjFke3NCMg1WpoGBPFlUJ6v7AYFnxrIc05xxrDeCxu0oL7nKNC3cS2R1rWlCLpOVVAnnyZ/9iHu7pYy5ujeU/ztTuVfUHv47QZk5GsSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/HgRXEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E0C4CEC3;
	Sun, 27 Oct 2024 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730050420;
	bh=VWpp83wY/7sIKdkFNIyp1Jg+vorbUuwQIz2kzxgO0PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/HgRXEEGU42Ocq71KDo8ZGFxN8sRZUU5qaq8EAw5EFi4NXYpnznHAffdoKsRiBqe
	 Ka2MuxN060J4OFFqoSrzZu97VmkaG0UVK253Ooa832PFa29qgVM82KhxL8i9i4UMKb
	 3+PZ+TNS13rSGuxJo8teZqqccaJPSJM16Pt8Rtv9OxVBZSorxf+8kw7C+wdmn7o8VL
	 3LUe4lH3kySNsSm6TyMtjM81ZjVruEI/ozOWACwqbXnX6NklXKXQ99pMVyfRdhf9Qa
	 7kosHTnwgOEJLdXjXcdGLWdK2mebuLrk2DZNYQOd8GVCGS4CAqdqJhDLInoczcZJao
	 OjcG5O3fnr80Q==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2] memcg: workingset: remove folio_memcg_rcu usage
Date: Sun, 27 Oct 2024 10:33:38 -0700
Message-Id: <20241027173338.148147-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qrxkf25y6yh6mdzi73kl3cy3kdhihevqb2hgllcjgihghyvrzw@ooy4kzzwc2y7>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 23:55:14 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

[...]
 It seems like folio_memcg_charged() is not defined for CONFIG_MEMCG=n
> config option. The following stub should fix the build for such config.
> 
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 89a1e9f10e1b..5502aa8e138e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1055,6 +1055,11 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>  	return NULL;
>  }
>  
> +static inline bool folio_memcg_charged(struct folio *folio)
> +{
> +	return false;
> +}
> +
>  static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
>  {
>  	return NULL;

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

