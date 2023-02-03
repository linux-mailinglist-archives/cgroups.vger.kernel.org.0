Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18312688B78
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjBCAKM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 19:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjBCAKK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 19:10:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34EB7B790;
        Thu,  2 Feb 2023 16:10:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m13so3603759plx.13;
        Thu, 02 Feb 2023 16:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kfNBgxSSJowqr7f+kUtO8SrtMneOtknsJRJcWhm3UM=;
        b=MfH7+aDprhldVN4x7NFL8jm8YAifDholHfvo/JApNRoGIQbAQS8a7v/X6sYID6DCFs
         ChgCX55D0e7oRxWe17EQk+cb7krzhwFdmJNXQSq3qSg+qUsmbLGBAnuehS4oa7Atg3eV
         t5Y6qiQ78HgQIbFuhKg53N/DXWQ3hGB08/4dKqxYq+8XZSkxVQ1vdWaprJamx9lR0OnH
         aS/ctHNBYfd1nja49T9VtQlzNjM4mjCngbn3coIwp577DTyZmiS3YmVxA/MEj7CVDxke
         sj4kufnoLb2i/NM0JyWgkxQ3U0DqNeG/WAN1TwGM+pHdITdBle1rdZ152VAcQuXiABLl
         aO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kfNBgxSSJowqr7f+kUtO8SrtMneOtknsJRJcWhm3UM=;
        b=qfwuAqpDzuRMUUqqp3vKOmtjjVrj6RmiPOZFBjx/o/LRoVX62rSut20xNcXBUroP/d
         UADLjEqRhpR5Kz2zrSxNTV/FCxXhH09++Z4Lkh5PyBgRQsqqUgxXtEdrMGj1EEIaoHsY
         si5LyKLfF2pb59ypkgNChOhd9ltC+3/zRano6hiONsbQzKu5ox48OedqaehWq+RtE7/B
         ms8cPbTSbJ8F00G9BTpvPR+rxJnb0fj7ZpikhAERGKxnvXtrrs511BGj1DeT3X/2gTh5
         0foV0B7i9qmpeJvXI40BtYuQ8nMBBlXjOumUSmEVs/eV3hreJYGEc982fTKDJdb6OmCd
         T9Ig==
X-Gm-Message-State: AO0yUKW+LSPUmy+/298GjXrMBIUKHw05V8/WLpvwoCNq9DiwbG1D3xSb
        ycdPUe8yCZpaMUlS0ezzQiUkVpvCHPU=
X-Google-Smtp-Source: AK7set98T+giIHYsd9vBpq6YrSQedRGpH6XhdFm8X7r1QyryzUmkPDHsHICazUpBj1fAKuoLOH/myg==
X-Received: by 2002:a17:902:ebd0:b0:195:32b3:260f with SMTP id p16-20020a170902ebd000b0019532b3260fmr7064589plg.16.1675383009054;
        Thu, 02 Feb 2023 16:10:09 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id s17-20020a63a311000000b0045dc85c4a5fsm340545pge.44.2023.02.02.16.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:10:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:10:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] blk-cgroup: improve error unwinding in blkg_alloc
Message-ID: <Y9xQ33MtLhoxtPNv@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-4-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:07PM +0100, Christoph Hellwig wrote:
> Unwind only the previous initialization steps that happened in blkg_alloc
> using goto based unwinding.  This avoids the need for the !queue special
> case in blkg_free.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is fine but is this necessarily better? If it's needed for future
changes, maybe that should be mentioned?

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
