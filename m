Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72E15C380
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2019 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGATMR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jul 2019 15:12:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfGATMR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jul 2019 15:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0htxnIK1Wduic/JIKCNlUJk+0wwHKgV99WAuI//uAS4=; b=eU/iOVhJKXcr8fi85AGcX1pY0
        NK0W9Vf632ZZzWS3+uVfZHCOuWraFnZqUiMSLdsB+yZP3coujr95WDGbyehXOn12VDCiSHkS9BT98
        vL1LUFqKKaDBsBzcCoKCxgDz23AlcvkBWW8UIamqfDzzlsC8F8UjCal71OW9/wfrm2rPTSgUD9Fgn
        k5SOfS2/YiWiRAfzJjljIEmKgPqu9DK7PQmLuq6vj+ZJMEzE0w/CjD/2Zs2Xc6/kcXuBlB3xUriWL
        2CwXWDAAhf7TMX49hYAjonRDY0Lu2jV4cUErlgH6Qu8HFEmHeiRqqNyRMBf4E5Ag+cRwzeD2P+NMa
        +2vYCgmGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi1iJ-0001Vs-61; Mon, 01 Jul 2019 19:11:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E40E2013A20D; Mon,  1 Jul 2019 21:11:41 +0200 (CEST)
Date:   Mon, 1 Jul 2019 21:11:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 7/8] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20190701191141.GD3402@hirez.programming.kicks-ass.net>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-8-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628080618.522-8-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 28, 2019 at 10:06:17AM +0200, Juri Lelli wrote:
> No synchronisation mechanism exists between the cpuset subsystem and
> calls to function __sched_setscheduler(). As such, it is possible that
> new root domains are created on the cpuset side while a deadline
> acceptance test is carried out in __sched_setscheduler(), leading to a
> potential oversell of CPU bandwidth.
> 
> Grab cpuset_rwsem read lock from core scheduler, so to prevent
> situations such as the one described above from happening.
> 

ISTR there being a funny vs normalize_rt_tasks(); maybe mention that?
