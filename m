Return-Path: <cgroups+bounces-4858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6359975E90
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 03:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A951C226F8
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0AE250EC;
	Thu, 12 Sep 2024 01:33:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684115684;
	Thu, 12 Sep 2024 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104810; cv=none; b=cfq75SxBPEPCpJWLSqjq8Ar8UHLUbp3/PN4DdRGLpiYGBIGeiNWmIenfmwrMZA/yH2xWkBxNpgwgJVtTxqjHAQXNzjUWSxSzH3VSDhHzOR6h2c8QyJItEdnYSPDQimfSQYlX73KGDTiCH3tql4qR1+bn0IIvtHRH0TfuUN8l/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104810; c=relaxed/simple;
	bh=jHmJWTrEqPsqScYuqYapWqJNq9LsR2bNW6C0fjjRqJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZiFcrNAoJPSOVzs6Na6QIbvqenvelelvOaodDyC7BVFOp2wLZOB92etf0y2eZPdVCsOBUpe/Y8z4p/fC1KjgFIzMjCcQj7Z0wz7xsU0A6LqaIDe8W73DtBcuCR9JuxZwvE2nE5BGzTnewCnXoDSKR7ODO+jMXTHBcaEPP10Eu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X40Ls0Tsyz4f3kvP;
	Thu, 12 Sep 2024 09:33:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 555221A172E;
	Thu, 12 Sep 2024 09:33:25 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDnHMnjROJmEMNLBA--.2713S2;
	Thu, 12 Sep 2024 09:33:25 +0800 (CST)
Message-ID: <83cea8c6-d2f8-42f2-990e-80412ebf296e@huaweicloud.com>
Date: Thu, 12 Sep 2024 09:33:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, bpf@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
 <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
 <ZuC0A98pxYc3TODM@google.com> <ZuC3femqBNufgX1D@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZuC3femqBNufgX1D@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnHMnjROJmEMNLBA--.2713S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWDJry3tw4DGw4UXryUtrb_yoWDurb_W3
	92vr1DC3yUGFW5uw1qkFZ3WFWxXrZY9r1DX34DJwnrWw1Yyr43CryDXFy3X3Z8WFWrJrnI
	gF90q34qvasrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIks
	gUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/11 5:17, Tejun Heo wrote:
> On Tue, Sep 10, 2024 at 09:02:59PM +0000, Roman Gushchin wrote:
> ...
>>>> By that reasoning any holder of cgroup_mutex on system_wq makes system
>>>> susceptible to a deadlock (in presence of cpu_hotplug_lock waiting
>>>> writers + cpuset operations). And the two work items must meet in same
>>>> worker's processing hence probability is low (zero?) with less than
>>>> WQ_DFL_ACTIVE items.
>>
>> Right, I'm on the same page. Should we document then somewhere that
>> the cgroup mutex can't be locked from a system wq context?
>>
>> I think thus will also make the Fixes tag more meaningful.
> 
> I think that's completely fine. What's not fine is saturating system_wq.
> Anything which creates a large number of concurrent work items should be
> using its own workqueue. If anything, workqueue needs to add a warning for
> saturation conditions and who are the offenders.
> 
> Thanks.
> 

I will add a patch do document that.
Should we modify WQ_DFL_ACTIVE(256 now)? Maybe 1024 is acceptable?

Best regards,
Ridong


