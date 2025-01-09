Return-Path: <cgroups+bounces-6078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91844A06AB8
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 03:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A733A726B
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2025 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD128136327;
	Thu,  9 Jan 2025 02:07:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23B126BF1;
	Thu,  9 Jan 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388473; cv=none; b=KpK0q7kryXYE/xnVW8EzZzRnrzxjS36/O+sQkXX51RLPFUFvi79Gwr0z208xydxd8hgKiYskdfyEjAznOuvkxGEkFlyL1s0mp+PBR3iLjwVpwbf5vfpQhX3QeRfmgydq05ToQxVxZKgNP6rDNbohbdGpRSJlhwSjmHbuSwHR5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388473; c=relaxed/simple;
	bh=jvopal6yRvBvAAy8DyZ3R/vsuC13Uh/84R6gXtzoy9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRzdMwwau3hH7MsWweW2sk58Jcye0VSQZ73tGKQRa/6xFiFwTsP7v05w7uCHkLYS1UCcacPm2Nhce1A3xn1zHwITYH65XwIeopg5TWewtyoYNj2RF9gCIUO+R6nlzqllS/fEXXmaE/jjMRiiUTylNLFoSwWEBKC/Yv8XE4b0p3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YT7TX2prCz4f3kFL;
	Thu,  9 Jan 2025 10:07:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 918A91A1ABF;
	Thu,  9 Jan 2025 10:07:48 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDnS3xzL39n3Bm7AQ--.5839S2;
	Thu, 09 Jan 2025 10:07:48 +0800 (CST)
Message-ID: <ad9802d1-b5e2-4866-b494-499e9e05aa5e@huaweicloud.com>
Date: Thu, 9 Jan 2025 10:07:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
 <Z37Qxd79eLqzYpZU@slm.duckdns.org>
 <9250b4e8-8ef8-4a85-af24-14a34cc72e3b@huaweicloud.com>
 <Z38sopf57DAusY9I@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z38sopf57DAusY9I@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnS3xzL39n3Bm7AQ--.5839S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW8AFykZF13Ary8tw1xAFb_yoW3JrbEv3
	98ta4I93W7Xa1xGa43Jr4Fkw4vq3WjvrsrJw48Ww42gr93J397Wr4rZ395W3WkG343Crsr
	Aa1rtr4qk34a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/9 9:55, Tejun Heo wrote:
> On Thu, Jan 09, 2025 at 09:29:59AM +0800, Chen Ridong wrote:
>> Hi, Tj and Longman, I am sorry, the fix tag is not exactly right. I just
>> failed to reproduce this issue at the version 5.10, and I found this
>> warning was added with the commit bdb2fd7fc56e ("kernfs: Skip
>> kernfs_drain_open_files() more aggressively"), which is at version 6.1.
>> I believe it should both fix  bdb2fd7fc56e ("kernfs: Skip
>> kernfs_drain_open_files() more aggressively") and 76bb5ab8f6e3 ("cpuset:
>> break kernfs active protection in cpuset_write_resmask()"). Should I
>> resend a new patch?
> 
> No worries. I updated the commit in place.
> 
> Thanks.
> 

Thank you very much.

Best regards,
Ridong


