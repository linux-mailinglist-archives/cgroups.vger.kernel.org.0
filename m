Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986742C5290
	for <lists+cgroups@lfdr.de>; Thu, 26 Nov 2020 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKZLCa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Nov 2020 06:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729663AbgKZLC2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Nov 2020 06:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606388547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cvGV8OUthTmjmbY5oJ7mRxJLMMwznOKcyuaPUff3ek=;
        b=VezbIcJalAdt/otNdxYgQil5QVSdbXlehicqEyhGBWBCVCiJzLL0t8enPJIlyr35Cchr2a
        nzZXjjyxclHMD639PRhxITSS3o/dSbOwkfB/MxNBsYLGLTjXuL4bYQXKHKR39jIc08qYEZ
        mrHxatGwzRXg07yudk4mrJJSGfZXrgI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-pPN2YdfAOaCV6_SzTSznIg-1; Thu, 26 Nov 2020 06:02:24 -0500
X-MC-Unique: pPN2YdfAOaCV6_SzTSznIg-1
Received: by mail-wr1-f69.google.com with SMTP id b12so1093768wru.15
        for <cgroups@vger.kernel.org>; Thu, 26 Nov 2020 03:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8cvGV8OUthTmjmbY5oJ7mRxJLMMwznOKcyuaPUff3ek=;
        b=iIf72OlMlptB/GH71P7wGkaH3+vcb5ZKLw3MxD/T2INE8Jc3NGDKIow7fySBSpUDgN
         ooUw2j2+kpGLOZKK08R4cj1w3DjhzQI/U7A7Hi/auaDqhR5/j+RW10AG92Rj/O87q6J8
         qwspf7O+cPiKH4NxkqPkNPbGecwghss7g8752wCxWUsWCzwBIhu/FBOyz18VlV75fVqT
         gTThjuy+pqKRlVnJvG1F1DC3ujLRHFzs0pcHc7n4ipskIcDL8MO/TC5CvP8eAttOV+jD
         idqBv4+4L8pG7nbHOEPpJhAxh5x80YnIYtNcY9498OwF7FwJTUk+JXWYZvp6QfJGU96g
         usdQ==
X-Gm-Message-State: AOAM533R9ZGtm+7gZKt4vDGYxtjGPxNziiCFVy8F5ARX/wPqCUMWNkBx
        xuzqf47qzzEIyrmGEBDZQBgDXJQULEHt3T/zzDmHyzUxgvusm5dCzCT+wutxpZr6MVhn32DJEB3
        g+V5DM6Lb8SyF5ub7
X-Received: by 2002:adf:a54d:: with SMTP id j13mr3210906wrb.132.1606388543423;
        Thu, 26 Nov 2020 03:02:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNurD+B9K0wyu+wLx1//nc60gT6N9gDdwcKceycA0Aw8hI/yIujAcODjNgQftSCd3n2mbAxg==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr3210886wrb.132.1606388543257;
        Thu, 26 Nov 2020 03:02:23 -0800 (PST)
Received: from localhost (cpc111767-lutn13-2-0-cust344.9-3.cable.virginm.net. [86.5.41.89])
        by smtp.gmail.com with ESMTPSA id y2sm8806139wrn.31.2020.11.26.03.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:02:21 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:02:20 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
Message-ID: <20201126110220.k4o6s32er5jy2mdk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20201124105836.713371-1-atomlin@redhat.com>
 <20201124112612.GV27488@dhcp22.suse.cz>
 <CANfR36hyrqXjk2tL03GzCk6rn6sCD7Sd811soBsZC3dHY0h9fQ@mail.gmail.com>
 <20201124133644.GA31550@dhcp22.suse.cz>
 <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANfR36hw8iSSszSt4sNh+ika3vTdXQnXHPLj5t2iLL=5-nzZZw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 2020-11-24 13:47 +0000, Aaron Tomlin wrote:
> On Tue, 24 Nov 2020 at 13:36, Michal Hocko <mhocko@suse.com> wrote:
> > This like any other user visible interface would be a much easier sell
> > if there was a clear usecase to justify it. I do not see anything
> > controversial about exporting such a value but my general take is that
> > we are only adding new interface when existing ones are insufficient. A
> > performance might be a very good reason but that would really require to
> > come with some real life numbers.

Michal,

> Fair enough and understood.
> 
> At this stage, I unfortunately do not have such supporting data. This was only
> useful in an isolated situation. Having said this, I thought that the
> aforementioned interface would be helpful to others, in particular, given the
> known limitation.

Furthermore, I can see that this is already provided via /proc/cgroups
(see proc_cgroupstats_show()). As such, another possibility:
the proposed interface could reliably produce the difference between the
maximum permitted memory-controlled cgroup count and the used count
(i.e. the remaining memory cgroup count, from root); albeit, I doubt that
this would be particularly useful to others i.e., the use-case would be
rather limited.


Kind regards,

-- 
Aaron Tomlin

