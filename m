Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF59E17D934
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 07:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgCIGUv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 02:20:51 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37163 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgCIGUu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 02:20:50 -0400
Received: by mail-pj1-f65.google.com with SMTP id ca13so1726520pjb.2;
        Sun, 08 Mar 2020 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g75Qh0w0IMlX/zV9hQvw54yKT3VrtMDkZu/Q14Db4QQ=;
        b=oLuNqixNl1JxNVT152qOq/xNxOVKrrzZ6dbHvCBWH/+3doPheUSai4W8Asav3nC6uU
         qdEv2xwxy2lA/KdtQMkqQ5FFkvz4Q5F7Cq598Htvjw6tVym6ZXB5wFlesntytgI8+TSj
         3T0R+fC5Fyk9OrD2EaoizKfpnsFYktFYpsuD8L4qYUQvATxVO8f5L1/ezu7ZNh8U4a47
         4XEYWEVzUzKzoycFQQi+5nySgzPSrZQWph39MGZ5OJMn2QV0b/knhiraNQexExmY02pg
         yI5Ed4aPCD/hqzR2JiRjsQhrkwxv8OVH12+aZ9NL25gytbe/L7taOxw0caVyRszKWETB
         kR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g75Qh0w0IMlX/zV9hQvw54yKT3VrtMDkZu/Q14Db4QQ=;
        b=nFvENOHmBnp2HcFZDj/ZPrz7r0Ukz3U05fH003biui7j9mjzCmOiYoUwjKc9kdD1m/
         5dXaLPdSmydvaGW7rv7e97TnjHf0F3RpQdCm/vAsJPwywOp/J2FaXAivN8F8pxjTp9n3
         +NdqQyUEGvqDUxlhphKMiZO7ifw9h90tnLuOiJ66GB/SsaOy2HInmWUbLQPEAFa0BieL
         KA5vN38SFwS9C6X8FN+J6YUF/TciT0naOMjiL7kl6YSokuyJdDzlFvJ7jCB6bGa3ZYvZ
         8DWb0hog7yDrhqN9eoujnRme7XzJyGStc/uHDM7mwDQlU/d+pm/PZoLWPVfJNTjZKyJC
         NOVQ==
X-Gm-Message-State: ANhLgQ1EukIbudNnP9C8YYj0+vMijPyj5wqubiyCkjsSERzZ2RsIXBfs
        hmhZLZyGK9TS1eZELgJ0JiY=
X-Google-Smtp-Source: ADFU+vuTacwZljz++7mnGUt/1ePVmD3eBqPVSmeedFPkE4WHnu5hOKP7jdOfQMZ9g3/9NHhJm+yNiA==
X-Received: by 2002:a17:902:70c8:: with SMTP id l8mr14211162plt.89.1583734849681;
        Sun, 08 Mar 2020 23:20:49 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l189sm3156157pga.64.2020.03.08.23.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 23:20:48 -0700 (PDT)
Date:   Mon, 9 Mar 2020 15:20:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: Use fallthrough;
Message-ID: <20200309062046.GA46830@google.com>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
 <20200308031825.GB1125@jagdpanzerIV.localdomain>
 <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
 <20200309041551.GA1765@jagdpanzerIV.localdomain>
 <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (20/03/08 21:51), Joe Perches wrote:
> On Mon, 2020-03-09 at 13:15 +0900, Sergey Senozhatsky wrote:
> > On (20/03/07 19:54), Joe Perches wrote:
> > > On Sun, 2020-03-08 at 12:18 +0900, Sergey Senozhatsky wrote:
> > > > On (20/03/06 23:58), Joe Perches wrote:
> > > > [..]

[..]

> > > Consecutive case labels do not need an interleaving fallthrough;
> > > 
> > > ie: ditto
> > 
> > I see. Shall this be mentioned in the commit message, maybe?
> 
> <shrug, maybe>  I've no real opinion about that necessity.
> 
> fallthrough commments are relatively rarely used as a
> separating element between case labels.
> 
> It's by far most common to just have consecutive case labels
> without any other content.
> 
> It's somewhere between 500:1 to 1000:1 in the kernel.

I thought that those labels were used by some static code analysis
tools, so that the removal of some labels raised questions. But I
don't think I have opinions otherwise.

	-ss
