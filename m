Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBC2C9861
	for <lists+cgroups@lfdr.de>; Tue,  1 Dec 2020 08:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLAHqJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Dec 2020 02:46:09 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55076 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbgLAHqI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Dec 2020 02:46:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0UH7dQ8L_1606808694;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UH7dQ8L_1606808694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 15:44:55 +0800
Subject: Re: BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0x1e0
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        inux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        alexander.h.duyck@linux.intel.com,
        Yafang Shao <laoar.shao@gmail.com>, richard.weiyang@gmail.co,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <58f66f22-fd5f-685d-e608-99c35d89c1a3@linux.alibaba.com>
Date:   Tue, 1 Dec 2020 15:44:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYtk3fKy7ct-rT=T8iFDhE4CbjGgdfxsOBrKT9y8ntwXyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/12/1 上午3:52, Naresh Kamboju 写道:
> Crash log:
> -----------
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> [  285.862123] ==================================================================
> [  285.863025] BUG: KASAN: null-ptr-deref in workingset_eviction+0xf2/0x1e0
> [  285.863025] Read of size 4 at addr 00000000000000c8 by task kswapd0/245

Hi Naresh,

Good to know you again. :)

Would you like to use command to check whichh line cause the panic:

scripts/faddr2line vmlinux workingset_eviction+0xf2/0x1e0

I can't reproduce it. and my gcc version mismatch with yours.

Thanks
Alex
