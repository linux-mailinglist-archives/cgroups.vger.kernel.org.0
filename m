Return-Path: <cgroups+bounces-9255-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F27EB29A35
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 08:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FA57A7ED4
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0D3262FF3;
	Mon, 18 Aug 2025 06:54:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F6278173;
	Mon, 18 Aug 2025 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500084; cv=none; b=kFhvvt3FgLofCoSRRP7L3yaofwC5G2S67vAVXI3lOkMnUEoWg/Z5I9TSQhjxRfmiygYO/+Bx5c8h7PppcU77T1g4cCDuPmaExO8/5FefAewAbcZrgDsiO6ZK2OsrIdquWH0UdpjdgzxJu5GGvpDncQeKiEA+1xyeMF4+KtTJWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500084; c=relaxed/simple;
	bh=uKI8uIf/gDF2fVa0mNGUItUEgRf+Ku9l5lSnJnd83gk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WmumQYQUF0NAguP8YJoCRB9LNnDzW7d2zFDU5oWcoIy/XYNNmnLvXN9lbgyaGSAzjDgNu760Biwwvz7GQp+AxXFMANNX9Xof0PqThEc/ewzHLpDjkWtBH7Z8nSErVKqCI2r7xD/agy1hGqnpc03LIFK0ABY1VKAKV79z2+rswpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c53Nv5Jj7zKHNCh;
	Mon, 18 Aug 2025 14:54:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 24E801A0D81;
	Mon, 18 Aug 2025 14:54:39 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC3w7UtzqJoueoSEA--.57677S2;
	Mon, 18 Aug 2025 14:54:39 +0800 (CST)
Message-ID: <63846dd9-3b5d-4a27-be6e-754dadfa5444@huaweicloud.com>
Date: Mon, 18 Aug 2025 14:54:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 0/3] some optimization for cpuset
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818034430.1304069-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818034430.1304069-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3w7UtzqJoueoSEA--.57677S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF48Ww45Kr43uFyfZry3XFb_yoWDWFX_AF
	y8ZFy0kr15XF4xta1ayrn3JrWkKa1UCrykAFyDtr42yFn7Arn7ZF1Ut34rXr17XryfJr15
	u3s7CFn5Jw17XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/18 11:44, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This patch series contains several cpuset improvements:
> 
> 1. Decouple cpuset and tmpmasks allocation/freeing.
> 2. Add cpuset_full_[un]lock helpers.
> 
> ---
> v3:
>  - fix typos and comment errors.
>  - rename cpus_read_cpuset_[un]lock to cpuset_full_[un]lock
> 
> v2:
>  - dropped guard helper approach, nusing new helper instead.
>  - added patches for decoupling cpuset/tmpmasks allocation
> 
> Chen Ridong (3):
>   cpuset: decouple tmpmasks and cpumasks freeing in cgroup
>   cpuset: separate tmpmasks and cpuset allocation logic
>   cpuset: add helpers for cpus read and cpuset_mutex locks
> 
>  kernel/cgroup/cpuset-internal.h |   2 +
>  kernel/cgroup/cpuset-v1.c       |  12 +-
>  kernel/cgroup/cpuset.c          | 220 +++++++++++++++++---------------
>  3 files changed, 122 insertions(+), 112 deletions(-)
> 

Sorry for forgetting to update the commit message for patch 3. Please ignore this series.

-- 
Best regards,
Ridong


