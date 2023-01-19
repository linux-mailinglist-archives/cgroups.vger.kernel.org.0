Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55AA673F76
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 18:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjASRDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjASRDl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 12:03:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D408455B;
        Thu, 19 Jan 2023 09:03:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bj3so3058871pjb.0;
        Thu, 19 Jan 2023 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQoTJcoI0zudP9kqEp3QP7XD1mX3VxGZCw8MlkN3oyA=;
        b=hYG6+PIItfIJ8RaYvrETkb1iEq22Peoj6RQaavU/zimVQAD1HERJ+3gkMl1FEPriVS
         Bb80iDejEzIY050s7ahNT6VLftXVfGWSX/VBKCmhcCzZsUndo44FmyJgpBTIaWCIyI27
         h25sq8scf7twn/fjK2cqZdOj33D4EttK+Oq/QCGwktPToLV/YpuBR3ckpQZHQnjKdUFS
         sc3Hw5fxdfg3akD1Ew8I65aIaVOhEhO8jNRaugq9ihIEIdgeZtYpAef5dO7g+pAb4fUb
         MlCeresDFfHSBlKCBLHAlkim1el8jHIlNSFjPn3ji3UXy+Mz4rI7uW6y/7oC/fGcK1cB
         WEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQoTJcoI0zudP9kqEp3QP7XD1mX3VxGZCw8MlkN3oyA=;
        b=66oqS3fMdy9LLuUdKSzUjY2fnamOs1NmQl+mDKO0Xsj9T5tLMDFxvxxSRZHKmTNBS3
         6nUerlXNwyApI4/SXU1sHXONfwkQMDhiD1gj+pkzza+kGYMSNJrVsYP9zGS37zyLSFk4
         Tdf7yMVhpFL99dxOo+apY52dkuEnh3r7meCGzr5p6Wzm2JZ5jIYi58jeQUu1F3DMtJLT
         x7Pd8m5TgaFOyNPoYzzGcZCQd7iOIXH+U7z6HfzHZ/b5QUzbGavpGu3giSS1psUS/mKk
         sdHbkb+Oo7/1KEK2Cu++/pJes+sP0tuVtYjoxKsB8uRxcMlaT1j5SvzC6yoQk+Bgk+o5
         qm+A==
X-Gm-Message-State: AFqh2kqfJs5edkg113N6/ZcDpfQjL4iHlbBDMxA44NIaBQ4Gz+RRT91K
        SRr0bgRKAGCCR4oGsr85oKI=
X-Google-Smtp-Source: AMrXdXs0yhVs81RqjlAAAvmXVpjhwSEp9wPJlVq3Ilbp8sNjZu5jtrw4jhcnOsjU3DuY9okNuvFBJw==
X-Received: by 2002:a17:902:b788:b0:193:3678:dc3e with SMTP id e8-20020a170902b78800b001933678dc3emr10418524pls.21.1674147813323;
        Thu, 19 Jan 2023 09:03:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ef5200b00187033cac81sm25349929plx.145.2023.01.19.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:03:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 Jan 2023 07:03:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: switch blk-cgroup to work on gendisk
Message-ID: <Y8l34/qeHPLV4rKJ@slm.duckdns.org>
References: <20230117081257.3089859-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117081257.3089859-1-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:42AM +0100, Christoph Hellwig wrote:
> blk-cgroup works on only on live disks and "file system" I/O from bios.
> This all the information should be in the gendisk, and not the
> request_queue that also exists for pure passthrough request based
> devices.

Can't blk-throttle be used w/ bio based ones tho? I always thought that was
the reason why we didn't move it into rq-qos framework.

Thanks.

-- 
tejun
