Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6652A141
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbiEQMNe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345788AbiEQMNd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 08:13:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84246670
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 05:13:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ds11so5604320pjb.0
        for <cgroups@vger.kernel.org>; Tue, 17 May 2022 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=0CFZi2WdHh+fWnk2m1bIXH7l+E5jrgN/oQfn0swAlk0=;
        b=J1JomReZIjMEXQobTzVFw7ummBWdomtyzdyFFet3/kcc/jM+gvVqVpq2Vc/6ULmkci
         TrdzxzJOgkhyPeKaEB8TyJ7GUYbqXaJZChg1Rzz1OPOY2zKD77e7B0Ud/Ct9XzPpczfQ
         yUdrdQGcMoQGHU1XbBhSp/qOlzwdGZgqOReniRcnAHlJWwroi239fLHrS611gIYdCqsQ
         s1AQKsJqLq7O3ZWsoslHYwzyf+cl8QKLKbhwG54yFd7Xi3PMk4WPr07FuzlA155FlJn/
         w1x8iegRjjG7bDocm0Y6wTLVG0E4NoUC9hTcL58Y6RzIYndo/yNAwrJ53a0ICDcGifsf
         mAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=0CFZi2WdHh+fWnk2m1bIXH7l+E5jrgN/oQfn0swAlk0=;
        b=n2YeMqmR32ZlnYmRbYaOYakM0WZfyuuf0hZWGFgVs+b3JHsJZ497LkqZkRjNUg+x3U
         doW+mxfjPho8AuJi4surIw4oXRq3p/Fg9BFDjxgmTIurRA+4xvw6nc7JknIggRF+VR22
         WEBpS2cUCvFK7lEW1xovAmJNQnB/jcEzenADdlzW/JkMrtBqr0uVPP46i4wqupZGTWnG
         3avCSXPgORMrC9NAWCQGGtfhQLRE8vdRoXhmNdQlccGFvl0yIr8FIEzdnlUYJ3IEicsy
         pKbATaSS3qQ0L7Lrgij0CX1GVMH8Xa/xWTeQpFIqlywWs0UdgorPMp1reBRJKIkK67vF
         s4vA==
X-Gm-Message-State: AOAM530yukJKlh+EfRUg97jEf7J6Ns1uvQ2t/IHg8UMVCdbz4aEMQqP9
        1IudM1F0oL1Mz/zFQ3kiQ+/ysyNGBXhs0Q==
X-Google-Smtp-Source: ABdhPJyDx71heU0gfcxf+CGzQq7lXgAi5h3sMUNbGKzfQW4j5ZJ5G1UoPX9LPtNbpGfbEUenH6f63w==
X-Received: by 2002:a17:903:1248:b0:151:9708:d586 with SMTP id u8-20020a170903124800b001519708d586mr22127846plh.15.1652789603163;
        Tue, 17 May 2022 05:13:23 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0015e8d4eb269sm8754436plk.179.2022.05.17.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:13:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, bh1scw@gmail.com
Cc:     songmuchun@bytedance.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
References: <20220516173930.159535-1-bh1scw@gmail.com>
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Message-Id: <165278960081.13853.15178111681664943346.b4-ty@kernel.dk>
Date:   Tue, 17 May 2022 06:13:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 May 2022 01:39:30 +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
      commit: 77c570a1ea85ba4ab135c61a028420a6e9fe77f3

Best regards,
-- 
Jens Axboe


