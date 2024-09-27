Return-Path: <cgroups+bounces-4964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36523987FAB
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675B81C22FEF
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451D17E014;
	Fri, 27 Sep 2024 07:45:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85D208D7;
	Fri, 27 Sep 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423124; cv=none; b=fQL3kYhOmtGFK3JYlIQ/RoF5H8cvdb6/gEutJS5+XOGy/qleiKnrAEetJNBQZkJ+Eam4CHvePOpx6B5lAscvMfZkbhX3Np61eHFaRTiynZpqSEI+SrhiJn26SJRHpZxLVOF+moATuk3JkdxnIybUa4B/i0ChUEAP69AudwMH4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423124; c=relaxed/simple;
	bh=ypXZmQ6dKOwdo+1jgOYy9lN6chCL2pA6F1O+NZ0qugw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMGMrtbOFfycq6vGM1mBxV9N1Jf5vH6FlinGGsyXRMfyw1Pvl7YzwuZmnwD9O96jXX/w/tr5tSldoI4WQklHR88O+cutMWaCDURHn1R1c3z93+8vx5gajnpbnwtGOa63S61NOGaJ891zW9cG3/pXsPa/yBReXTD8kbJOcjIil0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFMv02XGFz4f3jJ1;
	Fri, 27 Sep 2024 15:45:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A72791A0D44;
	Fri, 27 Sep 2024 15:45:16 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCH24eLYvZmVXyTCQ--.18822S2;
	Fri, 27 Sep 2024 15:45:16 +0800 (CST)
Message-ID: <c7bcf377-c386-41cd-8268-7b6f8cb251fd@huaweicloud.com>
Date: Fri, 27 Sep 2024 15:45:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-2-chenridong@huaweicloud.com>
 <24rp7n32rtzdszc7zxwmeitfmtib5yu7wo432b7uxjkvbdtrxp@kemt7l74yich>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <24rp7n32rtzdszc7zxwmeitfmtib5yu7wo432b7uxjkvbdtrxp@kemt7l74yich>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCH24eLYvZmVXyTCQ--.18822S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1fWF1fGryxCF4kGFWrGrg_yoWfZrb_Wa
	yIkwn2k3yrCay2gw1Iq39xXrWkCF48JryUWwn5Gr47Gw1fWw4DWa97Jrn3Za4UZa1vyasr
	uFZxWa42qr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/26 20:49, Michal Koutný wrote:
> Hello.
> 
> On Mon, Sep 23, 2024 at 11:43:50AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> +static int __init cgroup_bpf_wq_init(void)
>> +{
>> +	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
>> +	WARN_ON_ONCE(!cgroup_bpf_destroy_wq);
>> +	return 0;
>> +}
>> +core_initcall(cgroup_bpf_wq_init);
> 
> I think hard fail (panic() if you want to avoid BUG_ON) would be
> warranted here and mere warning would leave system exposed to worse
> errors later (and _ONCE in an initcall looks unnecessary).
> 
Thank you. I think panic() is alright.

Best regards,
Ridong

> Maybe look at other global wqs. I see that returning -ENOMEM might be an
> option, however, I don't see that initcall's return value would be
> processed anywhere currently :-/
> 
> Besides this allocation failpath this is a sensible change to me.
> 
> Thanks,
> Michal


