Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838248BBC6
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 01:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiALAYZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 19:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiALAYY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 19:24:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFAC06173F;
        Tue, 11 Jan 2022 16:24:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so3076626edd.5;
        Tue, 11 Jan 2022 16:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFpazlv+lywoGwl9/cFSYAAABBv6zxWMmcLpH0m+3/M=;
        b=Jvwa9TaIcLtrQXSCOZEpvt5o4j62C2t3W/QMQ/KHJ/fiv10OoW6JKvXj5KBsR6XAd9
         YTJX3yMs+oReKUEusB6HXOycLwagLJUD3wZlEY4LzzdZZk2UhbnmiM2kmyYYwY3bXcry
         I5k+BCombR71JSn6bX3+5Knoym/PI1ut2Mzwc/VjfVDq/AqE04o8xf4fXQz5FmaHuweo
         JkXPznZqOnmSwakVWgUKEGUyT9xIufjGXDTNb8kX1g956DAXLnicAHPkoZITy9/nV74M
         TdhGyqIuaWMDnKnhm95W6/P6RSpUBTjyJ0EQAGayOmRlDg58JOSj8qZKnbD+IR6TiQkT
         Fhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFpazlv+lywoGwl9/cFSYAAABBv6zxWMmcLpH0m+3/M=;
        b=G/jHIhwY2QJz/iM/z5KIfT2569IgvybYzHhliT2r/TU3elKOSOMZT5f4/Bo5EicCdL
         25ttgA19YAuRpYnZZ253K9e1OPUGNYEreETryAjuspUuHvye/nPB4+jGEwdU3vMyS+c+
         Z8ghKHbsJdyudSjGW+anmyxGMto1fn3gOi8smG+prQhkHuSKPjf/WbGsDt1Xlkmjhc8R
         zpSQNxq6NLQiCtImpKYvQZQ5BOPIWgiD0q3chewd8knqmHuyRcEpt7b8aWFbw8Pl54r+
         Wk2/R1sVJPi6s+1WsoHmE0tzg9imcYQ1Y3mWOsu3AiRucytev6W7DwGQi1IStyJrvGGI
         lGbQ==
X-Gm-Message-State: AOAM530SBq9Gc+Ny3kwm304gHfgojkfX29KJXJMxEO3B7pDwZiEhrver
        Ai75uDbHGqq4YWq8jy/DqP8=
X-Google-Smtp-Source: ABdhPJxbp1jqOMEDjz32OniUVIm0N2DkA9bp6QjRfoPbyPBgiQ99JQe7N3wdX7/klyg2U5f09KGbYA==
X-Received: by 2002:a05:6402:1764:: with SMTP id da4mr6500959edb.324.1641947062977;
        Tue, 11 Jan 2022 16:24:22 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w17sm183314edr.68.2022.01.11.16.24.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jan 2022 16:24:22 -0800 (PST)
Date:   Wed, 12 Jan 2022 00:24:21 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, vbabka@suse.cz,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
Message-ID: <20220112002421.m3fyktkkz55fup3v@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-3-richard.weiyang@gmail.com>
 <Yd3H8Hea6dBlkzeW@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3H8Hea6dBlkzeW@carbon.dhcp.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 10:09:52AM -0800, Roman Gushchin wrote:
>On Tue, Jan 11, 2022 at 01:03:01AM +0000, Wei Yang wrote:
>> The parent we get from page_counter is correct, while this is two
>> different hierarchy.
>> 
>> Let's retrieve the parent memcg from css.parent just like parent_cs(),
>> blkcg_parent(), etc.
>
>Does it bring any benefits except consistency?
>

I am afraid no.

>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Reviewed-by: Roman Gushchin <guro@fb.com>
>
>Thanks!

-- 
Wei Yang
Help you, Help me
