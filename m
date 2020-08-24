Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9025008D
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHXPLK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 11:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHXPKw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 Aug 2020 11:10:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3AABAB8B;
        Mon, 24 Aug 2020 15:11:17 +0000 (UTC)
Date:   Mon, 24 Aug 2020 17:10:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200824151045.GC3415@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200824145201.GB4337@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145201.GB4337@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 24-08-20 10:52:02, Qian Cai wrote:
> On Thu, Aug 20, 2020 at 10:58:50AM -0400, Qian Cai wrote:
> > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > > Since readahead page is charged on memcg too, in theory we don't have to
> > > check this exception now. Before safely remove them all, add a warning
> > > for the unexpected !memcg.
> > > 
> > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This will trigger,
> 
> Andrew, Stephen, can you drop this series for now? I did manage to trigger this
> warning on all arches, powerpc, x86 and arm64 (below).

Yes, I do agree. See http://lkml.kernel.org/r/20200824151013.GB3415@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
