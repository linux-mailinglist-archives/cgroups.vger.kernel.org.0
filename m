Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289A233BF85
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhCOPNz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhCOPNx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:13:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20104C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:13:53 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d20so34795256oiw.10
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MvLffGY2PDS6HPT4gIfMBvNzZ4NCk1hS/akJFXwFv14=;
        b=dbLAM1WhoHTn5xOOeGVbScgJG8gKQo/OU/0p6mPUVY8/4ztpqRilTab/zD2yGj8jFV
         SZ75dAe4FSJby+OEsdztV8G6t3PwMNXiFcN/a6Ktn/7my3KQkW6FuQGOQFqLjfiVJ7f9
         F85VM8OUp1CMxUf730d5r299PKD0Ro+Di0SlRDXrw3K2bxqsV+pvqUSj18U56UPe+mgt
         PgOKe9oq190jzbwH018/UWMDnCvztwrydvpgdfsq0ASIfniK4xBmDfu2bZORyJG5vTGT
         KM148mzuMsV37ZSwJ44qdikeMjx+SGTn+RpUvh78GWpH1QC6W/WYwEfSWbh1WeiQ03ZO
         jlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MvLffGY2PDS6HPT4gIfMBvNzZ4NCk1hS/akJFXwFv14=;
        b=jYzNl285aidsMWymrjb423hCsVCXQDyE1kY/Agxd65QBdhObTDKTwjFKiQSSPm8rk/
         bn2Fl92P1aHipTvFTwNkJUd+AN0VVYZIVwTJDNYjNLr7m0Z2CMzKgcpb1GncgG5UjSzR
         6LjEeofnRkR8npI33lU3+iLuklCYEoFGyZrLaqigcRkR0S/XFqoejCVa5mxcdOVnQRVq
         yyl0tmMqci5cLADYgUHcch40k3cJlp0enzI1IFmDapw2Qzn8BMq3ravQQsg7o9yKRMlA
         WphSce1M5BgJEkbRV0FFGOJoK6wRBtrGkIIctXjxw3tKyoVF7DAifm0HQL48L/bHNFEa
         gZ1g==
X-Gm-Message-State: AOAM53260UwH4bprX1+eEe3R3kBmnD7zDvorlLwIiqQFkGzjNGJGiICc
        F3kzT+rO/iX3s6OXJEwr0bR66zW+MPU=
X-Google-Smtp-Source: ABdhPJx7c0SgRBxx0OuCYhCrmq64zkwdaXggmOYaaEF6EG6NupRRMnLM+tMn2QRBtFrLqaK4G9KwyA==
X-Received: by 2002:a05:6808:148a:: with SMTP id e10mr18888386oiw.138.1615821232643;
        Mon, 15 Mar 2021 08:13:52 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.56])
        by smtp.googlemail.com with ESMTPSA id f197sm7496157oob.38.2021.03.15.08.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:13:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
To:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <39f3f0ba-e169-f44f-3aae-5ebaca3c42a0@gmail.com>
Date:   Mon, 15 Mar 2021 09:13:50 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
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
> One such object is the 'struct fib6_node' mostly allocated in
> net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:
> 
>  write_lock_bh(&table->tb6_lock);
>  err = fib6_add(&table->tb6_root, rt, info, mxc);
>  write_unlock_bh(&table->tb6_lock);
> 
> It this case is not enough to simply add SLAB_ACCOUNT to corresponding
> kmem cache. The proper memory cgroup still cannot be found due to the
> incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
> To be sure that caller is not executed in process contxt
> '!in_task()' check should be used instead
> ---
>  mm/memcontrol.c    | 2 +-
>  net/ipv6/ip6_fib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>


