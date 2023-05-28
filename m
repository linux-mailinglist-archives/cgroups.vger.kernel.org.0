Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36C713E9D
	for <lists+cgroups@lfdr.de>; Sun, 28 May 2023 21:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjE1ThM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 May 2023 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjE1ThL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 May 2023 15:37:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E5A8;
        Sun, 28 May 2023 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e9C5sp0JfDN0TOfD6vzNrxMlNWDxTkjAnRW3Cl3BwKc=; b=QrafmJMTDakEdl29f/4YCuqjSX
        TaT+j+jNB/c9w16rhRp1JiKt+zted/BzWUU0uB+Np/k0UXpfVxSnECIFF8U62AHN8GRbHBq3d0OZu
        bCE9Q93On8wlFEotIREI7fN5xjG8MxffyKcz7q4ySbQzxreKAOnwjqg0WQhtUUfzVaPHyRj0XFcrw
        BvFaD61P/4HPB940FseNTpr8BYIjgmFkLuwrLthIPTpvYjcAUCmVe+b0xcIjAO3LZYTkBajbZxHEy
        KR4zi1C+WuQQRmLyPIjWm7vW0+VlOsN1J/vaZ4NpvWzc+8sEYbTq1Ry6oiN5XalqcZKk4KAC6Tpwy
        uxitormg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3MC3-004lLt-5L; Sun, 28 May 2023 19:36:43 +0000
Date:   Sun, 28 May 2023 20:36:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
Message-ID: <ZHOtS67ZtMPsyNVk@casper.infradead.org>
References: <20230527103126.398267-1-linmiaohe@huawei.com>
 <ZHGAcaqOx/e8lqwV@casper.infradead.org>
 <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
 <ZHIcnOV/mrkcerlG@casper.infradead.org>
 <CAJD7tkZ2Q1ZCqNchpiiC6FCE08dYH6tzANA=VqujeDgT8YhRUA@mail.gmail.com>
 <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2B59104-B602-45A3-B938-AE5DC67BAC98@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 28, 2023 at 09:01:37PM +0800, Muchun Song wrote:
> with *init_net*. If Vasily does not want to bring commit 1d0403d20f6c back,
> this patch LGTM. Otherwise, let's wait for Vasily.

If we're not going to bring back 1d0403d20f6c then we should
simply revert fc4db90fe71e instead of applying this patch.
