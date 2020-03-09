Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900C617E988
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 21:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCIUAc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 16:00:32 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:55570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgCIUAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 16:00:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E7891181D3030;
        Mon,  9 Mar 2020 20:00:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3873:4321:5007:7903:8603:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: angle62_44c5bace4011
X-Filterd-Recvd-Size: 1773
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 20:00:29 +0000 (UTC)
Message-ID: <84ef5548ee27e7150d0b7a5702ce50536cea975a.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:58:49 -0700
In-Reply-To: <20200309195104.GA77841@mtj.thefacebook.com>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
         <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
         <20200309195104.GA77841@mtj.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-03-09 at 15:51 -0400, Tejun Heo wrote:
> On Mon, Mar 09, 2020 at 12:41:05PM -0700, Joe Perches wrote:
> > If the need is to allocate from a single block of memory,
> > perhaps you need a submemory allocator like gen_pool.
> > (gennalloc.h)
> > 
> > Dunno.  Maybe i just don't quite understand your need.
> 
> vmalloc is the right thing to do here. vmalloc space isn't a scarce
> resource on any 64bit machines. On 32bits, which basically are tiny
> machines at this point, these allocations are both size and quantity
> limited by other factors (e.g. each cgroup consumes way more memory).

This feels like driving spikes into a living thing
more than into a
corpse.

I've still got more than a few 32-bit devices around.


