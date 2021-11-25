Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8545D3A8
	for <lists+cgroups@lfdr.de>; Thu, 25 Nov 2021 04:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhKYDgD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Nov 2021 22:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbhKYDeC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Nov 2021 22:34:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DEC061757;
        Wed, 24 Nov 2021 19:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FJveyksDdIzezjLTh+rtqlw7W3mbjgrzS1zYLwDdyJw=; b=Vj1482sPd6MjdEtA4qCXvJvQgD
        WL8f/9idar4o0C/fULR3TZDxRtRNJMjmdXZyjO9qAMmUE6otb1jbAdlCat9KaXunIf3DoF/4SaiZo
        d70wYXABjupPPwTtTdu75c8n0aotcx9CFFrEmcXXFx33d6XSaX9SGWn6mkRv/yzmbEazqSowyQ5Jo
        ckv/+EaPXkcil4YJKlFWKRCpI3R0DFuCkatvSXzBb/qo3VzEipuSAbPba2decKg5GjX+JFvzCjY13
        8p0AYV+r1HdmRsCiFTBSXCLS4PaiyPOcWpuXgoEE0IQiFcnx9fm/vlOmtFRpBd+J89SK2FZJvTXlK
        r0s68t0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq5TA-004ZXE-H4; Thu, 25 Nov 2021 03:30:44 +0000
Date:   Thu, 25 Nov 2021 03:30:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YZ8DZHERun6Fej2P@casper.infradead.org>
References: <20211124151915.GA6163@haolee.io>
 <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 25, 2021 at 11:24:02AM +0800, Hao Lee wrote:
> On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > We do batch currently so no single task should be
> > able to monopolize the cpu for too long. Why this is not sufficient?
> 
> uncharge and unref indeed take advantage of the batch process, but
> del_from_lru needs more time to complete. Several tasks will contend
> spinlock in the loop if nr is very large.

Is SWAP_CLUSTER_MAX too large?  Or does your architecture's spinlock
implementation need to be fixed?

