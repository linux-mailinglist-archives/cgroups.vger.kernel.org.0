Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F12DA651
	for <lists+cgroups@lfdr.de>; Tue, 15 Dec 2020 03:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLOCi0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Dec 2020 21:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgLOCfJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Dec 2020 21:35:09 -0500
Date:   Mon, 14 Dec 2020 18:28:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607999289;
        bh=slstsyQ5JPFm4UzsTcoHM8XYj2Zgq9w2a6Y8T3mYAqA=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=UPYRgmtHyTjcqK47L9AAX1Rfo31gdLIZ4tiG0cb061cd3YFgE/R/BgJQFQwWEmQcN
         2ae/Ek+hZrOSyjmZCZJGB9CIFxjnS7JTD+rHgd321PxMMAAnBKJfejP68jMGLuz+HJ
         t2POAUptSWQG/Uus0i74Ly4L3E6kAn9j7tnS5PKI=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v21 00/19] per memcg lru lock
Message-Id: <20201214182807.b95df2cd4b22dba37e1f6ffa@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2012141734060.3082@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
        <20201214164712.39da20f908c6199eb4cde961@linux-foundation.org>
        <alpine.LSU.2.11.2012141734060.3082@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 14 Dec 2020 18:16:34 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> On Mon, 14 Dec 2020, Andrew Morton wrote:
> > On Thu,  5 Nov 2020 16:55:30 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> > 
> > > This version rebase on next/master 20201104, with much of Johannes's
> > > Acks and some changes according to Johannes comments. And add a new patch
> > > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > > v21-0007.
> > 
> > I assume the consensus on this series is 'not yet"?
> 
> Speaking for my part in the consensus: I don't share that assumption,

OK, thanks, I'll include it in patch-bomb #2, Tues or Weds.
