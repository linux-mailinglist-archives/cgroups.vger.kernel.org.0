Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE365DF3E
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbjADVqu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjADVq2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:46:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E21EAC1;
        Wed,  4 Jan 2023 13:45:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so35937627pjd.0;
        Wed, 04 Jan 2023 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HP49eHGQprOWy/o9YAiJT2BohVJETnV4fu4DZ9xoKVU=;
        b=am7cWJUxSY+kVv2i1XesOjuZY5/rfaau1sAwfQrVls7yEjhu3MCtLYYSO/yYult8Uo
         WHRb8isgq1iOq/Ng5Lg5PDY24f//vBjtz65tALlr2/6+H28fa1RqP5BhmWdtyw0Dhxae
         9HhYrvbluk8zh0BabpGcW0B61Vja8dkHDI4rODdtNvw13a0SqW+2hzPPbUjF1g2Z1Hkh
         Hc4kj22L2gF4BG3n8r5Hg+WpvoNc60VwppDumxDVcRAsZEl+uMyHGGfDNFUkVwNVgGeL
         oWWp961cGxDINEjbdae7xhsedktVsXAqF8OUhErIz9EvxppBMxuYo8VaH+cISWBU0DZy
         x3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP49eHGQprOWy/o9YAiJT2BohVJETnV4fu4DZ9xoKVU=;
        b=VZzgXWYQAFKH26cyoXD0V/M6QNDkn+RA3BwOU0wS5iGx/alF9xYY5izI+TI53mhtkU
         KAHTQbUr9O0Fo66s/udhLVx81FuUH1FcEA9SHda6lbEw2/Df1DviH7uQ+OQpsw/VgLdf
         h+twUolE08hlgI5aCRCXCrIm0wJganl684XITPJ9wOdtzFZpLMPX+Ohxwy2YoEkrl7qh
         BYYaU+Ctk1wzzsoioYaFWlPltD/QtpAeRH0ov8UOe1etbuCgqP2XWzfe5E0Tk/DrS5bS
         GwM5OtHzFKoL3/noAM7jjMYGKOT7ZZx6ZYBXE9Uey1R/Z2N2lxCNp5xArf6bJbqFOxuL
         Bzwg==
X-Gm-Message-State: AFqh2kr7OynFajLDLvEO9/hPSLwYgpkVPzTZoHnCuZppQ/APMDVrXoJ5
        8jEvdeJhEfuLuYpoJlqzhoA7HxuGYHE=
X-Google-Smtp-Source: AMrXdXue85NiAnKB8lqurAz3gxzGPsscumMnlt2d7OV9AjVmjKdjcvLLyfkucmC2Zc7tD4to2XeHIg==
X-Received: by 2002:a05:6a20:c78e:b0:aa:15b6:6322 with SMTP id hk14-20020a056a20c78e00b000aa15b66322mr54748836pzb.42.1672868744689;
        Wed, 04 Jan 2023 13:45:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j1-20020a62c501000000b00581d48ad9b0sm12064239pfg.154.2023.01.04.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:45:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:45:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/2] blk-iocost: add refcounting for ioc
Message-ID: <Y7XzhqyJYBDfZhnF@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227125502.541931-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 27, 2022 at 08:55:02PM +0800, Yu Kuai wrote:
> Root cause is that blkg_free() can be asynchronously, and it can race
> with delete device:
> 
> T1			T2		T3
> //delete device
> del_gendisk
>  bdi_unregister
>   bdi_remove_from_list
>    synchronize_rcu_expedited
> 
> 			//rmdir cgroup
> 			blkcg_destroy_blkgs
> 			 blkg_destroy
> 			  percpu_ref_kill
> 			   blkg_release
> 			    call_rcu
>  rq_qos_exit
>   ioc_rqos_exit
>    kfree(ioc)
> 					__blkg_release
> 					 blkg_free
> 					  blkg_free_workfn
> 					   pd_free_fn
> 					    ioc_pd_free
> 					     spin_lock_irqsave
> 
> Fix the problem by add refcounting for ioc, and iocg will grab reference
> of ioc, so that ioc won't be freed until all the iocg is exited.

Ditto, why do this in iocost instead of blk-cgroup core?

Thanks.

-- 
tejun
