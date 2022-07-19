Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E701C579384
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 08:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiGSGxt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGSGxs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 02:53:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A028E03
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 23:53:47 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31e1ecea074so54376047b3.8
        for <cgroups@vger.kernel.org>; Mon, 18 Jul 2022 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5KxztmCmMVHIN310A4ZHMWsumpUd/uei+99VlIfECo=;
        b=g45peOwJLERlzIw9j9Qr3FglyHx1ejYM46zmBvA/t4aMhMusgrlHHP7DtNqT3w8UDx
         +nBrmbn3AeWkJLwpUK3lBY+pXw5XeerP0NGTxCjRBjj8iozdPjAL8Jci7xtIVoqKdBHL
         fEUljn0PqIWZr/hPjTugMvYwnqskDlL10SVhxZ8CnPVRvTIxBC5x8rAXgDmSAduRjwo4
         vhYvaSwgrqv7mSpvQ5A7gKQbEfS+zIX/0XYSM/O/B+apqFIO+1NiJatid+NqnQIqIo7K
         L1w3wWiR2lvJZHwarcjfbBoMYr2KyA83S8A3w/tgFxGpzA8wF+Vuh0UAE5vn24mWyr64
         ig1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5KxztmCmMVHIN310A4ZHMWsumpUd/uei+99VlIfECo=;
        b=GIMO4H1Iha4ZE8MaxELTgsAw66umAzzakqyaPrITSW3KLoLmY70g0/LmAtO4h33oFq
         9ntWYOqqF7jhv55DLcRMT06C+5JmWyg0BMILqgPN41J222kKlkqVNDYZ/zdpFXhpfq48
         bsxl6IVYCAZYhs82RDHo9fmuupjzOv3MZp4qDYX6LkkRE/NMuncPe+ye+keiWhdFJmdn
         JV3sfEz668osQMt6JkJotv9bblIqae3HeK1vl66kZt8c2YAKcyEpLORmLXVYKRvrHh9u
         gS9XqkGtdnSBDUl21g/KFP2UkV4HzdLtsUOTurCD5qzDmhwH9n1gndmlHgPrtlwoC9Mv
         o8Jg==
X-Gm-Message-State: AJIora/6IlfM+SHjwxWvyAqk4EtxqpVP4LYBO32FVOi0Biw8sc1fx+Hw
        neHwM48AJ4uP32vCqPIkFg4MTikD91Hb6pFEJdzKQg==
X-Google-Smtp-Source: AGRyM1vKSBqibQJYRQ+aqUzhML96/8AsNMD0slmFOO0+vHlS3+2F8QNM4+T5y938H9dnBSoBA29EmeNpgAcZLDGPnbA=
X-Received: by 2002:a0d:ca88:0:b0:31d:c7a:6ec3 with SMTP id
 m130-20020a0dca88000000b0031d0c7a6ec3mr35667468ywd.141.1658213626831; Mon, 18
 Jul 2022 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220718083646.67601-1-hanjinke.666@bytedance.com>
In-Reply-To: <20220718083646.67601-1-hanjinke.666@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 19 Jul 2022 14:53:09 +0800
Message-ID: <CAMZfGtVLkO6T-0n7fMBTvR84Ji8GhTO5==u9v+8f+dRkJhFHMA@mail.gmail.com>
Subject: Re: [PATCH] block: don't allow the same type rq_qos add more than once
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 18, 2022 at 4:37 PM Jinke Han <hanjinke.666@bytedance.com> wrote:
>
> From: hanjinke <hanjinke.666@bytedance.com>
>
> In our test of iocost, we encounttered some list add/del corrutions of
> inner_walk list in ioc_timer_fn.
> The resean can be descripted as follow:
>
> cpu 0                                           cpu 1
> ioc_qos_write                                   ioc_qos_write
>
> ioc = q_to_ioc(bdev_get_queue(bdev));
> if (!ioc) {
>         ioc = kzalloc();                        ioc = q_to_ioc(bdev_get_queue(bdev));
>                                                         if (!ioc) {
>                                                                 ioc = kzalloc();
>                                                                 ...
>                                                                 rq_qos_add(q, rqos);
>                                                          }
>         ...
>         rq_qos_add(q, rqos);
>         ...
> }
>
> When the io.cost.qos file is written by two cpu concurrently, rq_qos may
> be added to one disk twice. In that case, there will be two iocs enabled
> and running on one disk. They own different iocgs on their active list.
> In the ioc_timer_fn function, because of the iocgs from two ioc have the
> same root iocg, the root iocg's walk_list may be overwritten by each
> other and this lead to list add/del corrutions in building or destorying
> the inner_walk list.
>
> And so far, the blk-rq-qos framework works in case that one instance for
> one type rq_qos per queue by default. This patch make this explicit and
> also fix the crash above.
>
> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>

The change LGTM. Maybe it is better to add a Fixes tag here so that
others can easily know what Linux versions should be backported.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
