Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7A17F5CD
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJLMO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 07:12:14 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:42301 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbgCJLMO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 07:12:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E15B6837F24D;
        Tue, 10 Mar 2020 11:12:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:6742:7903:8531:9389:10004:10400:10848:11026:11232:11473:11658:11914:12050:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:14721:21080:21324:21433:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: worm72_6a6262640771f
X-Filterd-Recvd-Size: 2949
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Mar 2020 11:12:10 +0000 (UTC)
Message-ID: <7e2471ed71a42d74c0dbd9f2197034f5163d0eda.camel@perches.com>
Subject: Re: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Date:   Tue, 10 Mar 2020 04:10:29 -0700
In-Reply-To: <20200309064806.GB46830@google.com>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031825.GB1125@jagdpanzerIV.localdomain>
         <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
         <20200309041551.GA1765@jagdpanzerIV.localdomain>
         <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
         <20200309062046.GA46830@google.com> <20200309064806.GB46830@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-03-09 at 15:48 +0900, Sergey Senozhatsky wrote:
> On (20/03/09 15:20), Sergey Senozhatsky wrote:
> [..]
> > > <shrug, maybe>  I've no real opinion about that necessity.
> > > 
> > > fallthrough commments are relatively rarely used as a
> > > separating element between case labels.
> > > 
> > > It's by far most common to just have consecutive case labels
> > > without any other content.
> > > 
> > > It's somewhere between 500:1 to 1000:1 in the kernel.
> > 
> > I thought that those labels were used by some static code analysis
> > tools, so that the removal of some labels raised questions. But I
> > don't think I have opinions otherwise.
> 
> ... I guess GCC counts as a static code analysis tool :)
> 
> Looking at previous commits, people wanted to have proper 'fall through'
> 
> 
>     Replace "fallthru" with a proper "fall through" annotation.
>     This fix is part of the ongoing efforts to enabling
>     -Wimplicit-fallthrough
> 
> ---
> 
> -       case ZPOOL_MM_RW: /* fallthru */
> +       case ZPOOL_MM_RW: /* fall through */

That conversion was unnecessary.
(there are still 6 /* fallthru */ comments in today's kernel)

There are tens of thousands of consecutive case labels without
interleaving fallthrough comments in the kernel like:

	switch (foo) {
	case BAR:
	case BAZ:
		do_something();
		break;
	default:
		something_else();
		break;
	}

So gcc and clang handle consecutive cases without fallthrough
without uselessly emitting warnings just fine.

