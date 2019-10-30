Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF48E942F
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 01:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfJ3ArY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 20:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJ3ArY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 29 Oct 2019 20:47:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2EB2083E;
        Wed, 30 Oct 2019 00:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572396444;
        bh=rC4DTyV2zuA+J7bw7dlMjJDABthKcuPGgzmZ5hyLjuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DqNmB7cmPEMslfCggeao0xz1kdv2tQhIkyD7Hc8ovAHyXPu3xJlmo9hCCB4yuZF2C
         Yqf39GHojD759SooL74JvoLuYT7M8J0q4zOVJ8XoFBP4Q/DrCA+/i6JM6+iJH4KCx8
         s/OLz4DGT94C0Dhpc+xlz1YOg3OoodQ3lsuWTBl0=
Date:   Tue, 29 Oct 2019 17:47:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: vmscan: memcontrol: remove
 mem_cgroup_select_victim_node()
Message-Id: <20191029174723.ceb916ec850e7c88ed00e091@linux-foundation.org>
In-Reply-To: <20191029234753.224143-1-shakeelb@google.com>
References: <20191029234753.224143-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 29 Oct 2019 16:47:53 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> Since commit 1ba6fc9af35b ("mm: vmscan: do not share cgroup iteration
> between reclaimers"), the memcg reclaim does not bail out earlier based
> on sc->nr_reclaimed and will traverse all the nodes. All the reclaimable
> pages of the memcg on all the nodes will be scanned relative to the
> reclaim priority. So, there is no need to maintain state regarding which
> node to start the memcg reclaim from. Also KCSAN complains data races in
> the code maintaining the state.
> 
> This patch effectively reverts the commit 889976dbcb12 ("memcg: reclaim
> memory from nodes in round-robin order") and the commit 453a9bf347f1
> ("memcg: fix numa scan information update to be triggered by memory
> event").
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: <syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com>

The sysbot report
(http://lkml.kernel.org/r/00000000000055aba7058af4d378@google.com) was
for a null pointer deref.  So won't we be needing a Fixes: and cc:stable?
