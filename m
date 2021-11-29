Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11DD461051
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 09:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbhK2Ioi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 03:44:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350040AbhK2Imh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 03:42:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B6ECA212CB;
        Mon, 29 Nov 2021 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638175157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1/HRvQWe5bupilVHXWVZDusBm8nr9LZt0uqBedKdKA=;
        b=J4qijL9j7NKJC0s4vnqOlrDs2BSFPsMfOKHgq75fzXUbUMmG6kDFsHC446/t8l9HnhxQGi
        1X48f8fJWJ9sQfbIUtxwtWBvay0Vz0aMdUE83pfyyc4cYhcZsz7fW82PhBT10czrrivQxi
        qE3pMx7MyDOyufnfhAhM+rP1LoUdXcM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8242FA3B83;
        Mon, 29 Nov 2021 08:39:17 +0000 (UTC)
Date:   Mon, 29 Nov 2021 09:39:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YaSRtKwTCOj7JnR6@dhcp22.suse.cz>
References: <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
 <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
 <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
 <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
 <20211126162623.GA10277@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126162623.GA10277@haolee.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 26-11-21 16:26:23, Hao Lee wrote:
[...]
> I will try Matthew's idea to use semaphore or mutex to limit the number of BE
> jobs that are in the exiting path. This sounds like a feasible approach for
> our scenario...

I am not really sure this is something that would be acceptable. Your
problem is resource partitioning. Papering that over by a lock is not
the right way to go. Besides that you will likely hit a hard question on
how many tasks to allow to run concurrently. Whatever the value some
workload will very likely going to suffer. We cannot assume admin to
chose the right value because there is no clear answer for that. Not to
mention other potential problems - e.g. even more priority inversions
etc.
-- 
Michal Hocko
SUSE Labs
