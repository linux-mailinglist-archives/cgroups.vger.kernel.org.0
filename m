Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8813D8914
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhG1HsK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Jul 2021 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhG1HsJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Jul 2021 03:48:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C1C061757;
        Wed, 28 Jul 2021 00:48:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so2983073pjh.3;
        Wed, 28 Jul 2021 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nSOViMYPYa18THue5NB1xRZRfJm692a7CdBC4/LyTC4=;
        b=KNM2TQ0qBbPb4XvWNcysK8INoORw2FRUtbc8UbVGuaP8PeRKXOA40SbsDF9oCehOVL
         AnCZvTFY+1SPWB6JTBKcQKVHe3UPQGU3v1GUFjON3h/+SJzOISApHH7sj4rhrF7i2OA/
         MoxIDhyejas59nJVOYyl3xM1pLZ6ytfPEfoAhwvPgna4fkebhtY+gUYU+jJCtA+Ctm3k
         Ji/a68Vrx6gto6KOy8+ipXUFVimMCo4eWMWAltb/IoZ4C2U32jFknB1VnzXzmkX2ohHe
         CJffsTry3FwO+oIN4xrkKxl/JfuJtPbRpXoMTAJLEmaV29xTQ0CpI2LIj2vNyc5xy9+V
         XZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nSOViMYPYa18THue5NB1xRZRfJm692a7CdBC4/LyTC4=;
        b=aNryeBLSB+UUUiT8cNZOdvRfD5SbdGJiFqNL8zRo+0kiiJDagddv76/uoGDKwddmGp
         8WMQL2xAsFunVJAN7QVOZD3C1EMXJMly7by+ER+Vfd9T3JZ7aGgmOz5XF7dnjzzM1JVy
         j7K7k9gIDSY0eHQLiSmvkH3kbl54nFwNkQovtvd6MyLfa93ozz86Q3op9cLHPkXmZqk1
         4x911aFgGBvXTWsQmavHULYIO2B5MYDhCK1lV0BpeHEnxy+po4iBk8G13vlpXXa93zvu
         jb75QY4VD3lRJ1VdI+jhebQ9SRByb1fSmoXCJY2PG3DoZbsvE8lyrxH1rvYe9m+75dvC
         x56Q==
X-Gm-Message-State: AOAM5337Qt1qmGRUDr51ZuQrCsf/nokaeEkPRiFLWGLXukFp+DgIjcwZ
        G1su/n8JQPk2TWrzPcIUhBI=
X-Google-Smtp-Source: ABdhPJyQ5x/nLRycZwhKR5z/hDbd5kNAj62JRoGgdGAZyAI1/V0HjUmqvoghYIyRYo7AvfzFszmIXQ==
X-Received: by 2002:a63:a42:: with SMTP id z2mr27192335pgk.245.1627458488040;
        Wed, 28 Jul 2021 00:48:08 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id i8sm6639232pfk.18.2021.07.28.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 00:48:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 21:48:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
Message-ID: <YQELtmeLjlDHCk2i@mtj.duckdns.org>
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
 <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
 <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
 <34a6f4b5-9055-e519-5693-068f8dcb169c@gmail.com>
 <YQAydzEhZfPUpzWI@mtj.duckdns.org>
 <fab343e8-5929-fb30-90e3-b5b6bd34702a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab343e8-5929-fb30-90e3-b5b6bd34702a@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 28, 2021 at 10:33:20AM +0800, brookxu wrote:
> If we do this, I think we will encounter some problems, as follows:
> 1. blk-throttle is now at the top of the IO stack. Changing the position of the throttle hook
>    will make this mechanism invalid for some devices.
> 2. We may also need to add a new hook to handle back-merge, otherwise I think the isolation
>    effect will be worse in the sequential IO scene.
> 3. Since bio has entered the IO stack, if it is suspended and resubmitted by blk-throttle,
>    then there is an IO stack reentry problem, which I think may cause many small problems.

Yeah, you're right. I don't think it's worth rocking the boat with
blk-throtl at this point. An extra callback it is then.

Thanks.

-- 
tejun
