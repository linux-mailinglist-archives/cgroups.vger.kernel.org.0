Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA3512587
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiD0WwA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 18:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiD0WwA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 18:52:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04089CEB
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 15:48:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq30so5612553lfb.3
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SQk+uPdXjus9l+tZCRcT7jspmYgklYtunIPDK1R0FPo=;
        b=4be664J+OKOeBO0o8b8/lSmk7jn8HmLIxoeRFfTKVZp/qfcuXsj0nn0H7AsnMzYhl1
         ES/5EofZCQG+lU25D5qAXkc8AWQpCGUfz9nDBy6CFgdN3kWmzPKWPX3ouImm0xjv8Hot
         Q1nLzcRXHoGKjZZq2Ugu0RFU8yN4C0APkgUeDUB6KrZ1trEszX9xLoTyIm2bJLDwMNdk
         N7W3FgisFjh7vg/mDxMWbdPH84tzDYTOBZqlPWxH+fPixhU1X26YGN658TZN77CaspzE
         6acX8xvHwftaEXxYqp5UMxc8oAGQBmwZm+vxqUqGmkQKqvGDa+d8noiqD3E455dFClQ1
         3Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SQk+uPdXjus9l+tZCRcT7jspmYgklYtunIPDK1R0FPo=;
        b=S8ovboxvRkOGmPmdi1DCue9SsVMFTK7XZkIazhjXmK5+Ak5pD/ahQxHlyWDA9HU21W
         RsmL//WdRUkOerpuI7tnIFD3/e6XuInYaPbUR0LNFk9/vMvN76ZE+ufz53NFDzNGCRri
         MLe9GBU8lz8rMIRn57FeIRQAZ1iRl6mLDeLGYBo1e7rHYM8GF28lzaUsfLECI1oPKQkQ
         fKFiGNsRF3E0g043XkhFjHqeQ0M5sq9I90MbWps8gYnWDwRZlmmwQXG9wEF12Ebip9zV
         sOusjz8wLILF29g1WdNUR6KhNn1dYnw0XOVRhlK7KbsLvleJob7XonbJMnqrnlbglOqk
         zF+A==
X-Gm-Message-State: AOAM531mxwZbXRviNHq5RyaEWxZPo5TY63xdFlMhycKeIwhVL6KyCBni
        CMN1gK9YpQevQoEdkxCavR6/9g==
X-Google-Smtp-Source: ABdhPJz73JY3yLDUY6xr/jjV4y8SsKN6H0NWeoiwZQ6xAk04KGa1rAljireM7SzoraFwJvt6CG+IFw==
X-Received: by 2002:a19:4f10:0:b0:471:fb4e:bf28 with SMTP id d16-20020a194f10000000b00471fb4ebf28mr16129205lfb.274.1651099725237;
        Wed, 27 Apr 2022 15:48:45 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id h10-20020ac24daa000000b00471f8c681fdsm1740502lfe.233.2022.04.27.15.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:48:44 -0700 (PDT)
Message-ID: <9600b84a-8590-4e7b-c74d-3f52fe905e7f@openvz.org>
Date:   Thu, 28 Apr 2022 01:48:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memcg: enable accounting for veth queues
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
References: <1c338b99-8133-6126-2ff2-94a4d3f26451@openvz.org>
 <20220427095854.79554fab@kernel.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220427095854.79554fab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/27/22 19:58, Jakub Kicinski wrote:
> On Wed, 27 Apr 2022 13:34:29 +0300 Vasily Averin wrote:
>> Subject: [PATCH] memcg: enable accounting for veth queues
> 
> This is a pure networking patch, right? The prefix should be "net: ",
> I think.
Thank you for the remark, I'll fix it.

Initially it was a part of the patch accounted resources accounted 
when creating a new netdevice, but then I moved this piece to
a separate patch, because unlike other cases, it is specific to veth.
 
Thank you,
	Vasily Averin
