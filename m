Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0E697FC1
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBOPmJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 10:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBOPmE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 10:42:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5BA366B2;
        Wed, 15 Feb 2023 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J1HP1AYxs+CPgeT/Uk3lsnz97zGE2SKFHAXmfCAw3bw=; b=Y0PKbb2GdfSnGd5GRhVnYZGNLK
        S2B4glLdiOEykJBOnN/nU8lvfvyNknik1yQ8cOcv9q2fIz9pbnNOYxDhnhIx7ZHeQiWzsjqZCuaTa
        JrddlddthRmAKYwpOF8TuJM0ngO8PaURDxPZTUMO46mwpNTH3bPdUohUwBwc/U4fCEkBEGeWl06U1
        MDA2+xdslRl+t1aRvavQmvMMojmeVVeCG6meQe2Cgxk+Zc2cKz7EFOD2tmMciWoWjk8WhInFX08Ul
        7aqG9lkcHfdkciRCtzifRVf33MBMXUGrjWkCu8rNNLTupObyC6B4bUQ05ytVIIVrpA/9Vmge97DkK
        ecTx6fwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSJsY-007aAb-HO; Wed, 15 Feb 2023 15:39:30 +0000
Date:   Wed, 15 Feb 2023 15:39:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: change to return bool for isolate_lru_page()
Message-ID: <Y+z8suWLusQk8N3U@casper.infradead.org>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <3074c1ab628d9dbf139b33f248a8bc253a3f95f0.1676424378.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3074c1ab628d9dbf139b33f248a8bc253a3f95f0.1676424378.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 15, 2023 at 06:39:35PM +0800, Baolin Wang wrote:
> The isolate_lru_page() can only return 0 or -EBUSY, and most users did
> not care about the negative error of isolate_lru_page(), except one user
> in add_page_for_migration(). So we can convert the isolate_lru_page() to
> return a boolean value, which can help to make the code more clear when
> checking the return value of isolate_lru_page().
> 
> Also convert all users' logic of checking the isolation state.
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
