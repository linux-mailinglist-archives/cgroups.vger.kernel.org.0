Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188724E81A
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 14:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFUMhC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 08:37:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMhC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 08:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7d0AOZocI1Q8mX1LNBJNSJm0RkC99Q9KWsCv6Fj3D2U=; b=QqilS2cTBLO5CxZgnbs9vg0AZ
        Fw+7J7SF13LrD1619BXFTIM5UIvwH4y6SUicD1rJb09/2Dl0DbdaWDiHspbwMtiJtDCRSoJt2Q3jU
        uqpkRNSpjtzBiPF0iDIoY99ViCz0W5OEmCrGolSJCE3SGXsSN9j+/Ja9zMkc0Mg84HZO1rZ3WL+zb
        t9jbe1HQRgc3aJSRZIaDsR86V8mPZ2ag7k87LFOLm62b6Kt+FJMyk8A0sWMKoSEkj4FY5Ybvj7K3b
        5PUC8nOFttIt//Y1WnBxZudT1nUZWBnuwS8NiaBI9UHrNM5X8D7q+OkJcOczv6Ob7SzL4N6B04IcS
        phsCUloxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heImL-0000Te-BO; Fri, 21 Jun 2019 12:36:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85A14203C6955; Fri, 21 Jun 2019 14:36:25 +0200 (CEST)
Date:   Fri, 21 Jun 2019 14:36:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     xiaoggchen@tencent.com
Cc:     jasperwang@tencent.com, heddchen@tencent.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/5] BT scheduling class
Message-ID: <20190621123625.GJ3436@hirez.programming.kicks-ass.net>
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 21, 2019 at 03:45:52PM +0800, xiaoggchen@tencent.com wrote:
> From: chen xiaoguang <xiaoggchen@tencent.com>
> 
> This patch set introduces a new scheduler, we name it BT scheduler
> for the moment.

> The BT scheduler is similar with the CFS scheduler. We also use the
> rb-tree as the run queue to save the runnable tasks. And the vruntime 
> concept is also used in the BT scheduler. And the priority of BT scheduler
> is from 140 to 179. So now the schedulers in the kernel are as follows:
> deadline, RT, CFS, BT and idle.

NAK; it has no forward progress guarantees. This is also the reason why
SCHED_IDLE is not a true idle time scheduler but a very low weight CFS
tasks.

It also has some very 'interesting' starvation cases, consider one of
your BT tasks owns a mutex, but then there are there are runnable CFS
tasks. The BT task will never get runtime and release the mutex.

Also; NAK at all the duplication.
