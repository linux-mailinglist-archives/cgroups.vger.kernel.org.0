Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C176F66B
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjHDAMp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHDAMo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 20:12:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F14213;
        Thu,  3 Aug 2023 17:12:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1144419b3a.2;
        Thu, 03 Aug 2023 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107961; x=1691712761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mK/SUGZd/Inm2gGsrCEsgPACkbFKLFUt6mW7c1W89dY=;
        b=DtSGG/oRMwGU3wuk4qrV+2+UcwBZ77mVPn2F8Ts7bZHxnr3d+2Ip7akJrrmqJ92uoJ
         W5f7xrDRhSIlCMdVoEPDSJLWESCedoCAR3GQAMLTyLPgYlRFs+yuJpd+RPgT9yTr6hKz
         fqZF/D/AfJU1Zf5KwLPUe2HS6WtArMSPi5NTlAHAZAEpMQP5d7Q6aDfxqLibxpeP7S8e
         6mQttf6nQbMBJtJSHVaQX9uhseiyr3V7mcepWY9wCIU4S4+/41B9gvDZbGg7lUW8nAnM
         ZpLLRPLTNMWzeJpHnXs3N/Qo8Cqu04PEFsjRNA7skCwtcwNJHpGWKSpB6xkPkCnRM0TK
         KzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107961; x=1691712761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK/SUGZd/Inm2gGsrCEsgPACkbFKLFUt6mW7c1W89dY=;
        b=MZ4IPjYSp0WX/dsKS7+QU4FdgJkXj2sp8BBU92ZCex3kPWlTVhVDnaqeC0SqhRa49/
         83+rsePm+YerOEekmBil1Pi/CSvMbL/xj9nQxce78IR7Aq1qDwuKajOPOoenM5ECDO8u
         SfI4R1nDtH4Nofj4B+su/0BYZAMJnTIvIUwgZ0ObzksSC3ZuuMmjD3vvVsdRzW2ht8Xv
         Ikj4J/TPB3J1QJTXJpX4CrxRPA7GPa4hiHpPKPGgU8JzkJt7HyDw/ZRyRBHUPSMU/nLN
         pM1tSPQkToXz4jj/czrkv4jNuNuXb0kz6dW/n5Yb5omWarpkm43UyXrptpHsveCwNXnL
         4sTg==
X-Gm-Message-State: AOJu0YwCadC5yy6oAAUEvWMMTO9bgqYfSYwhugxA5/D7Yh6YKH7vieyJ
        x4ML0vBdYtXjw8/ijNCMqeDdAs75FjE=
X-Google-Smtp-Source: AGHT+IGwiePXAOhxb57+gIXtX2vbKG04TZpfa6VTSd3jnvrC59z/rM4o3R4N88JxLuFKrr15w0K/GA==
X-Received: by 2002:a05:6a00:2301:b0:681:d247:8987 with SMTP id h1-20020a056a00230100b00681d2478987mr213223pfh.17.1691107960569;
        Thu, 03 Aug 2023 17:12:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id x21-20020aa793b5000000b00682af93093dsm393915pff.45.2023.08.03.17.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:12:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Aug 2023 14:12:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Han Dapeng <han-dapeng@qq.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Han Dapeng <han-dapeng@foxmail.com>
Subject: Re: [PATCH] Documentation: cgroup-v2.rst: Correct number of stats
 entries
Message-ID: <ZMxCdojf1-SFQWaN@slm.duckdns.org>
References: <tencent_D28A72FC6B13C2955D8CD3200E939DA78D08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D28A72FC6B13C2955D8CD3200E939DA78D08@qq.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 03, 2023 at 11:55:27PM +0800, Han Dapeng wrote:
> From: Han Dapeng <han-dapeng@foxmail.com>
> 
> Signed-off-by: Han Dapeng <han-dapeng@foxmail.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
