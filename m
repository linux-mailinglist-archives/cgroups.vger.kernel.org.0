Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5897933BF8D
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCOPO7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhCOPOy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:14:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF98FC061762
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r24so7143162otq.13
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpuZaiVrlNlwHASDhPqhddOX6dJW8QhrY9uWLI1rY04=;
        b=edTWOLsBDmAlUGB7ucxeGLpXdgsmMVpfpuLUfSKoSpL6qBsDWSBR5ns5bV+aTTtYHL
         zA+g2MigGIdR8EeLa4iPweB3MWhPZiRm1POzYbneUQ2Ot87YFb7LzTaY4XIgShIwfcMS
         J250iOuJVnLOfLxIYEp6lbTIv8wCbspmuHnzFSTYFHNsGYmTigGvaFjGG1EL71CN5ShM
         6ZBnOcmUlMrmEoaczCt/267Gc8zTKXsjYUOxQRIB4MXRQrN0+PqUWWA8Sht9A6H2ours
         F6Jon+u3cwNGtzJlUeKGA0Se49N1rTP/H5iq/V6VPo0R6HaiQPjVbisl9xcncZBMBEt0
         xxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpuZaiVrlNlwHASDhPqhddOX6dJW8QhrY9uWLI1rY04=;
        b=LdUZgqW98XaJe5Uk8YX8xnv9NxVYNspCIvNo20Me5jKyYolC5jMyD+limKNYO5bZbS
         5AhD82YuwoMoVTTLHwvYpEdGg+ksbOqq15NooVSy/pSS+uT0JX438s/79a1d2Lh+2tV5
         vh7E8MO/Eo63LU3fqX3q4Q8QQzIcY8x0XV5a8j6VJdtIrjY3wYBH+qoc3GRZEUytGlsw
         iJhKR1NyJqeolMh/qn9Y2P3WGBHPw2efZRQTqHP2pHFuYoieQmQ2kONNshaliL6cXJB9
         jzcC9HwFAQ8B5HZNe1fq4b+hTRy4iK7eSVLJfQAvLMffp8QY7l8OdcS4YsNFzsi+xymP
         qj9A==
X-Gm-Message-State: AOAM533K4DXUH379h/GdTYF+yKgwyuH9xqgBbIs02S2MUXPHsX7mSROl
        s1mvBDjq8ukBwOjhpN9HATQ=
X-Google-Smtp-Source: ABdhPJyHLAbB9ge3t1JALEcwKeHlRTfpQNUN86IBr4nQMmDouNtmsDAU6lx90PGYFy96YB/U5NHeQA==
X-Received: by 2002:a05:6830:118f:: with SMTP id u15mr14254665otq.43.1615821294223;
        Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.56])
        by smtp.googlemail.com with ESMTPSA id e15sm7220081otk.64.2021.03.15.08.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:14:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] memcg: accounting for fib_rules
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
 <cb893761-cf6e-fa92-3219-712e485259b4@virtuozzo.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <4800bd7d-92b9-ee82-6b9d-71bc13769964@gmail.com>
Date:   Mon, 15 Mar 2021 09:14:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cb893761-cf6e-fa92-3219-712e485259b4@virtuozzo.com>
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
> This patch enables accounting for 'struct fib_rules'
> ---
>  net/core/fib_rules.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: David Ahern <dsahern@kernel.org>

