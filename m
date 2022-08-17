Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB15972CC
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiHQPTc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiHQPTc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 11:19:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794851A046
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 08:19:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s4-20020a17090a5d0400b001fabc6bb0baso834075pji.1
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2Dzsz0z2prfhgcbdQayKeKRlLfrKQM5D6pSVBtZ7THM=;
        b=GCmgVkz+4yjg/OIcr2ND13CCDmdSh+WHCUT6HE9iMQmhjE4cFo3stnG1YrZoN7u2jA
         X50ubaDBe2N1zPHvWHi9l/NTCLsojyti+EbEBmECP0yxN9mvcFwnCZX6U5UqWeZGV4vd
         UCp9Jj4DkuFnJ2uB+xOIyniJjwYfbdnuS0eTVMFLTlWm6kt96GEZeZSsspDqrubXzuck
         DUXXm+Jxw/p/0xP9Atph6ZbCIOrc4E7iEKFavcTiP8r0rI29yFs4MdI82C1dJhvpqOGK
         /2v7aN9fekT9Dl2kwXvNX5ouI+kmQ6XKxIBpmWB8XiS2dvIP6Annb8vwO7R2MwF9gMdK
         ncag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2Dzsz0z2prfhgcbdQayKeKRlLfrKQM5D6pSVBtZ7THM=;
        b=uDRiBOaFGaD23c9OsUFG7DydwE1bivpF47lrf0nnd8sU+Aa+o8Y1d7/+C6KKnWTqvx
         pASl0hwJCfbRNnzgPzzTw2ol/Jeet95H6hxnjj+CKk5YWZLL2yYdHzyS7qhotOn5XbXh
         Rokk+Hqeyhc7eYFLqAKqbRAVZ9TQcZmCEdGZB/w3l4JEkDLPOMPENfRPdHpbQiSKdFcP
         5d6yZ8xxe7eFOMMW43dYFKe4Mzv5HCuUaUQH00serocMgYhPe0ma+4c2TcOECBT8B9e4
         pbFiY0dTRaOJpMHfRzxey/BfIqmjCj7VOL3zFqjU+q06z/SN0b60b45VkSBwyFkJVDv7
         PqRw==
X-Gm-Message-State: ACgBeo3vI+W6DgAi7Inc035e/goQJX2oaS0wu7ejqIfvtqw5EsupUxRz
        7wL6Y/StnyStdt0v6SJbMJYhaQ==
X-Google-Smtp-Source: AA6agR6kokDwE6+pMf5BQdL0piGfoMv4TNps5u+H7z2eEXQEoh698ZXAEgsCRmvmL5MAXJWLFaNIWw==
X-Received: by 2002:a17:903:2589:b0:16d:c26c:d641 with SMTP id jb9-20020a170903258900b0016dc26cd641mr26813781plb.8.1660749570010;
        Wed, 17 Aug 2022 08:19:30 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e63:2e90:498e:2d75:1610:f371? ([2409:8a28:e63:2e90:498e:2d75:1610:f371])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b0052dc3796cbfsm10562485pfb.75.2022.08.17.08.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:19:29 -0700 (PDT)
Message-ID: <42c6d11d-d68a-e869-375e-550c495be5bb@bytedance.com>
Date:   Wed, 17 Aug 2022 23:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v2 00/10] sched/psi: some optimization and extension
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220815132514.GB22640@blackbody.suse.cz>
 <08ec9c4f-80b2-f731-aa8b-fb4e852ece25@bytedance.com>
In-Reply-To: <08ec9c4f-80b2-f731-aa8b-fb4e852ece25@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/16 22:01, Chengming Zhou wrote:
> On 2022/8/15 21:25, Michal Koutný wrote:
>> On Mon, Aug 08, 2022 at 07:03:31PM +0800, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>> This patch series are some optimization and extension for PSI,
>>
>> BTW do you have some numbers/example how much these modifications save
>> when aggregated together?
>>

Sorry about delay...

Performance test using mmtests/config-scheduler-perfpipe in /user.slice/user-0.slice/session-4.scope

                                 next                patched       patched/only-leaf
Min       Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
1st-qrtle Time        8.90 (   0.00%)        8.58 (   3.63%)        8.05 (   9.58%)
2nd-qrtle Time        8.94 (   0.00%)        8.61 (   3.65%)        8.09 (   9.50%)
3rd-qrtle Time        8.99 (   0.00%)        8.65 (   3.75%)        8.15 (   9.35%)
Max-1     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
Max-5     Time        8.82 (   0.00%)        8.49 (   3.74%)        8.00 (   9.32%)
Max-10    Time        8.84 (   0.00%)        8.55 (   3.20%)        8.04 (   9.05%)
Max-90    Time        9.04 (   0.00%)        8.67 (   4.10%)        8.18 (   9.51%)
Max-95    Time        9.04 (   0.00%)        8.68 (   4.03%)        8.20 (   9.26%)
Max-99    Time        9.07 (   0.00%)        8.73 (   3.82%)        8.25 (   9.11%)
Max       Time        9.12 (   0.00%)        8.89 (   2.54%)        8.27 (   9.29%)
Amean     Time        8.95 (   0.00%)        8.62 *   3.67%*        8.11 *   9.43%*


Thanks!
