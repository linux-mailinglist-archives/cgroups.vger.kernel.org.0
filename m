Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4191D13F6
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgEMNGJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgEMNGI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 09:06:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F30C061A0C
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 06:06:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z80so11652126qka.0
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h765WvXxpy/Yg+afYA3tB6uLG1cyplu9hQ4hJS3lUyg=;
        b=ia/CbeLy2LUPItZTijdqb67Xr3yrC1V2Akofb2PmxGqinrWI+pOVsawEs0koo6v7Fa
         gCP6bgNNJEK8pRyTYOP+S2zHXdpnEQhx/xzNwQxKsaZBEZnkSIH7UdVoy2YQZri5EE1n
         1j7UD2W0xvkZvdBu3sYJvokZzNFyGc9uIRNg4CtQLgsMria1ifdj8m/cmCJW4rt5tZ6p
         4qDJhpVaz3noeluPwUkuQC4qisHe1BL6VfRkIdks8btyXCVbk4OrpI3Blz75jsmxju5N
         ko+IIc3A4yrdm5EUk5XlGvlfxdtzZWM+Rq7qzozf3HUdBfA4k3DbpgS3nHjRStqTAXeG
         piGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h765WvXxpy/Yg+afYA3tB6uLG1cyplu9hQ4hJS3lUyg=;
        b=BSyh/66GD6uSK72onK0as1pfU3KWMWJyQJPweH8lvFgWmP6BXUEN6+Hj6gCtZgFuHN
         FjbpvCY/mHb8WOjb/FBWzvIXQBQJ3+RkD3UxW6r4KLvD4mJZVgjN1dMZvpUUvJqV5SZg
         FLxSLFURD378zNau/rGIDgLInACoywUgueqzWbJM52DDqho/fPte/m7NUQjITT5F7wnK
         3dcShEXT//ZS9kYrzlL5uofY/8M5ztktoiQ4lNDQowImeKZCzJUnHXTKb2k+2lxPfaaW
         7oxjJ2osKZ4Gs4oVxTMY9izM4ZcSqix60j1GQwqMybYe0seJMUrW8T6z4Wfw1m0vUtB5
         YANg==
X-Gm-Message-State: AGi0Pua+e1J+jKrVOzORvHh3ppCrtNKiPO8EtFRZu8CNoMkzPZidsKUB
        a6vEhTcFrLIpmQOFq6b0tDHKHw==
X-Google-Smtp-Source: APiQypLareWSeJOjcn6Ughzj2NdzZwwaaqd1hP/cy6TF45FizW7Flugs+YQzTdDVvyLHzDwh/qUwsQ==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr27655338qkj.373.1589375167694;
        Wed, 13 May 2020 06:06:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g1sm13700151qkm.123.2020.05.13.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:06:06 -0700 (PDT)
Date:   Wed, 13 May 2020 09:05:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200513130548.GD488426@cmpxchg.org>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
> 
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, it's better we fix it now.
> 
> Signed-off-by: Zefan Li <lizefan@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
