Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633AD53D4D4
	for <lists+cgroups@lfdr.de>; Sat,  4 Jun 2022 04:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348936AbiFDCQe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jun 2022 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiFDCQd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jun 2022 22:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22BC13879C
        for <cgroups@vger.kernel.org>; Fri,  3 Jun 2022 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654308992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAVPgM6qZdc+rcFlXJ6cxNAqdIfu1YMLp42YefCDdmM=;
        b=bhIYuC63yTTE46WyO8LaveJ+ryGb1ahxVjGrp3/JSvbKKB2QROqXgVuuMv4NTpWohSmRNV
        Zg9QUHHuspBHOXMhPsNu9O3d/fP/zmxpNOHuMsvoLs6sjmZF4DscEJMOdyjr3S/6mWsTGt
        U3hTUjYY+nG2w987HAHc2Qq0BjtcADs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-WlB0nJM3Pb-0ptLsha05ag-1; Fri, 03 Jun 2022 22:16:29 -0400
X-MC-Unique: WlB0nJM3Pb-0ptLsha05ag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1D2101A54E;
        Sat,  4 Jun 2022 02:16:28 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 171E7492C3B;
        Sat,  4 Jun 2022 02:16:24 +0000 (UTC)
Date:   Sat, 4 Jun 2022 10:16:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Message-ID: <YprAc9uLaDPXUW2s@T590>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-3-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 02, 2022 at 03:20:19PM -0400, Waiman Long wrote:
> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
> Simplify error handling code by returning this error directly instead
> of setting an intermediate "ret" variable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

