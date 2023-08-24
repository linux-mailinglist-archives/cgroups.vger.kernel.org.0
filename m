Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AA7865EB
	for <lists+cgroups@lfdr.de>; Thu, 24 Aug 2023 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjHXDj0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 23:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbjHXDjQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 23:39:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67610C4;
        Wed, 23 Aug 2023 20:39:13 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWTLD1n6DzrSGD;
        Thu, 24 Aug 2023 11:37:40 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 11:39:10 +0800
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache
 pages
To:     Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
 <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com>
 <ZOYFydIp3q8BNrEa@dhcp22.suse.cz>
 <CAJD7tkYivogrRtAx8a+EPfjRqQNgoOZFZyG8rC91E_hW6pdTEw@mail.gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <14e15f31-f3d3-4169-8ed9-fb36e57cf578@huawei.com>
Date:   Thu, 24 Aug 2023 11:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJD7tkYivogrRtAx8a+EPfjRqQNgoOZFZyG8rC91E_hW6pdTEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/8/23 23:29, Yosry Ahmed wrote:
> On Wed, Aug 23, 2023 at 6:12 AM Michal Hocko <mhocko@suse.com> wrote:
>> On Wed 23-08-23 10:00:58, Liu Shixin wrote:
>>>
>>> On 2023/8/23 0:35, Yosry Ahmed wrote:
>>>> On Mon, Aug 21, 2023 at 6:54 PM Liu Shixin <liushixin2@huawei.com> wrote:
>>>>> When spaces of swap devices are exhausted, only file pages can be reclaimed.
>>>>> But there are still some swapcache pages in anon lru list. This can lead
>>>>> to a premature out-of-memory.
>>>>>
>>>>> This problem can be fixed by checking number of swapcache pages in
>>>>> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that can
>>>>> be used directly. For memcg v1, use total_swapcache_pages() instead, which
>>>>> may not accurate but can solve the problem.
>>>> Interesting find. I wonder if we really don't have any handling of
>>>> this situation.
>>> I have alreadly test this problem and can confirm that it is a real problem.
>>> With 9MB swap space and 10MB mem_cgroup limit，when allocate 15MB memory,
>>> there is a probability that OOM occurs.
>> Could you be more specific about the test and the oom report?
> I actually couldn't reproduce it using 9MB of zram and a cgroup with a
> 10MB limit trying to allocate 15MB of tmpfs, no matter how many
> repetitions I do.
The following is the printout of the testcase I used. In fact, the probability
of triggering this problem is very low. You can adjust the size of the swap
space to increase the probability of recurrence.

10148+0 records in
10148+0 records out
10391552 bytes (10 MB, 9.9 MiB) copied, 0.0390954 s, 266 MB/s
mkswap: /home/swapfile: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 9.9 MiB (10387456 bytes)
no label, UUID=9219cb2a-55d7-46b6-9dcd-bb491095225d
mkswap return is 0
swapon: /home/swapfile: insecure permissions 0644, 0600 suggested.
swapon return is 0
swapoff success
10148+0 records in
10148+0 records out
10391552 bytes (10 MB, 9.9 MiB) copied, 0.0389205 s, 267 MB/s
mkswap: /home/swapfile: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 9.9 MiB (10387456 bytes)
no label, UUID=614b967a-bd87-430d-b867-6e09a8b77b27
mkswap return is 0
swapon: /home/swapfile: insecure permissions 0644, 0600 suggested.
swapon return is 0
---- in do_test---
=========orig_mem is 10428416, orig_sw_mem is 17059840
SwapCached:         3428 kB
SwapTotal:         10144 kB
SwapFree:            240 kB
rss is 7572, swap is 0
check pass
memcg_swap.sh: line 79:  6596 Killed                  cgexec -g "memory:test" ./malloc 16777216
swapoff success
10148+0 records in
10148+0 records out
10391552 bytes (10 MB, 9.9 MiB) copied, 0.0404156 s, 257 MB/s
mkswap: /home/swapfile: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 9.9 MiB (10387456 bytes)
no label, UUID=a228e988-47c1-44d5-9ce1-cd7b66e97721
mkswap return is 0
swapon: /home/swapfile: insecure permissions 0644, 0600 suggested.
swapon return is 0
---- in do_test---
=========orig_mem is 10485760, orig_sw_mem is 16834560
SwapCached:         3944 kB
SwapTotal:         10144 kB
SwapFree:              0 kB
rss is 7112, swap is 0
check fail
memcg_swap.sh: line 79:  6633 Killed                  cgexec -g "memory:test" ./malloc 16777216

This is my testcase:

memcg_swap.sh:
#!/bin/bash

_mkswap()
{
    size=${1:-10}
    swapfile="/home/swapfile"

    # clear swap
    swapoff -a
    expect_size=$(free -b | grep 'Swap' | awk '{print $2}')
    if [ $expect_size -ne 0 ]; then
        echo "$expect_size"
        echo "swapoff fail"
        return 1
    fi
    echo "swapoff success"
    rm -rf $swapfile
    dd if=/dev/zero of=$swapfile bs=1k count=10148
    mkswap $swapfile
    echo "mkswap return is $?"
    swapon $swapfile
    echo "swapon return is $?"
}

echo "----in do_pre----"
cgdelete -r "memory:test"
cgcreate -g "memory:test"
_mkswap 10

while true
do
    _mkswap 10
    echo "---- in do_test---"
    cgcreate -g "memory:test"
    echo 1 > /sys/fs/cgroup/memory/test/memory.oom_control
    echo 10M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    cgexec -g "memory:test" ./malloc 16777216 &
    pid=$!
    sleep 3
    orig_mem=$(cat /sys/fs/cgroup/memory/test/memory.usage_in_bytes)
    orig_sw_mem=$(cat /sys/fs/cgroup/memory/test/memory.memsw.usage_in_bytes)
    echo "=========orig_mem is $orig_mem, orig_sw_mem is $orig_sw_mem"
    cat /proc/meminfo | grep Swap
    swapfree=$(cat /proc/meminfo | grep SwapFree |  awk '{print $2}')
    swapcache=$(cat /proc/meminfo | grep SwapCached |  awk '{print $2}')
    if [ $swapfree -eq 0 ]; then
        echo "==========" >> /root/free.txt
        echo "swapfree is $swapfree" >> /root/free.txt
        echo "swapcache is $swacache" >> /root/free.txt
        echo "==========" >> /root/free.txt
    fi
    rss=$(cat /proc/$pid/smaps_rollup | sed -n 2p | awk '{print $2}')
    swap=$(cat /proc/$pid/smaps_rollup | sed -n 19p | awk '{print $2}')
    echo "rss is $rss, swap is $swap"
    echo "test data==================" >> /root/data.txt
    echo "rss is $rss" >> /root/data.txt
    echo "swap is $swap" >> /root/data.txt
    echo "test end===================" >> /root/data.txt
    if [ $orig_mem -le 10485760 -a \
             "$(cat /proc/$pid/status | grep State | awk '{print $2}')" == "R" ]; then
        echo "check pass"
    else
        echo "check fail"
        kill -9 $pid
        cgdelete -r "memory:test"
        break
    fi
    kill -9 $pid
    cgdelete -r "memory:test"
done

malloc.c:
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
        char *p;

        p = malloc(atoi(argv[1]));
        memset(p, 1, atoi(argv[1]));
        return 0;
}
>
>> --
>> Michal Hocko
>> SUSE Labs
> .
>

