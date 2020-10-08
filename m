Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80714287488
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgJHMvs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Oct 2020 08:51:48 -0400
Received: from m12-18.163.com ([220.181.12.18]:52546 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgJHMvq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Oct 2020 08:51:46 -0400
X-Greylist: delayed 978 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 08:51:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=7snQg
        UUJSF5tKYLwhoTXmX+RnS13E0l5FHg91pRGEt8=; b=TBwxSNoIp21YXiaIJENv0
        MP5W7XPDKS3g7j6aUCxBY1VvRFNFo2nLYIeyER1o0tOtZWOgC2MNeVYZjMdU2xy0
        I6jCGPN9DpkmWlG0VmB9pBcz9nnbhMGZd1gYdCCqsJc/xWCClQxXr8XdmKluD5zr
        JsAcTktXCGtnTkD2ZLomW0=
Received: from localhost (unknown [101.228.30.83])
        by smtp14 (Coremail) with SMTP id EsCowACnL6cdB39fzHnSSA--.1218S2;
        Thu, 08 Oct 2020 20:33:34 +0800 (CST)
Date:   Thu, 8 Oct 2020 20:33:33 +0800
From:   Hui Su <sh_def@163.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix some comments in page_alloc.c and mempolicy.c
Message-ID: <20201008123333.GA7424@rlk>
References: <20200925160650.GA42847@rlk>
 <10c1b339-b352-7643-7adf-d82c941c7d2c@redhat.com>
 <11c9c699aaa873847b4d14dfa5e2435b94c08569.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c9c699aaa873847b4d14dfa5e2435b94c08569.camel@perches.com>
X-CM-TRANSID: EsCowACnL6cdB39fzHnSSA--.1218S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2qg4UUUUU
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBywq3X1PAPK5HEgAAs9
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 01, 2020 at 09:17:29AM -0700, Joe Perches wrote:
> On Thu, 2020-10-01 at 14:27 +0200, David Hildenbrand wrote:
> > On 25.09.20 18:06, Hui Su wrote:
> > > 1. the cpuset.c has been moved from kernel/cpuset.c to
> > > kernel/cgroup/cpuset.c long time ago, but the comment is stale,
> > > so we update it.
> []
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> []
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - *  kernel/cpuset.c
> > > + *  kernel/cgroup/cpuset.c
> 
> It's probably better to remove this altogether instead.

Please ignore this change, thanks.

