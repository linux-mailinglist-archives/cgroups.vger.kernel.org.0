Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE641DC314
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 01:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgETXmo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 19:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgETXmo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 May 2020 19:42:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BD92072C;
        Wed, 20 May 2020 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018164;
        bh=l2mS/FNkusn6YLF9oQ03x6lf0x9xSKXhbjmtXuuKOEU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=qJ+3eof3hck1Gh1nBa2/+j6vwmtmoQW2xYQ0eTC853DIb8H/4+cHCLfaXLzznyRd6
         ZFvs8b1FX05UdabsiW4zNAhkt+Oi8JMbHMFNUnude+cklLBNZvcgSEyR+fU9qXbBDa
         2AkRUBPbAjt3JLK7Wd6YJ3db43kp8TzLxIItbyQo=
Date:   Wed, 20 May 2020 16:42:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page
 allocator
Message-Id: <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
In-Reply-To: <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
References: <20200520163142.GA808793@chrisdown.name>
        <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 20 May 2020 16:40:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> > -/* The number of times we should retry reclaim failures before giving up. */
> 
> hm, what tree is this against?

Ah, my habit of working in reverse time order sometimes does this ;)

I suggest that "mm, memcg: reclaim more aggressively before high
allocator throttling" and this patch become a two-patch series?

