Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01B229FB45
	for <lists+cgroups@lfdr.de>; Fri, 30 Oct 2020 03:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgJ3CaD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 22:30:03 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60283 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgJ3CaD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 22:30:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UDafu36_1604024997;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDafu36_1604024997)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Oct 2020 10:29:58 +0800
Subject: Re: [PATCH v20 02/20] mm/memcg: bail early from swap accounting if
 memcg disabled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-3-git-send-email-alex.shi@linux.alibaba.com>
 <20201029134648.GC599825@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <96b6d122-df0e-dfb0-368c-6bd714fab116@linux.alibaba.com>
Date:   Fri, 30 Oct 2020 10:27:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201029134648.GC599825@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/10/29 ÏÂÎç9:46, Johannes Weiner Ð´µÀ:
>>  ? release_pages+0x1ae/0x410
>>  shmem_alloc_and_acct_page+0x77/0x1c0
>>  shmem_getpage_gfp+0x162/0x910
>>  shmem_fault+0x74/0x210
>>  ? filemap_map_pages+0x29c/0x410
>>  __do_fault+0x37/0x190
>>  handle_mm_fault+0x120a/0x1770
>>  exc_page_fault+0x251/0x450
>>  ? asm_exc_page_fault+0x8/0x30
>>  asm_exc_page_fault+0x1e/0x30
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Roman Gushchin <guro@fb.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> This should go in before the previous patch that adds the WARN for it.

Right, but than the long ops may not weird. Should I remove the ops and resend the whole patchset?

Which way is convenient for you?

Thanks
Alex
