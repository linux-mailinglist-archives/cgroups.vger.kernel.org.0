Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F06973A9
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 02:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjBOBb0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 20:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBOBbY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 20:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB8034011
        for <cgroups@vger.kernel.org>; Tue, 14 Feb 2023 17:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676424636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKU0neX7HspOKwgho4RN5DZrsBuffeJ73oSMJgy2eMo=;
        b=GCkNdpXMvi1S332h7Iw/1eguYe53xY0CU8ggS+5/uWRhpaVO/K+j3TMTXc0HuKxaikOTbO
        PsRAjIKoaoqRswvoZOTDxJcsRwiYqK/EObsyTTlhTUZFL4ADlqhixfXPzCg7sYdcXdqu5z
        W9pd3Uq7hDwF8RBSSmzRIy3wwwXvOLY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-xW-TbRo9MsWTgZcPn0rg8w-1; Tue, 14 Feb 2023 20:30:33 -0500
X-MC-Unique: xW-TbRo9MsWTgZcPn0rg8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAF5C3815F6D;
        Wed, 15 Feb 2023 01:30:32 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D4ED492B15;
        Wed, 15 Feb 2023 01:30:21 +0000 (UTC)
Date:   Wed, 15 Feb 2023 09:30:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: revert blk-cgroup changs
Message-ID: <Y+w1qFgMNh6mz/GH@T590>
References: <20230214183308.1658775-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214183308.1658775-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 14, 2023 at 07:33:03PM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series reverts a bunch of blk-cgroup patches as one of them
> caused a problem for which the time is running out to fix for this
> merge window

Thanks for fixing these issues!

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

