Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC812FFC4
	for <lists+cgroups@lfdr.de>; Sat,  4 Jan 2020 01:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgADApB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jan 2020 19:45:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgADApB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jan 2020 19:45:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so19607427plt.2
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2020 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yueUb/2kKIa7znFfBTW3dbm2LtvKwc/fgWoUwv6QXa8=;
        b=mrSqENRxgPFzYjmvtbYUobSHdxD/gmPB8X3hNTXHwmWPCtHOKOY54ixHxasePPe/cc
         T2+yc3YpKwej9x8VwJ+mOO5DoH35aHhFDhbCdJalumQcWaes9OO05xzW5iKPb+y7FAAP
         XQ0MbV77UazX0jY9hxS8OVIFP5jFIxnhHHH5QhHoQeaXlRJ5pzKHmn2BpYoAZ5IyqodW
         F8RyV1oPchLvurdpYR3G65+tdA6DZwn7cgV36RQxVg9O+2+zR3ONkNuweFY8DUHfUMlz
         tVuCOWgc8341ZFLHp4DNobjomQY41eU/Xx0P5whxV7yedd8FP/vixBnLYFx8SFe+hXnL
         zjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yueUb/2kKIa7znFfBTW3dbm2LtvKwc/fgWoUwv6QXa8=;
        b=VtRqqPupBcb4pX3MJfBRFS0grBsOAr6/myAszOlKrH22JMO969DaJwpCamS1yAstWb
         7c1GrCV/kl8Fe1ZPLpagETMP2z9NDE8QPywWaO1xtE3r4Ibj6bsylX+unWyUwOo3a86u
         Y+Ce9fLillpeReJ1KBU6oFcRekrpK07fQITS7TOB0RHf2gT5ocQBAEEEnUhjb+ACorJM
         RHJjyp4BkQ6dEby9Btu1h58rx+EWQfrqztXp7fDTwdrFk5SIN9qoXlAEYBmnALfig1lD
         +XD4sUEK4jEcqnDB7gHjA3OBGcSik/F0ZuWrBtW5b73365USWbtRoajTm5J3QQmS0Nkh
         gSvg==
X-Gm-Message-State: APjAAAW2WjhXPh7zS5PGEMEt1mq3zzVUjrdAIQwM8KrOBuCeNYMH4GS8
        TFNBJg33vPCyFUvJt12k2I7xQg==
X-Google-Smtp-Source: APXvYqx/Y0M5wIAfPK4sXD/h1uhec4zOldt+8ptaybbZcvoLpd+Puwt9SM51mH7YzkjNLr+8gprW0A==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr29928414pjz.95.1578098700912;
        Fri, 03 Jan 2020 16:45:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a28sm68401959pfh.119.2020.01.03.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:45:00 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:44:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200103233925.GA3678@richard>
Message-ID: <alpine.DEB.2.21.2001031642530.92066@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com> <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com> <20200103233925.GA3678@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 4 Jan 2020, Wei Yang wrote:

> On Fri, Jan 03, 2020 at 11:29:06AM -0800, David Rientjes wrote:
> >On Fri, 3 Jan 2020, Wei Yang wrote:
> >
> >> As all the other places, we grab the lock before manipulate the defer list.
> >> Current implementation may face a race condition.
> >> 
> >> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> 
> >> ---
> >> I notice the difference during code reading and just confused about the
> >> difference. No specific test is done since limited knowledge about cgroup.
> >> 
> >> Maybe I miss something important?
> >
> >The check for !list_empty(page_deferred_list(page)) must certainly be 
> >serialized with doing list_del_init(page_deferred_list(page)).
> >
> 
> Hi David
> 
> Would you mind giving more information? You mean list_empty and list_del_init
> is atomic?
> 

I mean your patch is obviously correct :)  It should likely also have a 
stable@vger.kernel.org # 5.4+

Acked-by: David Rientjes <rientjes@google.com>
