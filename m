Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795911A3285
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgDIKeE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 06:34:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35658 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDIKeE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 06:34:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so11370029wrx.2
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kex7+/mkOoiqgQQhgFeuRjcanp2NfM1STXp4bZWfUbk=;
        b=dtq/RkCfrVfYIS9kMxAZPwzMFyzwUh7BFJ7sqxUJ0/gcM9xCmRBnYr5LLFfAARKJyC
         PAv9ru/qERI/IcIKEQeQ4J73PfS6JANmqibUe5Tgn6YwwayKdx57sB0B2s0bJjPV34Ow
         9bT0vfd5DhreWZI1gOQeNKsrItwc4B8ifwJHMyPfnAinDescz+/3OlpMXnAfhpqFdebO
         2HW+gRmk1OR+BPHprS7SDjWqJzv/UycOZxfBQDQbvXN0EXF7gClIkJrwdF0N7kZ5e9Nv
         qcfgfJQ542pCoTA5rkEV304fnHwh/8hHSPXUiWTKULyhUZZrjPdS/Fgj7hVSqBnwJc5S
         JHWg==
X-Gm-Message-State: AGi0Pubx0gwjrqDoyDbZBsmY4GWZuF1pbQvO2oFTbAHMlolXlr02n/fn
        0CiGy0673RQJBVaM69LjfVPF5g6X
X-Google-Smtp-Source: APiQypJ34Hoi8ZwAU9HgaM3nzfLYNcEqSrL9TVmxIZNUQVITH8pA4aFwyM7HLekX8o0+ATn+geoqng==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr1776126wrp.82.1586428443726;
        Thu, 09 Apr 2020 03:34:03 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a8sm3136708wmb.39.2020.04.09.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:34:02 -0700 (PDT)
Date:   Thu, 9 Apr 2020 12:34:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409103400.GF18386@dhcp22.suse.cz>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
 <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-04-20 12:17:33, Bruno Prémont wrote:
> On Thu, 9 Apr 2020 11:46:15 Michal Hocko <mhocko@kernel.org> wrote:
> > [Cc Chris]
> > 
> > On Thu 09-04-20 11:25:05, Bruno Prémont wrote:
> > > Hi,
> > > 
> > > Upgrading from 5.1 kernel to 5.6 kernel on a production system using
> > > cgroups (v2) and having backup process in a memory.high=2G cgroup
> > > sees backup being highly throttled (there are about 1.5T to be
> > > backuped).  
> > 
> > What does /proc/sys/vm/dirty_* say?
> 
> /proc/sys/vm/dirty_background_bytes:0
> /proc/sys/vm/dirty_background_ratio:10
> /proc/sys/vm/dirty_bytes:0
> /proc/sys/vm/dirty_expire_centisecs:3000
> /proc/sys/vm/dirty_ratio:20
> /proc/sys/vm/dirty_writeback_centisecs:500

Sorry, but I forgot ask for the total amount of memory. But it seems
this is 64GB and 10% dirty ration might mean a lot of dirty memory.
Does the same happen if you reduce those knobs to something smaller than
2G? _bytes alternatives should be useful for that purpose.

[...]

> > Is it possible that the reclaim is not making progress on too many
> > dirty pages and that triggers the back off mechanism that has been
> > implemented recently in  5.4 (have a look at 0e4b01df8659 ("mm,
> > memcg: throttle allocators when failing reclaim over memory.high")
> > and e26733e0d0ec ("mm, memcg: throttle allocators based on
> > ancestral memory.high").
> 
> Could be though in that case it's throttling the wrong task/cgroup
> as far as I can see (at least from cgroup's memory stats) or being
> blocked by state external to the cgroup.
> Will have a look at those patches so get a better idea at what they
> change.

Could you check where is the task of your interest throttled?
/proc/<pid>/stack should give you a clue.

-- 
Michal Hocko
SUSE Labs
