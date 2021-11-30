Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA38463359
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 12:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhK3Lxs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 06:53:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhK3Lxi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 06:53:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 935FF21138;
        Tue, 30 Nov 2021 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638273018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3g3Z2MHUwUd1U35Ol3NxlY4iDKazpPykX0gbbPMrAWY=;
        b=j4vu2nuSB4Pk+hKkNIuqa7F6LZdF7W1GGIWqnax9L/VHC/0fyfYcOTDJl4j5sH6CJsJzKh
        VJ69Xlqk6w6rpEDZ5ZwBqlDBFKt/5ICKSnHIchMp8pQ/eexjcGzUKq6Zo3hBtrXkv3bL/a
        ZT1YlOGtfNoYRjatIyx9onATTlp4s1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638273018;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3g3Z2MHUwUd1U35Ol3NxlY4iDKazpPykX0gbbPMrAWY=;
        b=ehUdP68vAtmSHTHJYSSDA5CqwkeARFhp8yhXfq1ZRbaz2ccFKhGOo1QmtlPepq2JBM8fuF
        lnxvddYgPR/UMZBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id F0DAAA3B87;
        Tue, 30 Nov 2021 11:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 857C61F2CAE; Tue, 30 Nov 2021 12:50:10 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:50:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogdt@suse.de,
        cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211130115010.GF7174@quack2.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <YaUKCoK39FlZK9m5@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaUKCoK39FlZK9m5@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-11-21 07:12:42, Tejun Heo wrote:
> On Fri, Nov 26, 2021 at 03:47:24PM +0100, Michal Koutný wrote:
> > The question here is how long would stay the offlined blkcgs around if
> > they were directly pinned upon the IO submission. If it's unbound, then
> > reparenting makes more sense.
> 
> It should be fine to pin whatever's necessary while related IOs are in
> flight and percpu_ref used for css refcnting isn't gonna make any noticeable
> difference in terms of overhead.

Yes, holding cgroup ref from IO would be fine. But that is not really our
problem.

The problem is bfq_queue associated with a task effectively holds a
reference to the potentially dead cgroup and the reference can stay there
until the task (that itself got reparented to the root cgroup) exits. So I
think we need to reparent these bfq_queue structures as well to avoid
holding cgroup in zombie state excessively long.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
