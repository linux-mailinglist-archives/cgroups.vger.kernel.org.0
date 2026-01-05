Return-Path: <cgroups+bounces-12924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E9CF4E81
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 824B23003BC5
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570462248B3;
	Mon,  5 Jan 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XS1TiyVe"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9E31D36D
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632904; cv=none; b=h0zCO3ziESEEnMJwM8hVasmSpsgnp61DcAd+EEJ/mis63+eCjz1CvyvW4pIPLQv2XwA/Mp7uptAnaEn6xCdiStuPgPb3QZ67S7t54jiYTA8wbezj4QDpoYs3AqX54Tq1ojKfcFhjT77oTt4vw5mdok7g/CX6r1mC83S0UgyHt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632904; c=relaxed/simple;
	bh=P2HHutXwyjPqMpZtmAJz7SucEs3qdm12F6gplWSlie4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntV6ea8en4mQGnywok5XvfjzKgWcK5UNbCUAMZfhp9T6ArAWopC4hsQHpL1H8yDfIETSEsRF5GHdZtPQ49RAKs2C4l+w/DJS+iJ/tz4yGSQuPpF893EN2Wv2RI7w6wUlTIL7DPC6UfDyNkXMdfigFvxEnr65VUuOxgtEEO9/KQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XS1TiyVe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 Jan 2026 09:08:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767632897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/YCqX8o5v9VD26M3nxmomUHfJaSJn42QMDaxF6W4n0=;
	b=XS1TiyVeiyIyOlMjdeiI6yjCJrpmqbHF/OZAV12j10f0zr+3z8ozLOYrMzXpi+/oCW8Nmx
	FlqbEY7Cxnl7khT2W/5F7goEBLiGE6jpFL1RYXUZCK12I0NlV+0hl5FIPi6lt4LU7kPX5g
	0MwLWfCr23EzxnQbidln80Cz2RgREQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Hui Zhu <hui.zhu@linux.dev>
Subject: Re: [PATCH v2] mm/memcg: scale memory.high penalty based on refault
 recency
Message-ID: <qlzvksuvo22rrngdihyeepwhphretoenre3gvkako7kgsgw3sy@l775pvzorcdh>
References: <20251229033957.296257-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251229033957.296257-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

+Hui Zhu

Hi Jiayuan,

On Mon, Dec 29, 2025 at 11:39:55AM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Problem
> -------
> We observed an issue in production where a workload continuously
> triggering memory.high also generates massive disk IO READ, causing
> system-wide performance degradation.
> 
> This happens because memory.high penalty is currently based solely on
> the overage amount, not the actual impact of that overage:
> 
> 1. A memcg over memory.high reclaiming cold/unused pages
>    → minimal system impact, light penalty is appropriate
> 
> 2. A memcg over memory.high with hot pages being continuously
>    reclaimed and refaulted → severe IO pressure, needs heavy penalty
> 
> Both cases receive identical penalties today. Users are forced to
> combine memory.high with io.max as a workaround, but this is:
> - The wrong abstraction level (memory policy shouldn't require IO tuning)
> - Hard to configure correctly across different storage devices
> - Unintuitive for users who only want memory control
>

Thanks for raising and reporting this use-case. Overall I am supportive
of making memory.high more useful but instead of adding more more
heuristic in the kernel, I would prefer to make the enforcement of
memory.high more flexible with BPF.

At the moment, Hui Zhu is working on adding BPF support for memcg but it
is very generic and I would prefer to start with specific and real
use-case. I think your use-case is real and will be beneficial to many
other users. Can you please followup on that Hui's RFC to present your
use-case? I will also try to push the effort from the review side.

thanks,
Shakeel

