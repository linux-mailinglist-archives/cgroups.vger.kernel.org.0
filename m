Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748F7BA6D8
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJEQmq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjJEQkq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 12:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898AE55A1
        for <cgroups@vger.kernel.org>; Thu,  5 Oct 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696523123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcIHJd8zrYki+Wg0RoULYhP1Y/OyxEQ+26ogj6n5WEc=;
        b=i7hty6kqPZmdFFdAWH4JjD15l//U7thddu6NJZNG8el/PIdPm7FQzlq59e/gSXx5h15c1K
        AQacdJfrvuehHIQtq2tmL46wFQRbehqMN99pz75rI/KnRVfKGTX950sbeqRVElf9ZWc4Q0
        EacJ3FaCUNkkd7XpWCwqm5rFKm+w61c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-R_aqFmEYMeisHvtuHQG8fQ-1; Thu, 05 Oct 2023 12:25:20 -0400
X-MC-Unique: R_aqFmEYMeisHvtuHQG8fQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F1AA85A5A8;
        Thu,  5 Oct 2023 16:25:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A7E02156711;
        Thu,  5 Oct 2023 16:25:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  5 Oct 2023 18:24:21 +0200 (CEST)
Date:   Thu, 5 Oct 2023 18:24:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Khazhy Kumykov <khazhy@chromium.org>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
Message-ID: <20231005162417.GA32420@redhat.com>
References: <20230928015858.1809934-1-linan666@huaweicloud.com>
 <CACGdZY+JV+PdiC_cspQiScm=SJ0kijdufeTrc8wkrQC3ZJx3qQ@mail.gmail.com>
 <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ace01e8-6815-29d0-70ce-4632818ca701@huaweicloud.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Li,

On 10/05, Li Nan wrote:
>
> >I don't think this change is sufficient to prevent kernel crash, as a
> >"clever" user could still set the bps_limit to U64_MAX - 1 (or another
> >large value), which probably would still result in the same crash. The
> >comment in mul_u64_u64_div_u64 suggests there's something we can do to
> >better handle the overflow case, but I'm not sure what it's referring
> >to. ("Will generate an #DE when the result doesn't fit u64, could fix
> >with an __ex_table[] entry when it becomes an issue.") Otherwise, we
>
> When (a * mul) overflows, a divide 0 error occurs in
> mul_u64_u64_div_u64(). Commit 3dc167ba5729 ("sched/cputime: Improve
> cputime_adjust()") changed func and said: "Will generate an #DE when the
> result doesn't fit u64, could fix with an __ex_table[] entry when it
> becomes an issue." But we are unsure of how to fix it. Could you please
> explain how to fix this issue.

Not sure I understand the question...

OK, we can change mul_u64_u64_div_u64() to trap the exception, say,

	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
	{
		u64 q;

		asm ("mulq %2; 1: divq %3; 2:\n"
		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_DEFAULT|EX_FLAG_CLEAR_AX)
					: "=a" (q)
					: "a" (a), "rm" (mul), "rm" (div)
					: "rdx");

		return q;
	}

should (iiuc) return 0 if the result doesn't fit u64 or div == 0.

But even if we forget that this is x86-specific, how can this help?
What should calculate_bytes_allowed() do/return in this case?

> >probably need to remove the mul_u64_u64_div_u64 and check for
> >overflow/potential overflow ourselves?

probably yes...

Oleg.

