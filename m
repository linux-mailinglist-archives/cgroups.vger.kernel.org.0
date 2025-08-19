Return-Path: <cgroups+bounces-9271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5EB2B67E
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 03:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708151B24DCB
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 01:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC827FB2A;
	Tue, 19 Aug 2025 01:57:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DF189F20;
	Tue, 19 Aug 2025 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568622; cv=none; b=OyeAFOhwNeeVbSQPdXg7MTbV5JQ+f0XGr6VzxZfHXDUhbW9EHmpDQ90LaElZoaWWEqHFayLAA71z4yk7GwnzIFR9fh7IXOMkmvV88LquiBmr3++SlYrl4JCKpm47amXKm1gdsPCzsbK4gyq6rAR6pZMxtQFTL4WrQU9C82oDcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568622; c=relaxed/simple;
	bh=RzEL+rwP6HpQuOxG0EurPXT2Dg7I/8NOy2eyHr52r/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNStb6z0uySSV2CmReXQKcJ2ZXNtWJG4PYu++iHp5L7QHbqcWJJbSb8+uvmMCL98NPioaPRqIFcqDghHCTpZN9exsgnGOZUvNS9nNO19RtPV/MwWLVXzgV+BtkhBkT2FI/pkfVjKk685/ikkkQUzrunaYi6g7ly9nIPUybc9Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c5Xky6YnlzKHMhx;
	Tue, 19 Aug 2025 09:56:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 53E4C1A0CA0;
	Tue, 19 Aug 2025 09:56:58 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgC3MNvo2aNoOOhZEA--.18125S2;
	Tue, 19 Aug 2025 09:56:58 +0800 (CST)
Message-ID: <1cacc295-ccea-4725-913c-7c95efeec776@huaweicloud.com>
Date: Tue, 19 Aug 2025 09:56:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cgroup: split cgroup_destroy_wq into 3 workqueues
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com, hdanton@sina.com, gaoyingjie@uniontech.com
References: <20250818034315.1303955-1-chenridong@huaweicloud.com>
 <20250818061435.1304516-1-chenridong@huaweicloud.com>
 <aKNeF68tmjLKB6dK@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aKNeF68tmjLKB6dK@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3MNvo2aNoOOhZEA--.18125S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW8KrWxCr4UKw43WrW7Jwb_yoWxCrc_uF
	98Kr4jkw4DGa1DZw4agrs8WF40ga15Xw18JFWUtr1UK34fJ3s8CFZrArnxCrZ8Jay7XFnx
	Cry3uFyxCw47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/19 1:08, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 18, 2025 at 06:14:35AM +0000, Chen Ridong wrote:
> ...
>> + * Rationale for using separate workqueues:
>> + * The cgroup root free work may depend on completion of other css offline
>> + * operations. If all tasks were enqueued to a single workqueue, this could
>> + * create a deadlock scenario where:
>> + * - Free work waits for other css offline work to complete.
>> + * - But other css offline work is queued after free work in the same queue.
> 
> Can you please refer to the concrete example too?
> 
> Thanks.
> 

Sure, the comment has been updated in v6. Please let me know if you have any feedback.

-- 
Best regards,
Ridong


