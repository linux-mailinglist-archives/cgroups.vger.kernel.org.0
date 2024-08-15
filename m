Return-Path: <cgroups+bounces-4310-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C76953ADC
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 21:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C863A1C22153
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507E79B87;
	Thu, 15 Aug 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6jIaJOD"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06D6BFC7
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750053; cv=none; b=UUTSDoGvqAbmWUu8Zh4SM0c8yoQQz/CKkOah91Opxm2QHDT2d8mO8g3vte2l9ns9Uc9ig+vCJtbrEa3MQvwCY9vegM9v7w1pfQD4UpVDXkX3UPTxXZ/MxU67+ikLuQMz9cq9NrrQlQBsoeX/EXavq5IeMhmgj3GaObYT2T8L2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750053; c=relaxed/simple;
	bh=FewbRw4tUyZZjk2W84WuNf+l2RNNaOjU3ORVlGkXNyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq6RXULiRSJXWNSPAOYkX8lpoDBUWWPgcqGQI5LboLiN2TuP+C7K8HFGLZnVA22wx3YK1xvgvWwEgZaCOFkNxmP4LJB8tEZmKCQEmuDWZNGD0RRenXsmhEMLbCl9SwkDdNB6LEB7V9XGvr3slrR7/jRpPGYySew6MEZlJxcRQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6jIaJOD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Aug 2024 19:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0Xeb82lVijSqwns9NTrmpuUUH4zQ7c+TXWG5G988UM=;
	b=D6jIaJOD19nkqrqlj45gS2IKBIpTJN4auMAAmB2bJh1PlZx7/WK0Af69U4WNrooRXtBGIp
	XUYlSu/MVW4dJeG1gSddxm30scxYI6WWjhVHFrTK4F5cO45f6aA38yeFu0MzN8keFeadkd
	W/8hD1aAsytR2aKeTgjAzJ02sMFOWjA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/4] memcg: initiate deprecation of v1 features
Message-ID: <Zr5WmpgJUXe79dcz@google.com>
References: <20240814220021.3208384-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814220021.3208384-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 03:00:17PM -0700, Shakeel Butt wrote:
> Let start the deprecation process of the memcg v1 features which we
> discussed during LSFMMBPF 2024 [1]. For now add the warnings to collect
> the information on how the current users are using these features. Next
> we will work on providing better alternatives in v2 (if needed) and
> fully deprecate these features.
> 
> Link: https://lwn.net/Articles/974575 [1]
> 
> Shakeel Butt (4):
>   memcg: initiate deprecation of v1 tcp accounting
>   memcg: initiate deprecation of v1 soft limit
>   memcg: initiate deprecation of oom_control
>   memcg: initiate deprecation of pressure_level

I have a hope that we can deprecate memcg v1 altogether, but having more
information about specific v1 users won't hurt.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

