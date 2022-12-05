Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2186435FD
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 21:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiLEUqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 15:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiLEUqM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 15:46:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA12AC42
        for <cgroups@vger.kernel.org>; Mon,  5 Dec 2022 12:46:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w23so11943154ply.12
        for <cgroups@vger.kernel.org>; Mon, 05 Dec 2022 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXyrpJdo+UCHtqk4rvzCMrlf12yHI5XT5NQfrdPusNM=;
        b=hyvU997fHxXAg5pMw5Q7EANvosZU2uDUChKMrapmNJSBQaDVC6u3v7umlxStwBzbzs
         E0FHXqjNcKiwKBWUtDZLau0zGl+mmk39gdLUIK333XcKQxRdP9fkLqdqVFoOCzc5OLAi
         dvxI82cc54kdeoVo9wjn5+eKQmUb3E9QvxmvzSWdwT1xVskE2Y9/EGenbJogom6FZMMw
         dfqLiDjFrD2pWVQ/vS+3I9rw5Zi9zFZrHPyFwFZWsHtozrm8iTpsRPfrfrWm9wfnzdhG
         J2PM6ul1d2Mj2z9za7R3PCMZr5idEWkstHcALa9ucoqKRhwiFZnjyDu8rOLCZdjE3poG
         1g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXyrpJdo+UCHtqk4rvzCMrlf12yHI5XT5NQfrdPusNM=;
        b=FJjyHseZPZhvUfLanXiyQl1rAxL2Ju/WK358Z5JeVA+4EVwCylxgkqQKWYTBUgONQw
         t5slv/ZwsxROkScWSgsj4pMAqlyMgUsNlHbv2TjQAUepMG6eMSt7fGPZlSIcq8P0oER8
         STZ9qpn6gD9ACuljHsXj6KtnTGLVxV8Eg78es03Ju5vrsEpXhXuTyuwrx0Cs3PmCWUoS
         9eqKGtBVKFEVX2NqUWOsuqLmIgzZx1oiT2CB2i7lDjFyGiNQmHdaVpNZbT2Lgiqme2WB
         uPQb9gNm9ad3+jSyKONEzwEglozRakk+w+zDwmT7ef7O2oFVRgehzT2tFSnYwNxWWHJ/
         SnLg==
X-Gm-Message-State: ANoB5pkfpgbd0UfsnD2DSh3raHRz0sGOZ3D6GtZ8CUXPO47iDElJ2Rrz
        FzZWQryiiGOo8KMhHiJ1SdlBWw==
X-Google-Smtp-Source: AA0mqf5NuVtxki00wyBlo9Q/hqZ/9WskPSkJgzi8OQhXjgR79B1nlfP1XysAIJKkIYive6WD4C0rkA==
X-Received: by 2002:a17:903:26ce:b0:189:c267:19cc with SMTP id jg14-20020a17090326ce00b00189c26719ccmr15204721plb.101.1670273168440;
        Mon, 05 Dec 2022 12:46:08 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e8-20020a056a0000c800b0053e38ac0ff4sm3344135pfj.115.2022.12.05.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:46:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
In-Reply-To: <20221205115709.251489-1-shikemeng@huaweicloud.com>
References: <20221205115709.251489-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3 0/9] A few bugfix and cleanup patches for blk-throttle
Message-Id: <167027316733.161635.16505872806618790217.b4-ty@kernel.dk>
Date:   Mon, 05 Dec 2022 13:46:07 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Mon, 05 Dec 2022 19:57:00 +0800, Kemeng Shi wrote:
> hierarchy, corret comment and so on. More details can be found in
> respective changelogs. Thanks.
> 

Applied, thanks!

[1/9] blk-throttle: correct stale comment in throtl_pd_init
      commit: f56019aef353576f43f945fdd065858145090582
[2/9] blk-throttle: Fix that bps of child could exceed bps limited in parent
      commit: 84aca0a7e039c8735abc0f89f3f48e9006c0dfc7
[3/9] blk-throttle: ignore cgroup without io queued in blk_throtl_cancel_bios
      commit: eb184791821409c37fef4f67638bb56bdaa82900
[4/9] blk-throttle: correct calculation of wait time in tg_may_dispatch
      commit: 183daeb11de871b073515d14ec1e3bc0da79e038
[5/9] blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
      commit: a4d508e333829a8394e59efa06ce56e51f3e2b29
[6/9] blk-throttle: fix typo in comment of throtl_adjusted_limit
      commit: 009df341714c6c20a44dd9268681a8bff10bb050
[7/9] blk-throttle: remove incorrect comment for tg_last_low_overflow_time
      commit: e3031d4c7d2c5bff6b5944d61d4e31319739d216
[8/9] blk-throttle: remove repeat check of elapsed time from last upgrade in throtl_hierarchy_can_downgrade
      commit: 9c9f209d9d81ea67cd84f53f470a592c252d845d
[9/9] blk-throttle: Use more siutable time_after check for update of slice_start
      commit: eea3e8b74aa1648fc96b739458d067a6e498c302

Best regards,
-- 
Jens Axboe


