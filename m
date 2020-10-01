Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618212803D1
	for <lists+cgroups@lfdr.de>; Thu,  1 Oct 2020 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbgJAQXj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Oct 2020 12:23:39 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:55710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732610AbgJAQXj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Oct 2020 12:23:39 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 12:23:38 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 780CB1828958C
        for <cgroups@vger.kernel.org>; Thu,  1 Oct 2020 16:17:33 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id ECB2012C0;
        Thu,  1 Oct 2020 16:17:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3151:3622:3865:3867:3871:3872:4321:5007:10004:10400:10848:11232:11473:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21600:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mine82_04110cc2719c
X-Filterd-Recvd-Size: 1422
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 16:17:30 +0000 (UTC)
Message-ID: <11c9c699aaa873847b4d14dfa5e2435b94c08569.camel@perches.com>
Subject: Re: [PATCH] mm: fix some comments in page_alloc.c and mempolicy.c
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>, Hui Su <sh_def@163.com>,
        lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 01 Oct 2020 09:17:29 -0700
In-Reply-To: <10c1b339-b352-7643-7adf-d82c941c7d2c@redhat.com>
References: <20200925160650.GA42847@rlk>
         <10c1b339-b352-7643-7adf-d82c941c7d2c@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2020-10-01 at 14:27 +0200, David Hildenbrand wrote:
> On 25.09.20 18:06, Hui Su wrote:
> > 1. the cpuset.c has been moved from kernel/cpuset.c to
> > kernel/cgroup/cpuset.c long time ago, but the comment is stale,
> > so we update it.
[]
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
[]
> > @@ -1,5 +1,5 @@
> >  /*
> > - *  kernel/cpuset.c
> > + *  kernel/cgroup/cpuset.c

It's probably better to remove this altogether instead.


