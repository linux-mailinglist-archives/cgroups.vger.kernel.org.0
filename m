Return-Path: <cgroups+bounces-12484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF28CCB0DA
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E0930198C1
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C92F12C1;
	Thu, 18 Dec 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEpxZX6W"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130F185955;
	Thu, 18 Dec 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048440; cv=none; b=Kz2ODYaqAE6RCEtwWlag64a1z++9i0XI0V69kg8sKdo9RsKMu/hgLO5KGfGJI274CJoHOyPdIFc8g4vvdnHaLI+C9lHjdzIdWexqM1eGIXfPt3yC4mU1KRn2YgJ7c/+exCsGDBV90sicg09ayaV96MGU2JsXy3sIAmkdVyOac/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048440; c=relaxed/simple;
	bh=/0/rtcS385uWstxYx5vQaAZ1klTP2bjSTEEUQbZkcz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1swbuQysAalajGlRiEq0PSLtUUJb566KM2E0bNXJf7MlrNUHKzdiT4QAF47FUG2XByyO1Qhc0ljKSimMSyJ8PMRftkcWGutv7aKmcr+w+x1to4pJId1ZKjmbtUpmpkMnFak5db06hdFNBGCsEIhyr4kZDfCgXyHJ+WmTnGVof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEpxZX6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C743C4CEFB;
	Thu, 18 Dec 2025 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766048439;
	bh=/0/rtcS385uWstxYx5vQaAZ1klTP2bjSTEEUQbZkcz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jEpxZX6WcT4c7dWdMrJJZpdtGqPgJ8kMu4eIg1pFdkUP+oikEB4UsfBdrDdRQ2WGq
	 eBwrStNELBsyZOLBGrYdgsazW4zjFXww8ESHIe53dWMjSRMRWXLUtSvdIgRhaKcKve
	 CWFO/IKhnR1dsTN9uYixAyq9l6iegYeCC9xYw6eK6WsG31Dmr7rqY5NMoOB4Wahsn+
	 7/4RZGYWhk2BTmp5762UMBy/r8xGPpGwHT/MH/mztp7G7HzQi5cbBaZe4wFhAuunxX
	 bkES8QgTQQsL8V80bh9TZPh//h3rlTDHcF8zQn/Dhpy8FowhtYr2Cfr63FCUtqTr5j
	 5cH3r6C2E0XQQ==
Message-ID: <bf97a657-f12e-401a-bf19-09223ae768be@kernel.org>
Date: Thu, 18 Dec 2025 10:00:31 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/28] mm: rename unlock_page_lruvec_irq and its
 variants
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Chen Ridong <chenridong@huawei.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <a11ca717ddd52fd83e1fff9942fc49c9c5c5b78c.1765956025.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <a11ca717ddd52fd83e1fff9942fc49c9c5c5b78c.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 08:27, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> It is inappropriate to use folio_lruvec_lock() variants in conjunction
> with unlock_page_lruvec() variants, as this involves the inconsistent
> operation of locking a folio while unlocking a page. To rectify this, the
> functions unlock_page_lruvec{_irq, _irqrestore} are renamed to
> lruvec_unlock{_irq,_irqrestore}.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Chen Ridong <chenridong@huawei.com>
> ---

Nice cleanup

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

