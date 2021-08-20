Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79D3F29B0
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhHTKBK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 06:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhHTKBJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 06:01:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC19C061575
        for <cgroups@vger.kernel.org>; Fri, 20 Aug 2021 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=r2Z9eITNHiEp7NUrVW3qeRp2WLhTvHeWKNGqhJZadE0=; b=YPtVD+vSd4Bt2xpK6AK7FP5otx
        HcYAUZlhNUjWy/FQcCrMlXZKYS8Je6bUbT0Rg5kjayPyBNm2fvGkba3ExbKBzlw21UyGoCtjWKsJ3
        cNOGddcaqdrfdymLgJbheY7oliULnvQhPMUJEPSwSfAW1bqUdS2xbN4vhRcSM8/DEX+tpMHj+o5hk
        9ukcTSUSAA3TSpxSfFjUcvDER0eGyC+f7fgF0PB2rOs7klh7AMN/sp555oERT8X6J9S/JoS/0Y26+
        e9rUyllWf/4Zqee1RKQ4cfM6edjy/vbxGauTDSJ+B6dNCG+aqgsOC4uQsxfOb5afuqoq9PW7nnuKR
        OIk8NcdA==;
Received: from [2001:4bb8:188:1b1:43a3:4b88:ec18:d4de] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH1I0-006LGY-OF; Fri, 20 Aug 2021 09:58:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: unexport memcg locking helpers
Date:   Fri, 20 Aug 2021 11:58:13 +0200
Message-Id: <20210820095815.445392-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

neither the old page-based nor the new folio-based memcg locking
helpers are used in modular code at all, so drop the exports.
