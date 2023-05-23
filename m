Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933CD70E51F
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjEWTJZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjEWTJY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 15:09:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CF7119;
        Tue, 23 May 2023 12:09:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so6971773a12.2;
        Tue, 23 May 2023 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684868963; x=1687460963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z5OxRlNGFDksqOxV/WuukP5r2QPiQu+c1cFCQeYYDE=;
        b=Fjq2/r2eJg8sxpSURL2bskZvWvE/vaukNbU7Hr8dfPIbfks/WfaA/iyDBHVTG8qLJU
         JSB9bDnVnCl6OVMYqZUoI+EesTtZdzvDLno5/pKHSv4+GsSV1bcnjjfj7Ek3iCEzQGeD
         frvVPGI/tA0gYTokSJptMu17N3CwYUDVFjP4tIkW+2vZeXRxUbpm1G9O/qun6DmIua58
         Y2L0+Gn9PNMJaTqxqjoWTBqgutnxtV7+35UlkNhouHeG1VXbNcd23UnjO1m244dz3LO/
         AMXiW6ga2oIQmmzpTL3V8d749fuuxrZfi8lvkmeN8VHijWOZAnMsJGSESis1fSslZ2/J
         10lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868963; x=1687460963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z5OxRlNGFDksqOxV/WuukP5r2QPiQu+c1cFCQeYYDE=;
        b=MFY5nvCfIF6TYsIZKhymqRw1UR7fyvC4WCxvFj2SfLdzU0YZs7bDHrKfVQgpv6T8/q
         Emg/yB4lHrQ0gCi0cagRqEQNNx4kangSZNmeUjdUQ06NfRMvp05yPJ7J0hEeCw5r5Kas
         iG0LFbdOoMuvIGVDYNJGKQOhU2qHiSP7lLyHcw/dG2nyhS2F6LX0RcoIY3IwxVIrSbKm
         liTXxa1+dOIqd1aPLfjgUHTl6d7+9hk96ilYKN81h0YEznhFk2K4SPP9fcATpIf4DGUd
         6PwphhlmEMLB45Mj9cOVFTdQYXijg7zFNy7xfBfYFXScnsLov6a2gmcNfxCSA/NxcvRd
         ZqIw==
X-Gm-Message-State: AC+VfDxPwqL/BGI5Zvo65uCuOXik8b2RHoUCa5rQKKjGDAYvMjyByHTo
        b1ygYKJipKpfl+CXhrU0sI8C4ykXma0=
X-Google-Smtp-Source: ACHHUZ4nT41nFzlegruYDpteeblhOJMzXV3S2Bdu9AyXupuk00ajCc+oq0WNPbSPSJFkGLjrSdyK3Q==
X-Received: by 2002:a17:90a:6444:b0:255:99c0:9f2 with SMTP id y4-20020a17090a644400b0025599c009f2mr3845341pjm.1.1684868962416;
        Tue, 23 May 2023 12:09:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a6e4400b0025271247ab8sm6012254pjm.11.2023.05.23.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:09:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 09:09:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Remove out-of-date comment in
 cgroup_migrate()
Message-ID: <ZG0PYH7a9Mw50bEl@slm.duckdns.org>
References: <20230523111456.146053-1-xiujianfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523111456.146053-1-xiujianfeng@huaweicloud.com>
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

On Tue, May 23, 2023 at 07:14:56PM +0800, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Commit 674b745e22b3 ("cgroup: remove rcu_read_lock()/rcu_read_unlock()
> in critical section of spin_lock_irq()") has removed the rcu_read_lock,
> which makes the comment out-of-date, so remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

So, that removed rcu_read_lock() because it's implied by the irq disable but
the comment content is still useful in describing what's preventing
use-after-free. Can you please update the comment accordingly instead?

Thanks.

-- 
tejun
