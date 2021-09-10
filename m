Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F814066C7
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 07:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhIJFco (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 01:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIJFco (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 01:32:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5927C061574;
        Thu,  9 Sep 2021 22:31:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c6so626185pjv.1;
        Thu, 09 Sep 2021 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svfX9vrckIXv0kIsXF1Q/PyrjfnFqdiB+uHxilhWrdk=;
        b=DsoWUPYLyH10u3d1eAgto4n9+YHgGmryBuTU6J0m9Yr7KuorWxHF2yxAWPKUxWBFHM
         x2B0+3RoLsmf4Jj6mHDxW6RC1/bQK5guVuS1QaaQKBD1y9R3+sCHpUtDlY0KKKb5qRXk
         9oCPVpqniclK+QjaiuLG09eiKHArJ/W09gn5lAQmxBI9XFyvxTuIfpXCiOrSP5OH/O4F
         +V5PJLkog8EB3Se7oyPLlA+cj3bU1M3btokG2h8wHLg18TVsFnZLXjta+HxezIrvEyoX
         B7r88e18ApPdRNg+nNWe7rtHd6SGZp4sVu71gz1iAc1CeQCl6031+5br9Z4URhuohdL8
         WLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svfX9vrckIXv0kIsXF1Q/PyrjfnFqdiB+uHxilhWrdk=;
        b=41hEvMeeZhWAXE0xdmw4DjddbYcp7WhvUr9Q+PrFxMkkta7XAwwUPjB0PJjXzCsMMo
         7Ody9LIf8b5qWZhbPxsbfahEmkQxmeKGCQeJoUyhypbwWqnKmiZoUm07a/IYyglpCG0t
         3JE/BL3arqysj06iaO2m7kGQ0eIho8RlpMmn/psncLnrYkWtdTTxAuMVSCJm1EDKzp0v
         CTAPvCV9qp4JFlM+MmlPteBQYyk4zhs4XkrqfUyPjtwVwd52Z/Awgf99YmKgRd57fQ3C
         0oBcd254QVrF6fIGGX4auOeOonNyh4EgdYBqiXDM9cbbLjxsnvdpw5sWYLXAEwp0BWCX
         1tBA==
X-Gm-Message-State: AOAM530kt3KvUWYXl6bBUFR/9A3ZPmBl2iytfec6R0shxwqjSim9G4s/
        HvWnoePGuX3leqgQuacxmz8xjUy0uhs=
X-Google-Smtp-Source: ABdhPJwEvyoYNFGGCWYsnZiTj2N0FUwbbi4MlENVHaDd+k8Xq8Bi8vcgCw/F6v2GQRdx7GTdznXCUg==
X-Received: by 2002:a17:902:b601:b029:12b:d9a:894f with SMTP id b1-20020a170902b601b029012b0d9a894fmr5884186pls.63.1631251893206;
        Thu, 09 Sep 2021 22:31:33 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id mv1sm3692398pjb.29.2021.09.09.22.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 22:31:32 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vipin Sharma <vipinsh@google.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
Date:   Fri, 10 Sep 2021 13:30:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTpY0G3+IJYmGbdd@blackbook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Thanks for your time.

Michal Koutný wrote on 2021/9/10 2:56 上午:
> On Thu, Sep 09, 2021 at 09:49:56AM -0700, Vipin Sharma <vipinsh@google.com> wrote:
>> We are adding two files in this patch series, misc.events and
>> misc.events.local. I think "fail" should go in misc.events.local and
>> its name should be changed to "max".
> 
> I consider the max vs fail orthogonal to local vs hierarchical. I.e.
> both entries can be in both files:
> 
> (1) misc.events.local:max	number of times the cgroup's misc.max was hit
> (2) misc.events.local:fail	number of times operation failed in the cgroup
> (3) misc.events:max		number of times the cgroup's misc.max was hit in the subtree
> (4) misc.events:fail		number of times operation failed in the subtree
> 
> Is that too many? Admittedly, I assume (1) and (4) will be the more useful ones.
> However, I'm afraid overloading "max" as suggested might be (more)
> confusing. ('subtree' above := self or descendant)

I am a bit confused here. For misc_cgroup, we can only be rejected when the count
touch Limit, but there may be other more reasons for other subsystems. Therefore,
when we are rejected, does it mean that we have touch Limit? If so, do we still
need to distinguish between max and fail? (for misc_cgroup)

> Michal
> 
