Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB68149A33
	for <lists+cgroups@lfdr.de>; Sun, 26 Jan 2020 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgAZKqD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jan 2020 05:46:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:37976 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgAZKqC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 26 Jan 2020 05:46:02 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ivfQI-0007Tv-2g; Sun, 26 Jan 2020 13:45:46 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/2] cgroup: seq_file .next functions should increase position
 index
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <195bf4c6-2246-b816-f18f-110b156a9341@virtuozzo.com>
Date:   Sun, 26 Jan 2020 13:45:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In Aug 2018 NeilBrown noticed 
commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
"Some ->next functions do not increment *pos when they return NULL...
Note that such ->next functions are buggy and should be fixed. 
A simple demonstration is
   
dd if=/proc/swaps bs=1000 skip=1
    
Choose any block size larger than the size of /proc/swaps.  This will
always show the whole last line of /proc/swaps"

Described problem is still actual. If you make lseek into middle of last output line 
following read will output end of last line and whole last line once again.

$ dd if=/proc/swaps bs=1  # usual output
Filename				Type		Size	Used	Priority
/dev/dm-0                               partition	4194812	97536	-2
104+0 records in
104+0 records out
104 bytes copied

$ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
dd: /proc/swaps: cannot skip to specified offset
v/dm-0                               partition	4194812	97536	-2
/dev/dm-0                               partition	4194812	97536	-2 
3+1 records in
3+1 records out
131 bytes copied

There are lot of other affected files, I've found 30+ including
/proc/net/ip_tables_matches and /proc/sysvipc/*

This patch set fixes the problem in cgroup-related files

https://bugzilla.kernel.org/show_bug.cgi?id=206283

Vasily Averin (2):
  cgroup_pidlist_next should update position index
  cgroup_procs_next should increase position index

 kernel/cgroup/cgroup-v1.c | 1 +
 kernel/cgroup/cgroup.c    | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.8.3.1

