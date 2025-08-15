Return-Path: <cgroups+bounces-9195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E2B27408
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 02:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1799189D406
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763211DE4CD;
	Fri, 15 Aug 2025 00:30:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36971D7E41;
	Fri, 15 Aug 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217829; cv=none; b=PjRFPiu/Myz2pvqxqxLtiBJyMDH33vcW0IvkUwvH0OD9rxHYPUNHfRoW6HNC8hZzZN5d3r65UY/JTL4ZWPC5N9LdLaW9uyMImozyy6JKYqJSV23GNUXOJYc0M0hUFoCLYYGfIM8Vlmk305k1jo1QuSZIOzzTOlj/TWKfCEfzfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217829; c=relaxed/simple;
	bh=vpihdFNnQtO3u3VXfH54QN6UBWoYNFvJyTb4uwpbg3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hyu/KrqSkYqOKMgtRZSV8nPP+lMak8YEb+tnxRds6OMvLNudz6J6pTbkL91e59BY0lY1G6wkmeJVE0hw/sEVswU1qyb39koO4cot4o1uAfbwkA+R0ngOmRBzDZVXH28ke+t+z3RboidbBug3ugJu3L9E0UviZ3XDuxpGMpriSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c330w2xnLzKHMsY;
	Fri, 15 Aug 2025 08:30:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B115D1A1034;
	Fri, 15 Aug 2025 08:30:23 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCXXNecf55oifGUDg--.61325S2;
	Fri, 15 Aug 2025 08:30:22 +0800 (CST)
Message-ID: <39e05402-40c7-4631-a87b-8e3747ceddc6@huaweicloud.com>
Date: Fri, 15 Aug 2025 08:30:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
 <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
 <4fdf0c5b-54ce-474a-a2c7-8b99322ff30e@huaweicloud.com>
 <btaaerpdl3bolxbysbqcig6kiccdgsoo32td64sk6yo4m5l5zy@nds6s35p6e6w>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <btaaerpdl3bolxbysbqcig6kiccdgsoo32td64sk6yo4m5l5zy@nds6s35p6e6w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXXNecf55oifGUDg--.61325S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF47ArWfWw4rCw4rCw4fAFb_yoWkKFb_uF
	srJrnIkryFyr1DWw47KrZxZrW5Ca9rCry7CFyUtrWY93s7XFn3urs8tr95Aas5ZayaqFsx
	Zw4Yy392v3sxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/14 23:17, Michal Koutný wrote:
> Hi Ridong.
> 
> On Thu, Jul 31, 2025 at 07:53:02PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> Have you come up with a better solution for this?
>> Would appreciate your thoughts when you have time.
> 
> Sorry for taking so long. (Also expect my next response here may be
> slow.)
> I tried reproducing it with the described LTP tests [1] (to get a better
> idea about what and why needs to be offlined) but I cannot bring it to a
> hang nor lockdep report. How do you launch the particular LTP tests to
> trigger this?
> 
> Thanks,
> Michal
> 
> [1]
> while true ; do
> 	/opt/ltp/testcases/bin/cgroup_fj_function.sh net_cls $pp
> 	/opt/ltp/testcases/bin/cgroup_fj_function.sh perf_event
> done
> (with pp both `;` or `&` for concurrent runs, two vCPUs)

Hi Michal,

I’ve provided details on how to reproduce the issue—it’s quite straightforward. For your reference,
here’s the link to the discussion:

https://lore.kernel.org/cgroups/btaaerpdl3bolxbysbqcig6kiccdgsoo32td64sk6yo4m5l5zy@nds6s35p6e6w/T/#m01f1229f2e84e1186abaf04378b4c0f47151f7e4

Let me know if you need further clarification.

-- 
Best regards,
Ridong


