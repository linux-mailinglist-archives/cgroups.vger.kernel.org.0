Return-Path: <cgroups+bounces-3300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C412914784
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA81C21F23
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED94136648;
	Mon, 24 Jun 2024 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYladxw2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE687125D6;
	Mon, 24 Jun 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225018; cv=none; b=NYkHJ+E/o27EoLXqNPrG1BHBnipj5ZFocVQ3F4K/ftpXMF0riQ3M6EqlScGaTpxv6IlGVt4itc7kWU/nqtGVUg2KnKBJNxEeCYq4DWB7om8+bmOHc1u3sOlqEKyicQnKac5CC2xxysvphenyX8S2Ys1LHiudQJyWzCAQS6QeEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225018; c=relaxed/simple;
	bh=BhXMYPQ/+WmfR8YCkca+YfLTakDZXtfzOYcByJxFw4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9ctja27FgChUPrHEXmtchHHtXdZQ939fLdh7+nQl2ZmiYXsGQQcSNFvgHzyjBKycz0E2NXQIyQUOPbSsoV0ksXUJPN7q/M5peeJB1mzl8hwSYQK6p93aBWFKqnM6hfAITm9GwK3++Neo9IPiGzsEgoF1GqeT+c9Hk1nElzJffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYladxw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A148C2BBFC;
	Mon, 24 Jun 2024 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719225018;
	bh=BhXMYPQ/+WmfR8YCkca+YfLTakDZXtfzOYcByJxFw4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IYladxw2/FPfs/DZrCRC8LUMt6ManHKUelxki/tXBBGUV3GQq0tk7VSP4htkq2r3d
	 bkUH02KJn1wbHlBYgzhWOi1rIlr+4qWLl9ErjXulKY884qkfRFne1kU67d+lyqe/ES
	 UyB+PGtZ8Zu3+YL4BDRZLUHP4zt7v+f1eSixxgxtAekyCh21oEvcHNjBfDUiCyRTZM
	 y/7t3Sj0Wy8qOyf/0D4OghtHoAX153ZvN+UlNP/T+qg8ARlCKFPUdKM2415o2vgE5C
	 SbVWp5tNjNtMr4eKtm8MD0P85wL9Od7f0/kUxUMin2N52/x21ETRchYPyRkEfcoSw7
	 3KS1cG/ZuxnKQ==
Message-ID: <d6bbb201-55a0-4630-a01f-fedae8d2eb96@kernel.org>
Date: Mon, 24 Jun 2024 12:30:14 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Waiman Long <longman@redhat.com>, tj@kernel.org, cgroups@vger.kernel.org,
 yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171898037079.1222367.13467317484793748519.stgit@firesoul>
 <bb5d0ff3-c130-4f98-bac1-e3b95ddc7791@kernel.org>
 <f75c9256-1969-4b34-bc93-106581157042@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <f75c9256-1969-4b34-bc93-106581157042@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21/06/2024 17.13, Waiman Long wrote:
> On 6/21/24 10:47, Jesper Dangaard Brouer wrote:
>>
>> Hold off applying this patch, as test kernel didn't boot with this patch
>> applied on top of TJ's cgroup tree (on commit ec9eeb89e60d86).  I don't
>> know if this is related to this patch or not.
> 
> Commit ec9eeb89e60d86 is just a snapshot of the Linus' tree. You should 
> use for-next/for-6.11 tag as a base.

Patch works fine when applied on branch for-6.11.
(This snapshot of the Linus' tree seems to be at fault).

I would still like feedback on, if this code (for detecting "root" cgrp) 
is correct? :

  static inline bool cgroup_is_root(struct cgroup *cgrp)
  {
	return cgroup_parent(cgrp) == NULL;
  }


Next step for me is to backport and deploy this on a subset of 
production servers.

--Jesper

