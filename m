Return-Path: <cgroups+bounces-5053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3EA993C4A
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 03:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46D9285AA1
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 01:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08312E7F;
	Tue,  8 Oct 2024 01:32:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682A1388;
	Tue,  8 Oct 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351166; cv=none; b=tYFO6bxC4fVQDlrKeIo43SGz6q4F4+wxM6ZAL6xlbHIBVVPHz+xJ9FR1EINIvbir86Wld2vmdGEY3vcKJrIyZ0GiIefDg2EjCRnrM4D5r5KxrOVPidH6jFwIYVGhNHDFhMYU7mRKEl1nvXDbnUMBBfQ+Ka3CrCC0vQh5q0M3+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351166; c=relaxed/simple;
	bh=3KRvihZPuYjgBr5Wx3GSlaRyE8msdFng5koVj0+5JBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jl1w8fGt4+egIOPH2ieN5ejKUAdNMyLJsXKrQnOG5/wWgC08p83r78cIn3EQ1zu9LXNgQvNMu4L5dBN6sz1p5Cpw1YBw2+kioFhH200r6axMD9BcRhzXLcg3fTgprRwTMoha9W0ya3AKOakWoAH3YeX5ox5F8tMi7spEVsweb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XMz5x5tJXz4f3jkJ;
	Tue,  8 Oct 2024 09:32:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 848961A0A22;
	Tue,  8 Oct 2024 09:32:33 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAHiMSwiwRnULjpDQ--.47120S2;
	Tue, 08 Oct 2024 09:32:33 +0800 (CST)
Message-ID: <a7399dd5-f332-4a0e-a0a3-fcc0ba7a20bb@huaweicloud.com>
Date: Tue, 8 Oct 2024 09:32:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] workqueue: doc: Add a note saturating the
 system_wq is not permitted
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, chenridong@huawei.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
 <20240923114352.4001560-3-chenridong@huaweicloud.com>
 <ipabgusdd5zhnp5724ycc5t4vbraeblhh3ascyzmbkrxvwpqec@pdy3wk5hokru>
 <6a2f4e01-c9f5-4fb5-953e-2999e00a4b37@huaweicloud.com>
 <hk4gfwg7cua6rbcly7qzpqah7bfxbzgndgwasmsqqzsim5uxzu@ofpo4e6koms2>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <hk4gfwg7cua6rbcly7qzpqah7bfxbzgndgwasmsqqzsim5uxzu@ofpo4e6koms2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHiMSwiwRnULjpDQ--.47120S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryUuFyfArWxuw45Zr43KFg_yoWDurc_G3
	ZxZwnFka1DJ3ZFga4Syw15Za9xJry3Cr45Zw17JwsrJw1aqa4kAFs5ArWxXwn8uFWfJrnr
	C3Z0gwn0vrnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
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



On 2024/9/30 20:50, Michal Koutný wrote:
> Hi.
> 
> On Fri, Sep 27, 2024 at 04:08:26PM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> How about:
>> Note: If something may generate works frequently, it may saturate the
>> system_wq and potentially lead to deadlock. It should utilize its own
>> dedicated workqueue rather than system wq.
> 
> It doesn't depend only on generating frequency (in Tetsuo's example with
> slow works, the "high" would only be 256/s) and accurate information is
> likely only empirical, thus I'd refine it further:
> 
>> Note: If something may generate more than @max_active outstanding
>> work items (do stress test your producers), it may saturate a system
>> wq and potentially lead to deadlock. It should utilize its own
>> dedicated workqueue rather than the system wq.
> 
> (besides @max_active reference, I also changed generic system_wq to
> system wq as the surrounding text seems to refer to any of the
> system_*wq)
> 
> Michal

Thank you, Michal.
I took a week off.
I will update soon.

Best regards,
Ridong.


