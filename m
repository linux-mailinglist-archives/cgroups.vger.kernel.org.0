Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED06631A9
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 21:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjAIUkp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 15:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAIUkp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 15:40:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C934770;
        Mon,  9 Jan 2023 12:40:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g20so7118785pfb.3;
        Mon, 09 Jan 2023 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbuOZEmZIWbG5ybltAbzMu36mLXSxbIEjJuDB+5SDZk=;
        b=qN5vtIa6GBLGNWJ37QfuUpC207TmkheSL0UgCYhy9wjkAUbSagihE+plEam1w0V2Xd
         wxYdRh/JdGmP9gLYoDCyJuU5oX6dVxKCKbQ/4wFetqA7FLstX1JQRphWtmeAaM38m9pC
         Q/K9eRGbhgbhyYUEtOo8CYizwshKEk5skvMwTzS8PsoWFUzxH/glfQUtZgmwbEEi20cK
         rCrqGuhNCoeI5wqZxHuHi7ZaThrUuX3wgxpDFVxpNfHpbm5lbsB8/k80q0ZVbNR0T5kX
         eudyCRJQKyrh04Cw0euZz8XEWt+A4oM6TjvTDhx0EW4e3NYfG+ySczOkUbuPmveD8jSK
         xtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbuOZEmZIWbG5ybltAbzMu36mLXSxbIEjJuDB+5SDZk=;
        b=Ae+xjGLzyQCeeFByRSKNCd4sXe46Ha8nnh6loYKZGeTJwxcl+9ThhejtdHVYDRlldN
         QzuKk6fp6NZm0RwxLPWx7mBA2BceF2ne39xgw1S9gIAQBvoHBb6mKXvhhOCOHAiClI7N
         zLgqATO2m8gTnwd0O02Z16YMoCRmc2imbHlb5LAlrVPeDrgIsmDJvjoOfv9F1Kj9s0/p
         7T9Uye8BHyDT0UImakXMG43SJsgpQmEg3XmCTECSMbzVwQuRp2i8/Hal4t1EMS7AqdsJ
         CbQ6TqnmlVV/HOkAnhGWLaV3wih1szBWBfdRWQWkL7faPg22sDTJLAkxqwlJSCBTeLiJ
         4MLQ==
X-Gm-Message-State: AFqh2kobyZQWI8JVmyMoK7/H7/2W0C9LycQlkaK5iP68cN7braJy4qK9
        hU34vKdZFEXzCVqRHDWVBZg=
X-Google-Smtp-Source: AMrXdXs2jXmoiSTn07PjM7c2GTXNbMyGKfjV/2vAVhIf3zG6/frejMpsZ+aR3OtYDP8E+51AZf15Pw==
X-Received: by 2002:a05:6a00:1c86:b0:587:8450:997e with SMTP id y6-20020a056a001c8600b005878450997emr6071512pfw.22.1673296843708;
        Mon, 09 Jan 2023 12:40:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g27-20020aa796bb000000b005815837164fsm6476633pfk.59.2023.01.09.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 12:40:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Jan 2023 10:40:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
Subject: Re: [PATCH v4] blk-throtl: Introduce sync and async queues for
 blk-throtl
Message-ID: <Y7x7yq5YmcXhVkQf@slm.duckdns.org>
References: <20230107130738.75640-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107130738.75640-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 07, 2023 at 09:07:38PM +0800, Jinke Han wrote:
> + * Assumed that there were only bios queued in ASYNC queue and the SYNC
> + * queue was empty. The ASYNC bio was selected to dispatch and the
> + * disp_sync_cnt was set to 0 after each dispatching. If a ASYNC bio
> + * can't be dispatched because of overlimit in current slice, the process
> + * of dispatch should give up and the spin lock of the request queue
> + * may be released. A new SYNC bio may be queued in the SYNC queue then.
> + * When it's time to dispatch this tg, the SYNC bio was selected and pop
> + * to dispatch as the disp_sync_cnt is 0 and the SYNC queue is no-empty.
> + * If the dispatched bio is smaller than the waiting bio, the bandwidth
> + * may be hard to satisfied as the slice may be trimed after each dispatch.

I still can't make a good sense of this scenario. Can you give concrete
example scenarios with IOs and why it would matter?

Thanks.

-- 
tejun
