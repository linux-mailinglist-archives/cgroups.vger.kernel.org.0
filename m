Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D657217D8A5
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 05:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgCIEwu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 00:52:50 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:36497 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgCIEwu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 00:52:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4D777837F24A;
        Mon,  9 Mar 2020 04:52:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:3874:4321:5007:6742:7903:10004:10400:10848:11026:11232:11658:11914:12297:12740:12760:12895:13019:13069:13095:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: note65_52936ebc40606
X-Filterd-Recvd-Size: 2288
Received: from XPS-9350.home (unknown [47.154.118.177])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 04:52:47 +0000 (UTC)
Message-ID: <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
Subject: Re: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Date:   Sun, 08 Mar 2020 21:51:07 -0700
In-Reply-To: <20200309041551.GA1765@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031825.GB1125@jagdpanzerIV.localdomain>
         <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
         <20200309041551.GA1765@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-03-09 at 13:15 +0900, Sergey Senozhatsky wrote:
> On (20/03/07 19:54), Joe Perches wrote:
> > On Sun, 2020-03-08 at 12:18 +0900, Sergey Senozhatsky wrote:
> > > On (20/03/06 23:58), Joe Perches wrote:
> > > [..]
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
> > > >  
> > > >  	switch (p->mode) {
> > > >  	case MPOL_BIND:
> > > > -		/* Fall through */
> > > >  	case MPOL_INTERLEAVE:
> > 
> > Consecutive case labels do not need an interleaving fallthrough;
> > 
> > ie: ditto
> 
> I see. Shall this be mentioned in the commit message, maybe?

<shrug, maybe>  I've no real opinion about that necessity.

fallthrough commments are relatively rarely used as a
separating element between case labels.

It's by far most common to just have consecutive case labels
without any other content.

It's somewhere between 500:1 to 1000:1 in the kernel.



