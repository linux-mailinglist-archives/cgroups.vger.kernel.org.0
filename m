Return-Path: <cgroups+bounces-7467-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B7A852DD
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 07:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA751899078
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807D27BF7B;
	Fri, 11 Apr 2025 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="udd7Vot1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616732F5A;
	Fri, 11 Apr 2025 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744347981; cv=none; b=LA64FcG4s+8zTP+OmhCGGVmqwX0OHCeyEn9AH2MnefPItTaU3gUbKCPHBuDXpFDj92scTKuGG5raOlWC2mrpHcSn75xXc1063p5Nsw96xcpByKRM19hxll9NMgZcH/zJ2fuk3KpywWN9AURL9ItRhlUCXOayx6ZahEzkPCOrSkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744347981; c=relaxed/simple;
	bh=vJDg156xDbHiFBc2HkJHcAvsBnrz0LlE9fmMNpCgXuk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JDxAViKa3Y3HNRsS3461IX4l7CCwvo6LoUIf2o9dLqebTAVwHfBbimuMQgrDiQ9bcOW12J3G5/VykUC+XLCtx9GMxL+Al5pnL+6ByGkVW+/pSNeWzPORq8N8KcWvJp1nottHJG/wze516ylY26if12Ee26RhFDX4Cb6sp3v5EAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=udd7Vot1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA6C4CEE2;
	Fri, 11 Apr 2025 05:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744347979;
	bh=vJDg156xDbHiFBc2HkJHcAvsBnrz0LlE9fmMNpCgXuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udd7Vot1d91cmE9l1YiWBC4Dpwq9GRa3cyguds5yLksbeH+ka4qJiHtlZPcV7dxiz
	 PTqsv4jKvTF24ekQUZuli8taGYj+db6x4dVwLr2JectjKgKm5IHXr7co+cVzpUzR0V
	 U8uct76BUcBbAnEmI9p0CAYRJmya6upqIFP5rUQY=
Date: Thu, 10 Apr 2025 22:06:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long
 <llong@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-Id: <20250410220618.405d00875ca61043c4ffa6e1@linux-foundation.org>
In-Reply-To: <20250410210623.1016767-1-shakeel.butt@linux.dev>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 14:06:23 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> The function memcg_hotplug_cpu_dead works on the stock of a remote dead
> CPU and drain_obj_stock works on the given stock instead of local stock,
> so there is no need to take local stock_lock anymore.
> 
> @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  
>  	stock = &per_cpu(memcg_stock, cpu);
>  
> -	/* drain_obj_stock requires stock_lock */
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> -	drain_obj_stock(stock);
> -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	local_irq_save(flag);
> +	/* stock of a remote dead cpu, no need for stock_lock. */
> +	__drain_obj_stock(stock);
> +	local_irq_restore(flag);
>  

s/flag/flags/

Obviously what-i-got isn't what-you-tested.  Please check what happened
here,

