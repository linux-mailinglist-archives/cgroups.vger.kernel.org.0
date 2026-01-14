Return-Path: <cgroups+bounces-13171-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AAD1DBA7
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFF030213DB
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426536BCE4;
	Wed, 14 Jan 2026 09:51:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032E3612E2;
	Wed, 14 Jan 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384273; cv=none; b=FtZA/4N1Wr9t+KM9TovvD+JOTVjedU0PeZKXolB5Oni7XYURrbODwAYkxmBA32gw2vRyptwuEn9ZZkgvns68kEUqRvTdOCupCI9GWGPwb8ES5eBADF4QnZkxnstNqxf4YQOhxNxlbWexC99CEkLHLq/0bLM8+jV4w4shvxwKCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384273; c=relaxed/simple;
	bh=CM/VOhg1ORhSkNVFV7NhnbVBHahMQBnNYzlfKyT89tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IId4htYupaxKLTZivc94CaigBMpMLbnfGgl7IZRqvLu926qNy0L1W0xYmT150zMhGL4dKRB1mBQrp5o9mA6LDYpMM6oHfhqAVwYtHXw90KqPmL8uN1qr8DbUlVx3WzPnlU+9mn7yTntTSvEV/9R1dFk0Ol2S62889wwEnWNhDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4drhFN1pKHzYQtg4;
	Wed, 14 Jan 2026 17:50:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA12C40577;
	Wed, 14 Jan 2026 17:51:01 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB31_cEZ2dp5QYPDw--.36280S2;
	Wed, 14 Jan 2026 17:51:01 +0800 (CST)
Message-ID: <d1324713-0a55-44de-aaf8-52cb8477d65d@huaweicloud.com>
Date: Wed, 14 Jan 2026 17:51:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Chen Ridong as cpuset reviewer
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260114045435.655951-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260114045435.655951-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB31_cEZ2dp5QYPDw--.36280S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryxGw4kCw4UCr13CrW3KFg_yoW3ZFX_Cw
	4rGry29F4rCF1IqwsYqF9aya1YkrW7JF1fW3Z8tw47Xa4DXFn7twn3tas8Kr4DAFyxWrWD
	uF93JFZYgrW3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/14 12:54, Waiman Long wrote:
> Add Chen Ridong as a reviewer for the cpuset cgroup subsystem.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d701a4d5b00e..9c79da17b438 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6402,6 +6402,7 @@ F:	include/linux/blk-cgroup.h
>  
>  CONTROL GROUP - CPUSET
>  M:	Waiman Long <longman@redhat.com>
> +R:	Chen Ridong <chenridong@huaweicloud.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git

Thanks, my pleasure.

I'll be more proactive in contributing to the community.

Acked-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


