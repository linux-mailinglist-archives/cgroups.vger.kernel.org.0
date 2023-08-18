Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F9781414
	for <lists+cgroups@lfdr.de>; Fri, 18 Aug 2023 22:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379884AbjHRUGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Aug 2023 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379888AbjHRUGs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Aug 2023 16:06:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7EA1BD4;
        Fri, 18 Aug 2023 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sS4yQXJ2Ya3KF8lqJJez/ry2mxKfhg1PxX5ngqnXF1w=; b=Odxo8IkqUnJLxGrSY+DvFGfooH
        vN+ao/DDJPwfKbeLt8qj9IuL1ZDN1NGpEL/LvlZ5ixQyLt1dNz8c7rJJYraWBJvqWa2QYDyuhRmJS
        /dNWPMrBKeMQm2eUN3tqTYt2wNsE/q7NMsavULQgQgN6F5EbX1PZ5d2ZVaF+UnchLCSDpNzK3yDCU
        0VUy5K31ZVPWwGxjaEARqeh07lVygSoTG+RJAZKVIXjEQRj+lgJ5FLX/XHVYxYkguU1POn5V0lBCr
        F0ha0kOAx8ywFl/XMawCQYsXk7yqhZuQDWglk8fnQpw8bvNEbjOeXDdeJYTaOZ+IzSjejRcFp58Qt
        1kr/K7Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5js-00BPV6-Du; Fri, 18 Aug 2023 20:06:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 0/4] Improve mm documentation
Date:   Fri, 18 Aug 2023 21:06:26 +0100
Message-Id: <20230818200630.2719595-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If you build with W=1, kernel-doc complains about tlb_flush_rmaps().
Then I ran scripts/find-unused-docs.sh against mm/ and found a large
number of files which weren't included in the ReST documentation.
I fixed up a couple of them, and added all those without erros to the
rst files.  There's a lot more work to do to organise all of this, but
at least now if we have documentation that refers to these functions,
we'll get a nice link to them.

Matthew Wilcox (Oracle) (4):
  mm: Fix kernel-doc warning from tlb_flush_rmaps()
  mm: Fix get_mctgt_type() kernel-doc
  mm: Fix clean_record_shared_mapping_range kernel-doc
  mm: Add orphaned kernel-doc to the rst files.

 Documentation/core-api/mm-api.rst | 25 +++++++++++++++++++++++++
 Documentation/mm/highmem.rst      |  1 +
 Documentation/mm/zsmalloc.rst     |  5 +++++
 mm/mapping_dirty_helpers.c        | 11 ++++++-----
 mm/memcontrol.c                   | 31 +++++++++++++------------------
 mm/mmu_gather.c                   |  1 +
 6 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.40.1

