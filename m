Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141B3EB5FA
	for <lists+cgroups@lfdr.de>; Fri, 13 Aug 2021 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhHMNLw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Aug 2021 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbhHMNLw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Aug 2021 09:11:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC8DC061756;
        Fri, 13 Aug 2021 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F+mZz90Iw9bJNSCiyhztHZfMrr85VxOQkOCEMKU4nZQ=; b=cYGYHE2HA3uBWTLGd4LtSr6t43
        JRORc4aXQeNilMuwMYpsjJZMCOUrUCUJZo+U9AKbuWDM879kva2Zk2qHgX50EC3BGecHnTXe3cr/U
        fEdPFk56SfgQ/DWMKq0++EQzFZ9sRGgx9Erlp8hgcsV1bRrk93xF9xby4lN3Y8uwpUy2gPe4BLtm+
        LAPtedZI2RJMPNvivl6sf0yEl6gzMzXDX0SGY5Fw/ql7VvuFwmlyc6BBAdll7O4xGCNg4QP8QyEz0
        In/Bn42/E2iYc5X378mO1YTpmma/aPeOkb29Jxi7wU9GSyDI6ZXP/4uAg6Ij2xhQqnHGmfeicTEJ7
        1eDAY0ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEWw6-00FhZM-Ms; Fri, 13 Aug 2021 13:09:35 +0000
Date:   Fri, 13 Aug 2021 14:09:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, tglx@linutronix.de,
        peterz@infradead.org, shakeelb@google.com, guro@fb.com,
        alexs@kernel.org, richard.weiyang@gmail.com, sh_def@163.com,
        sfr@canb.auug.org.au, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v1] mm: Add configuration to control whether vmpressure
 notifier is enabled
Message-ID: <YRZvAojYDsVPT+wr@casper.infradead.org>
References: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628855870-5070-1-git-send-email-wang.yong12@zte.com.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 13, 2021 at 04:57:50AM -0700, yongw.pur@gmail.com wrote:
> @@ -855,7 +856,7 @@ At reading, current status of OOM is shown.
>            The number of processes belonging to this cgroup killed by any
>            kind of OOM killer.
>  
> -11. Memory Pressure
> +11. Memory Pressure (CONFIG_MEMCG_VMPRESSURE)
>  ===================

Did you build the documentation after changing it (eg make htmldocs)?
