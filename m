Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F336D9A8E
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjDFOh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbjDFOho (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:37:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5B6B770
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:35:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l14so25889126pfc.11
        for <cgroups@vger.kernel.org>; Thu, 06 Apr 2023 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680791657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6B8WILcVPZkFHn7fuQhYBzfHKFx9fU8cwkns1fF9d0=;
        b=AIbzpnMbfgEcISAfvM0ZqDPjxCflIy7Bjr+w8Hoa9c4tyfutVUcOuhVy1uPqDCLN8o
         l2hXaWvIar5w34wTkmMTh916W5QufMl6gYWrBx84ksfKr5V0t1J46nv8NyAAgiMxooYH
         WWKwUSngOqDNX7gSnTmn1D3C9FpkFUV2eC6w69VAeEVKFX9YvDNYhB5ORZs+gPdAkeKR
         NA7oG+YnIn0VJIgaxex2cbj/BzhIlpmNbjOwjJL8NdWMD5QzdXUPiBJePwezcKHZbwgu
         BIZaG0rdrX3djh3P4C2XAfMXCQsU3jWticdWb0wXVg4WbhYgQGwpdeEfeYze+HJb4qNR
         uEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6B8WILcVPZkFHn7fuQhYBzfHKFx9fU8cwkns1fF9d0=;
        b=NBIo8kNhVBupS9nfdf0tOsELbT/CjHH0XKwltiDoV+2MWbWh+u1jY1/KpUG/e9uA2K
         g25jgr7AGbc1YNfZK3Y6/MTza28qmeN7tAeTiscnxI86HT4jnFFLyKVJdDxjBGcJli6j
         x+m/y/MUtiTMh1XzRhsb5q1Je5qKekMwXxXYA6Vo+HKGBZkedEPTQJrPMDUrqAEZqD1Z
         Utte/fxTIyOmpUB6jRCIDmbOMAn7Z0Mi2FqMQkTDpBV1afQ2MWwmOLQ4kUZ3zZFFLwAU
         BZhbN0m5fYO1SBmbHBZg7EwgE46SkYkJwwGZM5oXORkrNGBB/+Z7EKqN9OdSzFe5rb5z
         d6sQ==
X-Gm-Message-State: AAQBX9e66bEb3iS2vC7LIqVEYC++coEQ8b29VswcBQb3cQlh3yDH9TWs
        MWjXIXqnvE7xGjvU4EwB3bDRAg==
X-Google-Smtp-Source: AKy350ZAIzvvXjHG1dKqxuD65cj01SveLdRnp/W1/U8iPKSXPOQPdJcAL2U2qXfVTnlM+7Su3FMuCQ==
X-Received: by 2002:aa7:9ec8:0:b0:62e:407:fc69 with SMTP id r8-20020aa79ec8000000b0062e0407fc69mr10084557pfq.21.1680791656870;
        Thu, 06 Apr 2023 07:34:16 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e63:f500:18d3:10f7:2e64:a1a7? ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b0062d848b7a9esm1440545pfo.153.2023.04.06.07.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:34:16 -0700 (PDT)
Message-ID: <4cb0dfbc-d546-ed1e-b951-e37104a3f691@bytedance.com>
Date:   Thu, 6 Apr 2023 22:34:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
To:     Tejun Heo <tj@kernel.org>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
 <ZCSKirFH8f1JdQS2@slm.duckdns.org>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <ZCSKirFH8f1JdQS2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/3/30 02:59, Tejun Heo wrote:
> On Tue, Mar 28, 2023 at 10:56:58PM +0800, Chengming Zhou wrote:
>> BFQ_WEIGHT_LEGACY_DFL is the same as CGROUP_WEIGHT_DFL, which means
>> we don't need cpd_bind_fn() callback to update default weight when
>> attached to a hierarchy.
>>
>> This patch remove BFQ_WEIGHT_LEGACY_DFL and cpd_bind_fn().
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> For 1-3,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thanks, I will drop the last patch and send v2 with the tag.

