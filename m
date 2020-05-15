Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99E1D4892
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEOIfN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 04:35:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgEOIfD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 04:35:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id d207so13300187wmd.0
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 01:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmR2sJIk1w11Ugn/97XQiLnKGg9jqySC52XUmtX4lqo=;
        b=k+gpuqR+H09xe3icP96HMDK8erut2IyoutDIUqmCQeEDyA8wHK/JrfyIzEko9UZu+x
         h3+YbcPdp4EvPDZ2gn28UpL61P1fzzJopL206SxGJRykZ0HlUlN9dF8NWndXVAdNSfNo
         y0kgDthjcPTDuQavD00KdpybG94f86pMjM8/dMledTTL5bxtqDVOiFIhx67TbEQ9yaIR
         NYTwqlMr4GaUEUv4ZgL3cUFi+8+xzEODWLPYG4GyHMJkqcmy/jwFLx4l18UUvR1Cnwx3
         lTsiwEK0QPwB0I4JwKIypAExa46p7O1/2GiSbo50kPqb8Axw55+0OkclofZB1vClPnLX
         FYdg==
X-Gm-Message-State: AOAM532SNh7hDXuIY4OKjwu7D+bB2K+5QZfmGuVaDgJf36XhCkwF+/0G
        5IVW6HmKEVU1+qQM1a5a8FY8BSwM
X-Google-Smtp-Source: ABdhPJw9r3i0QDrfKP6xdLPLkp+JSugGzjFMzfPjTnW1sUly98WrdQXcjqitHPNoIICvc3kJJUoD1w==
X-Received: by 2002:a1c:720d:: with SMTP id n13mr2776680wmc.130.1589531701058;
        Fri, 15 May 2020 01:35:01 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id b18sm2411606wrn.82.2020.05.15.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:35:00 -0700 (PDT)
Date:   Fri, 15 May 2020 10:34:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200515083458.GK29153@dhcp22.suse.cz>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
 <20200515065645.GD29153@dhcp22.suse.cz>
 <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 15-05-20 16:20:04, Li Zefan wrote:
> On 2020/5/15 14:56, Michal Hocko wrote:
> > On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
[...]
> >>> I thought the user should ensure not do this, but now I think it makes sense to just bypass
> >>> the interrupt case.
> >>
> >> I think now it's mostly a legacy of the opt-out kernel memory accounting.
> >> Actually we can relax this requirement by forcibly overcommit the memory cgroup
> >> if the allocation is happening from the irq context, and punish it afterwards.
> >> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
> >> objects from an irq.
> > 
> > I do not think we want to pretend that remote charging from the IRQ
> > context is supported. Why don't we simply WARN_ON(in_interrupt()) there?
> > 
> 
> How about:
> 
> static inline bool memcg_kmem_bypass(void)
> {
>         if (in_interrupt()) {
>                 WARN_ON(current->active_memcg);
>                 return true;
>         }

Why not simply 

	if (WARN_ON_ONCE(in_interrupt())
		return true;

the idea is that we want to catch any __GFP_ACCOUNT user from IRQ
context because this just doesn't work and we do not plan to support it
for now and foreseeable future. If this is reduced only to active_memcg
then we are only getting a partial picture.
		
> 
>         /* Allow remote memcg charging in kthread contexts. */
>         if ((!current->mm || (current->flags & PF_KTHREAD)) && !current->active_memcg)
>                 return true;
>         return false;
> }

-- 
Michal Hocko
SUSE Labs
