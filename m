Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452F14E871
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFUNDs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 09:03:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFUNDs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 09:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8voMoB854F0d0ERXQAC40rhDRb6mL2IHOiaUQ+KH42o=; b=z8rASQxg05EpGWK8+LWzS8UKu
        R2t5YFty57rg3tJ+9o5GBkwAFsW238Ziar0WfMCtcJq1L/DAcVT1w/tbaJA4s64uIwHAkmnFyISd4
        4ANrU0r4enmtDhKjihUH0dSv4PnuZ4uUBgt0i5fxsojbqLFtJLRJZk23qdNTYXHIxV16wNZ4pDumI
        /sjfSFSbKJDdeOKwJ3Jnna5pw+NrsuUl4w0QdqE31uGhi36L8x9HNb/RZ2nLEob7bPa3O0kvNi5kb
        qce7MpVKClVlejw/WlIYqVDd8POiUFWKg6VCUmo1w6J3NbQsMuTKB3wsmCpKosmPAI9zG9BJ2bFMr
        HQRgz5mrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heJCI-0000dQ-6O; Fri, 21 Jun 2019 13:03:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF757203C694A; Fri, 21 Jun 2019 15:03:16 +0200 (CEST)
Date:   Fri, 21 Jun 2019 15:03:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     xiaoggchen@tencent.com
Cc:     jasperwang@tencent.com, heddchen@tencent.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        viresh.kumar@linaro.org
Subject: Re: [PATCH 0/5] BT scheduling class
Message-ID: <20190621130316.GK3436@hirez.programming.kicks-ass.net>
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

> First only server application exists in the system and the success
> rate is 99.998% and the average cpu use is only 25%.

Have you guys looked at this series:

  https://lkml.kernel.org/r/cover.1556182964.git.viresh.kumar@linaro.org


