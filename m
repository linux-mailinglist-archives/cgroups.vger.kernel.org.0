Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6504B7BCE3C
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbjJHLiI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344736AbjJHLiH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 07:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7377AC
        for <cgroups@vger.kernel.org>; Sun,  8 Oct 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696765043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dd6ivPkoy5OU8m6zrjUxdg/2ojaw9JTGsy7cUreFIZk=;
        b=P6d2RWqGsymXRb9jLBD3q2moVDY2q1iBDlPXysBlB/sRjhP9HZq2zkBh2sjOqNy0bt0NZb
        fr8PEpLErM+SND1Gms+qFmDRjLFKdqJemf8bC9ufoVlXADY5z9mZa9vFKgw0agQ8foIuHM
        ECzkBqtlOa4GJiQQ5zdW9cWZKsOK0do=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-_NdAhrgfP9K3XOElsbPEvw-1; Sun, 08 Oct 2023 07:37:06 -0400
X-MC-Unique: _NdAhrgfP9K3XOElsbPEvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0BE93804522;
        Sun,  8 Oct 2023 11:37:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id 625B61054FC0;
        Sun,  8 Oct 2023 11:37:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun,  8 Oct 2023 13:36:07 +0200 (CEST)
Date:   Sun, 8 Oct 2023 13:36:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan666@huaweicloud.com>,
        Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
Message-ID: <20231008113602.GB24726@redhat.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
 <20231007151607.GA24726@redhat.com>
 <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21843836-7265-f903-a7d5-e77b07dd5a71@huaweicloud.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/08, Yu Kuai wrote:
>
> >>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long
> >>jiffy_elapsed)
> >>  {
> >>+       if (jiffy_elapsed > HZ &&
> >>+           bps_limit > mul_u64_u64_div_u64(U64_MAX, (u64)HZ,
> >>(u64)jiffy_elapsed);
> >>+               return U64_MAX;
> >>+
> >
> >I can't suggest anything better...
> >
> >but I do not know if it is possible that HZ > jiffy_elapsed. If yes, then
> >mul_u64_u64_div_u64() above is not safe too.
>
> Well, 'jiffy_elapsed > HZ' is judged before mul_u64_u64_div_u64().

Yes, sorry, somehow I didn't notice this check.

Oleg.

