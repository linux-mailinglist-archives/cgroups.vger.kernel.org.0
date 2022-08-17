Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AEA597558
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiHQRwt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbiHQRws (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:52:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F607DF4A;
        Wed, 17 Aug 2022 10:52:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1300238pjo.5;
        Wed, 17 Aug 2022 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=OSADlFbIj2e9HqyRVtp14PL1Xr6rNvJVCrKar0E+Zk8=;
        b=Zo40/TjPDHiWeNSjJknVi5F5cx4JHD2EGWguUAk4iAmlDsu/4A7LpbnUsr/85DnZrg
         cNVsm3cOlYXqTW8jVChsuOr7xhFKyi+9lk2ZNwU09JWHWHIb/oKc0DoVmlV0NZvYUHnm
         Qymufs9T4X3vDGdiuoeLG0Bo/vBqVPBJ607NDNvmv90r2CrohZAKj2yfXaB39sDXC7q4
         YKNIfKMkeu/DQx5fq4gB+ou1zizz/7DxAYUADn+38nUmQvvl1SZx7VJCseh6RNsRoYY+
         jr0SD74JXBFmuez17lcEPwJZTwYvN4rq++uouH/sBEsaA0sYYyZ7xD7gAIhOAm89OD7w
         hoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=OSADlFbIj2e9HqyRVtp14PL1Xr6rNvJVCrKar0E+Zk8=;
        b=bO2tjmVbyg4KIhxCKjwoEN0P1JHISLmiwfLQMqSH0yK2ThJBuZT45p4RoW67Vqaw9b
         OAS9ALkwajGVMYD7jSZjC5f/4Cmh6MoqieXK8+zYgbUZFqNn3axxIjAqFswTpoCbrfTS
         DQlC4nDuly0b1ibkt94egqlmZtzu6CPqi3CW53abuI3X+Dsr17jL08kxQ7kx8D7rOatz
         ZpZMYgRF8nGySaPJgehERhIwDqLmmij/BP0EuJoGnYBRQhM+rCTxNeh1E446IXOzXIbb
         L2ESlLkD8MjFIYGkBGKCz33LMKGJ7I//aXp0u4aqbWLCkX154Zh9RrCBsKyrtZxaWr4C
         qAGg==
X-Gm-Message-State: ACgBeo35QY0FVcKxCJUnaTb3NxP9Bv8u3dwGpiuCFQtpb5ZjMHG9oSFi
        kMrzKOfVUylnGSFHhrD0+Lg=
X-Google-Smtp-Source: AA6agR6o7+VXireczEoNvcJf5BC9qxlMA/b1TDhfVukLZvA2R+1sU4T83EW4L6XIWp8y2ygsndmwEA==
X-Received: by 2002:a17:90b:38c9:b0:1f7:28bb:aa16 with SMTP id nn9-20020a17090b38c900b001f728bbaa16mr4832078pjb.201.1660758766791;
        Wed, 17 Aug 2022 10:52:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a8-20020aa79708000000b0052e6c058bccsm10695677pfg.61.2022.08.17.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:52:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Aug 2022 07:52:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v7 4/9] blk-throttle: fix io hung due to configuration
 updates
Message-ID: <Yv0q7T5Eg6MzOIuU@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-5-yukuai1@huaweicloud.com>
 <Yvv3jcycOguuEbA3@slm.duckdns.org>
 <215b4842-c09f-d622-7127-c8b1d9ce3aa9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215b4842-c09f-d622-7127-c8b1d9ce3aa9@huaweicloud.com>
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

On Wed, Aug 17, 2022 at 09:30:30AM +0800, Yu Kuai wrote:
> > Would it be easier if the fields were signed? It's fragile and odd to
> > explain "these are unsigned but if they underflow they behave just like
> > signed when added" when they can just be signed. Also, I have a hard time
> > understand what "preempt" means above.
> 
> I think preempt shound never happen based on current FIFO
> implementation, perhaps

Can you elaborate what "preempt" is?

> > > +	if (bps_limit != U64_MAX)
> > > +		tg->bytes_skipped[rw] +=
> > > +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> > > +			tg->bytes_disp[rw];
> > > +	if (iops_limit != UINT_MAX)
> > > +		tg->io_skipped[rw] +=
> > > +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> > > +			tg->io_disp[rw];
> > 
> > So, this is calculating the budgets to carry over. Can we name them
> > accordingly? I don't know what "skipped" means.
> 
> Yeah, thanks for you advice, art of naming is a little hard for me...
> How do you think about these name: extended_bytes/io_budget?

How about carryover_{ios|bytes}?

Thanks.

-- 
tejun
