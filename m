Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7966D2349DD
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgGaRGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 13:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgGaRGE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 31 Jul 2020 13:06:04 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A966D2074B;
        Fri, 31 Jul 2020 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596215164;
        bh=pLbeAibfw5n2vkRG3FD5oxVwpEDd8hei+OHLkZgRQvw=;
        h=Date:From:To:Cc:Subject:From;
        b=Hjwd8hIOq2+YnSWgcfAaNT3mNNczNPK0tA7gx9oFNc8GF8v0yf3VaLACd2KhJjoA4
         SIBdIPBq9kLq+UFq5caZc18jgsGVVHJAAN4S4KuZl0bk1v34gwmAQXYRpLaaKeVLNu
         6C9M00qHahqAzb6E2MjmIm1ZUkDnfk6pTmD+ahFE=
Date:   Fri, 31 Jul 2020 12:12:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/2][next] Use flexible_array_size() helper in memcpy()
Message-ID: <cover.1596214831.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This small series aims to:

1. Make use of the flexible_array_size() helper in a call to memcpy()
2. While there, use the preferred form for passing the size of a structure type

Thanks

Gustavo A. R. Silva (2):
  mm: memcontrol: Use flex_array_size() helper in memcpy()
  mm: memcontrol: Use the preferred form for passing the size of a
    structure type

 mm/memcontrol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.27.0

