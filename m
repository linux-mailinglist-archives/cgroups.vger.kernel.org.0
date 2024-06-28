Return-Path: <cgroups+bounces-3432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C191B4DF
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 04:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D472838CD
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5CA1429B;
	Fri, 28 Jun 2024 02:04:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219B23A8;
	Fri, 28 Jun 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540267; cv=none; b=DWtQ5XDRaaI9uW5cwcOiVEk1zkx2ocM92PZvKrtdYBwFK+5z84STkqgoZ3oKsP/wzMcRZz2FlxaA/qh61mVUkKi4MQufOdzyVxcVNLF8ebZvqcnFzRWALh/KgfYsWz5m9DqwXXMmRGueCD4jF8k8lyrc1CxYyN8vVw5YW3WT0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540267; c=relaxed/simple;
	bh=ofbM0xcK0jusdVrO6osOKxJNrsO1OiueOBSmdDE4d5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP3LDbAgoIciNKe/UCpyn4eHGm4LQLUhhcDgYw0dWZo/zsAsMXl5RCna8q2HlvgYXOMV/knG1zC5T238gscG+O2PYfZN56KjjZtXe2lBQYybyECVlcJB2F5QQFozvXHzhwql2Y3VOe/51U8tMueWR2cow8MB/mmkzyINhA4vjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W9Jdp6S6Fz4f3jtc;
	Fri, 28 Jun 2024 10:04:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1095F1A016E;
	Fri, 28 Jun 2024 10:04:22 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YYkGn5meawuAg--.45870S3;
	Fri, 28 Jun 2024 10:04:21 +0800 (CST)
Message-ID: <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
Date: Fri, 28 Jun 2024 10:04:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v2] block: flush all throttled bios when deleting the
 cgroup
To: Tejun Heo <tj@kernel.org>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com,
 houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com
References: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
 <Zn3O47DUoLliwbWm@slm.duckdns.org>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <Zn3O47DUoLliwbWm@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0YYkGn5meawuAg--.45870S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try3Cw45XrWkur1fCw18AFb_yoW8JFy7pF
	WfZ347KryDJr9I9F4rZr4SvrWrZrZ7Jr45Ar93K345JrW3Wr1xtFy3trWFqFy7ZF93C3Wa
	vr1Fyr9rAF4DCFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/6/28 4:43, Tejun Heo 写道:
> Hello, Li.
>
> On Thu, Jun 27, 2024 at 10:26:06PM +0800, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> When a process migrates to another cgroup and the original cgroup is deleted,
>> the restrictions of throttled bios cannot be removed. If the restrictions
>> are set too low, it will take a long time to complete these bios.
>>
>> Refer to the process of deleting a disk to remove the restrictions and
>> issue bios when deleting the cgroup.
>>
>> This makes difference on the behavior of throttled bios:
>> Before: the limit of the throttled bios can't be changed and the bios will
>> complete under this limit;
>> Now: the limit will be canceled and the throttled bios will be flushed
>> immediately.
> I'm not necessarily against this but the description doesn't explain why
> this is better either. Can you please detail why this behavior is better?
I think it may be more appropriate to remove the limit of bios after the
cgroup is deleted, rather than let the bios continue to be throttled by a
non-existent cgroup.

If the limit is set too low, and the original cgourp has been deleted, we
now have no way to make the bios complete immediately, but to wait for the
bios to slowly complete under the limit.

Thanks.

>
> Thanks.
>


