Return-Path: <cgroups+bounces-12462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44DCC9E29
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 01:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4B74301A728
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC81514E4;
	Thu, 18 Dec 2025 00:31:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311A3A1E64;
	Thu, 18 Dec 2025 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766017861; cv=none; b=qTLKLQAfqCd9Y1W2iSWgSN6EfG+5UAi/9BKkj7f+5Fc3I1mHDj+9zZP4nrTICh9jYok8NR1+v235Kyuu53Z8iF2riOatCMJcbF0WpyaGqDUVIIgr4ckhLgFedT8znyZYkgZ8jmoq6HTx5oNTwr1K7JTrJ94JPYERUf4noqcMiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766017861; c=relaxed/simple;
	bh=1B+qcfk1QbUHZK6mYe+pSkXnuCMhW5zEmRqwM5OzY8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ER9jYfIx8bda8MrOQlWKBy9fhOIfDIKu4WVt1IbiE+TksPQ5g7j8TAmdZ87NFBhw1g3pph2lFwVaSuMcKkPUskMrFikWTxZYeezxcgX9TYJx+wWFAkNF/jNAlBiuxQBMBXn2yMS9JyFdRV/09moHo7LZzG2sOpxRwTbIWHe3uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWs5J6x8VzYQtdp;
	Thu, 18 Dec 2025 08:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AC63E4058A;
	Thu, 18 Dec 2025 08:30:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB31_c_S0NpofFFAg--.7531S2;
	Thu, 18 Dec 2025 08:30:56 +0800 (CST)
Message-ID: <ab263a0c-8573-4297-ae08-f68b58dd4d55@huaweicloud.com>
Date: Thu, 18 Dec 2025 08:30:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: fix warning when disabling remote partition
To: Tejun Heo <tj@kernel.org>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20251127030450.1611804-1-chenridong@huaweicloud.com>
 <5cbfe54e-846a-4303-bb34-3a7b64a174f3@huaweicloud.com>
 <aULeLTUTnebo4GBc@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aULeLTUTnebo4GBc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB31_c_S0NpofFFAg--.7531S2
X-Coremail-Antispam: 1UD129KBjvdXoWrAF1ktrW8AF4UAr4UZFWUJwb_yoWxWrX_Xw
	40vw4qk343WrWI93yIyFnakFZ7Ca47Zr98tas5Ja15AFySqFZ7Zrna93409r95A3yfArW7
	Zwn5JFZ8uFy3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 0:45, Tejun Heo wrote:
> On Wed, Dec 17, 2025 at 09:10:07AM +0800, Chen Ridong wrote:
>>> Fixes: 4449b1ce46bf ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition")
>>
>> Fixes: f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier()
>> handle remote partition")
>>
>> Apologies, the correct fixes commit id should be f62a5d39368e. The earlier one might be from stale
>> code in my local repository.
> 
> Can you resend with the commit fixed and reviewed-by tag added?
> 
> Thanks.
> 

Sure. will resend.

-- 
Best regards,
Ridong


