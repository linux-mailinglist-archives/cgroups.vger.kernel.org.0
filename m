Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1D6514E4
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLSV30 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 16:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiLSV24 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 16:28:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6F13F4C;
        Mon, 19 Dec 2022 13:28:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14523724pjt.0;
        Mon, 19 Dec 2022 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+/Zc6HF+HMCFeX1vjX9OMe2YVRCyrJBTigomMNkApo=;
        b=YTxP4cH27crU7cLDy6KXr1WIQp1FJaDX9Sc61wvNatsiejqKbzyE48BOtkzQoEJscq
         Xq9vKKPkduSkCxvqnlSJ+xuUS2DG/FkZUqHmNjXz3ZlcQzGeXsru7Uj9z9tn9cNlKJtl
         UUpC3fWTWzopHj4/75cKXOvthjER/sDCA+LF4YYRxrp8gfhIhktADeGATWDVFd25z9Y5
         JYoI8ra68qoDQVE/4Cz0stB9x1/ZcyVfutfh5n2O/wU3DijgV25mNSCglMHsoJDRC8Fd
         RhkwwWhNETISGbtH3iG3qYZwuVADiu/Un2Gv90U3+kE5KnTgdnaPZfqNW+tChGZ8PbWB
         INsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+/Zc6HF+HMCFeX1vjX9OMe2YVRCyrJBTigomMNkApo=;
        b=o+Pdcfl9EaycX6cD9NLPHzALv/Hsf2+FPfrQ464iEpQ7rmPuu2EgNJQS4e0Tj+CbdG
         NcuGcF+fKr2wEKOX8Nae24zBrgdYv5luf8BkcjvUxGKbQYuWZrpn32KF7g/+ec7kT+53
         inix3s2gkLwKqoO07OM4mL5SgvZ/RYrGzZoarMUgKob7UeIDOAhG/Mp8E31edLC+ufzl
         8ufGm77o2f1SFXRiPyOFtMYOlHRRz7nvzjoKlDE3r/j3kYgd4oUcjcnWwyTSemBAIkha
         oQUF9b06/IDfVmNcbBhtYyliyt4207GvgD/KNewa/WYITOxNDoVaMxYohJ+BNKLdnjn8
         74Mg==
X-Gm-Message-State: ANoB5pnbzTJYR1d3F4hgkUaU91tmtnXwOgTPJFg8w4+wyuyj3RlifDD3
        neStOtZPjMFEL01W7g26/mhKH0dBDJbGDQ==
X-Google-Smtp-Source: AA0mqf7Asi82O6N0gmU0UcNYN1+oJwVe+xXHHM6zh8uiTddI4N4blkHkkatEkZRResYbYiTHl3TgLg==
X-Received: by 2002:a05:6a20:4387:b0:ac:f68:249a with SMTP id i7-20020a056a20438700b000ac0f68249amr54579248pzl.6.1671485330850;
        Mon, 19 Dec 2022 13:28:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u15-20020a65670f000000b00476d1385265sm6740700pgf.25.2022.12.19.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:28:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Dec 2022 11:28:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/4] blk-iocost: don't throttle bio if iocg is
 offlined
Message-ID: <Y6DXkLeOmu7VWovz@slm.duckdns.org>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
 <20221217030527.1250083-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217030527.1250083-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 17, 2022 at 11:05:25AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bio will grab blkg reference, however, blkcg->online_pin is not grabbed,
> hence cgroup can be removed after thread exit while bio is still in
> progress. Bypass io in this case since it doesn't make sense to
> throttle bio while cgroup is removed.

I don't get it. Why wouldn't that make sense? ISTR some occasions where we
clear the config to mitigate exits stalling for too long but in general a
policy being active on a draining cgroup shouldn't be a problem.

Thanks.

-- 
tejun
