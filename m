Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AB55E40B
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiF1NJ4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jun 2022 09:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiF1NJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jun 2022 09:09:54 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13925645E
        for <cgroups@vger.kernel.org>; Tue, 28 Jun 2022 06:09:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VHiiN6W_1656421788;
Received: from 30.225.28.103(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0VHiiN6W_1656421788)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 21:09:49 +0800
Message-ID: <1c9d5118-25fa-e791-8aed-b1430cf23d36@linux.alibaba.com>
Date:   Tue, 28 Jun 2022 21:09:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
From:   "taoyi.ty" <escape@linux.alibaba.com>
Subject: Question about disallowing rename(2) in cgroup v2
To:     lizefan.x@bytedance.com, Tejun Heo <tj@kernel.org>,
        hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hi all,

I found that rename(2) can be used in cgroup v1 but is disallowed in 
cgroup v2, what's the reason for this design?

rename(2) is critical when managing a cgroup pool in userspace, which 
uses rename to reuse cgroup rather than mkdir to create a new one，this 
can improve the performance of container concurrent startup, because 
renaming cgroup is much more lightweight compared with creating cgroup.

For new features in cgroup v2, I switch to cgroup v2 and meet this 
problem, I think renaming cgroup in v2 is similar to v1 and realizing it 
is not a hard problem, so I send this mail to learn the initial design.

Thanks,
-escape
