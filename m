Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB18434060
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJSVU7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhJSVU5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 17:20:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D37C06161C
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 14:18:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i76so1056607pfe.13
        for <cgroups@vger.kernel.org>; Tue, 19 Oct 2021 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GzA7XiYabDpwlwEkodpA4g2HW2PvdLTHL9by9i3zr0=;
        b=am9XbdWtSLAePsczf6sAyeuwlXGvpSs5OQQIudZxRB/oqzI0RbsoMVyASyiVYTCgfD
         XH28hBa/DiNO8YZxs6ZykFLeuLUBcnJDvlRLydt3YzQF6MTBw7ulb0eIne/AuoF4SiAD
         KwO6uvfqoin/Ez4BBQQHPODPByn9J5+y2qWtaFU9/T7k3lBpecrEXCXAW8asuyp67Zgx
         o6fY7qN36vKduaYKy6tN9E/0Kq5XHepbFSNCW8zW4h4SERn9niStfgTQYfgwhlCnM+EC
         orv/RSIadrJ0iFMYNmdXTRHXBuicW6m6YcGUsItcajeVbHrgjhs3YljdWV912FEjXDxO
         PWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GzA7XiYabDpwlwEkodpA4g2HW2PvdLTHL9by9i3zr0=;
        b=0GOuEYeMf2ZVu7L5QfLXsjWtlNu7JYJnTXszDq4gCfWBmWwYac3YBfRiNT2ovHI3oD
         4E7hxlK9AbzSGEuQDUmO4+Shwz4FPRMuZumtaKRJjNoyTFCskfwgN1ssKWJ++ZcjkBGj
         vodV8zkNKtBYqmujvQjzsUu+1lyI7cZbO0FuxFwDq3KWwZQySGT0ifmuFTW0COGWXm2X
         LbVlqnxL/Z1u4Fbhxl89opZVQXK+0j91/8ay4wVfrrfre7WBbRr5pyRrK3ztOY7Rn2NS
         b1ilNTnH3GqwE/7ExBzQggarOs6V1vz4O3PWRrppdIOjqFL3zBlppO6m7VtRrol4cNeG
         7ujg==
X-Gm-Message-State: AOAM532zK7njGpuQHciTKE53ZkLTuXBDc0Z81O1bHjVcI7prpwxLct+z
        SadZZ5419gC7rTZ8O4S6tgfdoEkh0WnG7aH+
X-Google-Smtp-Source: ABdhPJz/DcsvtuL8T8dwhFh1dn+y1UcohlesbtecLLZ8Xj8y+X4tJwvdjbmMFWoHU6Dlh1i4lOoevQ==
X-Received: by 2002:a63:3fc5:: with SMTP id m188mr683394pga.20.1634678324313;
        Tue, 19 Oct 2021 14:18:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:4a4d:b380:2bae:905e:e9f1:2cb8])
        by smtp.gmail.com with ESMTPSA id d14sm146599pfu.124.2021.10.19.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:18:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zheng Liang <zhengliang6@huawei.com>, tj@kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, paolo.valente@linaro.org,
        yi.zhang@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block, bfq: fix UAF problem in bfqg_stats_init()
Date:   Tue, 19 Oct 2021 15:18:38 -0600
Message-Id: <163467831594.699544.8918304401816350071.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018024225.1493938-1-zhengliang6@huawei.com>
References: <20211018024225.1493938-1-zhengliang6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 18 Oct 2021 10:42:25 +0800, Zheng Liang wrote:
> In bfq_pd_alloc(), the function bfqg_stats_init() init bfqg. If
> blkg_rwstat_init() init bfqg_stats->bytes successful and init
> bfqg_stats->ios failed, bfqg_stats_init() return failed, bfqg will
> be freed. But blkg_rwstat->cpu_cnt is not deleted from the list of
> percpu_counters. If we traverse the list of percpu_counters, It will
> have UAF problem.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix UAF problem in bfqg_stats_init()
      commit: 2fc428f6b7ca80794cb9928c90d4de524366659f

Best regards,
-- 
Jens Axboe


