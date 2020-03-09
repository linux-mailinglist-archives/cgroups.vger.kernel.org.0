Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA817E128
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 14:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCIN2B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 09:28:01 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36207 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgCIN2B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 09:28:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ts81o5L_1583760421;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ts81o5L_1583760421)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Mar 2020 21:27:01 +0800
Subject: Re: linux-next test error: BUG: using __this_cpu_read() in
 preemptible code in __mod_memcg_state
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        syzbot <syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <00000000000022640205a04a20d8@google.com>
 <20200309092423.2ww3aw6yfyce7yty@box>
 <5b1196be-09ce-51f7-f5e7-63f2e597f91e@linux.alibaba.com>
Message-ID: <d3fb0593-e483-3b69-bf2c-99ad6cd03567@linux.alibaba.com>
Date:   Mon, 9 Mar 2020 21:26:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5b1196be-09ce-51f7-f5e7-63f2e597f91e@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/3/9 下午5:56, Alex Shi 写道:
> 
> 
> 在 2020/3/9 下午5:24, Kirill A. Shutemov 写道:
>>> check_preemption_disabled: 3 callbacks suppressed
>>> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-fuzzer/9432
>>> caller is __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
>>> CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>>>  check_preemption_disabled lib/smp_processor_id.c:47 [inline]
>>>  __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
>>>  __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
>>>  __split_huge_page mm/huge_memory.c:2575 [inline]
>>>  split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
>>>  split_huge_page include/linux/huge_mm.h:167 [inline]
>> It looks like a regression due to c8cba0cc2a80 ("mm/thp: narrow lru
>> locking").
> 
> yes, I guess so.

Yes, it is a stupid mistake to pull out lock for __mod_memcg_state which
should be in a lock.

revert this patch should be all fine, since ClearPageCompound and page_ref_inc
later may related with lru_list valid issue in release_pges.


Sorry for the disaster!

Alex
