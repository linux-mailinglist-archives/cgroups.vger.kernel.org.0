Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650447161D
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfGWKbw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 06:31:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfGWKbw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 06:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MnT833q43OKgOeGMbkNl4vZ1Sr0chNDr5cIKxrka6/s=; b=guRZ1+tUYg9jhJ2PD2PsuUIT1
        4QBkAklWJMBjR8UXnloAdUN4bhNaFSBjKNDfGAUGWOD5iKniBRB+YfV+0UkW3CDtuLIkLlSjLK/Ed
        Z6vwQ1qxWmwY3EusrIZ5611r4vWuXwo+3a0omOSXASgptn1A6WiWz0+UPBCKEgE+K3SACKHbYjDzJ
        LH7ooWwzv5hNYYxpsrYRd6bnroTm5z9n5eeMxrcOTAQvI7WNDS5OwNGQh03Ds/dpR6FBMVtf2sq6l
        VVsL4ORpmJCl39/ulpHCNLeKHvDfXwygOLirPh0lzboT5Dju9JgC5S9bVnmLh76+mI0Y2LElUF1F/
        SS9hLuRug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hps4z-0003kp-Vw; Tue, 23 Jul 2019 10:31:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3B16201A9429; Tue, 23 Jul 2019 12:31:31 +0200 (CEST)
Date:   Tue, 23 Jul 2019 12:31:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        rostedt@goodmis.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190723103131.GB3402@hirez.programming.kicks-ass.net>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722083214.GF25636@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 22, 2019 at 10:32:14AM +0200, Juri Lelli wrote:

> Thanks for reporting. The set is based on cgroup/for-next (as of last
> week), though. I can of course rebase on tip/sched/core or mainline if
> needed.

TJ; I would like to take these patches through the scheduler tree if you
don't mind. Afaict there's no real conflict vs cgroup/for-next (I
applied the patches and then did a pull of cgroup/for-next which
finished without complaints).

