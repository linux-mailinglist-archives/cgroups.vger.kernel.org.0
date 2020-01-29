Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5066014C8D7
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 11:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgA2KkA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 05:40:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:34384 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgA2KkA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jan 2020 05:40:00 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iwkl1-00010J-VO; Wed, 29 Jan 2020 13:39:40 +0300
Subject: Re: [PATCH 0/2] cgroup: seq_file .next functions should increase
 position index
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <195bf4c6-2246-b816-f18f-110b156a9341@virtuozzo.com>
 <20200128172737.GA21791@blackbody.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <6d044e01-9794-fe22-ac74-fd01b024a5f1@virtuozzo.com>
Date:   Wed, 29 Jan 2020 13:39:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128172737.GA21791@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/20 8:27 PM, Michal Koutný wrote:
> I agree with your changes, however, I have some suggestions:
> 
> 1) squash [PATCH 2/2] "cgroup_procs_next should increase position index"
>    and [PATCH] "__cgroup_procs_start cleanup"
>    - make it clear in the commit message that it's fixing the small
>      buffer listing, it's not a mere cleanup(!)
> 2) for completeness, I propose squashing also this change (IOW,
>    cgroup_procs_start should only initialize the iterator, not move it):

got it

> 3) I was not able to reproduce the corrupted listing into small buffer
>    on v1 hierarchy, i.e. the [PATCH 1/2] "cgroup_pidlist_next should update
>    position index" log message should just explain the change is to
>    satisfy seq_file iterator requirements.

[root@localhost ~]# uname -a
Linux localhost.localdomain 5.4.7-200.fc31.x86_64 #1 SMP Tue Dec 31 22:25:12 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost ~]# mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate)
cgroup on /mnt type cgroup (rw,relatime,seclabel,cpu)

[root@localhost ~]# dd if=/mnt/cgroup.procs bs=1  # normal output
...
1294
1295
1296
1304
1382
584+0 records in
584+0 records out
584 bytes copied, 0.00281916 s, 207 kB/s

[root@localhost ~]# dd if=/mnt/cgroup.procs bs=581 skip=1  # read after lseek in middle of last line
dd: /mnt/cgroup.procs: cannot skip to specified offset
83  <<< generates end of last line
1383  <<< ... and whole last line once again
0+1 records in
0+1 records out
8 bytes copied, 0.000171759 s, 46.6 kB/s

[root@localhost ~]# dd if=/mnt/cgroup.procs bs=1000 skip=1  # read after lseek beyond end of file
dd: /mnt/cgroup.procs: cannot skip to specified offset
1386  <<< generates last line anyway
0+1 records in
0+1 records out
5 bytes copied, 0.000198117 s, 25.2 kB/s

    
> I can send my complete diffs if the suggestions are unclear.
> 
> Michal
> 
> P.S. I really recommend using `git send-email` for sending out the
> patches, it makes mail threading more readable.

thank you, will resent v2 
   Vasily Averin
