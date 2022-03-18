Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3474DD507
	for <lists+cgroups@lfdr.de>; Fri, 18 Mar 2022 08:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiCRHFr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Mar 2022 03:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiCRHFm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Mar 2022 03:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B23261DFB
        for <cgroups@vger.kernel.org>; Fri, 18 Mar 2022 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647587060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRxKY2ALGuJ0XownOAjggWtKbSTTBHbjSbBWPLWoaKg=;
        b=PeMnVBPXVaEOI0qir+CS71SreFVbmwbSlsDBZ1sG6oE0O9+cdJOKWlqYzaInIlBbiA9uGA
        TCqV6++qI8qOynAaSn2E8dzXWuotNfGKuTKmz5i9auBVlwSv8jKi3jup91lLgMcPGgeRjE
        Zh3AxjTxca8CYCjyycZcmkVZeLMqcMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-jfQBtssXPX6_DDe79gYaYw-1; Fri, 18 Mar 2022 03:04:17 -0400
X-MC-Unique: jfQBtssXPX6_DDe79gYaYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00B11802809;
        Fri, 18 Mar 2022 07:04:17 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B7E72156897;
        Fri, 18 Mar 2022 07:04:06 +0000 (UTC)
Date:   Fri, 18 Mar 2022 15:04:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tj@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <YjQu4FfpUq33pyDx@T590>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
 <Yhxnkg0AEaj36t+a@T590>
 <YhyYpWHGVhs3J/dk@infradead.org>
 <Yh31bQu3gbXoDBuK@T590>
 <836f0686-4ac8-327d-2bab-64a762ea8673@huawei.com>
 <Yh6/dH2CERzsBPJd@T590>
 <f46c8512-400b-144f-e2ba-c57cc895fca8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f46c8512-400b-144f-e2ba-c57cc895fca8@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 17, 2022 at 07:22:04PM +0800, yukuai (C) wrote:
> 在 2022/03/02 8:51, Ming Lei 写道:
> > On Tue, Mar 01, 2022 at 09:54:28PM +0800, yukuai (C) wrote:
> > > 在 2022/03/01 18:29, Ming Lei 写道:
> > > > On Mon, Feb 28, 2022 at 01:40:53AM -0800, Christoph Hellwig wrote:
> > > > > On Mon, Feb 28, 2022 at 02:11:30PM +0800, Ming Lei wrote:
> > > > > > > FYI, this crashed left rigt and center when running xfstests with
> > > > > > > traces pointing to throtl_pending_timer_fn.
> > > > > > 
> > > > > > Can you share the exact xfstests test(fs, test)? Or panic log?
> > > > > > 
> > > > > > I can't reproduce it when running './check -g auto' on XFS, meantime
> > > > > > tracking throtl_pending_timer_fn().
> > > > > 
> > > > >   From a quick run using f2fs:
> > > > > 
> > > > > generic/081 files ... [  316.487861] run fstests generic/081 at 2022-02-28 09:38:40
> > > > 
> > > > Thanks for providing the reproducer.
> > > > 
> > > > The reason is that the pending timer is deleted in blkg's release
> > > > handler, so the timer can still be live after request queue is released.
> > > > 
> > > > The patch of 'block: cancel all throttled bios in del_gendisk()' should just
> > > > make it easier to trigger.
> > > > 
> > > > After patch of "block: move blkcg initialization/destroy into disk allocation/
> > > > release handler" lands, the issue can be fixed easily by:
> 
> Hi, Ming
> 
> Now that the above patch is landed in linux-next, do you intend to fix
> the above problem? Or I can take over if you don't mind.

Hi Yu Kuai, 

I will send one fix and your V9 later.


Thanks,
Ming

