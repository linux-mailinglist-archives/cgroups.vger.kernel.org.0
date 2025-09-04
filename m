Return-Path: <cgroups+bounces-9714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C4B44A95
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 01:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD955473E4
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDC62EF65E;
	Thu,  4 Sep 2025 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjLypLiX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3A23507B
	for <cgroups@vger.kernel.org>; Thu,  4 Sep 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030148; cv=none; b=QkQMCHA5gTqT35PuqzKWAJQio33QEFRYZcAqjidsEsbuC+Yq5qOJfnVYttjhr2OMq8fdM9hlbVrLjXVTAfNSk8AhB+kzzg223/jfX4DjCYgL5hD3yeGAHt0zMr1aEmhpkZZqgRppMohZ/rl7K0WpkluYy3PORS1aPDv+oIYDVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030148; c=relaxed/simple;
	bh=e37MCHj4Ap7Be7HxFpu8iiHLdEXuvOo7oCxCgQr0ok4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQIwxKm57MkHOTQ3Ku0E7fKeYZNb/yT+2lcJFuuc4hb33pgPTXI5G5UUmq2UwAyLr0CUBaSRHmzXl7HGEB+3UpsLVVM8gv9CLAP/5BVLfP7fE7XBmXWB//ezW+EWkeMRKs63KtwqNOfL0VLP87dUax5oII+dpCfEfjBor2HgW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjLypLiX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757030144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pr14zv5u5Jg6s/TCR/mvY66VjHG8LpXuYMxg29uTMM=;
	b=YjLypLiXD6Ir2BWcVk0EcnqrPhfP+qYVCFd0BIO7aArwCRf3O5lYAuHvbK8RelTuh5bvTa
	3+YOoTZrVaKX8jWRIoUdj6YyYeEpTDCGFfI+mMnYRzHO9vrOkIQGf4HwxfQBz4eetrs0Zf
	dDEgi9Tb2Pi8clsCkKVVeCc5kDD58eA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/cgroup: rm unused MEMCG_EVENTS macro
Message-ID: <izkhad3p62zbja2olzuqhsgbusbq5bfam5w7wsonand6ti3foo@gcc5xqhnfaac>
References: <20250903073100.2477-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903073100.2477-1-zhangjiao2@cmss.chinamobile.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 03, 2025 at 03:30:59PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> MEMCG_EVENTS is never referenced in the code. Just remove it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

