Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44016945AA
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBMMTu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBMMTt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 07:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47ACDF2
        for <cgroups@vger.kernel.org>; Mon, 13 Feb 2023 04:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNqQ9bXDgnnpNFNLGb68QXM6v2J1h53ebKftG058Huc=;
        b=RqvkKL+JjOK7403TkRKXQPLdxOeGq81cEu5v8Idqv78gm7Co8amQ5GnO/PpOQYY42LsBV4
        h3D0mR57NCSd98RQurlmEDSiZcf1Ln089ERrUMvJLxfIQ991dJuU4xdbsaCFUg8q1drMCl
        sECeXCvs3f6uGIWLAv+Ddxl10bUppXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-NSzQ04ndMlucMFWpQUBP1w-1; Mon, 13 Feb 2023 07:11:46 -0500
X-MC-Unique: NSzQ04ndMlucMFWpQUBP1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109AE811E6E;
        Mon, 13 Feb 2023 12:11:46 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD5E3140EBF6;
        Mon, 13 Feb 2023 12:11:41 +0000 (UTC)
Date:   Mon, 13 Feb 2023 20:11:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 3/3] blk-cgroup: only grab an inode reference to the disk
 for each blkg
Message-ID: <Y+oo+P0MIZK8QMDZ@T590>
References: <20230213104134.475204-1-hch@lst.de>
 <20230213104134.475204-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213104134.475204-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 13, 2023 at 11:41:34AM +0100, Christoph Hellwig wrote:
> To avoid a circular reference, do not grab a device model reference
> to the gendisk for each blkg, but just the lower level inode reference
> preventing the memory from beeing freed.

It might not be enough to just prevent gendisk memory from being freed,
anywhere queue reference via disk->queue could become not safe given
disk->queue can be released after disk_release() is called.

thanks,
Ming

