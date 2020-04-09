Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8FC1A2DA5
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 04:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDICjQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 22:39:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27337 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726521AbgDICjP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 22:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586399955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HR+51ncLat+TViGePt1EzZ9/+c+0ffiOCieXE52eEnw=;
        b=f8NO9WvipJyNIkkhrJ1ASjOXLcmeZ/L+5qyCrVkWrOgVmjRoOLP4X0CuL/Rc5UjMgb3tOE
        uaiV+L0o7zOuV4lsfJLAM6H5uJob1YwzsXyfUNsYWifr5WmS/dZduZyjp4sppeJOFAQ7nP
        GEGoaC0NthSH/R8H1X+82ZhrZ0+ajaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-x3013G3HMNqqRz2AZLIqHg-1; Wed, 08 Apr 2020 22:39:12 -0400
X-MC-Unique: x3013G3HMNqqRz2AZLIqHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F23DF107ACCA;
        Thu,  9 Apr 2020 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABBA19DD6B;
        Thu,  9 Apr 2020 02:39:02 +0000 (UTC)
Date:   Thu, 9 Apr 2020 10:38:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200409023857.GB370295@localhost.localdomain>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <20200409014406.GA370295@localhost.localdomain>
 <20200409021119.GJ162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409021119.GJ162390@mtj.duckdns.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 08, 2020 at 10:11:19PM -0400, Tejun Heo wrote:
> On Thu, Apr 09, 2020 at 09:44:06AM +0800, Ming Lei wrote:
> > Almost all __blk_mq_end_request() follow blk_update_request(), so the
> > completed bytes can be passed to __blk_mq_end_request(), then we can
> > avoid to introduce this field.
> 
> But on some drivers blk_update_request() may be called multiple times before
> __blk_mq_end_request() is called and what's needed here is the total number of
> bytes in the whole request, not just in the final completion.

OK.

Another choice might be to record request bytes in rq's payload
when calling .queue_rq() only for these drivers.

> 
> > Also there is just 20 callers of __blk_mq_end_request(), looks this kind
> > of change shouldn't be too big.
> 
> This would work iff we get rid of partial completions and if we get rid of
> partial completions, we might as well stop exposing blk_update_request() and
> __blk_mq_end_request().

Indeed, we can store the completed bytes in request payload, so looks killing
partial completion shouldn't be too hard.

Thanks,
Ming

