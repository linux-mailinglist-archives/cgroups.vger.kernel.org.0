Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B83EC18E
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhHNJNk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Aug 2021 05:13:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237671AbhHNJNg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Aug 2021 05:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628932387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgM9wQjlbA+g1qn4Zgr5hjXwUSBX0Df22ncvONuM9No=;
        b=bFe0iQ5ULS+o3EbZL5bSKfa+cRYBPlhlLEW/n71f40Iq9EwHYPueP4kWLbCC6jxqSYjZd6
        ZOaiV5ROdHU/rxM38qjV6n0yitXqRmQWMuZgALyrC/XDd82UJnbFKQrRkt/vpE7vrf0GA5
        faBDIVh50iA1Soo6LEb2Uw2dJIbo2Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-l_UKb5ZgPBa4KBAH732zcA-1; Sat, 14 Aug 2021 05:13:03 -0400
X-MC-Unique: l_UKb5ZgPBa4KBAH732zcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D61968042F4;
        Sat, 14 Aug 2021 09:13:01 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C31C73AC4;
        Sat, 14 Aug 2021 09:12:52 +0000 (UTC)
Date:   Sat, 14 Aug 2021 17:12:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Message-ID: <YReJDkp8kswVdvBj@T590>
References: <20210806080302.298297-1-ming.lei@redhat.com>
 <20210809064159.GA19070@lst.de>
 <YRHx/qaKgEqWdXOP@T590>
 <20210812090037.GE2867@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812090037.GE2867@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Christoph,

On Thu, Aug 12, 2021 at 11:00:37AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 11:26:54AM +0800, Ming Lei wrote:
> > Can you share us what your expectations are in the re-write? Such as:
> > 
> > 1) no impact on normal non-cgroup path
> > 2) ...
> > 3) ...
> 
> Get the call cgroup mess out of this driver entirely?
 
Firstly the patch 2/7 in this series cleans up cgroup references by
killing unnecessary #ifdef and moving cgroup references into common
helpers, and the cgroup uses have been cleaned a lot.

Secondly the issue is that we need to wire proper cgroups(blkcg & memcg) for
loop's IO because loop uses wq or kthread for handling IO, and IMO it isn't
possible to moving cgroup references out of loop entirely if we want to
support this cgroup's function for loop driver.

Finally the current cgroup reference is actually very simple: retrieve
blkcg from bio_blkcg(bio) and memcg from the the blkcg. Then applies
the two in the single function of loop_workfn() only.


Thanks,
Ming

