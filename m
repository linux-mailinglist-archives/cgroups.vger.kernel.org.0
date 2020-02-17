Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72C2160DAB
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2020 09:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBQIlE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Feb 2020 03:41:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38310 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIlE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Feb 2020 03:41:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so18531763wrh.5;
        Mon, 17 Feb 2020 00:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIh2zhz3CHyVtr/v+YhufdsnrhLZdkCerv8N1UqU7iM=;
        b=gJ8xfk0X9zTOAHDiOrditUhUlMho4vSMp289WfYpEZcbvJ3rN1XMJygFdr6VgQPSsq
         s5D/ZoZ6GVVeUwH/dwaJDiAnJAvLHfQi1nt6//dmtmFYefKnrv66pdBu0gyUZqoUzBxY
         XblwnDRI8fFgjJ0ajYkDs5ZSZKkg/wfdCFWJoyO3jQ3Ysk5knX3KdDkjg2EHMbC5mIDe
         GMCLIvOt0xX7H19dIUVAnzknkTRqU+uBaU6K+GLNPYbhOhox7mzW2gbl0KihfYS0G6+j
         1yUHFpw9neuKPiqHdGS2BJjjGV3mlA7HkbOSTpYjKliTIPTg6XUTUAMBanONPNIsJeDc
         yxEQ==
X-Gm-Message-State: APjAAAWtlWYXTaoSiLK1Tnrgt7aALG32V2iePa+PE+gjcDVcOxCdVGpl
        kCchX/OCTH+nXEdkLJ6J/A0=
X-Google-Smtp-Source: APXvYqx4ghozQg++2LcYQHN1snAHGQw9ZFb1v26OtMo76BDIcJJ0q9/Fws6c9SkGN+jyTTJGoG3/2g==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr20715997wrv.151.1581928861612;
        Mon, 17 Feb 2020 00:41:01 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n3sm19377966wrs.8.2020.02.17.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:41:00 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:41:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200217084100.GE31531@dhcp22.suse.cz>
References: <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
 <20200213155249.GI88887@mtj.thefacebook.com>
 <20200213163636.GH31689@dhcp22.suse.cz>
 <20200213165711.GJ88887@mtj.thefacebook.com>
 <20200214071537.GL31689@dhcp22.suse.cz>
 <20200214135728.GK88887@mtj.thefacebook.com>
 <20200214151318.GC31689@dhcp22.suse.cz>
 <20200214165311.GA253674@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214165311.GA253674@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 14-02-20 11:53:11, Johannes Weiner wrote:
[...]
> The proper solution to implement the kind of resource hierarchy you
> want to express in cgroup2 is to reflect it in the cgroup tree. Yes,
> the_workload might have been started by user 100 in session c2, but in
> terms of resources, it's prioritized over system.slice and user.slice,
> and so that's the level where it needs to sit:
> 
>                                root
>                        /        |                 \
>                system.slice  user.slice       the_workload
>                /    |           |
>            cron  journal     user-100.slice
>                                 |
>                              session-c2.scope
>                                 |
>                              misc
> 
> Then you can configure not just memory.low, but also a proper io
> weight and a cpu weight. And the tree correctly reflects where the
> workload is in the pecking order of who gets access to resources.

I have already mentioned that this would be the only solution when the
protection would work, right. But I am also saying that this a trivial
example where you simply _can_ move your workload to the 1st level. What
about those that need to reflect organization into the hierarchy. Please
have a look at http://lkml.kernel.org/r/20200214075916.GM31689@dhcp22.suse.cz
Are you saying they are just not supported? Are they supposed to use
cgroup v1 for the organization and v2 for the resource control?
-- 
Michal Hocko
SUSE Labs
