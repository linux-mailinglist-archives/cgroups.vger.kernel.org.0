Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CC596379
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiHPUDV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiHPUDU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:03:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5A558DDA;
        Tue, 16 Aug 2022 13:03:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t22so10663580pjy.1;
        Tue, 16 Aug 2022 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=iu5TF+HIlWiXRw5i84jKcV9q+7psfaQE0MbUzyZYC7E=;
        b=O3oVKSvWFx+BJ+PtWLrwXiOht9Qt4PcjXLTlznB0lOSM1vPpC8l/Hf/u8Qp1CLrLzX
         g4roEEdbTsG4xNqJtyg6mHgyjUMegIeqRw3SK5BhxUd8LoNPbuKU/Iki8KPxjCI8yb7D
         l3xAVlPRkgATEu7i0iRii3EsRrgZFNGxjZAfg6YSx5Pg8nET3PtYtHsvHxYAZ/TQ185k
         H7K+VFmZLr3JPlNSY7uW8aBF7L9uxpWzf4eaAcP3SAYjeTCIxXEQlQCT5LA1raTx8M3w
         fmbC1dqRezdDDbarDLCZ7mvNwUOqEFVcw/6l4v14+b15vnnGpOK9X2OpRhKM9QhR1Prp
         WVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=iu5TF+HIlWiXRw5i84jKcV9q+7psfaQE0MbUzyZYC7E=;
        b=apBjZyvJncnD8V1K4VZ+KDHW4SvmbbgqCy253i5tHOTktEyrqFXsJwTxwfGvW6PGIw
         zcgNmuw4LXxJiWtXpYzz1RQRbxMAc+WCL/FhhC075Fvkd3A0tM5+xkkP5hEunOn+TU04
         SmRAFTMrlRWAeXudvDTk7loi49shNJ6nwSr7keLUDj6UyMr5t5miFzd5thoO+8OT1qvM
         OilKYaZlxDHTGe+Wum/qqVmxqIXzzP/lpgdMZdVgZGrYU38P8/Pto1pKaji/ZHarDc1f
         NUoDsKMI+Zhi/ehl6D8gtbdCa8yIRptHzCczY+t7c9KTJ3SoAiHYGK+riWh7e2wC/ZUv
         QLAQ==
X-Gm-Message-State: ACgBeo1wDtOsO2avpgrhRP0JAjHMq9/KHS3CKySEzpiihjxOXfP+gFY0
        RiRlfSDMRWTuTLbW5fPQZDQ=
X-Google-Smtp-Source: AA6agR6HDKGrblDNR1YfaMUxQgHOkA17njcJzen2RkfXVVEAuMizH9a4DAwtpivE2ShGxN+Je70KrQ==
X-Received: by 2002:a17:902:c1c4:b0:171:38ab:e761 with SMTP id c4-20020a170902c1c400b0017138abe761mr24190353plc.65.1660680198982;
        Tue, 16 Aug 2022 13:03:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001fa80cde150sm3448062pjb.20.2022.08.16.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:03:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:03:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 6/9] blk-throttle: use 'READ/WRITE' instead of '0/1'
Message-ID: <Yvv4BOx92l20VqD1@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-7-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-7-yukuai1@huaweicloud.com>
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

On Tue, Aug 02, 2022 at 10:04:12PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Make the code easier to read, like everywhere else.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Let's float trivial acked patches to the front so that they can applied
without waiting for the rest of the series.

Thanks.

-- 
tejun
