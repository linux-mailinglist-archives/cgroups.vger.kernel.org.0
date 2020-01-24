Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB614851C
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2020 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgAXMY0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jan 2020 07:24:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:35562 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgAXMY0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 Jan 2020 07:24:26 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuxfG-0002BI-DF; Fri, 24 Jan 2020 15:02:18 +0300
To:     cgroups@vger.kernel.org
From:   Vasily Averin <vvs@virtuozzo.com>
Cc:     Tejun Heo <tj@kernel.org>
Subject: cgroup.procs output problem
Message-ID: <ff3de0d7-b7fe-a12f-f816-3d6f0166e93f@virtuozzo.com>
Date:   Fri, 24 Jan 2020 15:02:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Tejun and cgroups mailing list users.

During validation of patches for cgoups I've noticed strange behaviour in cgroup v2 

dd with bs=1 reads each 2nd line of cgroup.proc and cgroup.threads file

on Fedora 31 node

[test@localhost ~]$ dd if=/sys/fs/cgroup/cgroup.procs  bs=1 | wc
195+0 records in
195+0 records out
195 bytes copied, 0,000149534 s, 1,3 MB/s
     54      54     195

VvS: it reads 54 lines

[test@localhost ~]$ dd if=/sys/fs/cgroup/cgroup.procs  bs=1000 | wc
0+1 records in
0+1 records out
389 bytes copied, 6,6956e-05 s, 5,8 MB/s
    108     108     389

following one reads twice more, 108 lines.

[test@localhost ~]$ dd if=/sys/fs/cgroup/cgroup.procs  bs=1 | wc
195+0 records in
195+0 records out
195 bytes copied, 0,000123775 s, 1,6 MB/s
     54      54     195

following dd bs=1 reads 54 lines again

[test@localhost ~]$ uname -a
Linux localhost.localdomain 5.5.0-rc6-00150-g82efece #7 SMP Fri Jan 24 12:05:04 MSK 2020 x86_64 x86_64 x86_64 GNU/Linux
[test@localhost ~]$ mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)

I prepared patches for .next seq_file funictions.
https://bugzilla.kernel.org/show_bug.cgi?id=206283
during its validation I've noticed described problem,
and did not found its reason yet.

Thank you,
   Vasily Averin
