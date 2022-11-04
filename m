Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF961A1F9
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 21:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKDUNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiKDUNQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 16:13:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5745A2D;
        Fri,  4 Nov 2022 13:13:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so4361384pjs.4;
        Fri, 04 Nov 2022 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xtk7jcohFLeQIICJ2B6kR5VUoj6ZVbcGeRiMSZFQHdg=;
        b=E8v7jZxwUA9gU2qPlTl8J4Rg6OiD4OSKi0kctzeKiV3i+IKf+Sl/5z3x2urDsrYTVt
         wjVDEi4/kcm1sF0fEPcDGV4mat20G0KBFoNdEqv+XmJ3cl1g6nVrvcE+nSMAvCN7de0U
         fYLQaTK8Bvrs+VA8b40ugVlQzyiauUOEnc/QTv16FXBYGN0erJ2KPpb3wGMKcw9Dfkvm
         GowtvrKej9023b75yQFFnY5sDs5PFzLKJR2wo/J+9I8Px7rzCvkzvqAWirFjrLWFQayZ
         KkmyPfd0uXymiDTEItGJHnbwoFPEPIVhkGojG1fQDTmqfUCREvS4ioKUQ7rAElcQi9F0
         Rr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtk7jcohFLeQIICJ2B6kR5VUoj6ZVbcGeRiMSZFQHdg=;
        b=QS/IqPeW1Qu8FvIGV7qQyCt2ckI8xTqEc3UCt9xjQB3vOehzS17qyf1Piz573CpfLB
         sq7iALFde9sv92/z8xLCPDiaQiLua/jSTHOypq16xA5pSSDqCfNt3sK+G+m+2sMHxdcp
         VH+YW7qZ5Sva7crh7wQevH2sjCys7kgksuOA7rnyDNwNm67002EM3vBmu8AwFAjd/Ow5
         llY1F6yLLIcRE+ULFa1KridZ7lTDBoC2S/QDhZeR3A/1m/HwR25+94Z/xX5FFPy0bDIl
         NTB3lL8LXUS9klNVHxHnbfcz7SwZyoE81Sso3Tu2z8dmypLwqQIiRDQRIeL9iMlsrXt6
         MOsQ==
X-Gm-Message-State: ACrzQf1GNqqdxAEiCqtbKORW+rgXH+VAjhWYcSF9LAQitLBl6iKsulAY
        JMDrZSbxjdQlakrk7/fA487qgPR7OFLulw==
X-Google-Smtp-Source: AMsMyM6qd9CTC7TC6uXr7CaubdhAZp/+H2rnnYFIm09opnb0Ne+i+Zxxo2WP2y4zdAfRM2oKRx4YrA==
X-Received: by 2002:a17:90b:4b81:b0:213:341d:3ea6 with SMTP id lr1-20020a17090b4b8100b00213341d3ea6mr38139323pjb.19.1667592793950;
        Fri, 04 Nov 2022 13:13:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b001871461688esm147983plg.175.2022.11.04.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:13:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Nov 2022 10:13:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v9 3/3] blk-cgroup: Flush stats at blkgs destruction path
Message-ID: <Y2VyWDvtwOsMBcKB@slm.duckdns.org>
References: <20221104182050.342908-1-longman@redhat.com>
 <20221104182050.342908-4-longman@redhat.com>
 <Y2VvboMSxgF0pYpX@slm.duckdns.org>
 <84fd6656-d133-b9df-c39e-fbb3a1f4a873@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fd6656-d133-b9df-c39e-fbb3a1f4a873@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 04, 2022 at 04:12:05PM -0400, Waiman Long wrote:
> I should have named the function cgroup_rstat_css_cpu_flush() to indicate
> that the cpu is a needed parameter. We can have a cgroup_rstat_css_flush()
> in the future if the need arises.
> 
> It is an optimization to call this function only if the corresponding cpu
> has a pending lockless list. I could do cpu iteration here and call the
> flushing function for all the CPUs. It is less optimized this way. Since it
> is a slow path, I guess performance is not that critical. So I can go either
> way. Please let me know your preference.

Yeah, cpu_flush is fine. Let's leave it that way.

Thanks.

-- 
tejun
