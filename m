Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BCB715ADE
	for <lists+cgroups@lfdr.de>; Tue, 30 May 2023 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjE3J6q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 May 2023 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjE3J6p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 May 2023 05:58:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DCBA3
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 02:58:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so1057192a91.2
        for <cgroups@vger.kernel.org>; Tue, 30 May 2023 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685440700; x=1688032700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmz6Z7NUWk0U026+5Q0T6CzUzMYytLkTng8HlWy5Lg4=;
        b=iettzvPTOMlgAHfkVY1pS+qqpIpB2PLO5C8dRw6KQRujBajTAL8JD/241Bty/FRLjz
         9s4iBi5fUThcbTsop2dBSPpWY8pQlaROVBqEShVgYP2QADtbotxRMzdurP4sveqF4v5l
         bep8dihv0HzugpAtHfbYgA9QSk+bN9QuV6G/i2qx2JC57dXj85puYaB4rwWAB2hHSfo3
         HtQNjQVoSoQ1gqKdnESow3SdjfNShjC5FxSWHmqXreZrB1WSWpc3Rnk9x5ICwkavB/2N
         h3IjZm8TacNSoTjLzCxgvkdlRjTk9O4eLCLKj+0vOksGRzCpNIohHIq+3jgaBLTMwvI5
         inJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440700; x=1688032700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmz6Z7NUWk0U026+5Q0T6CzUzMYytLkTng8HlWy5Lg4=;
        b=asTiGWF1KuM5V8UJgZJv9+fIgyFQelbzSlCTbt8aKowYe3lBkLvjNsb2fBhykPQE21
         yixRroBCpMvQwcRgtVTm1flXgypJk6SdLpOTiCxSWm8I8LK0C/dAfdDIHPyoc6MfXq1l
         fwKtzVPfpGhDIhnYfmYfd5GfIjpAcDNbMLgJNdrVpLfv7zpGwVmzYNi/4qAPW5ftNDfO
         IPbpXr05Cl1M+MPo8wkD2kQOXKeWuNusS7Z+S5diwAd0HaD5B5S5FVqg9dDYmKOCfsSz
         X4XTEzncdScYHLPwy/xzhwk1Dm+NiKFhxcAxr2Ij92h7Gt5fY6/nhAI4916luc3B+b35
         3CEw==
X-Gm-Message-State: AC+VfDxcjSr5Sli7B0umVBHdBePB3VLOrZv2RBnXUA8gD7WruUOoa2Bt
        OaHLov815MXQgq/bft0OhUwBjA==
X-Google-Smtp-Source: ACHHUZ6p1Z3EqBsdp/RqVMEmZmIFHNjD3bJwaRcnPXJc1KpOkq694fn/fRX0XIQ9hPrPSn83MYTSMA==
X-Received: by 2002:a17:90a:d510:b0:256:807c:62b with SMTP id t16-20020a17090ad51000b00256807c062bmr2085681pju.0.1685440700394;
        Tue, 30 May 2023 02:58:20 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090a1c1600b002533ce5b261sm11066413pjs.10.2023.05.30.02.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:58:19 -0700 (PDT)
Message-ID: <529f97d7-d9b7-2049-0c9d-a8d6a23b430b@bytedance.com>
Date:   Tue, 30 May 2023 17:58:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: Re: [PATCH v2 3/4] sock: Consider memcg pressure when raising
 sockmem
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20230522070122.6727-1-wuyun.abel@bytedance.com>
 <20230522070122.6727-4-wuyun.abel@bytedance.com>
 <20230525012259.qd6i6rtqvvae3or7@google.com>
 <73b1381e-6a59-26fe-c0b6-51ea3ebf60f8@bytedance.com>
 <20230529211205.6clthjyt37c4opju@google.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230529211205.6clthjyt37c4opju@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/30/23 5:12 AM, Shakeel Butt wrote:
> 
> +linux-mm and cgroups
> 
> On Mon, May 29, 2023 at 07:58:45PM +0800, Abel Wu wrote:
>> Hi Shakeel, thanks for reviewing! And sorry for replying so late,
>> I was on a vocation :)
>>
>> On 5/25/23 9:22 AM, Shakeel Butt wrote:
>>> On Mon, May 22, 2023 at 03:01:21PM +0800, Abel Wu wrote:
>>>> For now __sk_mem_raise_allocated() mainly considers global socket
>>>> memory pressure and allows to raise if no global pressure observed,
>>>> including the sockets whose memcgs are in pressure, which might
>>>> result in longer memcg memstall.
>>>>
>>>> So take net-memcg's pressure into consideration when allocating
>>>> socket memory to alleviate long tail latencies.
>>>>
>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>
>>> Hi Abel,
>>>
>>> Have you seen any real world production issue which is fixed by this
>>> patch or is it more of a fix after reading code?
>>
>> The latter. But we do observe one common case in the production env
>> that p2p service, which mainly downloads container images, running
>> inside a container with tight memory limit can easily be throttled and
>> keep memstalled for a long period of time and sometimes even be OOM-
>> killed. This service shows burst usage of TCP memory and I think it
>> indeed needs suppressing sockmem allocation if memcg is already under
>> pressure. The memcg pressure is usually caused by too many page caches
>> and the dirty ones starting to be wrote back to slow backends. So it
>> is insane to continuously receive net data to consume more memory.
>>
> 
> We actually made an intentional decision to not throttle the incoming
> traffic under memory pressure. See 720ca52bcef22 ("net-memcg: avoid
> stalls when under memory pressure"). If you think the throttling
> behavior is preferred for your application, please propose the patch
> separately and we can work on how to enable flexible policy here.

Ah I see. Thanks for providing the context. So suppressing the alloc
under memcg pressure could further keep senders waiting if SACKed segs
get dropped from the OFO queue.

> 
>>>
>>> This code is quite subtle and small changes can cause unintended
>>> behavior changes. At the moment the tcp memory accounting and memcg
>>> accounting is intermingled and I think we should decouple them.
>>
>> My original intention to post this patchset is to clarify that:
>>
>>    - proto pressure only considers sysctl_mem[] (patch 2)
>>    - memcg pressure only indicates the pressure inside itself
>>    - consider both whenever needs allocation or reclaim (patch 1,3)
>>
>> In this way, the two kinds of pressure maintain purer semantics, and
>> socket core can react on both of them properly and consistently.
> 
> Can you please resend you patch series (without patch 3) and Cc to
> linux-mm, cgroups list and memcg maintainers as well?

Yeah, absolutely.

Thanks,
	Abel
