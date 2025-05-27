Return-Path: <cgroups+bounces-8358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95FAC5403
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73694A20E5
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC927FD62;
	Tue, 27 May 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V3LAt2cT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321A27E1CA;
	Tue, 27 May 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364862; cv=none; b=aUygPp7cvAGqjf9Y3QoO7qXt6qDeeYosXv0wqO8rbVUcQLCagtm0/jRrOgm6zfpYjcbDldf04z+/rF5ZnFA3PDHsOPHwb6fmtmXSJqjEQYW5ioDIiR3Pb8dcJ23DVcQWYsQLaNrt2QAK19EaYmJIbuQqiqB5TzwShCioYz9NxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364862; c=relaxed/simple;
	bh=q09drV1QvIieRDj3Wy4m4RjhA6SAaqk0Go0ylNHT83E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGC3dAjtPfQ8f1JvvkSXOjIGrd/UueZPs0fuDalTKk8g9gq2clGsIsxXgxqyH5XRW4o/QiqCDGA18OclFlO2sneafLriJtNz3gndgXyZTesmjxQ5O+86YtPF/m0vU+1+MLKv+NqBNl+W1m5Xa8AE5O2lhRN0u+fFDvPMHwsj5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V3LAt2cT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 09:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748364856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7Eb1eNV+fnCUrZVOjpa1doj7OVOazrVC783oZlElww=;
	b=V3LAt2cT1G77bgMqInkvtG2L0r9PGJojdIuvBjSb9ErjNwewzXtEzEI5joRteaHtu35Dh0
	EGIYZhxAhIsP8OSxVCaW/v7FGW6j+KPBo4BP/zhN9GwU9IY33M6LMZPgPnnP7sWFrQqAPf
	dfEpZnqX5bpdqU+784fLRfdX4/P5NSc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Usama Arif <usamaarif642@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] memcg: Always call cond_resched() after fn()
Message-ID: <zxorog2mv54v5dpl5cmmkd3j4hznyxbj435hjtbtzljwspm6mt@tj446cjrclcg>
References: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
 <ucarls72c6j7xzhdjsbb2wj5ovlzthatmh7kzwhepvudszap4h@xetgnupdm5ui>
 <aDWN9mP3wPQnwo4m@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDWN9mP3wPQnwo4m@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 27, 2025 at 03:03:34AM -0700, Breno Leitao wrote:
> 
> Not sure I followed you here. __oom_kill_process is doing the following:
> 
>   static void __oom_kill_process(struct task_struct *victim, const char *message)
>   {
> 	...
>         pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> 
> 
> Would you use a buffer to print to, and them flush it at the same time
> (with pr_err()?)
> 

Something similar to what mem_cgroup_print_oom_meminfo() does with
seq_buf.

