Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD52258E482
	for <lists+cgroups@lfdr.de>; Wed, 10 Aug 2022 03:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiHJBbN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 21:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiHJBbL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 21:31:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A7A2AFF
        for <cgroups@vger.kernel.org>; Tue,  9 Aug 2022 18:31:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so646365pjk.1
        for <cgroups@vger.kernel.org>; Tue, 09 Aug 2022 18:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jArUS+cTDYrc34PVoRCPXKulj9z0Omh43tDAwlnBe04=;
        b=q6v8963dnNMz7nntm/3Rkm2/pPAeQvZ68R1TjZNVjNGTvgs6GYfS9Zsg888AKEaQSk
         ITgVZHKn5W6QHF1JYsP5vCpSdHO9NQlCBC2Z5DRVUMhEPNDXg+kZ4D4v7o7R2UoISGuk
         RzOKhIR3iJ5OdBOmoTcqzoJXJVZkaAJoVi2C60AsWLNwIBX4DQLI/Lc1+JVj+ynGe77J
         z88XqIDu+2Zh8WYB/nqhfbCsqsMUoAk/KkJdvBfUpJbV4K+pPcFCWz49p+pw4jUTccwn
         xp1YxVvk0IsJCEnppqbKMvnxkQirm5wazIlNeoIYMTTHBoSA25f68A+vuB+fGnT/LAwx
         0smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jArUS+cTDYrc34PVoRCPXKulj9z0Omh43tDAwlnBe04=;
        b=4cMAMfnhp3AI/amF1qvJ63rEcwkKFkXIUZdVJ/JBdRwnfIAoZB9sSpa32joESxmL36
         oXM5HD39DezvKd/Y7pcSmblVbC2zHmZngZAK4SYVPVZdXIhN5PHJ3/UBCGqmz83FVphA
         ewjy7bkrBciT7XO+T/8C7E4W4gABIjLkezUVdttFC0E4Xo1fak6oWwya+EJPtw/A3nmZ
         P+v/XZjo5jsb9yLZxN4CqHYGrUlQpkJaDizu7prHWvzoQ7B2ZkeVZm4i8afpiwdErwN1
         EqJuKOiU7U4vXBH9qqaNHLlu/pipoVkjzTQuDhq6R+KKOGoOvSLXlifDHeK0Sdak7mtB
         0xRw==
X-Gm-Message-State: ACgBeo1DymvDlamLVsJUpT6v1R3TCJDOMPGOInwL10Du2F/hXv9GKYE2
        Q/IjEtQvdoN/bZE/BRTyQPj33w==
X-Google-Smtp-Source: AA6agR7BLT3O6pJwmoNbS0ABHMXRhfGmTLSClhLCrhYSoJTn7kkIjqU4c2KyxC+3G7/tpmrYadq8gA==
X-Received: by 2002:a17:90b:3586:b0:1f4:d507:783e with SMTP id mm6-20020a17090b358600b001f4d507783emr1158932pjb.171.1660095068808;
        Tue, 09 Aug 2022 18:31:08 -0700 (PDT)
Received: from [10.4.175.112] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a2dc100b001f21f5c81a5sm243187pjm.19.2022.08.09.18.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 18:31:08 -0700 (PDT)
Message-ID: <b89155d3-9315-fefc-408b-4cf538360a1c@bytedance.com>
Date:   Wed, 10 Aug 2022 09:30:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats
 disable/re-enable interface
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     hannes@cmpxchg.org, corbet@lwn.net, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
 <20220808110341.15799-10-zhouchengming@bytedance.com>
 <YvKd6dezPM6UxfD/@slm.duckdns.org>
 <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
In-Reply-To: <fcd0bd39-3049-a279-23e6-a6c02b4680a7@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/10 08:39, Chengming Zhou wrote:
> On 2022/8/10 01:48, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Aug 08, 2022 at 07:03:40PM +0800, Chengming Zhou wrote:
>>> So this patch introduce a per-cgroup PSI stats disable/re-enable
>>> interface "cgroup.psi", which is a read-write single value file that
>>> allowed values are "0" and "1", the defaults is "1" so per-cgroup
>>> PSI stats is enabled by default.
>>
>> Given that the knobs are named {cpu|memory|io}.pressure, I wonder whether
>> "cgroup.psi" is the best name. Also, it doesn't convey that it's the
>> enable/disable knob. I think it needs a better name.
> 
> Yes, "cgroup.psi" is not good. What abort "pressure.enable" or "cgroup.psi_enable"?

Doesn't look good either, what do you think of "cgroup.pressure.enable"?

Thanks.

