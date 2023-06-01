Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9677196C2
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjFAJVv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjFAJVj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 05:21:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF6124
        for <cgroups@vger.kernel.org>; Thu,  1 Jun 2023 02:21:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256931ec244so450432a91.3
        for <cgroups@vger.kernel.org>; Thu, 01 Jun 2023 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685611297; x=1688203297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SifIOg3EEC6zrsKMH+AeZTstzDtSY/mgHTMqEQiv+Y=;
        b=dPwWBIklySlVaBz8aeBqewiIOE0jlHpvIS+F8E+hS9vGXogaqy82OoWltppnH3cRu/
         cyVh89Z0tPzL4LiipOoWMj4kULvV1bjyF1ODgZcwRTHTwQP4wrdSZClAe+2yEZO5k0KG
         +xy52vL/CfNLcNbysVWiRQd2lBmFYYGdgUkRcFn06ca4weGv8vtbQLFOD98a5NvIU1h8
         3MMB9BB/QjJxePr73CbAcbJzyv86gEBsA3+TZogVj5nah9tD21ixe85Q43JaHlS5rvph
         JVLX9nxUx/CXzwXX6QAm7DNMOtv7MqwDiP8ypsAIRfUR7z3NRA2elUGaSxSyHZbcqIrK
         +lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611297; x=1688203297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SifIOg3EEC6zrsKMH+AeZTstzDtSY/mgHTMqEQiv+Y=;
        b=dgo/0eXKKnB1btY2IHhQrhaIDMvjKw+EcaDDDI2xd8SjtI7B1qgsnU6QapB7klIJle
         t0DI+e/k9nIuhscUOvVJNXPHL/eWoZHnUcdS/VWGDSFXDcBxP95NrrozdZerNr4E/jH4
         F6fcvQbdk2M/Yeg5RUGVAgLJN+iurNz5XlGj3xFRI/z2NAcfPB+31CUXYE4+hBHYC/oZ
         A8N33FEOTFoIb5uInjIjgYNRJC6gOh1dH07cF3C7kKvAR5l5m8P6pVmczSIJNLjXjxD2
         u+zmzFXjSj1VKyk0+Rq2mrC66QkKN+3AUbCHzYF/Gn/pqFDWCUgKAG1V/Y22ofuUTmBX
         Vx3Q==
X-Gm-Message-State: AC+VfDwWz327uPaATsPALEC4fqJSUKomsiTBvSaFsZpg+TyofXDf0cd1
        TJGnTzjatDFf7qookOfFD3AtiA==
X-Google-Smtp-Source: ACHHUZ7FhBkJfqewCHGUAQxAW+IJu86mq8peHjHQfuAR1O2g96/sdIGSovJaGL9FEuFwpivR11EPMA==
X-Received: by 2002:a17:90a:8a0b:b0:255:63ae:f940 with SMTP id w11-20020a17090a8a0b00b0025563aef940mr8215670pjn.36.1685611297358;
        Thu, 01 Jun 2023 02:21:37 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b00256bbfbabcfsm985328pjc.48.2023.06.01.02.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:21:36 -0700 (PDT)
Message-ID: <1fb805bc-baef-ee09-fa3a-d464af94751f@bytedance.com>
Date:   Thu, 1 Jun 2023 17:21:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Re: [PATCH v4 4/4] sock: Remove redundant cond of memcg pressure
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530114011.13368-1-wuyun.abel@bytedance.com>
 <20230530114011.13368-5-wuyun.abel@bytedance.com>
 <db32243e6cb70798edcf33a9d5c82a8c7ba556e2.camel@redhat.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <db32243e6cb70798edcf33a9d5c82a8c7ba556e2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/23 5:10 PM, Paolo Abeni wrote:
> On Tue, 2023-05-30 at 19:40 +0800, Abel Wu wrote:
>> Now with the previous patch, __sk_mem_raise_allocated() considers
>> the memory pressure of both global and the socket's memcg on a func-
>> wide level,
> 
> Since the "previous patch" (aka "sock: Consider memcg pressure when
> raising sockmem") has been dropped in this series revision, I guess
> this patch should be dropped, too?

Yes indeed, these two patches should go together. Sorry for my
carelessness.

> 
> Is this targeting the 'net-next' tree or the 'net' one? please specify
> the target tree into the subj line. I think we could consider net-next
> for this series, given the IMHO not trivial implications.

Got it, I will resend this series based on net-next.

Thanks!
	Abel
