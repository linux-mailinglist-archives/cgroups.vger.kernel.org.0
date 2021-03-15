Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1D33BF8A
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCOPO1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhCOPO0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:14:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F8C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:14:25 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so5294831otr.4
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N4xTXJC3aSsvD0Tu2z/4hlaOiEJQneTxtWXS9WYbxG8=;
        b=M1Ya5zZ20aqVyvZ85hmde/EHfI5AObsfSfDrA87a21Ht4oI1Zmm7fH6gB2LcmyOger
         q5nPekECsbI4RLwiNAbf7epVDO84pP9BILC1Cod74cIPrC4D11b9Z/XJpnlBQKDNkR1G
         H54YjO0tsu3nSrLroPjSz0POB6CSRemuxDjKupePjHPqZ+6qfBdKXJd4qcEnvrwRoZgQ
         FeBZ/6Fn5q+jBkVm9Ohigril5diIuurWSi0P3xRRda93d6oCv8kSdUj4bYDLNZToEC4f
         lT80xEJFVSZi8J1t9lsLAFOqJeEVkboy4N3FZ0ALelUqPjcL+K758wvqWHJz4SvxEqvh
         bK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N4xTXJC3aSsvD0Tu2z/4hlaOiEJQneTxtWXS9WYbxG8=;
        b=ZLCqD6xUe6U2jyPM810IGPzIrXsU3mXyFoDrbX6O9SETtm8wXkkNosAmOamNdT31bV
         5ccCMZslc0KHEEzKXrKn8sPq4mhlq6UtGmd4VkQTf054HXbUmUK0UQl2h2tpbDSLaehx
         gUioI5TZGVBVgrHj5wthIq+t5SFombgr61VsgZs+MxRJ+OwndjjcxIsS7QFKAuH2LvnP
         v65TCNFAc6YtRxckddqKZcq40zPArhl+Xse8wLToGFXM0LsggwCgMVTnCLUJNLYS1ih+
         /Su5+10urDFplZJ0jnMjUXharGr8MDpzCtXI4xWCkmswRGIli28lSX5RBwylH40DNUD6
         kcFQ==
X-Gm-Message-State: AOAM531n1k0Pyf9XU/CCe7HUqc835UMcLSIc/xTr9F5CFP8p9uQwbSgF
        6oqwBNerr4yM6Zdg9+1rvko=
X-Google-Smtp-Source: ABdhPJz27WDfwQZmf6OhzuUEXGbDVVeVx0+IVOUN4j1Vc+BB1xQ9kMFUSo5/6C+DADDHXNjSFh+RqA==
X-Received: by 2002:a9d:2f65:: with SMTP id h92mr14748322otb.327.1615821265396;
        Mon, 15 Mar 2021 08:14:25 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.56])
        by smtp.googlemail.com with ESMTPSA id f22sm7112813otl.10.2021.03.15.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:14:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] memcg: accounting for ip6_dst_cache
To:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <8196f732-718e-0465-a39c-62668cc12c2b@virtuozzo.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a3d819f5-0291-0ba1-c5f8-42392d0404ad@gmail.com>
Date:   Mon, 15 Mar 2021 09:14:23 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8196f732-718e-0465-a39c-62668cc12c2b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/15/21 6:23 AM, Vasily Averin wrote:
> An untrusted netadmin inside a memcg-limited container can create a
> huge number of routing entries. Currently, allocated kernel objects
> are not accounted to proper memcg, so this can lead to global memory
> shortage on the host and cause lot of OOM kiils.
> 
> This patches enables accounting for 'struct rt6_info' allocations.
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>


