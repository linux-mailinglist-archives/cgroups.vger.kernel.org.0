Return-Path: <cgroups+bounces-13170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B0BD1CCE0
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 08:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1066530127A7
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB935CB76;
	Wed, 14 Jan 2026 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZ+rBRv0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAA35E537
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375320; cv=none; b=UPy1r3fPXkUuZSC8BvpTSrcP/eC8YxTP9qA8c+geTwAFCAIFEREO6shny6Wdp2ea5pCAzaOQwHssGuQiRyTRjgSOQW0TTwZMb9BIW4NMW7HgOgAR/hZgEpuXlJTsdQIurwLqqbpA7EPgu14nCDEQOKmCp9kSLwEaELw31PvsFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375320; c=relaxed/simple;
	bh=erDNYbSTG1g3IsDfFXFlDnRa3gLj02cBtpsRCIAc4Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz0gEE462fafHo92oAsuy68mLjSWN/KcVvnSbzMbbE5/G9P4G8vcukTT/gWTKzA2fFfha7zo5UeYFN2+DCnsFD23CrjMzENlIR2zvTmp1Vng+P/kuI+X2JJ9XDa3PAnB96roPP1kY+sKwT4en0G2q9BFVWA+t2CeH5V9dQEFA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZ+rBRv0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70686841-393b-47e6-b859-c2c07c273569@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768375310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0Y4zcNSVFbhgGtcesaqg9kuOlXT3wYJjn3Sc9JbeAs=;
	b=qZ+rBRv0vleQrxZd3mmQRXYExt58TgFeLWRUXsrpCfXmOURY+Q/lH+bKMnWiQPkNVpPtEx
	xWEJ8/R8calcY+rGpgCcrQ3nOkzCxcjqWslqQtG8Tp70Citz+0C0fX4q7ckS/5EolICodk
	KZ56oV0f3a6N09FjxCi35d6h71pASzM=
Date: Wed, 14 Jan 2026 15:21:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org, hughd@google.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <aWUDXtsdnk0gFueK@tiehlicka> <7c47ff99-4626-46ec-b2f1-f236cdc4ced1@linux.dev>
 <oo7re4nov5jar6nzu7awvbwlclh6esp3mltiflylzltjt57dca@jbt3hs7kgb7i>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <oo7re4nov5jar6nzu7awvbwlclh6esp3mltiflylzltjt57dca@jbt3hs7kgb7i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/14/26 2:02 AM, Shakeel Butt wrote:
> Hi Qi,
> 
> On Tue, Jan 13, 2026 at 10:34:08AM +0800, Qi Zheng wrote:
>> Hi Michal,
>>
>> On 1/12/26 10:21 PM, Michal Hocko wrote:
>>> I can see that Johannes, Shakeel and others have done a review and also
>>> suggested some minor improvements/modifications. Are you planning to
>>
>> Yes. I'm working on them (mainly non-hierarchical stats issue reported
>> by Yosry Ahmed).
>>
>>> consolidate those and repost anytime soon?
>>
>> I'm testing it locally and will try to release v3 this week.
> 
> Please take a look at the AI review posted by Roman. IMO it does have very
> interesting comments, so at least go through them and check if those

To be honest, until an official AI bot is developed, I don't want to see
any raw AI comment results unless the sender has already reviewd them.

> makes sense. Please point out if something doesn't make sense which we
> help us to further improve the AI review process.

That makes sense, the v3 fixed some issues, so let Roman scan it again
with the AI bot based on v3.

Thanks,
Qi

> 
> thanks,
> Shakeel


