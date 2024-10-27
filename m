Return-Path: <cgroups+bounces-5287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60A9B1C50
	for <lists+cgroups@lfdr.de>; Sun, 27 Oct 2024 07:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50C6B21363
	for <lists+cgroups@lfdr.de>; Sun, 27 Oct 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A972F46;
	Sun, 27 Oct 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALDNT+zZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA653D0D5
	for <cgroups@vger.kernel.org>; Sun, 27 Oct 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730012132; cv=none; b=EfEOogIBc1CUBC2c6UkK4oCh3Lr1KHWsGURGWi4hy5Fj2nn25KoQvsn9h5pySBPa0hI6W92GzRMW3igRljebZJJlubHjBsbBF5NG63BEd2oZHzqmXtZGf/q8R5uDwb/pFcmVciiIq37FxIdq79ecJWWc2B8EP4/Inc3HG5MRx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730012132; c=relaxed/simple;
	bh=KhIzbz3oik03799kOYw2I4vU0TVKak2hIj3WuMcfDfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su/sXAtygo2s63Cg5wb8+uysQQcNCGLBT94WaWfVkPSQhmW37iMtaGqpSGbvLKqnVoqaYhOSAFqFrQt6NGkSlQztFYYjQ9bOYuu5LnRtiH2E80VWvx0iSCn7wo6dD5cnaW9IYF/QZNKRl4baGKgfm28b0LLAHiwsOGqewNHtSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALDNT+zZ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Oct 2024 23:55:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730012121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw3H4pusaQ5DOw6+PyiDapAmvqYWQPaCzTwI8aIt2NU=;
	b=ALDNT+zZybCxXr4AleNgQbZljfuohJuCq+3RER0kWkH/SPGlOt7CPrHJuxGCKtE7d2TPxG
	CgtC8/kqWweHQ52UgPI2tYw2YjeZ9KRJPmLfl4lYDPv66XHUm0C+okPAUOEK5tMyMEU3QW
	waIL++MgR1WPdZkDH0S1OuK8p1BOv1o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2] memcg: workingset: remove folio_memcg_rcu usage
Message-ID: <qrxkf25y6yh6mdzi73kl3cy3kdhihevqb2hgllcjgihghyvrzw@ooy4kzzwc2y7>
References: <20241026163707.2479526-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026163707.2479526-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 26, 2024 at 09:37:07AM GMT, Shakeel Butt wrote:
> The function workingset_activation() is called from
> folio_mark_accessed() with the guarantee that the given folio can not be
> freed under us in workingset_activation(). In addition, the association
> of the folio and its memcg can not be broken here because charge
> migration is no more. There is no need to use folio_memcg_rcu. Simply
> use folio_memcg_charged() because that is what this function cares
> about.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> ---
> Andrew, please put this patch after charge migration deprecation series.
> 
> Changes since v1:
> - Fix for mem_cgroup_disabled(). (Yu Zhao)
> 

It seems like folio_memcg_charged() is not defined for CONFIG_MEMCG=n
config option. The following stub should fix the build for such config.


diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89a1e9f10e1b..5502aa8e138e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1055,6 +1055,11 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return NULL;
 }
 
+static inline bool folio_memcg_charged(struct folio *folio)
+{
+	return false;
+}
+
 static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
 	return NULL;

