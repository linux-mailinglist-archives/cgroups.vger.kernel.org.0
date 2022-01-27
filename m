Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFD49D9CA
	for <lists+cgroups@lfdr.de>; Thu, 27 Jan 2022 06:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiA0FEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jan 2022 00:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbiA0FEI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jan 2022 00:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643259847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plPajYXA8B5ZLakDfOB/mq6gwvfYbK84k4ZYLKgoU6w=;
        b=K/uusz10UWBF0kNGSINnxEN0rCT9PEtgs0Tclz6pdbMLSqFnmN/dtncCELtyt2KO0VO0jp
        Y4w5DWy3PwS0uxyDYySqf8FwRTs4tQOAoujs2KgIMolnLTikqHKRCKaVoSRc/Nhc/aSOmp
        3DFiAp4+oaKwgSfPzBhdL7j2CV1GXIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-NGGhIgoONtKk4r22eqt6yQ-1; Thu, 27 Jan 2022 00:03:57 -0500
X-MC-Unique: NGGhIgoONtKk4r22eqt6yQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E02283DD23;
        Thu, 27 Jan 2022 05:03:55 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6162F5ED2D;
        Thu, 27 Jan 2022 05:03:40 +0000 (UTC)
Date:   Thu, 27 Jan 2022 13:03:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, mkoutny@suse.com, paulmck@kernel.org,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YfInp7SsZNNgRfB7@T590>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com>
 <Yd5FkuhYX9YcgQkZ@T590>
 <b416e6a6-f2c9-caf3-dacd-f937746207da@huawei.com>
 <YfF+yukISfkuc9IK@slm.duckdns.org>
 <630c162b-8bdd-d87e-0d80-c7a78ea267a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <630c162b-8bdd-d87e-0d80-c7a78ea267a5@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 27, 2022 at 10:45:33AM +0800, yukuai (C) wrote:
> 在 2022/01/27 1:03, Tejun Heo 写道:
> > On Mon, Jan 24, 2022 at 11:50:11AM +0800, yukuai (C) wrote:
> > > Both ways can fix the problem, which way do you prefer?
> > 
> > Ming's suggested change seems simpler, no?
> 
> Hi,
> 
> Yes, if Ming don't mind, I can send a new version after Ming's
> pathset "block: don't drain file system I/O on del_gendisk".

The patch of canceling throttled bios shouldn't be conflicted
with the above big patchset, and you can send it out now against
for-5.18/block.


Thanks,
Ming

