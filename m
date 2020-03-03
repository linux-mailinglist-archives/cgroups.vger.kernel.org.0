Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4517726C
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 10:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCCJcs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 04:32:48 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33759 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727644AbgCCJcs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 04:32:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TrXu9-Z_1583227964;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrXu9-Z_1583227964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Mar 2020 17:32:44 +0800
Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        Rong Chen <rong.a.chen@intel.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200302141202.91d88e8b730b194a8bd8fa7d@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <59634b5f-b1b2-3b1d-d845-fd15565fcad4@linux.alibaba.com>
Date:   Tue, 3 Mar 2020 17:32:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302141202.91d88e8b730b194a8bd8fa7d@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/3/3 ÉÏÎç6:12, Andrew Morton Ð´µÀ:
>> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
>> and Yun Wang.
> I'm not seeing a lot of evidence of review and test activity yet.  But
> I think I'll grab patches 01-06 as they look like fairly
> straightforward improvements.

cc Fengguang and Rong Chen

I did some local functional testing and kselftest, they all look fine. 0day only warn me if some case failed. Is it no news is good news? :)

Thanks
Alex
