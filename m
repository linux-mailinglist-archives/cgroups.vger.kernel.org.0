Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3F271FB
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbfEVV7J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 17:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbfEVV7J (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 22 May 2019 17:59:09 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C966921880;
        Wed, 22 May 2019 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558562348;
        bh=R6YcL8U8yochP+E8Zmsq6kuoz61IzyX5bMmtEWQzZLM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zr8gMdggwmhhfTmcy+QmNgZLg2PfZ0TLrnp3IRFmnindd1nPaBjrlLwXUHhcFcytS
         S3fMlA75Nma6WNodFnANzU6+BozwhoGgdbcFd35fq7GZgrJZGvmrImtVwo3Ov4aZDg
         yyUMoyBBA3v49PwKKRYZio8kePJ/lBN6j6NRI9zQ=
Date:   Wed, 22 May 2019 14:59:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/7] mm: reparent slab memory on cgroup removal
Message-Id: <20190522145906.60c9e70ac0ed7ee3918a124c@linux-foundation.org>
In-Reply-To: <20190522214347.GA10082@tower.DHCP.thefacebook.com>
References: <20190521200735.2603003-1-guro@fb.com>
        <20190522214347.GA10082@tower.DHCP.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 22 May 2019 21:43:54 +0000 Roman Gushchin <guro@fb.com> wrote:

> Is this patchset good to go? Or do you have any remaining concerns?
> 
> It has been carefully reviewed by Shakeel; and also Christoph and Waiman
> gave some attention to it.
> 
> Since commit 172b06c32b94 ("mm: slowly shrink slabs with a relatively")
> has been reverted, the memcg "leak" problem is open again, and I've heard
> from several independent people and companies that it's a real problem
> for them. So it will be nice to close it asap.
> 
> I suspect that the fix is too heavy for stable, unfortunately.
> 
> Please, let me know if you have any issues that preventing you
> from pulling it into the tree.

I looked, and put it on ice for a while, hoping to hear from
mhocko/hannes.  Did they look at the earlier versions?
