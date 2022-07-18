Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248BE577CBA
	for <lists+cgroups@lfdr.de>; Mon, 18 Jul 2022 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiGRHmm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Jul 2022 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRHmk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Jul 2022 03:42:40 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E017617582
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 00:42:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJeuGyX_1658130154;
Received: from 30.227.85.72(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0VJeuGyX_1658130154)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 15:42:35 +0800
Message-ID: <5ee0bd70-5381-1219-7a52-772f80a11b52@linux.alibaba.com>
Date:   Mon, 18 Jul 2022 15:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Question about disallowing rename(2) in cgroup v2
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     lizefan.x@bytedance.com, Tejun Heo <tj@kernel.org>,
        hannes@cmpxchg.org, cgroups@vger.kernel.org
References: <1c9d5118-25fa-e791-8aed-b1430cf23d36@linux.alibaba.com>
 <20220715124538.GB8646@blackbody.suse.cz>
From:   "taoyi.ty" <escape@linux.alibaba.com>
In-Reply-To: <20220715124538.GB8646@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Michal

Thanks for your reply.

在 7/15/22 8:45 PM, Michal Koutný 写道:
> Strictly speaking, it's not critical if you decouple your job and cgroup
> naming scheme (i.e. use the cgroup with the old name).

Though using the cgroup with the old name is ok, but naming rule of 
cgroup used by container is containerd-<ID>, it's confusing for 
different containers to use cgroup with same name

> Do you have some numbers for this?
For 200 container concurrent startup, it can reduce 94% of the cgroups 
creation time if using cgroup pool based on cgroup1_rename(). More 
detail data can be seen in section 3.3 and 4.4 of 
https://www.usenix.org/system/files/atc22-li-zijun-rund.pdf

> You can save work with not rmdir/mkdir'ing but you mention
> concurrent startup specifically. And you still need to (re)setup
> the cgroups after reuse and that also isn't parallelizable (at least you
> need to (re)populate each reused cgroup, which is mostly under one
> lock). (Even cgroup1_rename() has an exclusive section under
> cgroup_mutex but it looks relatively simply.)
Yes, reusing cgroup isn't parallelizable, it just eases but doesn’t 
solve the underlying problem. The current bottleneck has been solved 
temporarily by cgroup pool, how to make creating cgroup and attaching 
tasks parallelizable requires more thought and research

Thanks.

Escape
