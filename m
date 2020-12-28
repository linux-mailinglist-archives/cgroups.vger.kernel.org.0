Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA32E2E3470
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 07:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgL1GLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 01:11:31 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:58640 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgL1GLb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Dec 2020 01:11:31 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2020 01:11:30 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 4E0FE8123FDE
        for <cgroups@vger.kernel.org>; Mon, 28 Dec 2020 06:02:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D875C1802926E;
        Mon, 28 Dec 2020 06:01:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1261:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2565:2682:2685:2687:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7652:7875:9025:9388:9389:10004:10400:10848:11232:11658:11914:12043:12297:12555:12679:12740:12895:12986:13069:13161:13184:13229:13311:13357:13437:13439:13845:13894:14181:14659:14721:14764:14819:21080:21324:21451:21627:21672:21781:21881:30054:30079:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: dogs21_4b1837427491
X-Filterd-Recvd-Size: 1828
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Dec 2020 06:01:36 +0000 (UTC)
Message-ID: <2822d565280536f36ea6ddd521a7716813ef85a2.camel@perches.com>
Subject: Re: [PATCH] cpuset: Remove stale URLs in the MAINTAINERS entry
From:   Joe Perches <joe@perches.com>
To:     Zefan Li <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>
Date:   Sun, 27 Dec 2020 22:01:35 -0800
In-Reply-To: <42668f2c-5ea1-da38-918e-ac4c86e3f03d@huawei.com>
References: <42668f2c-5ea1-da38-918e-ac4c86e3f03d@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-12-28 at 11:17 +0800, Zefan Li wrote:
> Those URLs are no longer accessable.
> 
> Reported-by: Steve Wahl <steve.wahl@hpe.com>
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae9b1dd748c4..2fe8eb54639e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4477,8 +4477,6 @@ CONTROL GROUP - CPUSET
>  M:	Li Zefan <lizefan@huawei.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
> -W:	http://www.bullopensource.org/cpuset/
> -W:	http://oss.sgi.com/projects/cpusets/

The general argument to avoid removal of these no longer valid links
is that they may still be available from archive.org.

For instance:

https://web.archive.org/web/20170512010721/http://oss.sgi.com/projects/cpusets/

It may be appropriate to copy the content into a local Documentation
file somewhere to avoid the need to lookup old reference links.


