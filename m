Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0354713265
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 06:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE0EBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 May 2023 00:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0EBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 May 2023 00:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F97A3;
        Fri, 26 May 2023 21:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2xCe7O7+yP7S2jBW94Ky2TVFSCOtAAD8aGSKVZyuo8=; b=vtTBlbTiGVU/kW7m0r2iZikpWF
        uHBfF2vaPo90m14jsnj8E/gfDUNom13R2UQzaU9KK8HjdYfF+YfzCOsLAD/7giYmZfBf4Opg6+RpV
        kopdXnQtBJdG+sH/CJDrY0A5IYTbRoxymJVHlmEZVHQtSxyJ8cc6dwVIPuxkQkjfhyir+UY1GB9/3
        Bm1GXtLYPJhxL55jGH4HFVOO3u2Wm4u1QKsr2ZZs+hp4LQTCttR4KEecxjjypBV7hyDknRnrVIL0O
        7c8ufJqP4v2QyS/LZtTwwYojlqhYIBiX84U0Rf40AjON56IPWAfOj8X1EL8J2xsQCulIkFRstpunW
        1qhvegUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2l6n-003VTr-DT; Sat, 27 May 2023 04:00:49 +0000
Date:   Sat, 27 May 2023 05:00:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
Message-ID: <ZHGAcaqOx/e8lqwV@casper.infradead.org>
References: <20230527103126.398267-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527103126.398267-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
> The function mem_cgroup_from_obj() is not used anymore. Remove it and
> clean up relevant comments.

You should have looked at the git history to see why it was created
and who used it.

Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?

