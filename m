Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0174F9F1
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 23:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGKVk2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jul 2023 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKVk0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jul 2023 17:40:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB4170E;
        Tue, 11 Jul 2023 14:40:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b852785a65so580925ad.0;
        Tue, 11 Jul 2023 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689111625; x=1691703625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzWAKJljFotAV5RnvCyAUBH4oa3yNrE3i5b8cXS4wDs=;
        b=H01SSHIb1kS93H6HNYS/RLOyZc28d9HFwfIOpFx4oZPNYDhZvhiUTVu1TkqFq3e7Yy
         DcuRfyEW04VrLtmT/urRmUi6zZ00CHAOW2ABnQUc9rtno7jgsA1XeG366wfTuHiFm/kK
         gUMlKOcH2Pfgf/f2VvC2K97MrnNyyaJ2rWY9rBhQKn86qSW+UCWTn/rIMPuO+Mf7aqgV
         e5evxzYfzYBiAGDi77p53xjSWUcVXvE/wfo6LlsPIk8HBOT+S7jFgkINsbxjSq6hccQ5
         UhyInggwinXaLec/Q+VgspeCqGvvaV9uS+kZhwBMX2MQjHRYW20uZCqibWzIlde+Dy7e
         9Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111625; x=1691703625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzWAKJljFotAV5RnvCyAUBH4oa3yNrE3i5b8cXS4wDs=;
        b=K9stVpNfzweEaysP3GQ1e2SmDJTYSxu/D+G7Qd25hkavFZF5s6azLK5LnsRV+bw87/
         jmXniVr1ORgL9XPjen7blzP6GnarkngMSgTOisTXsdB9/e12sa/xPjDmVg3bS7E6MB5q
         CSgqPsHu43HgrFWiB/01Z2LxigYeJ3QL2Gn4FWdGY7sHJsLP+NfoS+NnoVya62kD1pgF
         NzPWSqs36+kEyYhOeySTdbKa5yiUvPv9sY7lrEnYVIneyJfjIoObS8r7ZokksQ2MohCc
         7DGwBe2ewefrkU2f77+pqRH2MDzmBwJpFQem4t+iA5spMyz5P8ofFTgOobDSYMtrhOAd
         Fwwg==
X-Gm-Message-State: ABy/qLZ4UN+T2AVX9EqxIrAwcPsz5BND3mOqlUS26OBhVr255oWbxVEY
        KYELzTWEYwDvECsOBE8kPVI=
X-Google-Smtp-Source: APBJJlGqMyH8SZj29Bp2YljZ6QnHQ/cIWNbGOO8j6eMYtLRjmB+GxVUhhU48RIDA0rZLVNKiRbzpbw==
X-Received: by 2002:a17:902:d2cb:b0:1b9:d335:1740 with SMTP id n11-20020a170902d2cb00b001b9d3351740mr142210plc.2.1689111625025;
        Tue, 11 Jul 2023 14:40:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9374])
        by smtp.gmail.com with ESMTPSA id jk4-20020a170903330400b001b8b1f6619asm2410885plb.75.2023.07.11.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:40:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Jul 2023 11:40:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unneeded return value of
 cgroup_rm_cftypes_locked()
Message-ID: <ZK3MR5liSMSrlKVm@slm.duckdns.org>
References: <20230701073856.2095425-1-linmiaohe@huawei.com>
 <ZKxeke6SfBe37Jso@slm.duckdns.org>
 <27428e7d-e280-2f78-7856-056d4e174057@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27428e7d-e280-2f78-7856-056d4e174057@huawei.com>
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

On Tue, Jul 11, 2023 at 11:00:58AM +0800, Miaohe Lin wrote:
> On 2023/7/11 3:40, Tejun Heo wrote:
> > On Sat, Jul 01, 2023 at 03:38:56PM +0800, Miaohe Lin wrote:
> >> The return value of cgroup_rm_cftypes_locked() is always 0. So remove
> >> it to simplify the code. No functional change intended.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > Applied to cgroup/for-6.6. Please feel free to follow up with the comment
> > addition Michal suggested.
> 
> Should I send a v2 patch or a separate patch? Both is fine to me.

Please send a separate patch.

Thanks.

-- 
tejun
