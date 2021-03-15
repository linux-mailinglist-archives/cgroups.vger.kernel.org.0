Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE833BF8E
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhCOPQD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhCOPPp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:15:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92004C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:15:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l11so4108141otq.7
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=np/p9Ih58kbyvM0hIUqkXcnFFKPhSSCXOoOrFZ44REo=;
        b=MUPk/pbvsn449ONYJk455H6Kc7gE2u7S1noOh1h4Ceekj651HdpXnqPF/fmlu5WPOY
         DEMZjWTp3NjUYHaEVjXHq9/IpuVXsQNeu0rECQ2cRPbOYtmxEGxnt3Zw182ID7NEz35P
         CIUegNIVDabVbfTwMJT6CQUvgQNwZva/YpRFrAvOxpnGrB6pQBpNIQ40cU8N8bMx9eGl
         oUS6TFxnnRHPRrwCEy8p3u5SCf9hme2AESiU5ArpFKAn+UuCf70dKHW61rRBGmqU2iDF
         7ELKnpHho+NQSVdMrwNtVaNb4HFspvuEEKZ5jxvoxVayIb3tfeDsUE7ThTfq0g1JayYf
         dkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=np/p9Ih58kbyvM0hIUqkXcnFFKPhSSCXOoOrFZ44REo=;
        b=ZoQKj+TnBTE0JVaAWufylLq7D8zjRK9QL5UEYAcrb2E0AKY6DzEWubvUEeeAxrltY3
         CNkVLHjVM7LA8py6gThF8APVVYTKqQEg56Ug8eZZfn0F2yoqyGVJ339HYc+rbqqzb1TC
         /5Gel/3bytjP5L22EUWbJ+1J12xGDHkWHwRiJe9StGaP5LeVPYovI24totSCwiizfFx7
         /ru4ecdsgg4cwcAymlisotsYEeSuh1en7TgGpgUXMhdYsgJJeu4OzA+cAakHPqGu9oEZ
         Mg+TjQpAdhI0sYmI4o82y0Pn37JX09HrmJQKzXelxCXjOHFZ1VhVfw3qg6sbDIksMucb
         sWPA==
X-Gm-Message-State: AOAM5315+/xqBesrRqnmgqG3iqKRC1D0Y6gpf/+ldjPDU02RLNDncgs1
        AZd2mppvcldxGyoicz+jf6g=
X-Google-Smtp-Source: ABdhPJyUzyDPFptw1eG2mxbBN5j32n7BW8PMllgbZti9p0QJ7Rr9O3t1aGKq2vFOkq1Ui3/JT+Tm/Q==
X-Received: by 2002:a05:6830:1352:: with SMTP id r18mr15322205otq.283.1615821345096;
        Mon, 15 Mar 2021 08:15:45 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.56])
        by smtp.googlemail.com with ESMTPSA id w1sm7045730oop.1.2021.03.15.08.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:15:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] memcg: accounting for ip_fib caches
To:     Vasily Averin <vvs@virtuozzo.com>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <d569bf43-b30a-02af-f7ad-ccc794a50589@virtuozzo.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <afe47a9a-ec1e-36cb-7184-96a4c457f1f4@gmail.com>
Date:   Mon, 15 Mar 2021 09:15:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d569bf43-b30a-02af-f7ad-ccc794a50589@virtuozzo.com>
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
> This patch enables accounting for ip_fib_alias and ip_fib_trie caches
> ---
>  net/ipv4/fib_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>


