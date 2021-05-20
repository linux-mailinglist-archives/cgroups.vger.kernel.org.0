Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA938B43C
	for <lists+cgroups@lfdr.de>; Thu, 20 May 2021 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhETQbo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 May 2021 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhETQbn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 May 2021 12:31:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E618C061574;
        Thu, 20 May 2021 09:30:20 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x8so16794960qkl.2;
        Thu, 20 May 2021 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3W+WKCOZfAqXxcanQdJX+E4VIil1GeWKxxWHUOqsnD4=;
        b=HAbBW113TuLa9uF4nGtlHtdoyguK0a0XR8RiCgHJn6OOfAVrEndlerGb9lojxQQU46
         L+JMqEeBn3zvbZm1g3i1qMk6dF88k2K3E6YwAhiwWSxWq013UYHS81e566F87A6jm0rx
         WswXOtpOOkAqOcBcEbFJrkHq5CNCzz3oc9WcSnT6xfB+69zbr/as/cRSTLBjCRqARdwH
         b8MuzNtkv872KFOL3l/iZSxYhK7ZbCeb1gs2OE07mDuVVOtkBRsm6yENj/gm1zYhav2y
         YDsyfqXvkaPzhNMJ8Q2cKHPL6NsH2AklMxth7IQ0ZwikcS1FAOEJIjZXpUT+4BYm9Nbi
         1Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3W+WKCOZfAqXxcanQdJX+E4VIil1GeWKxxWHUOqsnD4=;
        b=V83SUxWcSFbHdOTPgsRwukfI6Wu6iLhjqwFKA6XD2mXxixXym+R8Zd/2R9Q6G5d8Lr
         lQmKeYPXX8HscPnIL4M4prqoH1p27ixQBlnqMVTKz2VisyHEesZHupKFKzvmTnuSF0Cb
         k+KfBECDG9MXc5qxJiAJ5jhErnMdJdXRFJaQQeZL+rmVO+zbhD5zhnrbWYMjmPSs5dbs
         OChW78Sfcz8NgkLqMt/jtsyWKj6+yqBQ4G4enHJQ8do4/xzcMtpHXEdWe/asUXFrAfRR
         IwYFLf0ZWelv/8XvDDXZgM3JlKHG9rEsQCLDFtUfiHARo/w2NO6nU3/zOK1JUJ44TBSX
         Laog==
X-Gm-Message-State: AOAM531GsDCnajKnmVf1arhg6X7bITRKvy5/HDjrcte+k3s0uUlvqls2
        WYWAk+RUQkYfEMURoQbis3M=
X-Google-Smtp-Source: ABdhPJx9lJDvWGuOPcMvZ/rfOceGpfyiWsJDD9YtW7iPj7j3dfO07FvRecvEo4/GqqOgyg3OBb0xcg==
X-Received: by 2002:a37:a254:: with SMTP id l81mr5855956qke.175.1621528219596;
        Thu, 20 May 2021 09:30:19 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id f16sm2151636qth.79.2021.05.20.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 12:30:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, shy828301@gmail.com,
        junichi.nomura@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: disable controllers at parse time
Message-ID: <YKaOmmI8G4DPk+uo@slm.duckdns.org>
References: <20210512201946.2949351-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512201946.2949351-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 12, 2021 at 01:19:46PM -0700, Shakeel Butt wrote:
> This patch effectively reverts the commit a3e72739b7a7 ("cgroup: fix
> too early usage of static_branch_disable()"). The commit 6041186a3258
> ("init: initialize jump labels before command line option parsing") has
> moved the jump_label_init() before parse_args() which has made the
> commit a3e72739b7a7 unnecessary. On the other hand there are
> consequences of disabling the controllers later as there are subsystems
> doing the controller checks for different decisions. One such incident
> is reported [1] regarding the memory controller and its impact on memory
> reclaim code.
> 
> [1] https://lore.kernel.org/linux-mm/921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: NOMURA JUNICHI(野村　淳一) <junichi.nomura@nec.com>

Applied to cgroup/for-5.13-fixes.

Thanks.

-- 
tejun
