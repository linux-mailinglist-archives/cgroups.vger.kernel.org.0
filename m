Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD05AC618
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIDT1Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDT1Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 15:27:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E829811;
        Sun,  4 Sep 2022 12:27:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q15so6763173pfn.11;
        Sun, 04 Sep 2022 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=hhOqEPi04AV0wzekaFieSTX5YqMIIS7ffO//I6J4RAA=;
        b=FEZwae9/shgAqtAoz1u27GSJjFWXeDqCSu1PMccOHcDQGVz5GYgDAzszVgxLj8iOaN
         +4a/mXPUPzWnZ/1pi7uSLMGBu6MIUap1IcF77lgwifRAdKKCVSTDN6JKxJpyD3YDT3qo
         0WSZf66SAVbfDjeVLGNMpiJoZSZuGl7hizBxZFoHQhsWbJbZJX1+eFgknt1yhiRo0kiW
         WHX5qZrHY0yLkrFdFhAH2DQwCXZkmt4oIKNTbojp889xacGf5uMxhRXzazD7mBmY8N49
         CRi/m0I1/MneBQ+MyLFdD7arbFBzRmE/XIhzduSiPDK7SW23TUukKKKXcVZdGQMJckAW
         g17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hhOqEPi04AV0wzekaFieSTX5YqMIIS7ffO//I6J4RAA=;
        b=qOrMzqpuEl6cBMdVg88Hsql148vV3X+lOCxH2hx6Wj3yf9j/YnXmB1PLU8/fjwvRXY
         Mua3rojzg0CtHJhNBsz4jjdI7GvEGBbXAqCiHE5zoZ8pkDKhfJSGB8MKxemUptwJrnE4
         2tS8rz5jcBoiY1Pa7YX8ktmdPWAUfeePJaO5NWfz2NRKqGj24up1MJzfNJtuegc6WxtK
         GVI3VRNA8aMdMZea0BMMAEvRjRIEK7RwQMULvoUNOKQYeNHbqirwnwV6BcWXZIIu53SW
         9/DSZbCj51KxPUKOjoSjGkAXajzxhzHByZkX5IFQa5+amvMZG5ic3wjCfyL54Rten9hb
         eV+g==
X-Gm-Message-State: ACgBeo1J53LPDtCvtVMD+9dSrqudVIr4n/698qRsoet3xdX3KSPqib1e
        4DC05B/JpbzqAxLGKDRJHTM=
X-Google-Smtp-Source: AA6agR5hJfZBJqeywitN953voJcftvOwIN3HbgA29MIDaOyr8wHGnqYWJfAqTKlfphgJrlOlmujVxQ==
X-Received: by 2002:a63:211:0:b0:41d:946e:cf67 with SMTP id 17-20020a630211000000b0041d946ecf67mr39156973pgc.497.1662319643362;
        Sun, 04 Sep 2022 12:27:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id v126-20020a626184000000b00528c066678csm6010528pfb.72.2022.09.04.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 12:27:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 09:27:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: add pids.peak interface for pids controller
Message-ID: <YxT8GdAtMfZBOQgg@slm.duckdns.org>
References: <20220831224903.454303-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831224903.454303-1-joshdon@google.com>
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

On Wed, Aug 31, 2022 at 03:49:03PM -0700, Josh Don wrote:
> pids.peak tracks the high watermark of usage for number of pids. This
> helps give a better baseline on which to set pids.max. Polling
> pids.current isn't really feasible, since it would potentially miss
> short-lived spikes.
> 
> This interface is analogous to memory.peak.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Applied to cgroup/for-6.1.

Thanks.

-- 
tejun
