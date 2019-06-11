Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3703D750
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405720AbfFKTzx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 15:55:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46721 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405886AbfFKTzx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 15:55:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so5552178pls.13;
        Tue, 11 Jun 2019 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwCIOFChcpLV9jmax1ImmjMnCxcc76+OXa2FfkpzRbI=;
        b=M9Z4LDyf9SZZLX+d8CLiaU1622gjvuImt3hgOgTYF2aM+GSl0AKsuxaM4G0Of4fQYH
         bV1tH5bOuSISTn6BvaZWTPMZ61j8tdlblPxANEmHu4dHb+K2/Nb8rXPQXf+d0yj/iA4G
         zdZXb+Tavk9kH5/1IApep03ogPUtZ3a8dntz14yOU4tABUdlci1Etq2OELbaeHGQxhdt
         0AhAsXZHBu3i5/EHAds23Y5tIy86tRFCy7esVxwHdzhzrZ1+5l8/WwVhL1qdEe/mOG5r
         8olwrJbO9oO1VXfufZSI7X/eJtOdsyQWzv9g+iTH6uKOQHboVP4PlxGpynBp/2YzJ1ek
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwCIOFChcpLV9jmax1ImmjMnCxcc76+OXa2FfkpzRbI=;
        b=Mf6PaulCnbbOiHu5+WaYQhY2wQYSAtj7KSTjELAcHqgevoZs6aT+j80fVurZHsesp7
         URcOtUzqXaURgmdqmSq30dz+0Cy34qDIWXxQnF4mhhO++n2bzeQGpO0Bct6hfObiX61B
         4axBuqaUncJRDHO2uDubTDuwO1u7cbWHdajl1thqI8RC7VZCwmbaGQfbA/n7ThpMROtg
         TGCA4BJYY2wbtVTgpm7/2KdG/xZFY1ilg9jnZb3r0+GYo2M4qhX04MPAQ5cYAc2yif6z
         h40aOMHZqhSxOrAckx8quvRhofkzs9hvah8WWJEjwOVhukvlqsB5THhzbryXtS57otwO
         sABg==
X-Gm-Message-State: APjAAAXfzz8+ilo3hUIksbYp6Ml8GVR6T7a2vJf8z5ivNiqhq6s/ZpKL
        MSBBW5/BeYT+52zQWb7BRbU=
X-Google-Smtp-Source: APXvYqzSML6oqxdWG8320UlbIzvjIXhb8GAWGH3LMdkVr7d+A1ePWy4coBXTLSk4rXZK+TEhlifpgQ==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr76300723plf.246.1560282952464;
        Tue, 11 Jun 2019 12:55:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id d19sm2990693pjs.22.2019.06.11.12.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:55:51 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:55:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     hannes@cmpxchg.org, jiangshanlai@gmail.com, lizefan@huawei.com,
        bsd@redhat.com, dan.j.williams@intel.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shakeelb@google.com
Subject: Re: [RFC v2 0/5] cgroup-aware unbound workqueues
Message-ID: <20190611195549.GL3341036@devbig004.ftw2.facebook.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
 <20190605135319.GK374014@devbig004.ftw2.facebook.com>
 <20190605153229.nvxr6j7tdzffwkgj@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605153229.nvxr6j7tdzffwkgj@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Wed, Jun 05, 2019 at 11:32:29AM -0400, Daniel Jordan wrote:
> Sure, quoting from the last ktask post:
> 
>   A single CPU can spend an excessive amount of time in the kernel operating
>   on large amounts of data.  Often these situations arise during initialization-
>   and destruction-related tasks, where the data involved scales with system size.
>   These long-running jobs can slow startup and shutdown of applications and the
>   system itself while extra CPUs sit idle.
>       
>   To ensure that applications and the kernel continue to perform well as core
>   counts and memory sizes increase, harness these idle CPUs to complete such jobs
>   more quickly.
>       
>   ktask is a generic framework for parallelizing CPU-intensive work in the
>   kernel.  The API is generic enough to add concurrency to many different kinds
>   of tasks--for example, zeroing a range of pages or evicting a list of
>   inodes--and aims to save its clients the trouble of splitting up the work,
>   choosing the number of threads to use, maintaining an efficient concurrency
>   level, starting these threads, and load balancing the work between them.

Yeah, that rings a bell.

> > For memory and io, we're generally going for remote charging, where a
> > kthread explicitly says who the specific io or allocation is for,
> > combined with selective back-charging, where the resource is charged
> > and consumed unconditionally even if that would put the usage above
> > the current limits temporarily.  From what I've been seeing recently,
> > combination of the two give us really good control quality without
> > being too invasive across the stack.
> 
> Yes, for memory I actually use remote charging.  In patch 3 the worker's
> current->active_memcg field is changed to match that of the cgroup associated
> with the work.

I see.

> > CPU doesn't have a backcharging mechanism yet and depending on the use
> > case, we *might* need to put kthreads in different cgroups.  However,
> > such use cases might not be that abundant and there may be gotaches
> > which require them to be force-executed and back-charged (e.g. fs
> > compression from global reclaim).
> 
> The CPU-intensiveness of these works is one of the reasons for actually putting
> the workers through the migration path.  I don't know of a way to get the
> workers to respect the cpu controller (and even cpuset for that matter) without
> doing that.

So, I still think it'd likely be better to go back-charging route than
actually putting kworkers in non-root cgroups.  That's gonna be way
cheaper, simpler and makes avoiding inadvertent priority inversions
trivial.

Thanks.

-- 
tejun
