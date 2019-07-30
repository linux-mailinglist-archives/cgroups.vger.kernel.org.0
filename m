Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949017A1A4
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfG3HMd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 03:12:33 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:34105 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbfG3HMd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Jul 2019 03:12:33 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 03:12:32 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 0C19518015306
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2019 07:03:33 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 586E983777EE;
        Tue, 30 Jul 2019 07:03:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,3,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:152:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2691:2827:2859:2893:2898:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3834:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4830:5007:6119:7858:7903:8531:9025:9040:10004:10400:10450:10455:10848:11026:11232:11658:11783:11914:12043:12294:12297:12438:12555:12663:12740:12895:13069:13311:13357:13845:13894:14096:14097:14181:14659:14721:19904:19999:21080:21324:21433:21627:21740:30054:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: anger88_1e83daf9ea507
X-Filterd-Recvd-Size: 2841
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jul 2019 07:03:29 +0000 (UTC)
Message-ID: <80fbaf63ddbe66cbbf3391256402295af1a3336f.camel@perches.com>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 30 Jul 2019 00:03:28 -0700
In-Reply-To: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
References: <20190729151346.9280-1-hslester96@gmail.com>
         <201907292117.DA40CA7D@keescook>
         <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2019-07-30 at 14:39 +0800, Chuhong Yuan wrote:
> Kees Cook <keescook@chromium.org> 于2019年7月30日周二 下午12:26写道：
> > On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> > 
> > Wait, stop. :) After Laura called my attention to your conversion series,
> > mpe pointed out that str_has_prefix() is almost redundant to strstarts()
> > (from 2009), and the latter has many more users. Let's fix strstarts()
> > match str_has_prefix()'s return behavior (all the existing callers are
> > doing boolean tests, so the change in return value won't matter), and
> > then we can continue with this replacement. (And add some documentation
> > to Documenation/process/deprecated.rst along with a checkpatch.pl test
> > maybe too?)
> > 
> 
> Thanks for your advice!
> Does that mean replacing strstarts()'s implementation with
> str_has_prefix()'s and then use strstarts() to substitute
> strncmp?
> 
> I am not very clear about how to add the test into checkpatch.pl.
> Should I write a check for this pattern or directly add strncmp into
> deprecated_apis?

After Nitin's patch gets applied: (which btw wasn't cc'd to lkml)

(sorry about the bad link, something about it hits some
 spam filter)

open wall . com/lists/kernel-hardening/2019/07/28/1

Add it to deprecated_string_apis

And we've had this sort of discussion before:

https://lore.kernel.org/patchwork/patch/1026598/

I believe I'm still in favor of global conversion of
strstarts to str_has_prefix.


