Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE1734C8A
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFSHm7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFSHmp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 03:42:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B410CA;
        Mon, 19 Jun 2023 00:42:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ql1rG1c22ztQYY;
        Mon, 19 Jun 2023 15:39:58 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 15:42:32 +0800
Subject: Re: [PATCH] memcg: remove unneeded header files
To:     Michal Hocko <mhocko@suse.com>
CC:     <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230617072658.1826560-1-linmiaohe@huawei.com>
 <ZJABkaSdZP+K6dOh@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5f1d08ea-72af-f287-9ec5-3c485c1e4f0c@huawei.com>
Date:   Mon, 19 Jun 2023 15:42:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZJABkaSdZP+K6dOh@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/6/19 15:19, Michal Hocko wrote:
> On Sat 17-06-23 15:26:58, Miaohe Lin wrote:
>> Remove some unneeded header files. No functional change intended.
> 
> Header inclusion cleanups are certainly welcome but it would be much
> more preferred to explain why those are not needed. As build test follow
> ups show this is much more subtle than it seems.

Will make it clear in v2. Thanks for comment.

