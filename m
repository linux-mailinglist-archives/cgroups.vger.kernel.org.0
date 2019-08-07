Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB6185359
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2019 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfHGTAk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Aug 2019 15:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGTAk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 7 Aug 2019 15:00:40 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8554B21EF2;
        Wed,  7 Aug 2019 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565204438;
        bh=H8GQL47oZOjHGMHt6mc7yPh3DyXvvruf/VfI2fdq1XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YlgkEarDGN0iPkWPaV/pbw5ncD7rQmx4yJoKPQ9nlm4ouA1+CTa9RxYW+98Vy24gI
         qJ6E09hPzeZhxEQ6ywpXQDT2SLGtRgRNv3zVoSJY1Fz2VgEHGrOKuc89UnlAoTAMXS
         uihlSf1Qg+aa309BG0I7DD0CeJ2fpdTb3Y3u8rXk=
Date:   Wed, 7 Aug 2019 12:00:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-Id: <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
In-Reply-To: <20190807183151.GM136335@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
        <20190803140155.181190-3-tj@kernel.org>
        <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
        <20190807183151.GM136335@devbig004.ftw2.facebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 7 Aug 2019 11:31:51 -0700 Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Tue, Aug 06, 2019 at 04:01:02PM -0700, Andrew Morton wrote:
> > On Sat,  3 Aug 2019 07:01:53 -0700 Tejun Heo <tj@kernel.org> wrote:
> > > There currently is no way to universally identify and lookup a bdi
> > > without holding a reference and pointer to it.  This patch adds an
> > > non-recycling bdi->id and implements bdi_get_by_id() which looks up
> > > bdis by their ids.  This will be used by memcg foreign inode flushing.
> > 
> > Why is the id non-recycling?  Presumably to address some
> > lifetime/lookup issues, but what are they?
> 
> The ID by itself is used to point to the bdi from cgroup and idr
> recycles really aggressively.  Combined with, for example, loop device
> based containers, stale pointing can become pretty common.  We're
> having similar issues with cgroup IDs.

OK, but why is recycling a problem?  For example, file descriptors
recycle as aggressively as is possible, and that doesn't cause any
trouble.  Presumably recycling is a problem with cgroups because of
some sort of stale reference problem?


