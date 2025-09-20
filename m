Return-Path: <cgroups+bounces-10302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0FAB8BB63
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 02:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AA582BB7
	for <lists+cgroups@lfdr.de>; Sat, 20 Sep 2025 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6218EFD1;
	Sat, 20 Sep 2025 00:54:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E8189;
	Sat, 20 Sep 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329691; cv=none; b=UEdCayr1IQ5CBvXu6K9klCw5PkKzNOpTS2p1wgkQll9lQe776rOQVhFYG+8LE2/kSEINoxzKJzrZySzsTLrzFLlMZo0HbIaSAOtCczDDYgets27qGFiRsCCBu26ExkOZ0gVhtvt9elSwyQSrDC2O0xWs65EHSmeBqQbyfA+7PWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329691; c=relaxed/simple;
	bh=2QERMCIay5DkaJeIepqBAytD+sy6Xn2dPmsJuvn7FvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1ye9paqDqojYRLxTjpR0eQJvvEgkgf4XSq8X93Y0Ghc1iU5gZ3tPJi+SydKfVnOgk8/5hQNWsd/l7f+LxODFwrh3Tx/+yR8eV8tdOGmoFXxgc4VizpwkQH7l2cxPJCO76PveOLFbC8vFd96CKz+43wMnZA1fjn8wCqPjcd0BKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cT9rM2NhMzKHMY4;
	Sat, 20 Sep 2025 08:54:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 440BB1A135E;
	Sat, 20 Sep 2025 08:54:44 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAnwkBS+81oSYCsAA--.31638S2;
	Sat, 20 Sep 2025 08:54:44 +0800 (CST)
Message-ID: <391f3b14-f1ad-483e-9bef-5e6006a39e29@huaweicloud.com>
Date: Sat, 20 Sep 2025 08:54:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next] cpuset: fix missing error return in
 update_cpumask
To: Tejun Heo <tj@kernel.org>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20250917060454.2885698-9-chenridong@huaweicloud.com>
 <20250919094903.3060470-1-chenridong@huaweicloud.com>
 <aM2ITLVvzU-k9I6i@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aM2ITLVvzU-k9I6i@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnwkBS+81oSYCsAA--.31638S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrW8uF1UZF1kZFWDWw45Wrg_yoWxAwc_ur
	WSv3429r18Jw1I934a9a4UCr1kAF17Jr4DA39xtF4IqF4kAFn7KF1YvryrAFyUAFW7XrnI
	kr95GanrWw1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
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



On 2025/9/20 0:43, Tejun Heo wrote:
> On Fri, Sep 19, 2025 at 09:49:03AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The commit c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
>> inadvertently removed the error return when cpus_allowed_validate_change()
>> fails. This patch restores the proper error handling by returning retval
>> when the validation check fails.
>>
>> Fixes: c6366739804f ("cpuset: refactor cpus_allowed_validate_change")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Applied to cgroup/for-6.18.
> 
> Thanks.
> 

Thank you very much.

-- 
Best regards,
Ridong


