Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B299F1B1E8
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 10:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEMIbA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 04:31:00 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57982 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfEMIbA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 04:31:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TRaHzOx_1557736257;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TRaHzOx_1557736257)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 May 2019 16:30:58 +0800
To:     tj@kernel.org, cgroups@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
From:   Alex Shi <alex.shi@linux.alibaba.com>
Subject: what's the recommend test case for cgroup2
Message-ID: <f5bd2e79-60d7-83d4-2fd0-892b60cf1cab@linux.alibaba.com>
Date:   Mon, 13 May 2019 16:30:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

We have couple of cgroup enhancement which we want to contribute to upstream cgroup2. But when seeking a usage module of cgroup2, I didn't find a workable APP for cgroup2, like a issue on lxc which failed to boot with "cgroup_no_v1=all" in cmdline (https://github.com/lxc/lxc/issues/2991)
Which APP are you using to test cgroup2? or is there some recommend testcase/benchmark except the selftest in kernel tree?

Sorry if it was answered. 

Thank
Alex
