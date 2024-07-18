Return-Path: <cgroups+bounces-3776-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC493523F
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461D1283BD1
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA1145A10;
	Thu, 18 Jul 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QK8kHQfm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF27145A0A
	for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332014; cv=none; b=LzIt2dyVTYL8KtqhQFvU8rikB4kubyaLsNMaM/gqgtEbb5ekWYtAt+YJ0gxeQQ8lPjtZxpOZc1V36mHZQLVZgRlC11FIQqps9oRZr+PNmN6dC3fTVMC/KSN2HN2gWHlO7YGgv2I/b77rAgyGblaZ1W6kalS5GL7tUkcI2UFgvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332014; c=relaxed/simple;
	bh=kzWORm6SuvaebzRysuNkfCQVCvljqnpJ5Ea/vPeoqdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J88KXg2rGCWEDq48i66g+ih1zc9daQDKRDsqWKP30OZJanb4iHZmWUjOcgNyr9ocHFHHANWwXJBtYVmU7iKFT3Fff1/A/kB7BFiGC4ZhI2UjGpCwIjZx7Odgdb8NlgmHCG8EhnMbUHuUH7tpk7MgyxONq9j9Fs5DxpP7w0Cz9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QK8kHQfm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: songmuchun@bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721332008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSregXPsYAdLpJ32tUMyFkFjP1/Em/6OT6zvIe33cXk=;
	b=QK8kHQfmsi5HBkWkeLugs8bBPe2sbNzGZjHx5bRZj9DlKSzh0RAfKBtMbvrmqoLFZQRjV8
	AgFkuMucQMNm2bXMdP1NWA6dZzY1RwTriBKaIC+PmsGf8rft/nl6flYMT6pD1/mwDargiz
	6Rdn9En3DjQqwoZbdFLsPkCYG6rdxOQ=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2024 12:46:35 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmem: remove mem_cgroup_from_obj()
Message-ID: <qimvdyf5tcu5uob75mn2j6ohx64affxlhnhzxgebxwr2plfmjg@tpajkur3s2wc>
References: <20240718091821.44740-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718091821.44740-1-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 05:18:21PM GMT, Muchun Song wrote:
> There is no user of mem_cgroup_from_obj(), remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

