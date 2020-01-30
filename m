Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C521014D90E
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2020 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgA3Keq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jan 2020 05:34:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:50162 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgA3Keq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 30 Jan 2020 05:34:46 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ix79i-00045Z-1H; Thu, 30 Jan 2020 13:34:38 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 0/2 RESEND] cgroup: seq_file .next functions should
 increase position index
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20200128172737.GA21791@blackbody.suse.cz>
Message-ID: <91c15d7c-a831-e409-2fba-93ecfef5e85c@virtuozzo.com>
Date:   Thu, 30 Jan 2020 13:34:36 +0300
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

v2 changes:
- improved patch description
- cgroupv2 patch includes fix for __cgroup_procs_start(), advised by Michal Koutný

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

Vasily Averin (2):
  cgroup-v1: cgroup_pidlist_next should update position index
  cgroup: cgroup_procs_next should increase position index

 kernel/cgroup/cgroup-v1.c |  1 +
 kernel/cgroup/cgroup.c    | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
1.8.3.1

