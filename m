Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040F878CF71
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjH2WTQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbjH2WSu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 18:18:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61A1AE;
        Tue, 29 Aug 2023 15:18:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c1e780aa95so16338475ad.3;
        Tue, 29 Aug 2023 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693347526; x=1693952326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT7SEszKRBMXUDd13cP5+4uGU9U+JYjqfeUfDZ3RsNQ=;
        b=JPfqk8f5jaQlxoxFPFpiH4aKLzDWZbfHu3TdXcY3byeE76PYwztTcQhtnIO0N63dpp
         Y4+OW8eGERKDKs1sCBjWAXscDPOdBF5D6mQuueasKk2XbaLfa0oq2UNMjwXXxT0Y/TAm
         3k9oVHme8uOdAb1mTXQ0Yycdq8DWguwpGWt0RTGIwwH1OK76fvUW8EO38UqKURsTcEPG
         B/BDarpKWfvoZWIXHnq/2oQsa+FL1Xinj02Mm8Tf4VLAay/g1EcxToOkkIPA7uRjSR9K
         D18/6MkvSsOfZEW8B56ZLmUDVWjf7iqxYasb62z3KGlyVdNkVD1tBwtKoRpCHmcrAT//
         AUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347526; x=1693952326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT7SEszKRBMXUDd13cP5+4uGU9U+JYjqfeUfDZ3RsNQ=;
        b=X7PTezHKiqES60vn8V8/xKRBYN3DOMrtm8X6yU+zcIhAYO+v9QCdal+y/nyU6MB5R1
         qq5AXqO6J5l9Y8x+71RQ5PAIu09HBTt5BB7svzASBIbfxQK1fVnUIg40ST8MTR+YPbmO
         Y17KxaIJkrTCu2jk66EX9GN0F4ZquyDDh0EKNjtzH863CLbzSeEi8JZklIZ03wG0EOdQ
         aeik5pV9vG+fylX46luPBgwP900UWKcyAgf/KqGCek3SdzZ7gL87k4kyC0DfxsZgu+1C
         M+Epbj//ZhFkxHySM0KNXC2gLQNCNIkkBF7CG3so1hcL5A7XzdOgCJ4wo5xb7JHDNOx+
         Yk7A==
X-Gm-Message-State: AOJu0Yw3IgBhGg+WeGhxMVkUkuXfthpmf7KY4nwQdkzxCoIHJP3+ZL8l
        2Ex/xqwskouxtUTULlyZ9uY=
X-Google-Smtp-Source: AGHT+IE+wXeM8hC7PVqTpwH2437SwY/NV2//LJ+ybyLkK+wZAT9vJUyy2MALuq8bcE2hJKFOohzF8w==
X-Received: by 2002:a17:902:edc7:b0:1c0:c640:3f3e with SMTP id q7-20020a170902edc700b001c0c6403f3emr374642plk.42.1693347526225;
        Tue, 29 Aug 2023 15:18:46 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001a6f7744a27sm9840035plz.87.2023.08.29.15.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:18:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 12:18:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 2/4] blk-throttle: fix wrong comparation while
 'carryover_ios/bytes' is negative
Message-ID: <ZO5uxJSlHRxexZwk@slm.duckdns.org>
References: <20230816012708.1193747-1-yukuai1@huaweicloud.com>
 <20230816012708.1193747-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816012708.1193747-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 09:27:06AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> carryover_ios/bytes[] can be negative in the case that ios are
> dispatched in the slice in advance, and then configuration is updated.
> For example:
> 
> 1) set iops limit to 1000, and slice start is 0, slice end is 100ms;
> 2) current time is 0, and 100 ios are dispatched, those ios will not be
>    throttled, hence io_disp is 100;
> 3) still at current time 0, update iops limit to 100, then carryover_ios
>    is (0 - 100) = -100;
> 4) then, dispatch a new io at time 0, the expected result is that this
>    io will wait for 1s. The calculation in tg_within_iops_limit:
> 
>    io_disp = 0;
>    io_allowed = calculate_io_allowed + carryover_ios
> 	      = 10 + (-100) = -90;
>    io won't be throttled if (io_disp + 1 < io_allowed) passed.
> 
> Before this patch, in step 4) (io_disp + 1 < io_allowed) is passed,
> because -90 for unsigned value is very huge, and such io won't be
> throttled.
> 
> Fix this problem by checking if 'io/bytes_allowed' is negative first.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
