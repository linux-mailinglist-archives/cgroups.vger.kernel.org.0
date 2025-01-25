Return-Path: <cgroups+bounces-6317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82841A1C055
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 02:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F141884487
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD01F9426;
	Sat, 25 Jan 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTnXbfha"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E51F941E
	for <cgroups@vger.kernel.org>; Sat, 25 Jan 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737769046; cv=none; b=W9tydg5k7L4X/Jct/Q/VaY6m4IGomuIs8E6srWINSlwnuwUXPBZjWy8U80Ka50Vrpd7CnZYrZkOip/JO7Dee2KISNnQO7rPewaZv2ZWBFZTTrmzweBX9IWgOOivcqxCzYX5N9cTvrOOjlgqHIzXMgQghb0o7AFm/st/jgM2MNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737769046; c=relaxed/simple;
	bh=n0KTFJjPRMfNxTNH/Gf3N7+KaNmAN/obghlC9sgW0ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7dvYy7hY5af1oyhji8nSTXeQX5ycAWMON3zHutQ9taLhEyhBCHfNhYi+9td2kNZjN6aUO0UGmuIPsQhyGvP3GzuT1cDFx0t2QcYPeB6BjCWA6bDw93xgv4Y5dEOlSNwjZUABZFae9VcRdW1fxJcgicaPzY/5mTa8uCNukpP1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTnXbfha; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 25 Jan 2025 01:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737769042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V//+ZdAY+sFPw1YUOl1H/GELFvYtZprdA3qTBnYdUJY=;
	b=bTnXbfhakmWEIJWg06WxiwejElGIZRo4OEJrSt2oHMJLYUEn5oetcJoiP1uoOWVnqA2Tpk
	Re1On2FUG/7uVhJhq0rDjUFZ3kZ0bUnhXs1hSyoQmrNQaeqaY1a4c9hC9Cjy2q1/3UkolR
	j43dehL0RPNRbvGA2Z3v+7433xutNYw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v4 next 4/4] memcg: add CONFIG_MEMCG_V1 for 'local'
 functions
Message-ID: <Z5RATUsipI9qtPg_@google.com>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
 <20250124073514.2375622-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124073514.2375622-5-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 07:35:14AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Add CONFIG_MEMCG_V1 for the 'local' functions, which are only used in
> memcg v1, so that they won't be built for v2.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>


