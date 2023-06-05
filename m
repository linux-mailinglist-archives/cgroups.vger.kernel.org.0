Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAE723170
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 22:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFEUcA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFEUb7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 16:31:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672ED2;
        Mon,  5 Jun 2023 13:31:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-651e298be3fso5074603b3a.2;
        Mon, 05 Jun 2023 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685997118; x=1688589118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6PHjxXVqGr/anCjyWJ5NzVjZ6+kUpY7d4+0bLn+hMA=;
        b=NK5TWOw6+PRoYhYmwe5WM0uChPHx86tWH1VxaEQlzps5NSc8B0vdDz1cdbIemALTXG
         5yPMWTU9W3imDF86OBSrMJxYzDFZj4Y5fBapiVDvh2EqZgU0uciddeEqByTixhqdIGwX
         KfeTIaaU3G/Ue8Te/+48Ps47QbhMDFq0VvXWBdHea8j5KL9ty0Bjw0P9rwmmINyq6D19
         ItdRglwt6tJKO8tNM1dfbqYWlZpFgThs1oR/8zQqqXL9KSm5srbTnejOedAKhgh/xt2M
         vuwEDr1Saela38h4NnO/7JCJrXaqJ8zGsT5AurllQSOQ2p1YtkOqD8UULaPAzAwcm9K0
         lFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685997118; x=1688589118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6PHjxXVqGr/anCjyWJ5NzVjZ6+kUpY7d4+0bLn+hMA=;
        b=dQMI6P12zH3DFXqqwa/ZiafiA3Yr212Ry6VhLBrJhriA0XysZk4DlsnNC6+NEC6TwB
         wUSvzhioL+i64f6aB21DZRqBWFe0W0/NnIxDYchlgAY2HL7AZDYRUZVrq5PgrxU6Hnll
         ALPpQlV+AxaxWSbGSxTNK7gxjU5/L9WrDkg/TzPzDV9CYGWVHcxfiB14fu1cXpxM0I5i
         tRjo1KA9/L4Jd0zQBi0UZ2eukoGsjmb1gNMM9BrxIAETpMvNiUNBaifK1re3GVT2F/Dy
         VRcn1c+mMyLzHQ264FxsvK0ewfgeAi/dcp5rMmWaB/jidWqKajPlyA8aLlk6s+ifYayQ
         3Jcg==
X-Gm-Message-State: AC+VfDwndatIKrLez9Jykm2XFCvxRVkf+qshZxQ4demobWOOOmtEy5uJ
        laR0gBjcTvmkQxFP3Dw+lQU=
X-Google-Smtp-Source: ACHHUZ5FDNuQxCHv5YqzlAuIQdW//XaFS5aGN0JbqOBCYCUhuKXeITUBsRawOrRwyJEFOItzTcyieA==
X-Received: by 2002:a05:6a20:431a:b0:10f:9bea:5a61 with SMTP id h26-20020a056a20431a00b0010f9bea5a61mr311109pzk.2.1685997117668;
        Mon, 05 Jun 2023 13:31:57 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id s8-20020a62e708000000b0064d2d0ff8d5sm5532031pfh.163.2023.06.05.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:31:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 10:31:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: make cgroup_is_threaded() and
 cgroup_is_thread_root() static
Message-ID: <ZH5GPHPW0ihSKtNo@slm.duckdns.org>
References: <20230603071304.1077085-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603071304.1077085-1-linmiaohe@huawei.com>
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

On Sat, Jun 03, 2023 at 03:13:04PM +0800, Miaohe Lin wrote:
> They're only called inside cgroup.c. Make them static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
