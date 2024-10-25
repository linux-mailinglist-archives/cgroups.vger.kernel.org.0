Return-Path: <cgroups+bounces-5264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A509B0BD8
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCD289B1B
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B21420C337;
	Fri, 25 Oct 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BSG50F8n"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95E20C320
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878015; cv=none; b=JW4azruxwA5GSNuoduOZM4oa/HXobrovH9tV/SnkiX7ZYk4vv/eqVMBrXhKkzNM/NjLtPpg/kkn1crK/wRX+JbrkWBWcnyoBS9r2cGjN0kAmhHHcAEVGLQJVmHNnVWKElC+g+BpDfgH25J4oixp1R1mql3tWFFf3pQ0M3vnzQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878015; c=relaxed/simple;
	bh=WxABe0ODP9+tc7RWru00ngU4k6HAkpEIiqJSF16oZ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCeXeM80rv2B4ZKoN3mWIwzrYJLP+Zng5Hqx1yZdz4j7bJ8XanuVJYd/aNIEY4wTClsFM7KzSDMjVWQWwv96GSSo7dMnUSYqjpO+/uVcGzX14P8TVtlZP8sqUMLRa/JBCTOO3TJXlnH1FF3jR5TQkCRKznufT81hFKodNN+zZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BSG50F8n; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 17:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729878007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dcekPzptXu2Fit7kcwKSnrnPY3JMJ5n+1FOAhs4EjkY=;
	b=BSG50F8nNJFwIP2DRr5E9g3QeSfO79EOlCwbOsKQiM4/XfCZW08d52HYnmckw4xI0lrsiT
	y/hJc6ukinpgujfZLtpMWlwdC0kZ/U+SEeszSY8Qxq8tNrA0deSfpuDaNQMm5Ezysugq9k
	K2PFjzmPw6xvhkctROblz/KSSNWUu0Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 3/6] memcg-v1: no need for memcg locking for dirty
 tracking
Message-ID: <ZxvX8beTxGhRj8G3@google.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-4-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:23:00PM -0700, Shakeel Butt wrote:
> During the era of memcg charge migration, the kernel has to be make sure
> that the dirty stat updates do not race with the charge migration.
> Otherwise it might update the dirty stats of the wrong memcg. Now with
> the memcg charge migration deprecated, there is no more race for dirty
> stat updates and the previous locking can be removed.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

