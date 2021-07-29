Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E43DA4C8
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhG2Nz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhG2Nz0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 09:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE480C061765;
        Thu, 29 Jul 2021 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//JteJBlPO/oxjTtV3LASZaFA4G6WCHzkWs4cs97Saw=; b=iZFUmVL3DjXeQg65XLBHJKYW+r
        ij7voxBE+IDPgeuSPz7voqUndWCfKEe4BwM0Nx49Uer0h//8+3oD9o62dZ6iJ7MeKTIiC9GwN6pja
        8Q25jshIVHOAXS/XavTefpp71qH3SOdLJSvYQVsr/wKa091xMOpafpfGWhUnh+aPDUXFW+Lh6rYLQ
        ZY/8spCb23lWoAi6nVPNAJbrFvBI4yoijzs/Rj77fHaz1wgpd6yvZEXNBV+xI/GYSLqe9TOtLA7sk
        pkqyZy7ewtzkjO/bGQf6v94jGRPAWzXQ90AeFGQkRITOa2ns2kghh3nmSN6zbJa9KwL7hmNpQyoTM
        xWxCLu8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m96Sd-00H7zD-ER; Thu, 29 Jul 2021 13:52:50 +0000
Date:   Thu, 29 Jul 2021 14:52:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        alexs@kernel.org, richard.weiyang@gmail.com,
        songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
Message-ID: <YQKyn8bKRblCDuND@casper.infradead.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-5-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
> rtpn might be NULL in very rare case. We have better to check it before
> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
> soft_limit_tree, warn this case and continue.

Why would we need to warn?  the GFP flags don't contain NOWARN, so
we already know an allocation failed.
