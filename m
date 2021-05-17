Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E23829F2
	for <lists+cgroups@lfdr.de>; Mon, 17 May 2021 12:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhEQKhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 May 2021 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhEQKhn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 May 2021 06:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468AC061573;
        Mon, 17 May 2021 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WpWqsmHNLWQc70bpUWhJIPOVl6gzN2zEoMJ15ENTac=; b=euTLqySvTY1oLnU3ssO7tDoule
        IstShSS2L0Gqd0ZjEr5FUbN1Q/Q+oVSqeI0hMwjHuqoH69qU7df/ui9pkiYtPQzMnd1+rF9qQ+pF0
        KSwW4ETdHVcVfMypNXly5zS0ncKO8GlfDu0Ng3Um5Ls9pzJqt9pval+I4O7j41gGVQQx4ViMaP9jE
        xEBByybdpEAsZrYa2bgOhTJN2Tf1u/kYTcFem6ybxSv9JvkXrJiMbsuictEXvnz2KDOXRNB0a/y4S
        J/Wu1WnpwnWZAOsrH+xRPbjvLZu14HxJ1v8tQWcaQF/J2nt+b15+t7gOvhBa6Baqoe57vIFjtp7iA
        Cz5GssVA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1liabZ-00CoX6-9r; Mon, 17 May 2021 10:36:14 +0000
Date:   Mon, 17 May 2021 11:36:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] init/Kconfig: Fix BLK_CGROUP help text indentation
Message-ID: <YKJHGbmRMcs/e+pm@infradead.org>
References: <20210516145731.61253-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516145731.61253-1-juergh@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While you're at it, please move the symbol to block/Kconfig.
