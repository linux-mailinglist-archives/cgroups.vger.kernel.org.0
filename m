Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC73647412
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHQUQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLHQUP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 11:20:15 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70296AD9BB
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 08:20:14 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z9so1203988ilu.10
        for <cgroups@vger.kernel.org>; Thu, 08 Dec 2022 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rgqBZ3uFNI/h6T8HpUKkmoQedKjgYsWFROeZ8YebM4=;
        b=vqBtQLqW+3MVCuOlb6qXeONN9af1mNtua+frx9RZmop1vht1R/RvkDRCPWV4UpgcdI
         wM3J1ua5XNHyWSunTTkdCvZiReucRWu8u+N6Bx1L9mlXLC6yFuuQtIdR4ez+VDBMZvFj
         om422svafQlJ+atSNFNXBEjfDWBsSm/XMYQvmUSw+GItcNCcxmvF3jsiEeFdLZOOgm2h
         5bGl92+9PVAK9yfiQ8z1UtSju8kg/reXrvTrIimAgyFpG/k4rsBNMH4IWvonGwbxQKzx
         eUICFsZqtRmmswI3ZBbPaEP9LlvfEqdC/u0HAGt4SnZJtCykAFQ+QU745Y763IGg20DV
         tWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rgqBZ3uFNI/h6T8HpUKkmoQedKjgYsWFROeZ8YebM4=;
        b=jG3fEjDfdm6TZSFKrVnx4oDb6UOXaop8ohzgBpgK//MwC1kJvff4JkrWCEuZYnWBdr
         v6SMwD4GPtQQRd6j70WXZjTYV5rot1Zj+IClA0ztbXq6BPKRblxUXe9bcHcXb9MOqqUv
         4DQWCk7sRzdw7fC4h6d3YKDuy/sXKY31apU88bSP9WZABCi0xFDrEXD6ekUWfVIpbg6X
         mWz38zvgQzlKLAm3m4YI6NIjMdz62MwEKP0rNJoK99g5NdB5qdKtepDoXg5WpHaIylk8
         k0rM876nzrX3CY/gDLIacsYG7i6HmUlIdjvIuOZhLBrrzVnJcUFejnUweMyEqP3r5XZY
         4cOw==
X-Gm-Message-State: ANoB5pmZ8yVrUi5qGN6SjkNdIy89dnBoUcZbI9sPIdli4ywknyl/lmP0
        DmxiZaKerVnBFZIJ3oz9TQVWkQ==
X-Google-Smtp-Source: AA0mqf6ANJIg3cGeVXRosWTci0yfZhHrF8RANqn3bKkZRC8nYTCUvwDGuf1VdQ6IsvDW4zo9akGSyg==
X-Received: by 2002:a05:6638:2708:b0:38a:66d5:871c with SMTP id m8-20020a056638270800b0038a66d5871cmr4129841jav.199.1670516413755;
        Thu, 08 Dec 2022 08:20:13 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a10b000000b0038a5083cfa7sm3573087jag.88.2022.12.08.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
In-Reply-To: <20221206093307.378249-1-shikemeng@huaweicloud.com>
References: <20221206093307.378249-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3] blk-cgroup: Fix typo in comment
Message-Id: <167051641300.134647.14873607646556634784.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:20:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Tue, 06 Dec 2022 17:33:07 +0800, Kemeng Shi wrote:
> Replace assocating with associating.
> Replace intiailized with initialized.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: Fix typo in comment
      commit: 37754595e94779db869e6ef803f038fa956d08ff

Best regards,
-- 
Jens Axboe


