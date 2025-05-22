Return-Path: <cgroups+bounces-8307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59BAC0265
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7591BC407E
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1042AD0B;
	Thu, 22 May 2025 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Q4C3+Lhr"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193041854;
	Thu, 22 May 2025 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747880220; cv=none; b=NRuY/u8nOqoh+swj3nklNOd/IdqRrY+c0A1fsk/3ulgu6uiUiBDMxQ354oq2i/7h/pv3gtfSdq8S5UbZIfZZlogHE45D0JgGX9GubjBWqM/wIRcVTn9rWpj9Bl0WGGRbiM4gr+0S9iP92Ow7Aatb1vD5HyKHZbRl+l55uFVtfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747880220; c=relaxed/simple;
	bh=yLUmlP7DaNAVtrWCSbOK7YUSTa1ul9w87aAbB+oebN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT0G0bG0bQQCtZCJv1BbzXBwRjga1w6gLAr5WfTQvrRUunyQrWlejt19qSY+uGsoGWM2Bqn3Dcea5PNDPlcOwOC4MLRv1SogILpsiaaWIXp07BxP2ORM3av9WqivW3vRkc5wNKsl3o0Ou0EBjqILUnCJEGWRq6xmlJFAMoLP2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Q4C3+Lhr; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747880218; x=1779416218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyFEWQvfFcI7M33d2V0gAbJnT7bAeiGW1d15NiaUM58=;
  b=Q4C3+LhrGZHZtKVj/ayX7N5hwsLYGQIyuCAwZqXfzSwTYQDYVkpGwVC2
   MlQJ+ChDnek6PjecFPx2Vm75enFZb5epVErsYAPhuxZN0XeHF7DG+nQSU
   sZLxVpj+pBX3+eT0x/D3md4HiHRke63glDR2EvygNBH6mk/866Q0WNRmY
   t5SEc/Lq1i09Lu7jOOGZLZkjAAmmWsa0zYwGS7fc2jF6NeYxQ3kfXCJk8
   6oTJXRE21JajSlpm+9aeY2ZIJGj9IyppX8lfJbQ5HCR00/KHh4Y0CHrxZ
   bszTXf7ec+dXiNKX4MUtiSeTqWfO5hlxEARiyrJgQRjRWldn3DEBZaN+V
   w==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:16:55 +0900
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; 
   d="scan'208";a="532597744"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:16:56 +0900
Date: Thu, 22 May 2025 11:16:52 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v3 3/3] cgroup, docs: cpu controller's interaction with
 various scheduling policies
Message-ID: <aC6JFEBfMzsUrChn@JPC00244420>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
 <20250522-rt-and-cpu-controller-doc-v3-3-483fc9cca591@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-3-483fc9cca591@sony.com>

Hi,

On Thu, May 22, 2025 at 11:08:14AM +0900, Shashank Balaji wrote:
> +* Processes under the fair-class scheduler
> +* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
> +* Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
> +  without the ``cgroup_set_weight`` callback

Though `cgroup_set_weight` is referred to here, CONFIG_EXT_GROUP_SCHED
is not yet documented in sched-ext.rst. But I don't understand it well
enough to add that documentation myself.

Thanks

Regards,
Shashank

