Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7555617E8D2
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 20:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCITmt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 15:42:49 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:45016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgCITms (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 15:42:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4FE3118224D82;
        Mon,  9 Mar 2020 19:42:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2692:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3871:3872:3873:4321:5007:6119:7903:8603:8828:10004:10400:10848:11026:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13071:13311:13357:13439:14180:14659:14721:21060:21080:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: steel13_8c8a845334d15
X-Filterd-Recvd-Size: 2076
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 19:42:45 +0000 (UTC)
Message-ID: <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:41:05 -0700
In-Reply-To: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-03-09 at 11:21 -0700, Daniel Xu wrote:
> Hi Joe,

Hello Daniel.

> On Fri Mar 6, 2020 at 12:49 AM, Joe Perches wrote:
> > On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> > > It's not really necessary to have contiguous physical memory for xattr
> > > values. We no longer need to worry about higher order allocations
> > > failing with kvmalloc, especially because the xattr size limit is at
> > > 64K.
> > 
> > So why use vmalloc memory at all?
> > 
> > 
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > ']
> > > @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
> > >  	if (len < sizeof(*new_xattr))
> > >  		return NULL;
> > >  
> > > -	new_xattr = kmalloc(len, GFP_KERNEL);
> > > +	new_xattr = kvmalloc(len, GFP_KERNEL);
> > 
> > Why is this sensible?
> > vmalloc memory is a much more limited resource.
> 
> What would be the alternative? As Greg said, contiguous memory should be
> more scarce.

If the need is to allocate from a single block of memory,
perhaps you need a submemory allocator like gen_pool.
(gennalloc.h)

Dunno.  Maybe i just don't quite understand your need.

