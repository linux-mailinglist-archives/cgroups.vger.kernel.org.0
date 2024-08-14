Return-Path: <cgroups+bounces-4247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0298951637
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE2E283DA7
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD913D518;
	Wed, 14 Aug 2024 08:10:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A6381D4;
	Wed, 14 Aug 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623006; cv=none; b=bH6CPzXjAMgj6e6pOmzRssGTkhUXHwxqrXwlzOct+lKrVvobQ5rFv6IADKu+7QQCev4JWFfDWUhrW+0QKcxfyp7g5Cavyal9E69yd7IAZXDaQ+MXFAMPpRqEODMWV1Tu6MBReiUCMQqyOq/pR4J1JXbIBVQMgr3zd8IDaZMPZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623006; c=relaxed/simple;
	bh=qXAfBeVt1rlHSXfZpWFX1g81HBiDbsqPNxF5fCeW5cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tn2slte3bw81/d89Fo69KTq8Dgcj1wLdLEDOQW8rIXnGKFBZO5jIG3RtvEjISpOrjy7WKRanAFR4HKHOPtgB8oK3F5OfSLVP+3L9q4IAvsCYBJ3SxtNtEihXwq34h8KpmZUYY8txBI2kOp8guuuUSvmMPFBvEJLqFXig4r+H1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkLQY1dFXz2Cm85;
	Wed, 14 Aug 2024 16:05:09 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 1782B1402E1;
	Wed, 14 Aug 2024 16:10:01 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 14 Aug
 2024 16:10:00 +0800
Message-ID: <e3bc3535-39af-4993-af29-bd4bd688d984@huawei.com>
Date: Wed, 14 Aug 2024 16:09:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>
CC: <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <longman@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
 <ex5gnhcoobbw74se4uchhqj2lsrcjx5bsh6m5lva2xmujv7uae@34vwukkwhkbc>
 <ZrutqDox2rrr7dlA@slm.duckdns.org>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ZrutqDox2rrr7dlA@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/14 3:02, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 12, 2024 at 06:57:06PM +0200, Michal Koutný wrote:
> ...
>> You could also have increased the ancestral limit (if there was any)
>> echo max > dlgt_grp_ns/pids.max // similarly allowed
>>
>> If you're a root (or otherwise have sufficient permissions) and you can
>> _see_ an ancestral cgroup, you can write to its attributes according to
>> permissions. Thus the delegation works via cgroup ns (in)visibility but
>> cgroup ns root is visible on both sides of the boundary hence the extra
>> check.
> 
> Yeah, the intended usage scenario w/ NS delegation is that the delegatee
> won't be able to see the ancetral cgroups beyond the delegation point. Chen,
> is this from an actual usecase? If so, can you describe what's going on?
> 
> Thanks.
> 
Hi，TJ， We plan to use delegation in cgroup-v2, so I am conducting some 
tests.
As doc mentions 'Because the resource control interface files in a given 
directory control the distribution of the parent's resources, the 
delegatee shouldn't be allowed to write to them.' However I found a root 
can write parent's file(cgroup.subtree_control) to change the resource 
limits(a fraudulent method). I believe this could pose a risk in some 
scenarios where a root enters a new cgroup ns without unmounting 
original cgroup system, and it can break limitations. For instance, 
running a docker with --privileged, could this be a risk?

So I sent this patch to discuss whether this case should be addressed?

Thanks,
Ridong

