Return-Path: <cgroups+bounces-7311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39689A79AC2
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 06:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4411D3AF1DA
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 04:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79014B959;
	Thu,  3 Apr 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jBywIYdD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A82E3387;
	Thu,  3 Apr 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743653744; cv=none; b=lhjGnZBWYVagKCPt/vOxlVkO3LhXitiqKL07hSUXiKXvOKxOsJg2h4cpROG4Ke57cD1/pfiqwB1MFEEbSoOR0wRA0CxI/v0B/O50hBFRKutAoQJY34F9AI1rGfGZe18ksJwah0xcISJBRgQqyzOmHio37pSdX4XYxM95V5j/beU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743653744; c=relaxed/simple;
	bh=cGKBxioptz7Nf5wl9y/wguPaG9HFs+hqPmKSo7At7Tw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gHrOLWfty0tDQ3idYUGryAssC6Ss9ERf2UyA3SQU3e1UUSlydQ+LpHoc5YylOqg96IR3WhDEAlAd3sCNdVuDHVf5E5BBNbtSJpws1UrfM1h4QwxM9dIqmHXSjbZqmsZ/qFLGC/prF/36ENl1oyYk2Y6L4Z4kLgs9kKeIP8enZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jBywIYdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FF2C4CEE3;
	Thu,  3 Apr 2025 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743653743;
	bh=cGKBxioptz7Nf5wl9y/wguPaG9HFs+hqPmKSo7At7Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jBywIYdDOXWFYkfEbnMHxBk604y0HTHpucz1Hi0XZzO6fzITzLsPH9TZSrR83r9oX
	 PFFNmPip+2ATDWejuZSGZc7zKpkHYsIFEcvBRw0mxeEaHU+F+/vAhMI1zFd1x5XVWT
	 kT1Q6pIiLVRZZ9Q1ZkoyKwlO/Nt0nBrxztQP87t0=
Date: Wed, 2 Apr 2025 21:15:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: Don't generate low/min events if either low/min
 or elow/emin is 0
Message-Id: <20250402211542.6bfb9ab3a6511ea26ce3cdf8@linux-foundation.org>
In-Reply-To: <20250403031212.317837-1-longman@redhat.com>
References: <20250403031212.317837-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Apr 2025 23:12:12 -0400 Waiman Long <longman@redhat.com> wrote:

> The test_memcontrol selftest consistently fails its test_memcg_low
> sub-test because of the fact that two of its test child cgroups which
> have a memmory.low of 0 or an effective memory.low of 0 still have low
> events generated for them since mem_cgroup_below_low() use the ">="
> operator when comparing to elow.
> 
> The simple fix of changing the operator to ">", however, changes the
> way memory reclaim works quite drastically leading to other failures.
> So we can't do that without some relatively riskier changes in memory
> reclaim.
> 
> Another simpler alternative is to avoid reporting below_low failure
> if either memory.low or its effective equivalent is 0 which is done
> by this patch.
> 
> With this patch applied, the test_memcg_low sub-test finishes
> successfully without failure in most cases. Though both test_memcg_low
> and test_memcg_min sub-tests may fail occasionally if the memory.current
> values fall outside of the expected ranges.
> 

Well, maybe the selftest needs to be changed?

Please describe this patch in terms of "what is wrong with the code at
present" and "how that is fixed" and "what is the impact upon
userspace".

Is this change backwardly compatible with existing userspace?

> To be consistent, similar change is appled to mem_cgroup_below_min()
> as well.

Ditto.



