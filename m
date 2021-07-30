Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7893DBB83
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhG3PEy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbhG3PEx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 11:04:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375F9C06175F;
        Fri, 30 Jul 2021 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mO/QfKKgdDva3A+HR1SvHcs/ooBUVUFlVYCzjnwt1Jc=; b=fiUI1Q6YBT7hv+CJGJ8nRMKHbs
        CbuMpTc3Jbe0ChvLzPGC6jlL9yVJMSZ6/Tq2vrwx0DwHtx6//o1G2fjJAQe7cnbNjE6reNlCy9tbV
        47ewXWmRbAUHFy4sMY85I8dpiAgxYDumsiSiWBlvPMDUr/XYhEK5RsFNFskxZk0TThicJvpC9bUAl
        eLyj7a+jdr9KPYQoxRBXGWkTPhYoAHPFVnIyiMH28p7TcZ+vCEBnlD02Sbt+WL2luH0oAlEC4pjW9
        UoBBtqzhsx6QTEB2eGXT3l5kUo2u/Yyrrqb3VzdZcNI3ZfYPyXeSdRsgaegVYUIOPsIWBzzw8axPe
        NOkyjVPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9U2r-000ork-Sb; Fri, 30 Jul 2021 15:03:42 +0000
Date:   Fri, 30 Jul 2021 16:03:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
Message-ID: <YQQUwX+/1N9utKEN@casper.infradead.org>
References: <20210730051605.2626-1-caihuoqing@baidu.com>
 <87lf5nc0su.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf5nc0su.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 30, 2021 at 08:51:29AM -0600, Jonathan Corbet wrote:
> Cai Huoqing <caihuoqing@baidu.com> writes:
> 
> > Fix typo: iff  ==> if
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> 
> This is becoming an FAQ ...  "iff" in mathematical English means "if and
> only if"; its usage in these documents is correct.

... and yet it's clearly not understood.  Similarly to the [start..end)
convention (also the [start..end[ convention).  Should we deprecate
use of it in kernel documentation, and if so, what should we replace it
with?
