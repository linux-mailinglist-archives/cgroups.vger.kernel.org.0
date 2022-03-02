Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703854CA6B1
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiCBNzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 08:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiCBNzR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 08:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C48792
        for <cgroups@vger.kernel.org>; Wed,  2 Mar 2022 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646229088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uztNbkycVorcCm23CCSPPERhmYpoYyhrF08z8BpZsMg=;
        b=anb6/UmiHK5LDhBYCBy81XyHLtUE3P4oWlGshTZ6I4k7fW1VWhX+xy2IA569rYnbNldC87
        oW7SieWQyeLXPKQ/7EUxTkPGrMSCYVUzCtyjygWoRHnZhwbWu+AWx2fKCuzMTgZcL0b+1b
        uvnPN3vn6CejiLHQb4vb0fyouApTDIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-4GxEwgBJNDCSKB_4CmBouw-1; Wed, 02 Mar 2022 08:51:25 -0500
X-MC-Unique: 4GxEwgBJNDCSKB_4CmBouw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA42B824FA9;
        Wed,  2 Mar 2022 13:51:23 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8801832B4;
        Wed,  2 Mar 2022 13:51:19 +0000 (UTC)
Date:   Wed, 2 Mar 2022 21:51:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] blk-throttle: Set BIO_THROTTLED when bio has
 been throttled
Message-ID: <Yh92UQ9/bxe6EcWe@T590>
References: <20220301123919.2381579-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301123919.2381579-1-qiulaibin@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 01, 2022 at 08:39:19PM +0800, Laibin Qiu wrote:
> 1.In current process, all bio will set the BIO_THROTTLED flag
> after __blk_throtl_bio().
> 
> 2.If bio needs to be throttled, it will start the timer and
> stop submit bio directly. Bio will submit in
> blk_throtl_dispatch_work_fn() when the timer expires.But in
> the current process, if bio is throttled. The BIO_THROTTLED
> will be set to bio after timer start. If the bio has been
> completed, it may cause use-after-free blow.
> 
> BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70
> Read of size 2 at addr ffff88801b8902d4 by task fio/26380

After the queue lock is released, the bio can be dispatched & completed,
so it shouldn't be touched after lock release:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

