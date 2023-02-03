Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ECA688B74
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 01:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBCAIT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 19:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjBCAIR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 19:08:17 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E0751A9;
        Thu,  2 Feb 2023 16:08:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bx22so543210pjb.3;
        Thu, 02 Feb 2023 16:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMk1NYKC1lJtEdtB8eToFsMCqzZsTQWGW+RVlS9XghE=;
        b=LOvy3i72nUa/WOnJbZkQjbqz2F990paP9jA/43nmN61WN+V9gt871bPmm3L8Yzb6KH
         GDCMJckpYT3lmvmczvKebXE6tzN56T0j+K5aNRchPoXGaJewwd6OdQ1xfjRCr3ASDeGP
         ZUe5rMIkYuUTrutLb7EqOAFi4/55Nn+y15xClpYXbBKFVnR8VCJof6Nkl7EG1AEcgfUl
         gTq1Ai9k/InCmWskbQ0snTA/M5jbJWSI4Y5cxrHDR7yL/iV7UwEnUT6x4gGS4NOfRljz
         mdDndjieKV7yd09ETOYEAxHFPtFcB8MrLcpCjA+9QlM/aeMUNiqRsTHboDM1MrnzBZ8j
         s4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMk1NYKC1lJtEdtB8eToFsMCqzZsTQWGW+RVlS9XghE=;
        b=YqoiHfDRKSLRbx7LPQsmkCj8caMI9kScCPERaIifzplLj5sPVCFLAsv2Yg1VqgNdCT
         iL6gOF6Kn0FfHNcIXGCI9qBRqkd1AUZyrHczeLhAzRRIyVm0yuT0kKRAdLvlYj1SUgxh
         fLsCVwLEvgIUGE9DaTiaBK2h6l4YjBF3VSlFObNPaKEIx/vY5me3tW5Yq2DWJFs93FIQ
         iuLs64wY/sZDehnR62+EACUuAJG7SmTaFcC3AswrByluaPDTqqTQCehFa9eJRc4F4VUI
         J0U3w6rKZ1zI0+Scvtk3o36fP9ggMtC6iudxh2a06M89I8ItFZsYfU7Tu/OI3ecw7sPe
         m11g==
X-Gm-Message-State: AO0yUKUUQIHXP1ib6eACMfNJcXAobuaWWsVomBYZ6EYCguqyoNkekqR6
        rSItb10pU6Q1ZxwK46C4Xns=
X-Google-Smtp-Source: AK7set8LRw0OqPHtR77Y1bBaRTMdeJyD3KDktzfau2zrftIN3wwkUZz+gTi/FRJoxkKEQT8cmww1sQ==
X-Received: by 2002:a17:903:3014:b0:194:4484:8e61 with SMTP id o20-20020a170903301400b0019444848e61mr6479794pla.69.1675382895989;
        Thu, 02 Feb 2023 16:08:15 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id q23-20020a056a0002b700b0058d9730ede0sm251406pfs.210.2023.02.02.16.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:08:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:08:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 02/19] blk-cgroup: delay blk-cgroup initialization until
 add_disk
Message-ID: <Y9xQbSp3BjHM+VtS@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-3-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:06PM +0100, Christoph Hellwig wrote:
> There is no need to initialize the cgroup code before the disk is marked
> live.  Moving the cgroup initialization earlier will help to have a
> fully initialized struct device in the gendisk for the cgroup code to
> use in the future.  Similarly tear the cgroup information down in
> del_gendisk to be symmetric and because none of the cgroup tracking is
> needed once non-passthrough I/O stops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

For 01 - 02:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
