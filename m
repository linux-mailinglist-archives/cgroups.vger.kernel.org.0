Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EC2FEC30
	for <lists+cgroups@lfdr.de>; Thu, 21 Jan 2021 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhAUNnI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jan 2021 08:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbhAUNml (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jan 2021 08:42:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D992C061575
        for <cgroups@vger.kernel.org>; Thu, 21 Jan 2021 05:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZquWffHuPqJrmXTxVmbVj/6yL4VuB/c9dASx5K+bWfQ=; b=mQrXe4gGqmYWQks/wF9TlqCsw+
        SttnRBknxhPu+lMtW7JnVeQmcOx5Gf9kDvcMuFgv0g4TUVDarUVqr0AKV8wuhZSHCoExHNkFWwTuy
        AWYyuJaTLgLoc8Oe50G6hFkqh81P0hZ7/4CUgxzMdWU254v5D9JS9KafI6uiZxtUNSPLVFaecBDSD
        0pZ/UjwqaSiEE3GM1wuA+8EeCbSG2FxtiFbpP7XwsBmAgQdoMQIkOROzh46GOtlVAcX1OTITz1bKd
        NXr5d6pmw/0oCqjSjI6dnQtJfF+ZHoh4aaE5Wyp0EotGxyuyq7q4kdJBWXImXxhQC2+GvHhHOvyYJ
        HN0BAs0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2aCb-00H6cP-Hz; Thu, 21 Jan 2021 13:40:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E2F33007CD;
        Thu, 21 Jan 2021 14:40:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35D522009D007; Thu, 21 Jan 2021 14:40:41 +0100 (CET)
Date:   Thu, 21 Jan 2021 14:40:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     wu860403@gmail.com
Cc:     tj@kernel.org, cgroups@vger.kernel.org, mingo@redhat.com,
        398776277@qq.com
Subject: Re: [PATCH V2] tg: add sched wait_count of a task group
Message-ID: <YAmEWbvVoVEGytiU@hirez.programming.kicks-ass.net>
References: <20210121201157.1933-1-wu860403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121201157.1933-1-wu860403@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Your subject is wrong; this is 100% a sched patch.

On Fri, Jan 22, 2021 at 04:11:57AM +0800, wu860403@gmail.com wrote:
> From: Liming Wu <wu860403@gmail.com>
> 
> Now we can rely on PSI to reflect whether there is contention in
> the task group, but it cannot reflect the details of the contention.
> Through this metric, we can get avg latency of task group contention
>  from the dimension of scheduling.
>    delta(wait_usec)/delta(nr_waits)

Only if all tasks have the same weight. So in general this is useless.

> Also change wait_sum to wait_usec.

Also patches should do 1 thing, also you can't do that, you'll break
everybody that expect the current value.
