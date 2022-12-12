Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80FB64AA6E
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 23:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiLLWkl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 17:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiLLWkj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 17:40:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B3B255;
        Mon, 12 Dec 2022 14:40:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1638109pjd.0;
        Mon, 12 Dec 2022 14:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPDIXZNKcYo1HDMoRq9WdF0H3wxdPBhSwXt2rQdX8Hk=;
        b=T2+mjUOnvMC6+SflvTfeyWtuCJGJy3r5riUOCGBFfGCcjwxEGIy88D1g3qOknp/kpu
         r44QvUgQpK7IfygXGopoHH1Aqbi/nw2i4MQqJwBE0lCXzalcJcAW1XuiZk/FGFJxgiZw
         TyeR/sUnOZE0e7jeZhBYzXFCMMScwKqXqgJ8pfVbW72SncqkteKT1wIGEAox7BOx78pH
         63kxkkSdWKIK4rJV+FaikdslcCef/vtpSxfob2P3xVWgugrM/WmIIqY360cPU55tMyRB
         cARaPspT5prnBLkezhBY9EE2WTXRTBgFrQZGgtY/jicSHR3pu+WJA3shdhCsQAysAnrt
         sDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPDIXZNKcYo1HDMoRq9WdF0H3wxdPBhSwXt2rQdX8Hk=;
        b=s6MzWKPNLxvCG6jYukLBeaZeHTYfKodf8YslBU1rtgv/H2hoES4w6FELyzkvgwNjyh
         jlQGiE73oXShZtmQ0TMfbSQPWqI3lPgsRN5/GHii/oEiAYNWAVpOE+Q6jSHYyPDL0LYy
         jke97veKRS8YuIZa/ufKKeLFkInfAY6EyMK3Ii8InSUfryXe+k2u/jBnp/WaJeRdt9mR
         lRurPM1V8Z0IFED4bofVfCoPn/njIyihWWzrKHmirR9vvl0+Bm1nCmJBct/uefsKv/Ws
         jFP0WpQEIlt6P6FWs6QqETdPUDv8ZerrCTg2aloAC4/BUooDfL/Se78WZQHljyeSUcce
         9P4A==
X-Gm-Message-State: ANoB5pnQqmv8pmwTaWhxiI39Se/ynwde9jrG/N5qwQXekHLnxt0CQY+V
        9mrCT1OP6zNtXzqFJXmKlq4=
X-Google-Smtp-Source: AA0mqf70xXX6MfhmFO/sZGl4MU+BzHo5ca+dRi//o50aclQl+kNKmpHaUSzIaWZ9VEnAYiXg0pzlXQ==
X-Received: by 2002:a05:6a21:2d07:b0:9e:9685:f15e with SMTP id tw7-20020a056a212d0700b0009e9685f15emr23337003pzb.0.1670884836974;
        Mon, 12 Dec 2022 14:40:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j28-20020a63231c000000b0047063eb4098sm5648360pgj.37.2022.12.12.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:40:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:40:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] blk-throtl: Introduce sync queue for write ios
Message-ID: <Y5et48VryiKgL/eD@slm.duckdns.org>
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206163826.10700-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 07, 2022 at 12:38:26AM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> Now we don't distinguish sync write ios from normal buffer write ios
> in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
> until write completion soon after it submit. So it's reasonable for sync
> io to complete as soon as possible.
> 
> In our test, fio writes a 100g file in sequential 4k blocksize in
> a container with low bps limit configured (wbps=10M). More than 1200
> ios were throttled in blk-throtl queue and the avarage throtle time
> of each io is 140s. At the same time, the operation of saving a small
> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
> the sync ios of fsync will be blocked by a huge amount of buffer write
> ios ahead. This is also a priority inversion problem within one cgroup.
> In the database scene, things got really bad with blk-throtle enabled
> as fsync is called very often.
> 
> This patch introduces a independent sync queue for write ios and gives
> a huge priority to sync write ios. I think it's a nice respond to the
> semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO gains the same
> priority as they are important to fs. This may avoid some potential
> priority inversion problems.

I think the idea makes sense but wonder whether the implementation would be
cleaner / simpler if the sq->queued[] are indexed by SYNC, ASYNC and the
sync writes are queued in the sync queue together with reads.

Thanks.

-- 
tejun
