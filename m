Return-Path: <cgroups+bounces-11788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A5C4B57E
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18AE1891189
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAB346E60;
	Tue, 11 Nov 2025 03:38:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A52F25F6;
	Tue, 11 Nov 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832284; cv=none; b=uwWlACYzQkOqWW6X8e3DKSxVmTKNxKIV4CMhhouqvXN6uxB4cJPy3ZkrlB+cuC4JYfRsKuQj5gDq4H5YkhegAEpXFxUBY8WW12CXzcNxIs/5VgMBMUPWdipAdGEkoWHuMzEEN4vgH6nVVm+Pz/tJLBP+9x7aRy2ru2TIgMUN6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832284; c=relaxed/simple;
	bh=Ybba2l0k7Erkb/ozPV+BkPg79xuQygZLKzfbzlr6uWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2C+X2ySNYVKq3XLL5pHUkJKDDWhWwfEbCPUgah+98jOMRL9f1PjCbsEmt2Bjhl7r/RdhDZdNMAN7TVUvi1S170TcLAQoCuU7MbIy3CYnAbfyeXO3TrAhydHRmvPqmsML6SkucY1aP0RyY2Yk7KD7ifUQ1X1sAKHkinF9Cqp9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5C055dDZzYQtkc;
	Tue, 11 Nov 2025 11:37:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEDCE1A1CA1;
	Tue, 11 Nov 2025 11:37:51 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXvluOrxJpkSNWAQ--.50946S2;
	Tue, 11 Nov 2025 11:37:51 +0800 (CST)
Message-ID: <f0418b48-e529-4ae9-a267-f0ab9edf1c7b@huaweicloud.com>
Date: Tue, 11 Nov 2025 11:37:50 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cpuset: simplify node setting on error
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-2-chenridong@huaweicloud.com>
 <o3daj3fasq66buthgl3rherobjqwkemjge5xlrgfzfyvcjxyme@anbppjgrj77h>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <o3daj3fasq66buthgl3rherobjqwkemjge5xlrgfzfyvcjxyme@anbppjgrj77h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXvluOrxJpkSNWAQ--.50946S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE_
	_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/10 22:27, Michal Koutný wrote:
> On Mon, Nov 10, 2025 at 01:52:26AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> There is no need to jump to the 'done' label upon failure, as no cleanup
>> is required. Return the error code directly instead.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  kernel/cgroup/cpuset.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks.

-- 
Best regards,
Ridong


