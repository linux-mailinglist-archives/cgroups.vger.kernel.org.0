Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7D86A33E9
	for <lists+cgroups@lfdr.de>; Sun, 26 Feb 2023 21:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBZUST (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Feb 2023 15:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBZUSS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Feb 2023 15:18:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2BB10EC
        for <cgroups@vger.kernel.org>; Sun, 26 Feb 2023 12:18:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c23so4070834pjo.4
        for <cgroups@vger.kernel.org>; Sun, 26 Feb 2023 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TycbyvH4hoRUp82zuYMHneygBALggpe+yy/y2XkSW+k=;
        b=y7EMRhNnxrODvQIIQapGaXGGVUFVhimKVzRv3nzmTFNHrmZ/lCtDOdtAjhWEZWsGhO
         T9Mtom41ApCTh3kgxshWwaBncqlr1K3XGOkKuRZPVdsvWg1mM7zS80ZSGXtrJ22QLHnV
         i6vLBHuw0kX5aQJHrmCGwX/E3hJ/C/Rdjp/sKyIGM+P/vo+PYVyw945FDDnrpEf97VzV
         XzvySTN/wr3T4mwbcMHh83umRapfM3vikuVKPg2yr0jFvrVe6qbp82tE3u5aTRB8nL+i
         FwjpEvpZaIQa0iZBzNvutcgexlftNlVzbLaTr7Mi97JEFtW2CWLY3hsOGSNxnxpQ4J+a
         127g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TycbyvH4hoRUp82zuYMHneygBALggpe+yy/y2XkSW+k=;
        b=0FwMnrZOMxWfuZ85VEp2lxki/pOQo5dTbw2FSq98KmA+nEuj/a8Q2nPSgwgTA2o0m+
         vmmRB1Xe0lox+P2Yzl1UWDEKyeHoScHE0dlcptxuWiK36qg1yriCL+J2apzusDpEb9RQ
         /NcAtGaEoO3zvit4JnlWWrMBBL8ozDZuYc6POus7ROYREOT+Ctl2/h9cYOLuAF5ygOwT
         m9mVdrJgHrDXuvxNVG8yh/4YnWp0nAiWP0uAO4J2bhZSsoWLRZR6r050drUulgMFPnZF
         YIF8B9XkPmnZC8l4dVmmyKaD0JfbBEGOgEsPd8P/vzdREKulgxLlNMJCtrwpUZD6kU+s
         fDrQ==
X-Gm-Message-State: AO0yUKXR/nfKuDRvA9BOya/GBFjq1DYLuhwP8UIz6+pLoWpdIF938B0C
        mVEOmEaqqnf9KTRv5ci66ORhNA==
X-Google-Smtp-Source: AK7set+ah+evDY725yvPhWa/W1z916LeantDZgaw+BwKM0D25u1Cww03NnG+h+G9vImmOpvnyAI5Ww==
X-Received: by 2002:a17:903:2291:b0:19a:8202:2dad with SMTP id b17-20020a170903229100b0019a82022dadmr24003543plh.2.1677442693302;
        Sun, 26 Feb 2023 12:18:13 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b0019a6cce2060sm3013823pld.57.2023.02.26.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 12:18:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, Breno Leitao <leitao@debian.org>
Cc:     aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
In-Reply-To: <20230224160714.172884-1-leitao@debian.org>
References: <20230224160714.172884-1-leitao@debian.org>
Subject: Re: [PATCH] blk-iocost: initialize rqos before accessing it
Message-Id: <167744269225.13527.9868779562423182386.b4-ty@kernel.dk>
Date:   Sun, 26 Feb 2023 13:18:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri, 24 Feb 2023 08:07:14 -0800, Breno Leitao wrote:
> Current kernel (d2980d8d826554fa6981d621e569a453787472f8) crashes
> when blk_iocost_init for `nvme1` disk.
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000050
> 	#PF: supervisor read access in kernel mode
> 	#PF: error_code(0x0000) - not-present page
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: initialize rqos before accessing it
      commit: efbb51a0aae5fcecda266ac254146e36fff41e16

Best regards,
-- 
Jens Axboe



