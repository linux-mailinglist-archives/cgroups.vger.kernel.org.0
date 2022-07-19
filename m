Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC54E57A3AB
	for <lists+cgroups@lfdr.de>; Tue, 19 Jul 2022 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbiGSPun (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jul 2022 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiGSPu0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jul 2022 11:50:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363915019D;
        Tue, 19 Jul 2022 08:50:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f65so13828617pgc.12;
        Tue, 19 Jul 2022 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KmDVlh31ZPGT/1gu3CgqryQOvMMNoshEj5LmQLClLE=;
        b=CF2Yl7/YP6QIiN+4C38UCBemOvDUzg7jlB4d1bqOkoD5yqqrJB+CRjWnNPHNlMgnu+
         sEHUhgCfdAlKwXHI/PmOSb1YvCYyiwG1O6dWPjunb+ExP0lN64xjqmEH93/2nrrD5XZ6
         N+pHWdcCKLfvI1mDWoLpIASJOORCjdgYfVpZzvo7/4exGllQykD5IexOfM+o02tkzLE/
         OIbRgvakahk0q70n3fYO/zz2Vsjd2Q23JtRKHT4gS24Xmo874q9vUSkafxEMuQ5UgR+1
         arPPp2PTOhN9BEo3i3LBk+xEy81ckUNH3Ck74QxAUAykiY5kjrK2ZIud4cL7Q9iNvME6
         yyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1KmDVlh31ZPGT/1gu3CgqryQOvMMNoshEj5LmQLClLE=;
        b=NS79c8Mulz/wjSutiumZQBfIIU+wXTm64ycGO7yKrEhnAJTmCPs8yMX1q11hddqrQa
         KP0JinqGIPzSwodQlkvbYFCv5+v031d0hjehYVTP6dwQmdlE6plZtuvs4zWscbHJzrmf
         pA8C7dValig3ch7CORQMGFlLgRqGyKZvZPuGyZCltpsr2MxGWIRm8drtig1FezHEkl7t
         Kv/LMWHZHMRoIGvjY33tSYo4xGeW1kr8tbTneQsi0SPZlumq6qgF33L8Wzxfq7HRK9J+
         esZUYzq6lZ0XBRhNvVyNrRUPJlRaR1OKbn1tTBDg0bJhBTQ/EdBQlZ36Iy/v0ZaYqSY8
         SL1Q==
X-Gm-Message-State: AJIora+XFR6W/+ACrFCyBI4A/FVjjzzTigRBA3uCtxiIuXkR2cI+Kjn+
        HnhGwwlKF9spQK0pyURsA7ix4aRRdpo=
X-Google-Smtp-Source: AGRyM1tL6lj/7a5Chb8Z0J9xbIW7Gt1EkHU36SQs0eRhYFiSuJqwwGeqiYt03NdfTgnXeQBdGjN8gA==
X-Received: by 2002:a63:f90d:0:b0:419:b112:91ea with SMTP id h13-20020a63f90d000000b00419b11291eamr25506678pgi.592.1658245819292;
        Tue, 19 Jul 2022 08:50:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:c106])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902ef4d00b0016d1ab31b05sm348255plx.42.2022.07.19.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:50:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jul 2022 05:50:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] block: don't allow the same type rq_qos add more than
 once
Message-ID: <YtbSuMqmrwGmAZti@slm.duckdns.org>
References: <20220719070258.25721-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719070258.25721-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 19, 2022 at 03:02:58PM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encounttered some list add/del corrutions of
> inner_walk list in ioc_timer_fn.
> 
> The reason can be descripted as follow:
> cpu 0						cpu 1
> ioc_qos_write					ioc_qos_write
> 
> ioc = q_to_ioc(bdev_get_queue(bdev));
> if (!ioc) {
>         ioc = kzalloc();			ioc = q_to_ioc(bdev_get_queue(bdev));
> 						if (!ioc) {
> 							ioc = kzalloc();
> 							...
> 							rq_qos_add(q, rqos);
> 						}
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
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
