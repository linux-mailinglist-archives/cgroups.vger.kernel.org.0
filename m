Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DA1A9CDA
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408914AbgDOLht convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 15 Apr 2020 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408903AbgDOLha (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Apr 2020 07:37:30 -0400
X-Greylist: delayed 4773 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 04:37:30 PDT
Received: from smtprelay.restena.lu (smtprelay.restena.lu [IPv6:2001:a18:1::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF3C061A0C
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2020 04:37:30 -0700 (PDT)
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:1:12::4])
        by smtprelay.restena.lu (Postfix) with ESMTPS id 2577340FCB;
        Wed, 15 Apr 2020 13:37:29 +0200 (CEST)
Date:   Wed, 15 Apr 2020 13:37:28 +0200
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200415133728.3f58d46e@hemera.lan.sysophe.eu>
In-Reply-To: <20200415102442.GE4629@dhcp22.suse.cz>
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
        <20200415102442.GE4629@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 15 Apr 2020 12:24:42 Michal Hocko <mhocko@kernel.org> wrote:
> On Wed 15-04-20 12:17:53, Bruno Prémont wrote:
> [...]
> > > Anyway the following simply tracing patch should give a better clue.
> > > The output will appear in the trace buffer (mount tracefs and read
> > > trace_pipe file).  
> > 
> > This is the output I get on 5.6.4 with simple tar -zc call (max=high+4096):
> >   tar-16943 [000] ....  1098.796955: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144
> >   tar-16943 [000] ....  1100.876794: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144
> >   tar-16943 [000] ....  1102.956636: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262120 high:262144
> >   tar-16943 [000] ....  1105.037388: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262121 high:262144
> >   tar-16943 [000] ....  1107.117246: mem_cgroup_handle_over_high: memcg_nr_pages_over_high:1 penalty_jiffies:200 current:262122 high:262144  
> 
> OK, that points to the underflow fix.
> 
> > 
> > With 5.7-rc1 it runs just fine, pressure remains zero and no output in trace_pipe or throttling.
> > 
> > So the fixes that went in there do fix it.
> > Now matter of cherry-picking the right ones... e26733e0d0ec and its fixe's fix,
> > maybe some others (will start with those tagged for stable).  
> 
> I have seen Greg picking up this for stable trees so it should show up
> there soon.

Applying just 9b8b17541f13809d06f6f873325305ddbb760e3e which went to
stable-rc for 5.6.5 gets things running fine where.
(e26733e0d0ec seems to have gone in shortly prior to 5.6 release, need
to improve my git-foo to locate commits between tags!)

So yes it's the fix.

Thanks,
Bruno

> Thanks!
