Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EB21C183
	for <lists+cgroups@lfdr.de>; Sat, 11 Jul 2020 03:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgGKBDb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 21:03:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58088 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgGKBDb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 21:03:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2KGBNi_1594429405;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2KGBNi_1594429405)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Jul 2020 09:03:26 +0800
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <58ceebd9-5e0e-4b78-c9e9-612ed501695d@linux.alibaba.com>
Date:   Sat, 11 Jul 2020 09:02:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hugh,

I believe I own your a 'tested-by' for previous version.
Could you like to give a try on the new version and give a reviewed or tested-by
if it's fine.

Thanks
Alex 
