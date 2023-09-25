Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFD7ADF47
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjIYSu1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYSu0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 14:50:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628695;
        Mon, 25 Sep 2023 11:50:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae015b6441so4681558b6e.1;
        Mon, 25 Sep 2023 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695667820; x=1696272620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FS6Sm1WF5Sz2XYLA9mMdoZkfL6tjoxQpUMHovY5b5ok=;
        b=WArYuSizFbQch4iYYOBhbeOvqWchppb5jh7GoQ/2nYKVSP++XKuZ3AeE9lsZ7ZxtoA
         ZgsBp/IZ2sSKOuA3qFU7/IYaOdqOgGwcBNUQXhdUO3Tga5iHSsrceir8EOtZpzDHMv79
         w8o1YI0MzecUKu2TmblpCGWqF51MlG04HchbGsMgSKhsNOftHfMrwa40mfxtwrApY9Tq
         HHLt7Mas9OkbE3eBT91Bi/TXDIBOgjFS+1DTNV8Q18tBh7Lv4bHvekkPOJuglYXbMycG
         LwGGoyJeYryzIgcNdlJs3DwAUJVB0aXwwGpMgzHyKENxTyRMmkMLFMc6om6fwTjJ+cmE
         pUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667820; x=1696272620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS6Sm1WF5Sz2XYLA9mMdoZkfL6tjoxQpUMHovY5b5ok=;
        b=kgGedOYlycDLs4Ppk+9cLlOCVwGcEBkTow2EwjoyGbOi3qlQcpILSfI6Ju4Pycis1+
         kRa6KWdNyGSzXFR64WkzGK/9bcOlu5oLCVETHOjpJacGAXPZ2rV8/QoSRGP+AhUJwN5X
         ZAFbtGFsEqPXaTO6uQzCMvS39JX3yxjr/jD0LQj/UMJMdwknUQvaAxn/NMhXIKdkRib8
         k5nhIeUc3bHlqCnfAmutB4JtQ788dxxQuhSgZhGC1872uGoRTIpm9rscYzLp+wUFCN3J
         QRDHYmx6FhIZJpDoazsvdKHkbne/PyjibOK2365FNXWd5H9UMuJ+QKi7i3Iw0HO4m6cZ
         1QWg==
X-Gm-Message-State: AOJu0YwOBya2oA1j53C8sYKUCzMxS02BLjN0iIXebWAfAIifp6yAutUs
        GlBlDyIzUBfzf0RTyZgS3C0=
X-Google-Smtp-Source: AGHT+IHRZMr6IhaOtGpvWwk25Rio4U4ABsE8JYOC/UUsGmYjv3f6Sq6emPCM4JRvywQlAlRRXp7n3A==
X-Received: by 2002:a05:6808:10d6:b0:3a9:e8e2:5799 with SMTP id s22-20020a05680810d600b003a9e8e25799mr11663773ois.14.1695667819737;
        Mon, 25 Sep 2023 11:50:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b0068ff0a633fdsm8406684pfn.131.2023.09.25.11.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:50:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Sep 2023 08:50:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, zhiquan1.li@intel.com,
        kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
        anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
        yangjie@microsoft.com
Subject: Re: [PATCH v5 02/18] cgroup/misc: Add SGX EPC resource type and
 export APIs for SGX driver
Message-ID: <ZRHWaZB5BeXt2EcY@slm.duckdns.org>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-3-haitao.huang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923030657.16148-3-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 22, 2023 at 08:06:41PM -0700, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> Add SGX EPC memory, MISC_CG_RES_SGX_EPC, to be a valid resource type
> for the misc controller.
> 
> Add per resource type private data so that SGX can store additional per
> cgroup data in misc_cg->misc_cg_res[MISC_CG_RES_SGX_EPC].
> 
> Export misc_cg_root() so the SGX driver can initialize and add those
> additional structures to the root misc cgroup as part of initialization
> for EPC cgroup support. This bootstraps the same additional
> initialization for non-root cgroups in the 'alloc()' callback added in the
> previous patch.
> 
> The SGX driver, as the EPC memory provider, will have a background
> worker to reclaim EPC pages to make room for new allocations in the same
> cgroup when its usage counter reaches near the limit controlled by the
> cgroup and its ancestors. Therefore it needs to do a walk from the
> current cgroup up to the root. To enable this walk, move parent_misc()
> into misc_cgroup.h and make inline to make this function available to
> SGX, rename it to misc_cg_parent(), and update kernel/cgroup/misc.c to
> use the new name.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
