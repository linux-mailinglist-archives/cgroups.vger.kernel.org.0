Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74763ACA9
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 16:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiK1Pcj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK1Pbn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 10:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635527DCE
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669649292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omHAWSGVOrqdistvF1mI4veeF3fLfIz9T/z0L/hp1Dw=;
        b=IxOr4AytRl94kiG5gnH1ChBIhDpasQw8MFIoYWRCy67om+lp0UAmrsInvI/6Yi8CQNfKff
        54y2qSgOI05pRdq8Zmb+VXyzTKcFamZv4ZFx3CFvizbuGAO22PAhXiSxmwr36BrtpdlmjO
        LOUVyrV+SGNR1IuFCnABOG6K6iI5bec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-EMi1OtOLOu-dlg5-KW-N1g-1; Mon, 28 Nov 2022 10:28:10 -0500
X-MC-Unique: EMi1OtOLOu-dlg5-KW-N1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 818F0882826;
        Mon, 28 Nov 2022 15:28:09 +0000 (UTC)
Received: from [10.22.10.34] (unknown [10.22.10.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A642F4B3FC8;
        Mon, 28 Nov 2022 15:28:08 +0000 (UTC)
Message-ID: <60c59bed-d9aa-5e49-7a1b-d3463ff267ad@redhat.com>
Date:   Mon, 28 Nov 2022 10:28:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <20221128140631.GI25160@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221128140631.GI25160@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/28/22 09:06, Michal Koutný wrote:
> Hello.
>
> On Sun, Nov 27, 2022 at 10:30:57PM -0500, Waiman Long <longman@redhat.com> wrote:
>> That may not be true if there is no blkg associated with the blkcg. If
>> css_get() fails, the subsequent css_put() call may lead to data
>> corruption as was illustrated in a test system that it crashed on
>> bootup when that commit was included.
> Do you have a stacktrace of the underflowing css_put() in
> blkcg_destroy_blkgs()?
>
> It looks to me slightly as a mistake of the caller site that it passes
> struct blkcg * without any references.
>
> By a cursory look, could it be cgwb_release_workfn?
>
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -390,11 +390,11 @@ static void cgwb_release_workfn(struct work_struct *work)
>          wb_shutdown(wb);
>
>          css_put(wb->memcg_css);
> -       css_put(wb->blkcg_css);
>          mutex_unlock(&wb->bdi->cgwb_release_mutex);
>
>          /* triggers blkg destruction if no online users left */
>          blkcg_unpin_online(wb->blkcg_css);
> +       css_put(wb->blkcg_css);
>
>          fprop_local_destroy_percpu(&wb->memcg_completions);
>
> Does your crash involve this stack?

That looks like a possible cause for the system crash that we are 
seeing. In my testing, I do see one case out of more than a dozen calls 
to blkcg_destroy_blkgs() where css_tryget() fail in the reproducing 
system during bootup. However, I didn't force a stack dump at that point 
and so I am not sure if that is the place, though it looks likely. One 
of the crashes that was reported does involve blkcg_unpin_online(). So 
maybe that is it.

Cheers,
Longman


