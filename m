Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FAB17D969
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 07:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIGsK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 02:48:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 02:48:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so2081350pfo.13;
        Sun, 08 Mar 2020 23:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4UxGHAQZzEPyQy0KsfAI6f3ElLxET+uiuIqagGiKHY=;
        b=B6pVr9UgIF/7hOkq20mC2Tt8jES/c+2rAZeqAcgLBjERCMe3+hq3EpMlarZK9XW4j2
         7Z4TjxwS3LhKwveWSWHGBN9wdcb2nxb4Epj0ixu30KrLq+maqRWnbOMn4UcEr8Dg9ipz
         yTnNGYdcXhxzg5vMpI9Oe2I+lC4Wq0sreAnJZMQqU7vBHps1ykJ26WyKrNCXxtN9hJ4N
         uybpbMx7yoss9Xln3TAb7zP+3CmV8CCEvfro2zQCJ8uMjQqQ/QSbBRJnWl02a1YUZo+E
         2PftO9hM/qgTcb5zBGVg/hAnXyOVtN46PMS7R8nTLJcl4/mIjWOK5T+VEKNLfzuCOW4c
         pRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4UxGHAQZzEPyQy0KsfAI6f3ElLxET+uiuIqagGiKHY=;
        b=daywR3dx2gzbPtOZxn35s6hxxPmDFkVLx87pRuWhxiM0pmy3GQG0n+lG8JWQ/P2/uW
         llCbGgpilz1tEe4qwdJrukedSUbygDc0WIm3OjKTgC398EmrON30Ms/90vBFQdSeQhap
         +e4FyKceyGni9/hC9XlCzchtlc+Llc0+GvFQOHVpYUQxv7jY8WzbmLXFeCcX9kemFei2
         0KwCHE4HCgBU4afw43TtTzWcmqJiMJ5zHGZxI4vW4b3Li7OtgYRlFqHarHtv5mJEaJOs
         YfN+u8TUsrtUgF+jhPuSUYWCVnFpQmkYrXHUSIDpb9Dy135uGV5X/NwP4/BITAGRmyfQ
         r7fQ==
X-Gm-Message-State: ANhLgQ08UesGVhmrO8nttUlJwfZ8m6Xc+n2uKJEahauh/uA5SSaMU8mL
        aAeDbfNqWVL4lMUV2Vi2MhM=
X-Google-Smtp-Source: ADFU+vuVCZqOpqiIus66R6ENXtbIH475h/jg+dfhpjNike4CDEGgLvQhXhpPqwTpSWgWrxGZp+umNA==
X-Received: by 2002:aa7:87ca:: with SMTP id i10mr15040880pfo.169.1583736489516;
        Sun, 08 Mar 2020 23:48:09 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id g20sm17126776pjv.20.2020.03.08.23.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 23:48:08 -0700 (PDT)
Date:   Mon, 9 Mar 2020 15:48:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] mm: Use fallthrough;
Message-ID: <20200309064806.GB46830@google.com>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
 <20200308031825.GB1125@jagdpanzerIV.localdomain>
 <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
 <20200309041551.GA1765@jagdpanzerIV.localdomain>
 <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
 <20200309062046.GA46830@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309062046.GA46830@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (20/03/09 15:20), Sergey Senozhatsky wrote:
[..]
> > <shrug, maybe>  I've no real opinion about that necessity.
> > 
> > fallthrough commments are relatively rarely used as a
> > separating element between case labels.
> > 
> > It's by far most common to just have consecutive case labels
> > without any other content.
> > 
> > It's somewhere between 500:1 to 1000:1 in the kernel.
> 
> I thought that those labels were used by some static code analysis
> tools, so that the removal of some labels raised questions. But I
> don't think I have opinions otherwise.

... I guess GCC counts as a static code analysis tool :)

Looking at previous commits, people wanted to have proper 'fall through'


    Replace "fallthru" with a proper "fall through" annotation.
    This fix is part of the ongoing efforts to enabling
    -Wimplicit-fallthrough

---

-       case ZPOOL_MM_RW: /* fallthru */
+       case ZPOOL_MM_RW: /* fall through */

---


> Consecutive case labels do not need an interleaving fallthrough;

I suppose this means that GCC -Wimplicit-fallthrough handles it?

	-ss
