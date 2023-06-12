Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C272CC05
	for <lists+cgroups@lfdr.de>; Mon, 12 Jun 2023 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFLRGS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 13:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjFLRGS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 13:06:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64208E0;
        Mon, 12 Jun 2023 10:06:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-65311774e52so3506902b3a.3;
        Mon, 12 Jun 2023 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686589577; x=1689181577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr6tGeFntRbSjgBy1Um8qOzjPQOuwFfu/EshJIcUU8E=;
        b=b63VmQfE/KSYmhiH3znSXphnujmx/FetpxWQ880wowk0pLOcAljxR2MwjuPliuX9yK
         cKjUoVhn1+/rsc/pCyavqU15Lhc4Xvctc6323U2scK8Ryaqsc/xQXtBmW6RPyluSTMvT
         sZ+W6EKMDmf7g12ABUoL8G5rYrd0oUlGDo5/GDaNX+XOUK61b9BSDahb61M4wIpmdc3C
         xbrKii+DbbcBtjBDHqnAS6drcRUBs1znPq/Gi/E9pfwkFd2Ltmz7rst7vo/9rVPGD4fP
         02XxGLXQPgBljEjUoDT1jUCYCrkBqkifRHstNqBy4/4lEjCL/bQx78Vlrs4fmODI+rB8
         82gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589577; x=1689181577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr6tGeFntRbSjgBy1Um8qOzjPQOuwFfu/EshJIcUU8E=;
        b=cyhq1wwdOPc2i0xEZJD5B5uhMrNz62ZuLeVNKssH2VbmnrwWR2PcF4KD1nOE7ulu1z
         +iYo7cbTVjitLNcdHRTTaSwfyvHa4MP+pBEjGvqxw2TCGvOB9euIGOVQ0iXsx1MyakIY
         32kf70ZIfjwlMvb/NBEDn8/n2GyC74lnXZStz5+xr0ejNefgUKs808accE6dcOQeL1eF
         Yj7BohqIpTZXPXQvoeMgwjTCLL6nPE6zo/7LQeXB1aWnAZPujd8Sfq0VUvDr3szq0vPC
         kFgVBVionA0SrPGIkICrUj/Ve7eGImOznWrSN4ZjubkBFwtYQVKjGlXc0rKcQRNoEeE4
         pPBQ==
X-Gm-Message-State: AC+VfDzyzJvYreh7sJxrP1PTXPUpwPYzb6+3qLNkX4f2E8ggPcKR4OcL
        P3cdA90W+mZerrp3VPANhHE=
X-Google-Smtp-Source: ACHHUZ70LTBLwPye3ZwAEFROWJfnJiMosGDRs+TFFvhOb6jYwen4MwNCuRnQMg2gH+eiaGBBKeTqWg==
X-Received: by 2002:a05:6a21:7895:b0:10f:c81d:f18a with SMTP id bf21-20020a056a21789500b0010fc81df18amr12331282pzc.49.1686589576614;
        Mon, 12 Jun 2023 10:06:16 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id s6-20020aa78286000000b0064ceb16a1a8sm7008616pfm.33.2023.06.12.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:06:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Jun 2023 07:06:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unused task_cgroup_path()
Message-ID: <ZIdQi6snJNTNg_rH@slm.duckdns.org>
References: <20230610035737.1046651-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610035737.1046651-1-linmiaohe@huawei.com>
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

On Sat, Jun 10, 2023 at 11:57:37AM +0800, Miaohe Lin wrote:
> task_cgroup_path() is not used anymore. So remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
