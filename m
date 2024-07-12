Return-Path: <cgroups+bounces-3645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069492F36D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 03:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D2D1C21953
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3D4A3D;
	Fri, 12 Jul 2024 01:25:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A81FBA;
	Fri, 12 Jul 2024 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747556; cv=none; b=o+bfmSChUQWfWQO2HO9znGbQG4jOTlDLTfS3XOZ+TBP+tdMhX2XSgX+d8WVPvkxyYAfo4Ntjg8IUSNAgK+TO90vVdWy87t6nNhvX/LIF/+YtOPBX+QQiRUM3n9AZEofxCuE0PtFMz9Rwx1UwNVZ0spwfpKWy/e/ECAuuikQlwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747556; c=relaxed/simple;
	bh=CD+Rwhbs9YWofJZlT1yp0uFKxRcBNsCaJR1THs4jp9I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VhNHYAHuWIN6BLBH2nTaaujqVX2q9O2jhySTW2N/I8CWjn03c2u69NMEnGzfjSKHb4h2Mwk22bLallLSM2AWDR/0elLAy3YUp4jQoVfuFnwgfSCLCbAIL5hoGmwpj/nQbUtlGwAy7jbXgX4io+yt9p5gPW374uLfwQUGrkaLyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKv6n1cKzz4f3kvH;
	Fri, 12 Jul 2024 09:25:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 271491A0572;
	Fri, 12 Jul 2024 09:25:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgB34YYchpBmDu5qBw--.22968S3;
	Fri, 12 Jul 2024 09:25:49 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-ioprio: remove per-disk structure
To: Yu Kuai <yukuai1@huaweicloud.com>, Bart Van Assche <bvanassche@acm.org>,
 tj@kernel.org, josef@toxicpanda.com, jack@suse.cz, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
 <20240711090059.3998565-3-yukuai1@huaweicloud.com>
 <4c8f1e4e-1b15-4afa-b1e2-084e0c4caeec@acm.org>
 <520b9c10-c152-77f3-bd5a-b86a1f5ac8ea@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3113a4cc-c1e9-cd14-b165-d8d1d39a39a1@huaweicloud.com>
Date: Fri, 12 Jul 2024 09:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <520b9c10-c152-77f3-bd5a-b86a1f5ac8ea@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YYchpBmDu5qBw--.22968S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF15Ww4kJry7Gw1rJr43KFg_yoWDKFc_ua
	95Z3s2k343ZFs7G3Z3Ar43XFZ7tFW0qry3Xr1jqF9xK3yFgrW5Wr1UW3yfuw13Cw48Cr9a
	kryq9w18Gr429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/07/12 9:10, Yu Kuai 写道:
> Hi,
> 
> 在 2024/07/12 2:03, Bart Van Assche 写道:
>> On 7/11/24 2:00 AM, Yu Kuai wrote:
>>> ioprio works on the blk-cgroup level, all disks in the same cgroup
>>> are the same, and the struct ioprio_blkg doesn't have anything in it.
>>> Hence register the policy is enough, because cpd_alloc/free_fn will
>>> be handled for each blk-cgroup, and there is no need to activate the
>>> policy for disk.
>>
>> As one can see in the output of git grep -nHEB1 '>pd_(alloc|free)_fn\(',
>> none of the pd_alloc_fn / pd_free_fn callers checks whether or not these
>> pointers are NULL. Hence my question why this patch does not trigger any
>> NULL pointer dereferences?
> 
> Because the blkcg_deactivate_policy() is removed as well, there are no

Sorry about the typo, blkcg_activate_policy() is removed, all the places
of pd_(alloc|free)_fn can't be reached.

Thanks,
Kuai

> callers now... blkcg_policy_register() is still called to make sure
> cpd_(alloc|free)_fn will still be called.
> 
> Thanks,
> Kuai
> 
>>
>> Thanks,
>>
>> Bart.
>> .
>>
> 
> .
> 


