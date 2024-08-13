Return-Path: <cgroups+bounces-4223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B794FE03
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 08:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD47281306
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152793BBC5;
	Tue, 13 Aug 2024 06:39:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D1381B8;
	Tue, 13 Aug 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531184; cv=none; b=BpWzuo52/k1ejAyCuRpLLGrjJmwNS0Lu5f+2fsAThUZO/CJjtWNQNwtVPaXuX0W+V8bmGNj1xAOwGgU3SneDFZv+hOiB6CKIYQ6OZ34ZhcY+fEdVLBvU/3hmr+PuM1qZOc/Z5KNMxMOgNsjouh9aFrLXCC5spMatyj7mCDHjHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531184; c=relaxed/simple;
	bh=AgOTf/1nimd9AxP69hLnqq2R4+9999KwphIxvW77f00=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oxDbXMd3xR9hZRclsWfnx7BTZLQdvIcAemFeTwF8BZcAkPpEE1SlkG+CE5FOkJmjXTfoEy+UZ6sLoqyX9u3BDiEYl7tuv91ZAyBvMyFE+FaHujn1I3CGiCOFGY8cX9S57+f7IcISI+4enJU9OXWeHjUemi1lxf4CTd6YDIketoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjhZ44fYXz4f3jsG;
	Tue, 13 Aug 2024 14:39:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 531ED1A0568;
	Tue, 13 Aug 2024 14:39:38 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4Wl_7pmE5E6Bg--.5405S3;
	Tue, 13 Aug 2024 14:39:35 +0800 (CST)
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: Lance Yang <ioworker0@gmail.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, josef@toxicpanda.com, tj@kernel.org,
 fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com, a.hindborg@samsung.com,
 paolo.valente@unimore.it, axboe@kernel.dk, vbabka@kernel.org,
 david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 libang.li@antgroup.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240812150049.8252-1-ioworker0@gmail.com>
 <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
 <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com>
 <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eef1f655-4fff-618d-4b8e-447230ec8ed9@huaweicloud.com>
Date: Tue, 13 Aug 2024 14:39:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4Wl_7pmE5E6Bg--.5405S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1ktr4fXw1DZF1UWFyrCrg_yoWrArWUpF
	Zxt3W7tFs5Gr13Gw1293y0gFyYqwnrJa15Xr1UKr15uFn0qr9Igr4UKr4qgFyFvF1fGw45
	Zw4fWF12gr1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/13 13:00, Lance Yang 写道:
> Hi Kuai,
> 
> Thanks a lot for jumping in!
> 
> On Tue, Aug 13, 2024 at 9:37 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/08/12 23:43, Michal Koutný 写道:
>>> +Cc Kuai
>>>
>>> On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.com> wrote:
>>>> Hi all,
>>>>
>>>> I've run into a problem with Cgroup v2 where it doesn't seem to correctly limit
>>>> I/O operations when I set both wbps and wiops for a device. However, if I only
>>>> set wbps, then everything works as expected.
>>>>
>>>> To reproduce the problem, we can follow these command-based steps:
>>>>
>>>> 1. **System Information:**
>>>>      - Kernel Version and OS Release:
>>>>        ```
>>>>        $ uname -r
>>>>        6.10.0-rc5+
>>>>
>>>>        $ cat /etc/os-release
>>>>        PRETTY_NAME="Ubuntu 24.04 LTS"
>>>>        NAME="Ubuntu"
>>>>        VERSION_ID="24.04"
>>>>        VERSION="24.04 LTS (Noble Numbat)"
>>>>        VERSION_CODENAME=noble
>>>>        ID=ubuntu
>>>>        ID_LIKE=debian
>>>>        HOME_URL="https://www.ubuntu.com/"
>>>>        SUPPORT_URL="https://help.ubuntu.com/"
>>>>        BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
>>>>        PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
>>>>        UBUNTU_CODENAME=noble
>>>>        LOGO=ubuntu-logo
>>>>        ```
>>>>
>>>> 2. **Device Information and Settings:**
>>>>      - List Block Devices and Scheduler:
>>>>        ```
>>>>        $ lsblk
>>>>        NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
>>>>        sda     8:0    0   4.4T  0 disk
>>>>        └─sda1  8:1    0   4.4T  0 part /data
>>>>        ...
>>>>
>>>>        $ cat /sys/block/sda/queue/scheduler
>>>>        none [mq-deadline] kyber bfq
>>>>
>>>>        $ cat /sys/block/sda/queue/rotational
>>>>        1
>>>>        ```
>>>>
>>>> 3. **Reproducing the problem:**
>>>>      - Navigate to the cgroup v2 filesystem and configure I/O settings:
>>>>        ```
>>>>        $ cd /sys/fs/cgroup/
>>>>        $ stat -fc %T /sys/fs/cgroup
>>>>        cgroup2fs
>>>>        $ mkdir test
>>>>        $ echo "8:0 wbps=10485760 wiops=100000" > io.max
>>>>        ```
>>>>        In this setup:
>>>>        wbps=10485760 sets the write bytes per second limit to 10 MB/s.
>>>>        wiops=100000 sets the write I/O operations per second limit to 100,000.
>>>>
>>>>      - Add process to the cgroup and verify:
>>>>        ```
>>>>        $ echo $$ > cgroup.procs
>>>>        $ cat cgroup.procs
>>>>        3826771
>>>>        3828513
>>>>        $ ps -ef|grep 3826771
>>>>        root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
>>>>        root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
>>>>        root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=auto 3826771
>>>>        ```
>>>>
>>>>      - Observe I/O performance using `dd` commands and `iostat`:
>>>>        ```
>>>>        $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>>>        $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>
>> You're testing buffer IO here, and I don't see that write back cgroup is
>> enabled. Is this test intentional? Why not test direct IO?
> 
> Yes, I was testing buffered I/O and can confirm that CONFIG_CGROUP_WRITEBACK
> was enabled.
> 
> $ cat /boot/config-6.10.0-rc5+ |grep CONFIG_CGROUP_WRITEBACK
> CONFIG_CGROUP_WRITEBACK=y
> 
> We intend to configure both wbps (write bytes per second) and wiops
> (write I/O operations
> per second) for the containers. IIUC, this setup will effectively
> restrict both their block device
> I/Os and buffered I/Os.
> 
>> Why not test direct IO?
> 
> I was testing direct IO as well. However it did not work as expected with
> `echo "8:0 wbps=10485760 wiops=100000" > io.max`.
> 
> $ time dd if=/dev/zero of=/data/file7 bs=512M count=1 oflag=direct

So, you're issuing one huge IO, with 512M.
> 1+0 records in
> 1+0 records out
> 536870912 bytes (537 MB, 512 MiB) copied, 51.5962 s, 10.4 MB/s

And this result looks correct. Please noted that blk-throtl works before
IO submit, while iostat reports IO that are done. A huge IO can be
throttled for a long time.
> 
> real 0m51.637s
> user 0m0.000s
> sys 0m0.313s
> 
> $ iostat -d 1 -h -y -p sda
>   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
> kB_dscd Device
>       9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>        0.0k sda
>       9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>        0.0k sda1

I don't understand yet is why there are few IO during the wait. Can you
test for a raw disk to bypass filesystem?

Thanks,
Kuai


