Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E585AF1F4
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiIFRKI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiIFRJc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 13:09:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F7B2A;
        Tue,  6 Sep 2022 09:58:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 123so2583246pfy.2;
        Tue, 06 Sep 2022 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=XjgZYFNOvrIhYZ3W1M3muFB2Y46u3ki4tze0cD2gLBc=;
        b=ouk+eTxl/O/1JqFYWDJvPJNXiyQ5m25943fmAjXirSUWWjqkhRjxfDq+7RNzmciuSr
         yUZjs545kA7NztlBMf5GNnN5KBFOxBK7KUVMYdkVeHatFQdVY7JmNlH5mgTyeYyWDVXk
         GHtVen0zUJEj6WOf1o1I9vsAnpA5Cdpn0tnJb2UYehMtDs1FZHl1qs15jt3xsNR8gD5R
         tFeuYTsj55zKEmB/pK97yGltxAgftipubcdfap3GvDFtZ0gCpC1yo/IR7Hr94LkJACek
         /wR5ySbLcxLsTkCQHbhrf6Jlmh/ZC8L9ASoNDuJ5VkDU8WLpShI0mna/QGevaLWHrmTV
         RQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XjgZYFNOvrIhYZ3W1M3muFB2Y46u3ki4tze0cD2gLBc=;
        b=WrCloHbPGe2xlFVKXuVFkx1hlPAkvF2lC2dINK8ITyj2t2W/v/K98iPTc9QD96zffT
         QX2bi2BAo9STVotG6lidT2dBy15rgqh2Ay8cSXSO76o4y0UfeV/KqD1vUrcUd6kONwSD
         NBdFn6uTN7ri/TlLFXvvY+4rzHqr0tVlMTaycgWtkQJqPRw24jzwzZ2U4Jy05duLjx1k
         pSWkNNs1fFwFs5tihELxMsZAewUioyM4T8U6w0fcF7x8FamCrDZ9sAFpzzzXzV3ICSes
         SFbrndO3Ex6OlJ1HSNjc7Q6CJCAttLE2HeHQq5zJdGM0PKgGIKShbUVoeoil1nr5wiRW
         YpzA==
X-Gm-Message-State: ACgBeo3K4I0XkxszMpcZTVxxkkTrmdIwwx/FjA+DeZH730/KK9MdFQUm
        MP5/YfxzkKHuZwT7MFiSDgssJsDCvdY=
X-Google-Smtp-Source: AA6agR7fFN6HwW9TVFDKjD67QX7bBbjkk+n3g9IJWmgeruCvlQobsvp/z+vIjLXz7yT7K5l+9FC9LA==
X-Received: by 2002:a65:6048:0:b0:412:73c7:cca9 with SMTP id a8-20020a656048000000b0041273c7cca9mr48303700pgp.257.1662483529204;
        Tue, 06 Sep 2022 09:58:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b0016f85feae65sm10163589plg.87.2022.09.06.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:58:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 06:58:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.0-fixes] cpuset: Add Waiman Long as a cpuset
 maintainer
Message-ID: <Yxd8R2VJFM44Hy6M@slm.duckdns.org>
References: <Yxd8MUTOPbxvZVOk@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxd8MUTOPbxvZVOk@slm.duckdns.org>
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

On Tue, Sep 06, 2022 at 06:58:25AM -1000, Tejun Heo wrote:
> Waiman has been very active with cpuset recently and I've been cc'ing him
> for cpuset related changes for a while now. Let's make him a cpuset
> maintainer.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Waiman Long <longman@redhat.com>

Applying to cgroup/for-6.0-fixes.

Thanks.

-- 
tejun
