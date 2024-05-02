Return-Path: <cgroups+bounces-2753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80978BA11F
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8B2B22806
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290A17BB12;
	Thu,  2 May 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKj2j8k0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804969D2F
	for <cgroups@vger.kernel.org>; Thu,  2 May 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679089; cv=none; b=ri557hP3l7C9fjLgQMUosAxB4UZt8Lvtz1AK+grooIQIysN7YWMquj7B5kQkmJ28x46p7fgoEqse7Ywe4qwm/l8Kjg+lvNlp0vuTZs4q5NCn06s0GxXDpBu19XtToqB1W9Wxj1Pp5yGDGYSBaojdpKGat9pfa+d9wbkYVU2Rz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679089; c=relaxed/simple;
	bh=8zGHSSWgeX3X13/v3rfRrPHehaPxx5LJIehuDZvKtFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgi8MUfeSGGFBzBE/wuU1CJPEnTChhn79cvD1XzNqgGM9AbYXDdDzo9hSLP97YVy7tVZ1d/XdXb+JHvQuO0lsZikbwD+AvyUoG0zlE2hafeu4jucUhqW8GBu+4Ke39jddPFxmvGysuoMo1EjqI9BsAXM6Gl3WHImSidQzoC9Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKj2j8k0; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 2 May 2024 12:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714679085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXy8uEDsBicvdpHMXfN/I0ThXwxaeNcYWg8FzG7/WXE=;
	b=RKj2j8k0Nh7DekmpDEeLn+xd6MtCVaQizS7d4i2gc5UoTjEk4TTzm6la9XVmXl8SAqJEO/
	IUCWXfadEOzwKu0Czqg4iRTr0wf8Tuj9eth1nd0XqWggilEGL5ozRBIYkkgISdS9ahy8ct
	8QvhMQCImAiKjCsNraNE2W8Bmy1FxOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <4m3x4rtztwxctwlq2pdorgbv2hblylnuc2haz7ni4ti52n57xi@utxkr5ripqp2>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 07:22:26PM +0200, Jesper Dangaard Brouer wrote:
> 
[...]
> 
> More data, the histogram of time spend under the lock have some strange
> variation issues with a group in 4ms to 65ms area. Investigating what
> can be causeing this... which next step depend in these tracepoints.
> 
> @lock_cnt: 759146
> 
> @locked_ns:
> [1K, 2K)             499 |      |
> [2K, 4K)          206928
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [8K, 16K)          64453 |@@@@@@@@@@@@@@@@      |
> [16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@      |
> [64K, 128K)        38359 |@@@@@@@@@      |
> [128K, 256K)       46597 |@@@@@@@@@@@      |
> [256K, 512K)       32466 |@@@@@@@@      |
> [512K, 1M)          3945 |      |
> [1M, 2M)             642 |      |
> [2M, 4M)             750 |      |
> [4M, 8M)            1932 |      |
> [8M, 16M)           2114 |      |
> [16M, 32M)          1039 |      |
> [32M, 64M)           108 |      |
> 

Am I understanding correctly that 1K is 1 microsecond and 1M is 1
millisecond? Is it possible to further divide this table into update
side and flush side?


