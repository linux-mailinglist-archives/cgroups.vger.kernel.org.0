Return-Path: <cgroups+bounces-9262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A81B29BE8
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8365196039F
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26772FF673;
	Mon, 18 Aug 2025 08:22:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682D1D9346;
	Mon, 18 Aug 2025 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505328; cv=none; b=S/Lp17uYuZ1IHjg4U+GAs3Oj/2Uunc9LalCKWbWKv15mSVjRBFuCC3ecloi1T9R7c1qkRClWYS3opaNBnXMgTLmO9vHQzK41N1jKTwIrqt1HbXI1umvZpeCeJfmhABAKNLrBhvZNhyqWrsKzmihIY48ELmj0mi59AFOIZxSQavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505328; c=relaxed/simple;
	bh=NWE7JKTTm/gkFy/hNNDMyNlnmXsG/mHuvfZUm1OvLoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QWA8DXoWpu5bNYgRCDSyqLq0RBq1G1ZpLOxmbKPcwn/0C5jTD0AqmY/g5QMAnpdikEmLFUp8D7phvJ03p1HdzQX97BZeqKDG3ohEWbyq8lq5iS8btvJDV5Cfeg1C8tn/eYCD5O+cyByztLdgkdPU34O0ud4GKCjacpimld8oOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c55Kl5VKQzKHNBq;
	Mon, 18 Aug 2025 16:22:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 286BF1A07BB;
	Mon, 18 Aug 2025 16:22:03 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgD3AbSp4qJoFbEZEA--.45966S2;
	Mon, 18 Aug 2025 16:22:02 +0800 (CST)
Message-ID: <bfd78e3b-936e-49e6-b17e-389ba016e8e7@huaweicloud.com>
Date: Mon, 18 Aug 2025 16:22:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: Fix UAF in PSI polling when open file is released
From: Chen Ridong <chenridong@huaweicloud.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: cgroups@vger.kernel.org, chenridong@huawei.com,
 gregkh@linuxfoundation.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, mkoutny@suse.com,
 peterz@infradead.org, tj@kernel.org, zhouchengming@bytedance.com,
 Yang Erkun <yangerkun@huawei.com>
References: <20250815013429.1255241-1-chenridong@huaweicloud.com>
 <0319ee9b-ce2c-4c02-a731-c538afcf008f@huawei.com>
 <e485b38a-183b-42c8-9aed-9c2d939add0b@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <e485b38a-183b-42c8-9aed-9c2d939add0b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3AbSp4qJoFbEZEA--.45966S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DZF4DCrWrKF1kZr47Jwb_yoW5uw4Upa
	90yF1UK3yUXr1qyrs2qF1vg3W8tayxJFyIgrn7Kr9aq3Z3trn5Ar1xCr15WFyDJrsxJr42
	q3ZFk342yw4YyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/18 16:00, Chen Ridong wrote:
> 
> 
> On 2025/8/16 17:53, Baokun Li wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> A use-after-free (UAF) vulnerability was identified in the PSI (Pressure
>>> Stall Information) monitoring mechanism:
>>>
>>> BUG: KASAN: slab-use-after-free in psi_trigger_poll+0x3c/0x140
>>> Read of size 8 at addr ffff3de3d50bd308 by task systemd/1
>>>
>>> psi_trigger_poll+0x3c/0x140
>>> cgroup_pressure_poll+0x70/0xa0
>>> cgroup_file_poll+0x8c/0x100
>>> kernfs_fop_poll+0x11c/0x1c0
>>> ep_item_poll.isra.0+0x188/0x2c0
>>>
>>> Allocated by task 1:
>>> cgroup_file_open+0x88/0x388
>>> kernfs_fop_open+0x73c/0xaf0
>>> do_dentry_open+0x5fc/0x1200
>>> vfs_open+0xa0/0x3f0
>>> do_open+0x7e8/0xd08
>>> path_openat+0x2fc/0x6b0
>>> do_filp_open+0x174/0x368
>>>
>>> Freed by task 8462:
>>> cgroup_file_release+0x130/0x1f8
>>> kernfs_drain_open_files+0x17c/0x440
>>> kernfs_drain+0x2dc/0x360
>>> kernfs_show+0x1b8/0x288
>>> cgroup_file_show+0x150/0x268
>>> cgroup_pressure_write+0x1dc/0x340
>>> cgroup_file_write+0x274/0x548
>>>
>>> Reproduction Steps:
>>> 1. Open test/cpu.pressure and establish epoll monitoring
>>> 2. Disable monitoring: echo 0 > test/cgroup.pressure
>>> 3. Re-enable monitoring: echo 1 > test/cgroup.pressure
>>>
>>> The race condition occurs because:
>>> 1. When cgroup.pressure is disabled (echo 0 > cgroup.pressure), it:
>>>    - Releases PSI triggers via cgroup_file_release()
>>>    - Frees of->priv through kernfs_drain_open_files()
>>> 2. While epoll still holds reference to the file and continues polling
>>> 3. Re-enabling (echo 1 > cgroup.pressure) accesses freed of->priv
>>>
>>> epolling			disable/enable cgroup.pressure
>>> fd=open(cpu.pressure)
>>> while(1)
>>> ...
>>> epoll_wait
>>> kernfs_fop_poll
>>> kernfs_get_active = true	echo 0 > cgroup.pressure
>>> ...				cgroup_file_show
>>> 				kernfs_show
>>> 				// inactive kn
>>> 				kernfs_drain_open_files
>>> 				cft->release(of);
>>> 				kfree(ctx);
>>> 				...
>>> kernfs_get_active = false
>>> 				echo 1 > cgroup.pressure
>>> 				kernfs_show
>>> 				kernfs_activate_one(kn);
>>> kernfs_fop_poll
>>> kernfs_get_active = true
>>> cgroup_file_poll
>>> psi_trigger_poll
>>> // UAF
>>> ...
>>> end: close(fd)
> 
> Thank you, Baokun.
> 
>> I think the problem is that kernfs_show() handles enable and disable
>> inconsistently. When disable is called, it sets kn->active and then frees
>> cgroup_file_ctx and psi_trigger. But when enable is called, it only sets
>> kn->active. This mismatch means we can end up accessing the freed
>> cgroup_file_ctx and psi_trigger later on.
>>
> 
> I agree with that.
> 
>> A potential solution is to make the lifecycles of cgroup_file_ctx and
>> psi_trigger match the struct kernfs_open_file they're associated with.
>> Maybe we could just get rid of the kernfs_release_file call in
>> kernfs_drain_open_files?
>>
> 
> Hi, Tj, what do you think about this solution?
> 

Or we should add KERNFS_HIDDEN check?

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -812,7 +812,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
                        on->nr_mmapped--;
                }

-               if (kn->flags & KERNFS_HAS_RELEASE)
+               if (!kn->flags & KERNFS_HIDDEN && kn->flags & KERNFS_HAS_RELEASE)
                        kernfs_release_file(kn, of);
        }

-- 
Best regards,
Ridong


