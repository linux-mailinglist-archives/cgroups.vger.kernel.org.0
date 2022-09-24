Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5705E8AC0
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiIXJ03 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Sep 2022 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiIXJ0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 24 Sep 2022 05:26:24 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E312476B;
        Sat, 24 Sep 2022 02:26:23 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZNnt5zzXz1P6pg;
        Sat, 24 Sep 2022 17:22:10 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:26:21 +0800
Received: from [10.67.109.150] (10.67.109.150) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:26:20 +0800
To:     Tejun Heo <tj@kernel.org>, <peterz@infradead.org>
From:   "lujialin (A)" <lujialin4@huawei.com>
CC:     Zefan Li <lizefan.x@bytedance.com>, <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [question] Is it possible for userspace program to control cpu usage
 time of RT process through cgroup2 now?
Message-ID: <0a83dcd5-b7fd-811c-b8d2-062115fa8c94@huawei.com>
Date:   Sat, 24 Sep 2022 17:26:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.150]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cgroup2 dose not support controling real-time processes and the cpu 
controller can only be enabled when all RT processes are in the root cgroup.

RT stuff was being overhauled when cpu controller interface for cgroup 
unified hierarchy was being implemented in 2017. It was decided that we 
would like to wait till the RT side settles down and proceed with an 
interface that better matches RT.

Is it possible for userspace program to control cpu usage time of RT 
process through cgroup2 now? If not, how is the current state looking 
and is there any proposed solution?

