Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00010649044
	for <lists+cgroups@lfdr.de>; Sat, 10 Dec 2022 19:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLJSzK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 10 Dec 2022 13:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJSzI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 10 Dec 2022 13:55:08 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD561705F
        for <cgroups@vger.kernel.org>; Sat, 10 Dec 2022 10:55:07 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so5440170qvs.2
        for <cgroups@vger.kernel.org>; Sat, 10 Dec 2022 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=BzvvoS4YZaiHtVtTnrMPkORr9QN1kyuo5edsRj1EnzCjtxaavYwgd1MdZhbSrsmMz/
         pQLt+8DKvwX5PRNY3AkuVsEXWG3TG9LNQME3xhKH5umXkHq8wRVg5p7P0UkLsc4gLlOz
         C1Wz8XlCiVSbwQEORsXQiY6twwLuti4patvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjD4ucfx+sg79aU2mhUtRUhlS74JIWv5Z/WsZ5sivF0=;
        b=xWwnqnjTCgt7o/9uLGnz8+yPvZJgTlGpY5FbxXclRjRMos8u6ysQIgqR5w30P2Vboq
         /m2jsPGTejThDSl2BPWOGgM9tST3k7Oows+Jg9ay+Er3M08owk9Tim2L91epOptsj+O0
         8r5sIZK0qFN1KkN47XLQYxKfYn9EfgC/UDWoTsC740SQgBGsPs88RWnHjdezWuGgv0MB
         z9XwYHnum0+tWbxaJHBJQPebAuKOJ16ws9olq4MgrKJgHsW5KftUW7+tiRcl/iFH5599
         eKUOnXceEXo4XLs+a2IvbfzdJyoveFw3JMtQD13Lt9R8vJPoOem2CU3jYb52zKnFxRPM
         vcBw==
X-Gm-Message-State: ANoB5pkTVkV2cCyy6CPD96GtD+wO1FYeVsm0cPfJ91ItGBXIQny3dale
        nW/EVHe6frN2pi4qE64VU9AKdhwP70YVsC8X
X-Google-Smtp-Source: AA0mqf4FJPdTU8j+SoegWM/b/OwmmPRTnPqwDWCkkRJa5ctuEsCr0WA9OBk+aYnNRkR4v1feSGHoVA==
X-Received: by 2002:a05:6214:459f:b0:4c7:6dd2:274a with SMTP id op31-20020a056214459f00b004c76dd2274amr16086739qvb.28.1670698506084;
        Sat, 10 Dec 2022 10:55:06 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a414c00b006e42a8e9f9bsm2599496qko.121.2022.12.10.10.55.04
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:55:04 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id o12so5439365qvn.3
        for <cgroups@vger.kernel.org>; Sat, 10 Dec 2022 10:55:04 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr68313518qvj.130.1670698504390; Sat, 10
 Dec 2022 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 10:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Message-ID: <CAHk-=wiw4bYT=rhA=UJD4u41Oq_uoWt1dAXpzqwQYdOtJQqYZw@mail.gmail.com>
Subject: Re: [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak on
 add_disk() failures
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 10, 2022 at 10:33 AM Tejun Heo <tj@kernel.org> wrote:
>
> I'm posting two patches for the iolatency memory leak issue after add_disk()
> failure. This one is the immediate fix and should be really safe. However,
> any change has risks and given that the bug being address is not critical at
> all, I still think it'd make sense to route it through 6.2-rc1 rather than
> applying directly to master for 6.1 release. So, it's tagged for the 6.2
> merge window.

Ack. I'm archiving these patches, and expect I'll be getting them the
usual ways (ie pull request).

If people expect something else (like me applying them during the
merge window as patches), holler.

            Linus
