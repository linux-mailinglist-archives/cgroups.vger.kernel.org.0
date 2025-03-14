Return-Path: <cgroups+bounces-7069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E27A60FEE
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A26461F2C
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82E1FDE09;
	Fri, 14 Mar 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xM8cFvE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5i0oLDcP"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FA1FDA66;
	Fri, 14 Mar 2025 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951598; cv=none; b=m4DggXazHGqrjZMDe4KiZyStJ+su4iPoW7i098XlEeF7a/GUrB9ljaqHBQeTdBT7+Gbp8wz9Ori5Qnv3PfK3Ime4ws8V92V0VytooNzTYNkm6GTYCdRjrJeW4SW9qEkbF1YBC56yofg/t5U0KUjxk0XSucI1Xv7mJsHzEQbOVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951598; c=relaxed/simple;
	bh=UjP2q5iXkPqFQQkzbG6qXXtRa12fV24cyM4Y/vqKPzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXopYtelUPl7//2FRisO4FiwyZh1fsDqSuAyUsIEgPOqVhjeoZUb3hBiieDbYw1N1X1QdH9fC/PbRH1egq8BQSRpJin9nTZ9X74n+Gkdmxy+7zKneNhUZWVbJUxHdDtzXmD7hZ2Z+13uiJbn+atYsOtPbd187UUrlPq3g01fFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xM8cFvE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5i0oLDcP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:26:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741951588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbKYjA9SVhaxm7sXHvounFWAXV9u7juv1r8koG8xUvc=;
	b=1xM8cFvEFiF65OuR9V/ekQ71vCryl2riVCfFmRM1/x9EKQIe2mYdSLpR/ODzlVpW/9uEeu
	QsIVvhyCldUpI/YDPtTx8qnzQ0U2fpN9JLoPXmPpfQ6d5Jca/VpP+jZzf0vrCx5Q32voIU
	UdsA2dCvkQREGaxDQh8OJ4AuAYiG6uUoiMaBg4XG7oy9vw8kGGNZmSlosJ5Eyi0X7KLHB1
	dbonBDZnxZiClHm+vZ0A5uxYDsSiKmboAZ9Kpcn9htr0W3VtGJauwPRiYvhKZLJ/+GsixP
	apm4oeRDseB7/dEP8hm82XeOc3yicvCCA/odquVHkz8VXYhvzS0Sy7wlPHRFtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741951588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbKYjA9SVhaxm7sXHvounFWAXV9u7juv1r8koG8xUvc=;
	b=5i0oLDcPq477lNZkULp774DDX1tbW5zxOX5PMAwhAdu+Gn8h1h97wkXmG84JkaoHRtJZ8s
	8d4uRk3HmUnBfnAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 05/10] memcg: no refilling stock from
 obj_cgroup_release
Message-ID: <20250314112627.dPKeawXj@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314061511.1308152-6-shakeel.butt@linux.dev>

On 2025-03-13 23:15:06 [-0700], Shakeel Butt wrote:
> obj_cgroup_release is called when all the references to the objcg has

"references to the objcg have"

> been released i.e. no more memory objects are pointing to it. Most
> probably objcg->memcg will be pointing to some ancestor memcg and at the
> moment, in obj_cgroup_release, the kernel call
> obj_cgroup_uncharge_pages() to uncharge last remaining memory.

This sounds somehow funny. I think the point is to uncharge the pages
without tampering memcg_stock because it is unnecessary.

> However obj_cgroup_uncharge_pages() refills the local stock. There is
> no need to refill the local stock with some ancestor memcg and flush the
> local stock. In addition this removes the requirement to only call
> obj_cgroup_put() outside of local_lock.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Sebastian

