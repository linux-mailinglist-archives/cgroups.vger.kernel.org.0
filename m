Return-Path: <cgroups+bounces-13057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98061D10C4A
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43D03036ADD
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5A320CB6;
	Mon, 12 Jan 2026 06:56:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC5320A3E;
	Mon, 12 Jan 2026 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200963; cv=none; b=QAnTds9dIqD8b3iVey7KsOIFmiPD3UOlntsLaBw6dei5PmkYbolMq1J7NYgb7vsCpHB9L01bg7SrWBXiHdkuiEXGCC3aJ9zFwzn4beC8ft9Kk1PDuuOA91E9ooNp2jfu7wejdekjd4KUtGgnS6puz1OPrZhLopohMLC8FSayrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200963; c=relaxed/simple;
	bh=k3oWapIKJd6lxtrBmIgi8rh73j//0OA0pIvB5kE0/Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7NQsJXvhlKzKoay1J1yyOFk/DVVUNr9CQ0K5xdLgZQq4VsbN3/j3R5ELcuJ9rNvSdcegg+RP+oR7fyn9VMvZcxj9Rk6w2RX7flCOItlZxA81Hfb/RTWDiHc4oTBWmblgaI2y/lVPfeeWlz80fK6BRSXAg9aV/aVpP5IdB5CcJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dqNSK5h5gzYQtvX;
	Mon, 12 Jan 2026 14:55:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B556740539;
	Mon, 12 Jan 2026 14:55:55 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_f6mmRpqfQNDg--.29252S2;
	Mon, 12 Jan 2026 14:55:55 +0800 (CST)
Message-ID: <9d2cdae1-178f-454c-b45a-681d782c483c@huaweicloud.com>
Date: Mon, 12 Jan 2026 14:55:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: Treat cpusets in attaching as populated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, stable@vger.kernel.org,
 lujialin4@huawei.com
References: <20260109112140.992393920@linuxfoundation.org>
 <20260112024257.1073959-1-chenridong@huaweicloud.com>
 <2026011230-immovable-overripe-abfb@gregkh>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2026011230-immovable-overripe-abfb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3l_f6mmRpqfQNDg--.29252S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4DGw43GF13Ww4kZF18Zrb_yoW3Krg_ua
	17tFyDCr18J3ZFkws8AFZ8WrZFka1Fvry5JrWDX3y2qF4rJFWDGFWFy395XFyrKF4xZFs0
	g3Z0yayFyasrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YYLPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/12 14:42, Greg KH wrote:
> On Mon, Jan 12, 2026 at 02:42:57AM +0000, Chen Ridong wrote:
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I did not send this :(
> 
>> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> This is already in the 6.6.120 release.
> 
> thanks,
> 
> greg k-h

I am sorry for the confusion.

I downloaded and modified the patch, and replied.

My point is that the patch intended for the 6.6.120 release should include an adaptation.
Specifically, the following block:

[...]
 	if (!excluded_child && !cs->nr_subparts_cpus)
 		return cgroup_is_populated(cs->css.cgroup);
[...]

Should be corrected to:

 	if (!excluded_child && !cs->nr_subparts_cpus)
-		return cgroup_is_populated(cs->css.cgroup);
+		return cpuset_is_populated(cs);

-- 
Best regards,
Ridong


