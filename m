Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91A472CCE3
	for <lists+cgroups@lfdr.de>; Mon, 12 Jun 2023 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjFLRaN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjFLR3c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 13:29:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A047FB;
        Mon, 12 Jun 2023 10:29:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-653fcd58880so3618536b3a.0;
        Mon, 12 Jun 2023 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686590971; x=1689182971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhcWplw0MheBHEmIkzjsW91UZcSA6RHIkXpE9/7nU90=;
        b=NKxzs0eIWy7UWWQrFowAJB+athTXNxT0R4kZFxHQbro1O9i4PXE+7x05SExYwpCPTr
         JHkzRvDOKFeRoWfQDVr/o5ha52O5DGrJO1YdD8q66+WuCwJylvtGLjo87peWA4CQd8bP
         aSUQ+9Am8E1n6lj+y3ObEjknyZTNkQ4Jl9/Eyb3psn19a8ydN+BdHGV6W76Zs5k79oc7
         gHuxRwx1OUgW/tbZD34k4j0DV+yL/TsJDF3BhaaUZhw0NQUiJ0Z1Xl3V7e1WOx7//wox
         EuUl2rPqyc6thx3A9zSsOg4E8rCUTxdhbAYscAk7NQ6vtMcl8+Q35+aYGA5jPdcdDswE
         nkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590971; x=1689182971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhcWplw0MheBHEmIkzjsW91UZcSA6RHIkXpE9/7nU90=;
        b=WqzCT1OLNRkGG11eTBCZTmfIg7JfHirc1ndFdvNlEwbt4B56rVpI5SiVkZcLewZ5DP
         jC3meBHfkk2LFBlbXGESuudZUx1f00WjAf0a8nghgDoGQQcWF0GOp+Rt4FveV0nawQgL
         SeVYVqXRc1KNr0IaPD+8Pgbw5f7EP9RGHsjOk+J9tTsoSNDD2aKJpAFhdFguk0quafLC
         u6MgaZYlwziKEEu63Rjb+IxYZqQY+aj56Rbf1tE4e67x+fEor4RzvtmksITwLq/wNC18
         1rL6kmYncD8SrSHId/P+imiiQP2p0Bbr6yzK+5QzAfysKyynWOY/Lhw+Md1+fU7sfefn
         SP5Q==
X-Gm-Message-State: AC+VfDwV86Fskaycs4GqN0UnHESx8VDTUHyDczNAXalmaqx0TFJL7LKE
        RfyumQ4fx42QKXHVCUtvaMw=
X-Google-Smtp-Source: ACHHUZ4NUcEcJJpcgpODDaZDZg7v27pbXFpSaNRkaWn+ixsVnrFVTIpoxb3MF5ex212EeZuO69aafA==
X-Received: by 2002:a05:6a20:4417:b0:110:9210:f6ac with SMTP id ce23-20020a056a20441700b001109210f6acmr11156146pzb.37.1686590970988;
        Mon, 12 Jun 2023 10:29:30 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b00543e9e17207sm7808560pgv.30.2023.06.12.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:29:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 07:29:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        cuigaosheng1@huawei.com
Subject: Re: [PATCH v2] cgroup: Do not corrupt task iteration when rebinding
 subsystem
Message-ID: <ZIdV_dDDKZazcO6p@slm.duckdns.org>
References: <20230610092643.139007-1-xiujianfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230610092643.139007-1-xiujianfeng@huaweicloud.com>
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

On Sat, Jun 10, 2023 at 05:26:43PM +0800, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> We found a refcount UAF bug as follows:
...
> To fix this issue, switch from all css_sets to only scgrp's css_sets to
> patch in-flight iterators to preserve correct iteration, and then
> update it->cset_head as well.
> 
> Reported-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> Link: https://www.spinics.net/lists/cgroups/msg37935.html
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Link: https://lore.kernel.org/all/20230526114139.70274-1-xiujianfeng@huaweicloud.com/
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.14-fixes w/ stable tag added.

Thanks.

-- 
tejun
