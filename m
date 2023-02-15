Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DD698586
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBOU05 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 15:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOU04 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 15:26:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220B5B98;
        Wed, 15 Feb 2023 12:26:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBAA6B82373;
        Wed, 15 Feb 2023 20:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C26C433D2;
        Wed, 15 Feb 2023 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676492811;
        bh=2B6OYT9baMUmpj081N8ApuyZRaf3nEcY8nE/MG7VCLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiKfIFOoUtM5otYmOb4O15O0dd+y9jtdA0UPtxP+BzMwcPKnA86t78F5aDKbxDUNy
         T/vJvHYUQfceohEwF4AHNCxD6Wpeq94+aTuEB8ZB7V1gqm8ntK5e2800CP2aoYKu7z
         PhEemm418KOfo5AyZsrbrzzSzYXGiPvQMqxa2A6xlFUyhNYriVakJCZIIgYT6hGgve
         jDL9lq9U8roY2wHXkAqsyNZ2JQeesizuQ20V8+zfX4b4cRB7U3qgwS2tqvpSIA6+Wi
         MbGX5r3DSAjg5OEalCoR5xTSmn2WUTDPEPA8+IariufCKZFD2uRE9+nujtdOHnqfE2
         xwXkeEd3X8gBw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Change the return value for page isolation functions
Date:   Wed, 15 Feb 2023 20:26:48 +0000
Message-Id: <20230215202648.92523-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Baolin,

On Wed, 15 Feb 2023 18:39:33 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Now the page isolation functions did not return a boolean to indicate
> success or not, instead it will return a negative error when failed
> to isolate a page. So below code used in most places seem a boolean
> success/failure thing, which can confuse people whether the isolation
> is successful.
> 
> if (folio_isolate_lru(folio))
>         continue;
> 
> Moreover the page isolation functions only return 0 or -EBUSY, and
> most users did not care about the negative error except for few users,
> thus we can convert all page isolation functions to return a boolean
> value, which can remove the confusion to make code more clear.
> 
> No functional changes intended in this patch series.

For the series,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
