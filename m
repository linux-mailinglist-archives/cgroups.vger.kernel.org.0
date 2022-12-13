Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013CF64BD51
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiLMTbD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 14:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiLMTbC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 14:31:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC9E24085;
        Tue, 13 Dec 2022 11:31:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n3so2904545pfq.10;
        Tue, 13 Dec 2022 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXb/rEJk2v1xayTt6fq4DLeZdX5JWv1TpuzsNKAsI7M=;
        b=G7J7io0xWPaTvvK6zYRTl01FHKEjCE7q/Jaq0JD7R1g3OdahdIZtirguReRInIrPRH
         lZsfSIG+8+OSKwrxDm0SlrqyJmOeSXBDZrO8SkfI4g6JjRukQH28HHKsxVX/gSYqaybD
         hxxQOSwBU4s3Sc7AvEyaQxh8DY45WGklrYMAn2GHRlP8xHqIqTs1JTT5nO6YSg9E9p2w
         fic1D5sGqkASXcthzYQanLnBIebq2BxRY4h0k/r/Sbgjb+opKe973QztrDdQbHiBgwbJ
         Yg/P5MaegIvmBAoR2/1zusmab90D83KH1vTve3IBK1wCcxqZ9z0CYdq5ekniAUS5kP7n
         q8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXb/rEJk2v1xayTt6fq4DLeZdX5JWv1TpuzsNKAsI7M=;
        b=19d8AlXAXm9gpJtZa3xBPfL6SQsQUhLHclLDmW9Jdnckq/muVFYE6d7YYQmjXytd4Q
         ysMwPrcMDf5TSCavn8omVsCFGbn9ckGBnC89Or0DJjgmOiNLtxif4ivO8eSqg3yOQsQR
         eIsoDQOdJmmXTG94KD2Frk9a3cj9Xaw8YQIHm9VHRaK+R+S0D1s9u0hjuLRKBBKlFSCU
         x/PmvLhB9tTFamB2dIjpaOFbn5MDiEizqWIG6hsbCP6ABF+/PjSke2JmtLBCG5E8e06O
         V9HXdp/aZH6LqaBuiTHv+g230KKGyHp1HNjNCmdA3dZOFK57HmsCIWzqahJ4JwS2I97H
         Bobg==
X-Gm-Message-State: ANoB5pl2uenaJlEcTY8JK8g3u6SK6h/DN7R/jdQCZLG8xCL8oZkkGFh9
        yifdUGneRhxUZKd6Sq8ZTmk=
X-Google-Smtp-Source: AA0mqf4LR0w9Q2cfjZcReFSGVhRaqHyqmcRJT4oMpOm+Bbkp1P5i0Ew5juN6Qehq6v8vhXbEJ9/Biw==
X-Received: by 2002:a05:6a00:4482:b0:576:95ec:bc93 with SMTP id cu2-20020a056a00448200b0057695ecbc93mr20756659pfb.23.1670959861145;
        Tue, 13 Dec 2022 11:31:01 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:c415])
        by smtp.gmail.com with ESMTPSA id i63-20020a62c142000000b00572198393c2sm7986815pfg.194.2022.12.13.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:31:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Dec 2022 09:30:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH-block v3 2/2] blk-cgroup: Flush stats at blkgs
 destruction path
Message-ID: <Y5jS825K7ej0jEV+@slm.duckdns.org>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213184446.50181-3-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 13, 2022 at 01:44:46PM -0500, Waiman Long wrote:
> +	/*
> +	 * Flush all the non-empty percpu lockless lists so as to release
> +	 * the blkg references held by those lists which, in turn, may
> +	 * allow the blkgs to be freed and release their references to
> +	 * blkcg speeding up its freeing.
> +	 */

Can you mention the possible deadlock explicitly? This sounds more like an
optimization.

Thanks.

-- 
tejun
