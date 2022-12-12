Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9E64AA05
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiLLWNw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 17:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiLLWNv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 17:13:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3321A232;
        Mon, 12 Dec 2022 14:13:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so1332634pjb.1;
        Mon, 12 Dec 2022 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2XZBEP0JR3u42vjkud6u2pf7wcC2jLfekfdtsMKR2o=;
        b=CFHCFDtE98y5A8aGdBtghjU5l9CphTqaYy8+bNqMg2oj+xvRkpTz+CiNOXnOGa+xmH
         aFRyuXYMB56A8Qaj2sKuwGcPdNQ8AoKGDqpSvvk1nupxWCQ6HeVJMNeCoCndqgy4KHMa
         gtTajfL2mnJdmGIF83EGfF+l6DuCgA8QoD2TcFhwAK1WOdR4yW8jtgwKhOVlWo2htGf2
         5VbW7laZOO8WJeDhfUU061bT5bwJcSuhhe/E7n8AUutbCBMyf/ER4mfE68WrEqJxoo3a
         6h3bRzsp+lesOssSJTDJcFigURcJGHNh6iZ62bkwx4gVc0a+Cg6S4v/6y1LTDsSJtivC
         4Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2XZBEP0JR3u42vjkud6u2pf7wcC2jLfekfdtsMKR2o=;
        b=yr9pfWf4kDhLvyvVeZvMHFhe9i++qnF7ZY1ko2LAtz0mzB7opjeuu9/lb9XhM/29rK
         HyJ1k3TZdoW7QRFQvCDtFeBi8lYvwoFUvX09WmAjLx0M2s07RiWHo/Qc9bTD4Y7fkOKh
         8PJzdRFkLi1ehXNhS06W3TcC+uc/P/rWj+brvrN9QQMu187L7KgBIEJb6ehIbVaScwLv
         cQ2zKqydLzn0XhLE8SKmOBBaHspHUagEmav789Q0Scj5N43FfYSv296Pd/ozkp1oU6D7
         wt9rYep5VD87ssv1U0sOpHk2VJkk/fn+4kHBjPDUR1wlKeARTO5CGs6lDGN5O23iQc/f
         YCrA==
X-Gm-Message-State: ANoB5pmsKokylVe94ZRK3+INeVfHnz9ncE4Vpt4lVWs2aY/y7X8ENm1Y
        fiAABasnnhk1XKr45O6YRbb2EBoWVJoLWA==
X-Google-Smtp-Source: AA0mqf67w1m5VItBX9PGVatqIjNwsKAAmChP+SvVKw5BDzUrHAocCOyWg7+eIfj//6EU5zpEYbFhbQ==
X-Received: by 2002:a05:6a20:8e02:b0:a0:462f:8e3f with SMTP id y2-20020a056a208e0200b000a0462f8e3fmr31554587pzj.53.1670883229447;
        Mon, 12 Dec 2022 14:13:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b00575afe3c188sm6255061pff.150.2022.12.12.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:13:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:13:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH-block v2 1/3] bdi, blk-cgroup: Fix potential UAF of blkcg
Message-ID: <Y5enmzQM7BIiEv9n@slm.duckdns.org>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211222058.2946830-2-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Dec 11, 2022 at 05:20:56PM -0500, Waiman Long wrote:
>  static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  {
> +	/*
> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
> +	 * references gone.
> +	 */
> +	if (WARN_ON_ONCE(!css_tryget(&blkcg->css)))
> +		return;

Wouldn't it make more sense to use percpu_ref_is_zero()? It's not like the
obtained extra reference does anything, right?

Thanks.

-- 
tejun
