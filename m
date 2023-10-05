Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB497BA774
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjJERP5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJERO7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 13:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9726BB
        for <cgroups@vger.kernel.org>; Thu,  5 Oct 2023 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696525523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKcKcbN0G6E1ZA/muCY4Z4QSr4fIlnQTBllEL5N75xE=;
        b=Wzr2aLrdb3ewZ8cF7zvq8rOrPvU0fnthcHuCQa0dCbRPu10I1tUlD+NRYUlFK2SojMjVe4
        h4H4fJ1gyyorcuZSncoCxvQEYl4fanGtVJfnyLyPwYpl41+9hugst5ChxiqOu28sSoULwp
        92VrePOO+oI4mKSFnNp3YEVPSoSEv90=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-XZ12uclKPy6PIwXfFzFfYw-1; Thu, 05 Oct 2023 13:05:16 -0400
X-MC-Unique: XZ12uclKPy6PIwXfFzFfYw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12A563C0F670;
        Thu,  5 Oct 2023 17:05:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36232492B05;
        Thu,  5 Oct 2023 17:05:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  5 Oct 2023 19:04:17 +0200 (CEST)
Date:   Thu, 5 Oct 2023 19:04:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
Message-ID: <20231005170413.GB32420@redhat.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

sorry, didn't notice this part before.

I am not a asm expert (to say at least;) but

On 10/05, Li Nan wrote:
>
> When (a * mul) overflows, a divide 0 error occurs in
> mul_u64_u64_div_u64().

Just in case... No, iirc it is divq which triggers #DE when the
result of division doesn't fit u64.

(a * mul) can't overflow, the result is 128-bit rax:rdx number.

Oleg.

