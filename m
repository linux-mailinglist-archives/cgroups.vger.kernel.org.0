Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45854C9A15
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 01:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiCBAv5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 19:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiCBAv5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 19:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F86913F2A
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646182274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSE7XhaCLoK3lvixPJtHiDdmfP+vYGOwXq3x81uSukw=;
        b=dSJsgPpRHCQ1jgbKljjd6pRUPrEFezAffRn2B8o3XXU3gPOdWucGtl3oJDo3kEFEoG07ub
        aZ9C23uZaqi+RSAM8RNXkIZ3vlYx/OzEXLuBYRV1DQu6CZP3gIEhH6Ue+ywT5BfBOHxIL5
        861OQFA3DWNBKxv6EfQv6zvi52uEYyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-BBzowO1OMtOEOJJbFaBeuw-1; Tue, 01 Mar 2022 19:51:11 -0500
X-MC-Unique: BBzowO1OMtOEOJJbFaBeuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051E08145F7;
        Wed,  2 Mar 2022 00:51:10 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0B0519BE;
        Wed,  2 Mar 2022 00:51:04 +0000 (UTC)
Date:   Wed, 2 Mar 2022 08:51:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <Yh6/dH2CERzsBPJd@T590>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
 <Yhxnkg0AEaj36t+a@T590>
 <YhyYpWHGVhs3J/dk@infradead.org>
 <Yh31bQu3gbXoDBuK@T590>
 <836f0686-4ac8-327d-2bab-64a762ea8673@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <836f0686-4ac8-327d-2bab-64a762ea8673@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 01, 2022 at 09:54:28PM +0800, yukuai (C) wrote:
> 在 2022/03/01 18:29, Ming Lei 写道:
> > On Mon, Feb 28, 2022 at 01:40:53AM -0800, Christoph Hellwig wrote:
> > > On Mon, Feb 28, 2022 at 02:11:30PM +0800, Ming Lei wrote:
> > > > > FYI, this crashed left rigt and center when running xfstests with
> > > > > traces pointing to throtl_pending_timer_fn.
> > > > 
> > > > Can you share the exact xfstests test(fs, test)? Or panic log?
> > > > 
> > > > I can't reproduce it when running './check -g auto' on XFS, meantime
> > > > tracking throtl_pending_timer_fn().
> > > 
> > >  From a quick run using f2fs:
> > > 
> > > generic/081 files ... [  316.487861] run fstests generic/081 at 2022-02-28 09:38:40
> > 
> > Thanks for providing the reproducer.
> > 
> > The reason is that the pending timer is deleted in blkg's release
> > handler, so the timer can still be live after request queue is released.
> > 
> > The patch of 'block: cancel all throttled bios in del_gendisk()' should just
> > make it easier to trigger.
> > 
> > After patch of "block: move blkcg initialization/destroy into disk allocation/
> > release handler" lands, the issue can be fixed easily by:
> 
> Hi,
> 
> Thanks for locating this problem,
> 
> Perhaps this patch should wait for the problem to be solved.

BTW, please see the top 3 patches in the following tree:

https://github.com/ming1/linux/commits/my_v5.18-pre-rc

xfstests generic/081 can run for hours without problems, without the fix,
the crash can be triggered in 10 minutes.


Thanks,
Ming

