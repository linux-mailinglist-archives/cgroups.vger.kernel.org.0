Return-Path: <cgroups+bounces-6512-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C6A31BF9
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 03:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7731661FF
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 02:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40D1C3BEE;
	Wed, 12 Feb 2025 02:27:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391C2AE90;
	Wed, 12 Feb 2025 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327227; cv=none; b=VZ5p3mtR/q6nwzhJQhr6N7Wz4RdVf786aGruayX2G5kSo8tBPI//EKD6s4CehgxLEl32VAQR28bNyEncAowzXoht9U06dcJxenk5lcNU05uNd/H9lnP22x++bcfDVapX+qnYasqetIyP5tvHk5EoWucaPnGfLndbxiDtRQx9rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327227; c=relaxed/simple;
	bh=QlyyhPqk6m3sIo6BvD/9VbX1f3j/d2XmefZRXi1VrAs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pytDnjg+MFX/6bcxypM0qp0HHqow40fdNTyhCjBrOc6s9RFRDuQcSOs6jb79YoHOO/eGXuApFMblbClGTeR7OD1TDJTO5gI5koI4O+n9alQcwFHzomkJx4mtssKDdKPqd8cdEPBwxTLfebZXG1PItsUqIfdImixRY1LPQ5HqLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yt2Hs099Yz4f3js7;
	Wed, 12 Feb 2025 10:26:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 556341A058E;
	Wed, 12 Feb 2025 10:26:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGDsBqxnXJBlDg--.62273S3;
	Wed, 12 Feb 2025 10:26:54 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: validate alloc/free function pairs at the
 start of blkcg_policy_register()
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Wen Tao <wentao@uniontech.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>
 <i6owvzwb4pjg27tex5utdzcoyeeawqejegvc2byz6tnfn2flmh@2ggun5qyokvs>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <29be6f4e-fc0b-8134-fee6-7b3170f0d806@huaweicloud.com>
Date: Wed, 12 Feb 2025 10:26:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <i6owvzwb4pjg27tex5utdzcoyeeawqejegvc2byz6tnfn2flmh@2ggun5qyokvs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGDsBqxnXJBlDg--.62273S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZF47JF15Cw47GF4DCFW3ZFb_yoW8JryfpF
	ZIya4rAFy0krWxWanxKaySvr1rWa1kGw47JF90q34fu343AFyrtr4jyan5WF97ZFyIyFya
	vFyYqaySk3WDA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/11 21:57, Michal Koutný 写道:
> Hello Linxuan.
> 
> On Mon, Feb 10, 2025 at 11:18:27AM +0800, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
>> Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn function
>> pairs to the start of blkcg_policy_register(). This ensures we immediately
>> return -EINVAL if the function pairs are not correctly provided, rather
>> than returning -ENOSPC after locking and unlocking mutexes unnecessarily.
>>
>> Co-authored-by: Wen Tao <wentao@uniontech.com>
>> Signed-off-by: Wen Tao <wentao@uniontech.com>
>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> 
> If you consider those locks contention a problem (policy registrations
> are "only" boot time, possibly module load time), then it's good to refer
> 
> Fixes: e84010732225c ("blkcg: add sanity check for blkcg policy operations")

This is super cold path, so I don't think it's a problem.
> 
>> ---
>>   block/blk-cgroup.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> But it's correct,
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 

Since we're here, can you also change the return value to -ENOMEM from
error path err_free_cpds?

Thanks,
Kuai


