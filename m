Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C667F21B
	for <lists+cgroups@lfdr.de>; Sat, 28 Jan 2023 00:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjA0XPW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 18:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0XPV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 18:15:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9C18172;
        Fri, 27 Jan 2023 15:15:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl3so6459463plb.8;
        Fri, 27 Jan 2023 15:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eAZDC+CSdqDtsryai1DaA/T4ovNaxm1PeaJnPbpd9g=;
        b=SsGqF9F0m/273yWjG9aHVv0nTg7qlrqNz9yqDYeIZeBP8oEQIILBEgBmw485h86cR4
         l0qRlv+V9ONcMmi5G1H3SHro4JrPu6U5NWuIaRGZTn7TFJ1HdT0lsXBSSAZTDG+iq6ah
         pwBudbcPE8M9MW2HLEr0psgNmoM2OqjipeLuMzUZkSO8ly12JP7u5+L/vBKIbhX1z1ng
         QXIhNv6MN8wuYYeqC1N7NcXd2MVi6QbOw1kAl3zpMmLvLQ1yPJnhLAknvL1pw8Io7GSn
         KPO0jMMXpXlAe+Fr6aEku2rjv/YYDrdwo6FwJ75olaW7SjdR9cKohZBjzwzM1Mg3gqCl
         Shqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eAZDC+CSdqDtsryai1DaA/T4ovNaxm1PeaJnPbpd9g=;
        b=HNN73P+Gb/DoYTtRofsmr+I7gfvQQaPm6gy6f5WJgwpLb/BJVUNOjwVgJnkUv+FdUF
         fXGzNhky6tjVw4mURwTlBiY6DMnalNQnH4eJrySS0Kg7u0Zpokr0iA4cd93x8IUbxTxy
         Hi6zrnTDh+VXA0vsNdcHd6/tJM89hLe79APFpVANULjpVlSiQgJBHflNVCeRqcpXPdIR
         ZzOxxhbdRq++YO4wymu8Sj2lDVSPFWysTJK0u6hsCU+a3/KRVkEEx3emyhxasAfBa3F4
         mCsTgA9v8NuGI6FKajfC4uzLDQs7z8JQgl7YvM2s91eJRdGaFDCi18dBQ/gL4OC0MFGi
         MwXA==
X-Gm-Message-State: AO0yUKUbLszzyYS4wljZ3mpmSKGfZm2NDBL5mkOPj3LqCCErje2z2+vb
        PLQVswctfHqhme2gVOISPhKdRwsiOrg=
X-Google-Smtp-Source: AK7set/szRy6QLjLEZzoZaQlUaGtsF+FYmlRSaE5/McB7Jf0ca9t/GHYUYMHOY+3TP8ezsGG276vjw==
X-Received: by 2002:a17:902:f353:b0:196:450f:d89e with SMTP id q19-20020a170902f35300b00196450fd89emr35376ple.18.1674861320007;
        Fri, 27 Jan 2023 15:15:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b00194b0074b25sm3391501plb.160.2023.01.27.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 15:15:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Jan 2023 13:15:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 04/15] blk-cgroup: pin the gendisk in struct blkcg_gq
Message-ID: <Y9RbBkyqhiRcSiRf@slm.duckdns.org>
References: <20230124065716.152286-1-hch@lst.de>
 <20230124065716.152286-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124065716.152286-5-hch@lst.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jan 24, 2023 at 07:57:04AM +0100, Christoph Hellwig wrote:
> @@ -245,10 +245,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	if (!blkg->iostat_cpu)
>  		goto err_free;
>  
> -	if (!blk_get_queue(disk->queue))
> -		goto err_free;
> +	get_device(disk_to_dev(disk));

We lose the blk_queue_dying() test here. It'd be great if the patch
description explains why this is safe.

> @@ -547,9 +546,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>  
>  const char *blkg_dev_name(struct blkcg_gq *blkg)
>  {
> -	if (!blkg->q->disk || !blkg->q->disk->bdi->dev)
> -		return NULL;
> -	return bdi_dev_name(blkg->q->disk->bdi);
> +	return bdi_dev_name(blkg->disk->bdi);

This isn't completely trivial like other conversions. Maybe worth mentioning
in the description too?

Thanks.

-- 
tejun
