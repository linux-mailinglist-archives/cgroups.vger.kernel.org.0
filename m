Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743DA1A9AE5
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408559AbgDOKjF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Apr 2020 06:39:05 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38074 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408566AbgDOKYs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 06:24:48 -0400
Received: by mail-wm1-f52.google.com with SMTP id g12so10486385wmh.3
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2020 03:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+kxlvdqj4G7H52Nr6jsXXb07LhAX1fjinkLOiENvF2U=;
        b=DbEeCYl0SkifdQA0uxJSb3ahToMu0gaK0fvu/eY58acz76qRtmhcvurCT5ZiAwbJ5U
         SjYJ6JaSD9VDpoTiViCu5A4joygOz4NEdC2YE7qDMO3Nu/3hvTjgmmSoRx7rjESn9luJ
         u+tjvIXG6yTzmXx7YgLwciFZM1+ZyaD58CwABnUSP4vO4zP8dm/fyc3YP/d6apOQjSlY
         d2oXGQHbF7O7A+p8eJW6nRjm+P4v/B+WBjDx1KAbteja3Xj5PjwK/WvFcLD/pE39guAs
         eDC6AhZ45AywGvJzycs7U90xyRoohELxdydFlixKz5IRjJNvlJbqMhIFj7tL5CyFlBPE
         2Bkg==
X-Gm-Message-State: AGi0PuZZyj4HWco4UfYFtRn6aZ/jjhp+KPNQVuGnFEZgrWRn4/bLRC77
        gqPYeJhDA2oXjeYFcF/RlDqTZGsU
X-Google-Smtp-Source: APiQypLGPG5YhJgQ1ifHp2eWDuhftQlzY+KRQdEbZstp1l7yqAcFYixtIUO3QNbWr27qDNc6DtG8Tw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr4750302wme.5.1586946284117;
        Wed, 15 Apr 2020 03:24:44 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id i17sm22428733wml.23.2020.04.15.03.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 03:24:43 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:24:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200415102442.GE4629@dhcp22.suse.cz>
References: <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
 <20200409103400.GF18386@dhcp22.suse.cz>
 <20200409170926.182354c3@hemera.lan.sysophe.eu>
 <20200409152540.GP18386@dhcp22.suse.cz>
 <20200410091525.287062fa@hemera.lan.sysophe.eu>
 <20200410104343.5bcde519@hemera.lan.sysophe.eu>
 <20200410115010.1d9f6a3f@hemera.lan.sysophe.eu>
 <20200414163134.GQ4629@dhcp22.suse.cz>
 <20200415121753.3c8d700b@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415121753.3c8d700b@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 15-04-20 12:17:53, Bruno Prémont wrote:
[...]
> > Anyway the following simply tracing patch should give a better clue.
> > The output will appear in the trace buffer (mount tracefs and read
> > trace_pipe file).
> 
> This is the output I get on 5.6.4 with simple tar -zc call (max=high+4096):
>   tar-16943 [000] ....  1098.796955: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144
>   tar-16943 [000] ....  1100.876794: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144
>   tar-16943 [000] ....  1102.956636: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262120 high:262144
>   tar-16943 [000] ....  1105.037388: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262121 high:262144
>   tar-16943 [000] ....  1107.117246: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144

OK, that points to the underflow fix.

> 
> With 5.7-rc1 it runs just fine, pressure remains zero and no output in trace_pipe or throttling.
> 
> So the fixes that went in there do fix it.
> Now matter of cherry-picking the right ones... e26733e0d0ec and its fixe's fix,
> maybe some others (will start with those tagged for stable).

I have seen Greg picking up this for stable trees so it should show up
there soon.

Thanks!
-- 
Michal Hocko
SUSE Labs
