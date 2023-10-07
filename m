Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB47BC894
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJGPSK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 11:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbjJGPSJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 11:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84DCBC
        for <cgroups@vger.kernel.org>; Sat,  7 Oct 2023 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696691847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPtQSncuXiGIg7RBOh+ShvADCBAgeQPrkAF7VWeTPLA=;
        b=UDtrXGfLa1xYxyp1jExhletha02622/UkiRd9zAdZrGCR+KXwPAhFUC4kCqPaRquFfxzNL
        1nOqhI/ecAr4wcKQ/0c2IjArdWmwkBYD08DLAKORkeGEb/1GDKNcIJ5lheU8JM5vEuOJLl
        m2QAQ0OxozJJsC2R5jI8rw422Ob6q48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-677-fko8I_r8MS2GPNjMFFWdRg-1; Sat, 07 Oct 2023 11:17:10 -0400
X-MC-Unique: fko8I_r8MS2GPNjMFFWdRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FCE885A5A8;
        Sat,  7 Oct 2023 15:17:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1BA47215670B;
        Sat,  7 Oct 2023 15:17:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  7 Oct 2023 17:16:11 +0200 (CEST)
Date:   Sat, 7 Oct 2023 17:16:08 +0200
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
Message-ID: <20231007151607.GA24726@redhat.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
 <20231005162417.GA32420@redhat.com>
 <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8f34aa-ced9-e613-3e5f-b5e53a3ef3d9@huaweicloud.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/07, Yu Kuai wrote:
>
> >>>probably need to remove the mul_u64_u64_div_u64 and check for
> >>>overflow/potential overflow ourselves?
> >
> >probably yes...
>
> How about this?
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 1101fb6f6cc8..5482c316a103 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -723,6 +723,10 @@ static unsigned int calculate_io_allowed(u32
> iops_limit,
>
>  static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long
> jiffy_elapsed)
>  {
> +       if (jiffy_elapsed > HZ &&
> +           bps_limit > mul_u64_u64_div_u64(U64_MAX, (u64)HZ,
> (u64)jiffy_elapsed);
> +               return U64_MAX;
> +

I can't suggest anything better...

but I do not know if it is possible that HZ > jiffy_elapsed. If yes, then
mul_u64_u64_div_u64() above is not safe too.

Oleg.

