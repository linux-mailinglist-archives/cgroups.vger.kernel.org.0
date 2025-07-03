Return-Path: <cgroups+bounces-8676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275DAF8359
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 00:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5DE583B0D
	for <lists+cgroups@lfdr.de>; Thu,  3 Jul 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943892C08A2;
	Thu,  3 Jul 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7D1V8lv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D328ECF4;
	Thu,  3 Jul 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581462; cv=none; b=qUPQqqMWj442iM0chUfFcE/5x1CiycU+bZqKZhPb8dYoTQUL4fLNky1pGxtybzUjPmbz4CvtwulR7i6hbpcpaJFIR7s/X4ajaF8NRTmZ4QLI2DiDsUQP/HmvxVQceA0zBpVNf1jhLFWN0a9h1GH3z1VZ41AS3AWiF3rqD9K+4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581462; c=relaxed/simple;
	bh=w3w1HWQyGrjxfcDVX2a88rURwMNQ/bcqmR87nd0s9Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzxBnDHv9O/gcpWxzdklEuw+SP5kaNWcgVGJFyZdOdjj0irs81/ETkFH7zDSh2HKyMbQg0oMuO3ACqKlzgDdEBRn5W94vxx9ApEPNWIJyYOvQfMgUCfqaZQm/NHxY9T6jZYoPKKOJgT/uucQrVzzwz1mMm0/vpqC2Lytmpg/2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7D1V8lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF723C4CEE3;
	Thu,  3 Jul 2025 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751581461;
	bh=w3w1HWQyGrjxfcDVX2a88rURwMNQ/bcqmR87nd0s9Z8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=m7D1V8lvjoTrd6PjJFv97POmRk+UwpwxR+LzTocMLe/xsSNRhHobl/uHgb5255QMN
	 v7amSpj80uwaAx16SBhhDPWQ35p6mdwGQhSU+jR3Gj+qJMKSWOScm6pCaJeqBwsuuH
	 lCOMVNgrdLHU756bL5Ck6fc8woPLcLjJ5tBYw6TIvb1ST5WaCdL34r0uVObPOowGzH
	 Nk4snpd8+8Mmj4myMi37u2r9QvNvaWGqnxJP9mvbxLyJWsgfr2uxa4sv+3iN/uxGGI
	 G8Uq8ZLwKC2tpiQZBzXDY2ODw9gG1ijfCJbFAhMmuE3AFGK+SfvhUgXBYR6ZyngGAi
	 Oh3lvRnXgQyXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80FF4CE0C97; Thu,  3 Jul 2025 15:24:21 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:24:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/2] llist: avoid memory tearing for llist_node
Message-ID: <e33d07a0-8470-44a8-88c1-10dfcb1171ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703200012.3734798-1-shakeel.butt@linux.dev>

On Thu, Jul 03, 2025 at 01:00:11PM -0700, Shakeel Butt wrote:
> Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
> safe"), the struct llist_node is expected to be private to the one
> inserting the node to the lockless list or the one removing the node
> from the lockless list. After the mentioned commit, the llist_node in
> the rstat code is per-cpu shared between the stacked contexts i.e.
> process, softirq, hardirq & nmi. It is possible the compiler may tear
> the loads or stores of llist_node. Let's avoid that.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/llist.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 27b17f64bcee..607b2360c938 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -83,7 +83,7 @@ static inline void init_llist_head(struct llist_head *list)
>   */
>  static inline void init_llist_node(struct llist_node *node)
>  {
> -	node->next = node;
> +	WRITE_ONCE(node->next, node);
>  }
>  
>  /**
> @@ -97,7 +97,7 @@ static inline void init_llist_node(struct llist_node *node)
>   */
>  static inline bool llist_on_list(const struct llist_node *node)
>  {
> -	return node->next != node;
> +	return READ_ONCE(node->next) != node;
>  }
>  
>  /**
> @@ -220,7 +220,7 @@ static inline bool llist_empty(const struct llist_head *head)
>  
>  static inline struct llist_node *llist_next(struct llist_node *node)
>  {
> -	return node->next;
> +	return READ_ONCE(node->next);
>  }
>  
>  /**
> -- 
> 2.47.1
> 

