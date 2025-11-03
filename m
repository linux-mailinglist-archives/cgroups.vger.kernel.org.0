Return-Path: <cgroups+bounces-11487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC17C29FF4
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC013AF01A
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FEF2882DB;
	Mon,  3 Nov 2025 03:53:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A08238C1F;
	Mon,  3 Nov 2025 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142025; cv=none; b=uL9p1TM52eVba5jU5QuBID3UxnsYDESd9ei6f2YQVv9YYsaodeYDbcg6ralzUo71bN0W3ptZRFQw1LIxHm1D5EZGO2UlgJ/J+62dX2gexIiLMoNp3F8AkY1zemg4ikYsaD/1mHT7mf8ixKsuHPo9Y7sb0fg5amicj2kqeMOsCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142025; c=relaxed/simple;
	bh=ABEuAm5ARHbct024gyAww3Irg87tLgx80jwvZfDvfg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDsEhm9iayzAYZkG+Mc6yZ9BxS+GRnXo1mSXn09O72zLYadOCjqBZ1hZlIVpNUQcnghMqQxPGP7WIJ7CtP/x5hiUerF2UWMX0DxF2j0iPlWYwT3hH4XmSxarR7vA/LWquxIn4ibPo0E+4NlOEjc3d5oyCf7tcIncDDkd6mzZQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0HkJ33NszYQtrv;
	Mon,  3 Nov 2025 11:53:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 30FB31A0B27;
	Mon,  3 Nov 2025 11:53:41 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXmT5CJwhpwtUKCg--.49052S2;
	Mon, 03 Nov 2025 11:53:39 +0800 (CST)
Message-ID: <05281aa9-57c4-42c7-a17c-009d6b22943b@huaweicloud.com>
Date: Mon, 3 Nov 2025 11:53:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251103013411.239610-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXmT5CJwhpwtUKCg--.49052S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryrJrWUtrWUuFyfZF4kCrg_yoW3GwcE9r
	s7Za9ruF1DtrWUAa4DKwn5XF97K34UCrnxC34UtrZYyw1fZa17Zr1rK3sxWrWxWa4YqFyY
	9340gws09a13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3
	UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/




> +
>  	/*
>  	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>  	 * only).
> @@ -2994,7 +3055,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  		 * A change in load balance state only, no change in cpumasks.
>  		 * Need to update isolated_cpus.
>  		 */
> -		isolcpus_updated = true;
> +		if ((new_prs == PRS_ISOLATED) &&
> +		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
> +			err = PERR_HKEEPING;
> +		else
> +			isolcpus_updated = true;
>  	} else {
>  		/*
>  		 * Switching back to member is always allowed even if it

This is an issue I am trying to fix, the prstate_housekeeping_conflict check is necessary.

https://lore.kernel.org/cgroups/20251025064844.495525-2-chenridong@huaweicloud.com/

-- 
Best regards,
Ridong


