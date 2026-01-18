Return-Path: <cgroups+bounces-13290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BFD391E4
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 01:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8C83029576
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C62BB13;
	Sun, 18 Jan 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gi1Zp6ug"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AD184524
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696291; cv=none; b=dH/42uyfBiQAVEmjrk34peK/yt5VEQTTIv9guwPM8PKGrTjpcJj4caiQicPv2xc/ycB2r1fzfhCR2WXRE3Bl8m+jQz/L6WDJqE3vjibH+cgZXAGYjgh2feQvmHwJw++GVa5v9omtGs6+DbX80nqdQExs6abHVvKhWwjhP9+uHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696291; c=relaxed/simple;
	bh=8mL6VjP6136nrGOOCbLNTFdTYlLjqMMJOavBELA0H+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlvJX+/LaQjF3LRjQqaQFEozru5O6GLaFiWVC++9mjVXGQVWXCSbV4Frm4VX1snAwnPTmtP4MPZQTId7oOHD2Rn4GmQMX2PvPz4OU//szKZNXAlgrFJlq5gXL7ZzW/hMUpSEtLD+RswEVH/Q560nHix2pmztQvtLSax+ZrVOlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gi1Zp6ug; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Jan 2026 16:31:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768696277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y71L8gBblqC5DHID0WPWlWL3f+ctkgtsC30cK08O62w=;
	b=Gi1Zp6ugkmez3FJ3H3PlYo/cUrHAVY9VqxvRxShl1ZYlbgxNlVqNYP0GNcx+SgSaB0xEMy
	m4ZVzIRsTdh20KpQeyaOHqhtaAL7Ac9FqCfFs5rEesAykpUdR5rspBUkEixgWXawKrrHCZ
	EX0S6AfzG6uiCRhq60WDzAVQYJLhGbE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 08/30] mm: memcontrol: prevent memory cgroup release
 in get_mem_cgroup_from_folio()
Message-ID: <qdfq2vxdma4qnt7pyfvuiyiib6ffuv46jyqsfgab643ihzttb6@h4hodwsqkmom>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c8eba771ab90d03f4c024c2384b8342ec41452.1768389889.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 07:32:35PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in get_mem_cgroup_from_folio().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 982c9f5cf72cb..0458fc2e810ff 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -991,14 +991,18 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
>   */
>  struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
>  {
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct mem_cgroup *memcg;
>  
>  	if (mem_cgroup_disabled())
>  		return NULL;
>  
> +	if (!folio_memcg_charged(folio))
> +		return root_mem_cgroup;
> +
>  	rcu_read_lock();
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> +	do {
> +		memcg = folio_memcg(folio);
> +	} while (unlikely(!css_tryget(&memcg->css)));

I went back to [1] where AI raised the following concern which I want to
address:

> If css_tryget() fails (e.g. refcount is 0), this loop spins indefinitely
> with the RCU read lock held. Is it guaranteed that folio_memcg() will
> return a different, alive memcg in subsequent iterations?

Will css_tryget() ever fail for the memcg returned by folio_memcg()?
Let's suppose memcg of a given folio is being offlined. The objcg
reparenting happens in memcg_reparent_objcgs() which is called in
offline_css() chain and we know that the offline context holds a
reference on the css being offlined (see css_killed_work_fn()).

Also let's suppose the offline process has the last reference on the
memcg's css. Now we have following two scenarios:

Scenario 1:

get_mem_cgroup_from_folio()		css_killed_work_fn()
  memcg = folio_memcg(folio)		  offline_css(css)
  					    memcg_reparent_objcgs()
  css_tryget(memcg)
  					  css_put(css)

In the above case css_tryget() will not fail.


Scenario 2:

get_mem_cgroup_from_folio()		css_killed_work_fn()
  memcg = folio_memcg(folio)		  offline_css(css)
  					    memcg_reparent_objcgs()
  					  css_put(css) // last reference
  css_tryget(memcg)
  // retry on failure

In the above case the context in get_mem_cgroup_from_folio() will retry
and will get different memcg during reparenting happening before the
last css_put(css).

So, I think we are good and AI is mistaken.

Folks, please check if I missed something.

>
> If the folio is isolated (e.g. via migrate_misplaced_folio()), it might be
> missed by reparenting logic that iterates LRU lists.

LRU isolation will not impact reparenting logic, so we can discount this
as well.

> In that case, the
> folio would continue pointing to the dying memcg, leading to a hard lockup.
>
> Also, folio_memcg() calls __folio_memcg(), which reads folio->memcg_data
> without READ_ONCE().

Oh I think I know why AI is confused. It is because it is looking at
folio->memcg i.e. state with this patch only and not the state after the
series. In the current state the folio holds the reference on memcg, so
css_tryget() will never fail.

> Since this loop waits for memcg_data to be updated
> by another CPU (reparenting), could the compiler hoist the load out of
> the loop, preventing the update from being seen?
>
> Finally, the previous code fell back to root_mem_cgroup on failure. Is it
> safe to remove that fallback? If css_tryget() fails unexpectedly, hanging
> seems more severe than the previous behavior of warning and falling back.

[1] https://lore.kernel.org/all/7ia4ldikrbsj.fsf@castle.c.googlers.com/



