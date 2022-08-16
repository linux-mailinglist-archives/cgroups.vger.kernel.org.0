Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D23596355
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiHPTrP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiHPTrO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 15:47:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145874CC6;
        Tue, 16 Aug 2022 12:47:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso10623461pjd.3;
        Tue, 16 Aug 2022 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=vllq36/daEKxm2CDMyNXs0id/mJg/Ne6mr0IeuT3myQ=;
        b=TrlTzDve7P6EFOm6VCsVgEKIHRFvxY+ZaHDsXeab/pd4Z8HbF6qIOvR8El7kRzypgj
         X1Si/5qJ0ANF0XHOatZW0diA0derl7lczuLx4jfvX9tR1vKsUQT/mNHO7z/dGXH2rKHx
         1BB2riwObOQMawpCcY+N/k2WZM75VWMeMIZMydCWZzaykXNlQDm5D9+Cgb8qLZQCgBWV
         TjEev9s9PUygbDw86uQt3fFKIy8uTyDFypdmVcSn9+8e+9A2I6XL9O6/Wz57xkSZB3Pt
         ei0mxzhNTBiCaktvr9zbxzeIoKYP5jqfDbNk5pXA5BbXWaIQdsM7IlIGkdv0tjot/kKS
         8+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=vllq36/daEKxm2CDMyNXs0id/mJg/Ne6mr0IeuT3myQ=;
        b=XHoXLkKcDtkK0/h4sF6Oicv346WOwvrmv6+slDFeLCkrpQfUH/VmI1ewjPlIRZlfLC
         r17+Ygaq3RwGesGChWPJzTvzHcrr1bArXfH4eNMF1oRgorFyYaZliBpHYbziqe9hmPLz
         by9w/tcmMKwiYGhV4kHJeb64MOR7EuD66ax3B7rnzCKU2WtE7theTdvFcBde2V9buGOV
         vhk4xHEXckEfJedsJdN02FX43ZbLjluLSEZl36BA4CGJlLPuxvY7fo7hHfVG9bZGnKnh
         B0rTJ/9jhCR51M4WCwyy/wRhplVwsAE84cpCGWMobw5Chwl2AdJV0yWZ2Jww7chUGsfF
         2hNQ==
X-Gm-Message-State: ACgBeo2sFeKHAb0xA9wq+gLk+XOz21Af7rEUJgfKaiLA9FgusEsNhx4G
        q3abMQ0GCuEIndHfuOu7bVU=
X-Google-Smtp-Source: AA6agR5qhY3mqweXsoggMUomPyzwdzr+cxIQY2eyJA4Ahz2URBACV189y0DZpiRZNLyZkPq2sqkDYg==
X-Received: by 2002:a17:902:bb8c:b0:172:74c9:62bd with SMTP id m12-20020a170902bb8c00b0017274c962bdmr8435605pls.87.1660679233588;
        Tue, 16 Aug 2022 12:47:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id je2-20020a170903264200b0016dafeda062sm9421191plb.232.2022.08.16.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 12:47:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 09:47:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 3/9] blk-throttle: factor out code to calculate
 ios/bytes_allowed
Message-ID: <Yvv0P5YXf2HdEC1d@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 02, 2022 at 10:04:09PM +0800, Yu Kuai wrote:
> +static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
> +				  u32 iops_limit, unsigned long *wait)

While at it, can you please rename these functions to tg_within_iops_limit?
"within" is a single word. Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
