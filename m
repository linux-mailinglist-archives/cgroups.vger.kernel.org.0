Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB74C62D1
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 07:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiB1GMn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 01:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiB1GMl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 01:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F8966ACC
        for <cgroups@vger.kernel.org>; Sun, 27 Feb 2022 22:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646028722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=koDNyhpZRRWUbZFhH9KWUoWf+UDX5NXH16ZSUqLPEwY=;
        b=RmLQNyorDtsYwwMMR5zor/HnhNq5QCh8xoJUhjNELgxTIjcPTZqf5pTQMqyxoFOIbK+jbV
        KTvy8Tz0fH2sJ1FsdLfN+4PCGijxjX4Ecdg3tfBlBMTwnnjUnXvxnGtHUtE9OmJywyWHLP
        D4pqL2iGnxnvpNj/f2fDyUGiP5gI7Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-ks5XyE6KNN-Cmhjz6i-Eiw-1; Mon, 28 Feb 2022 01:11:58 -0500
X-MC-Unique: ks5XyE6KNN-Cmhjz6i-Eiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D747800422;
        Mon, 28 Feb 2022 06:11:56 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C84D5DBBD;
        Mon, 28 Feb 2022 06:11:35 +0000 (UTC)
Date:   Mon, 28 Feb 2022 14:11:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <Yhxnkg0AEaj36t+a@T590>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhuyBgZSS6m/Mwu6@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Christoph,

On Sun, Feb 27, 2022 at 09:16:54AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 07:56:37PM +0800, Yu Kuai wrote:
> > Throttled bios can't be issued after del_gendisk() is done, thus
> > it's better to cancel them immediately rather than waiting for
> > throttle is done.
> > 
> > For example, if user thread is throttled with low bps while it's
> > issuing large io, and the device is deleted. The user thread will
> > wait for a long time for io to return.
> 
> FYI, this crashed left rigt and center when running xfstests with
> traces pointing to throtl_pending_timer_fn.

Can you share the exact xfstests test(fs, test)? Or panic log?

I can't reproduce it when running './check -g auto' on XFS, meantime
tracking throtl_pending_timer_fn().


Thanks,
Ming

