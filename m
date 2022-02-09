Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067014AE7D0
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 04:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiBIDPS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 22:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiBIDOw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 22:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A251C061355
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 19:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644376491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9DHk6APJIsHE1UI+ceCyZijDLQACCuReEtHVHktgAg=;
        b=Ge3pakHxnVL3TJoU87q8CVo0aNFlRKRKvaLFTKgJjrLI2zbnRJFO0wSYnfuMitO5mW88nT
        xyT9v401LnSmcKKk7tE+DcryGq67O3DAg8pnup8DZwT4nZeCtxzVcxVtr6MuDzJMFNud7w
        2y2n+zv5ec+xA5EPsIw/zymFFP+19gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-TMv76d40NiuumRdfoHQ9zA-1; Tue, 08 Feb 2022 22:14:49 -0500
X-MC-Unique: TMv76d40NiuumRdfoHQ9zA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E426E1091DA0;
        Wed,  9 Feb 2022 03:14:47 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EBD4D729;
        Wed,  9 Feb 2022 03:14:31 +0000 (UTC)
Date:   Wed, 9 Feb 2022 11:14:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <YgMxjyVjMjmkMQU5@T590>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114093000.3323470-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Yu Kuai,

On Fri, Jan 14, 2022 at 05:30:00PM +0800, Yu Kuai wrote:
> RFC patch: https://lkml.org/lkml/2021/9/9/1432
> 
> There is a proformance problem in our environment:
> 
> A host can provide a remote device to difierent client. If one client is
> under high io pressure, other clients might be affected.

Can you use the linux kernel storage term to describe the issue?
Such as, I guess here host means target server(iscsi, nvme target?),
client should be scsi initiator, or nvme host. If not, can you provide
one actual example for your storage use case?

With common term used, it becomes pretty easy for people to understand &
solve the issue, and avoid any misunderstanding.

> 
> Limit the overall iops/bps(io.max) from the client can fix the problem,

Just be curious how each client can figure out perfect iops/bps limit?
Given one client doesn't know how many clients are connected to the
target server.

It sounds like the throttle shouldn't be done in client side cgroup,
given the throttle is nothing to do with tasks. 

Maybe it should be done in server side, since server has enough
information to provide fair iops/bps allocation for each clients.


Thanks, 
Ming

