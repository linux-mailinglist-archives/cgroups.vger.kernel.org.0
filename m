Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2326C807A
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCXO43 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjCXO40 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 10:56:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517AC7D8B;
        Fri, 24 Mar 2023 07:56:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088F011FB;
        Fri, 24 Mar 2023 07:57:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754B23F6C4;
        Fri, 24 Mar 2023 07:56:21 -0700 (PDT)
Message-ID: <6dd8bfad-b2d8-1d87-63ed-fd6882a17f6a@arm.com>
Date:   Fri, 24 Mar 2023 15:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/2] sched/cpuset: Fix DL BW accounting in case
 can_attach() fails
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Qais Yousef <qyousef@layalina.io>, Wei Wang <wvw@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
 <ZBwc4l0ZyyRQPiSP@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZBwc4l0ZyyRQPiSP@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 23/03/2023 10:33, Juri Lelli wrote:
> Hi,
> 
> On 22/03/23 14:59, Dietmar Eggemann wrote:

[...]

> This makes sense to me. Thanks for working on it!
> 
> Guess I might incorporate these in my (RFC) series and re-post the whole
> lot?

Yes, please do so.
