Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1D188DD0
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2020 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCQTPy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Mar 2020 15:15:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQTPy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Mar 2020 15:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yPxwtY4LfExVxpDzfHXr7GQEO/vgYWIH/zIZe2qoAOE=; b=umHTDXgkFaTB4OqwY4d55ClRiP
        Kr99DlC04qMyaYow6Laz7AiSN4FjdZyNkfWzKp6nm2oi5EUMHs4Byxk6Dku2ViS5kTaaeZWDNQQXQ
        6NsF3RB36or1y5k1+EEtgIRE+o9bNX1QLFuFvx6l49SWQXBRo8nKWUklznS1e6a/PK+/LakU5jlvq
        INspuMGW4b8YFa4BC9YljnVd5cd+fZNRbdAUnq7Yeg3k6gqWx+SQI/1ZxfqqMcTbu89iKH234fbEl
        eK6EANKPelJ4+Dm+WKHPa4mth1Ro8weiIHEl/AwpMB4QWRcOmS9oPZw60wvQHZrWGtR94lttdycVJ
        mveQDAFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHgr-0007ew-OV; Tue, 17 Mar 2020 19:15:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EB5B30110E;
        Tue, 17 Mar 2020 20:15:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36C8320B16493; Tue, 17 Mar 2020 20:15:47 +0100 (CET)
Date:   Tue, 17 Mar 2020 20:15:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/3] psi: cpu.pressure cgroup fix & MAINTAINERS update
Message-ID: <20200317191547.GB20713@hirez.programming.kicks-ass.net>
References: <20200316191333.115523-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316191333.115523-1-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 16, 2020 at 03:13:30PM -0400, Johannes Weiner wrote:
> Hello Peter,
> 
> Patch 1 implements the cpu.pressure fix for cgroups we were looking at
> recently, 2 is the cgroup hierarchy walk optimization you proposed.
> 
> Patch 3 adds a MAINTAINER entry for psi, as at least one person tried
> looking for it and couldn't find it.
> 
> If they look alright to you, it'd be great to get them into 5.7.
> 
> Based on 5.6-rc6.

Thanks!
