Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C55AC65D
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiIDUim (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiIDUik (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 16:38:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9742F2A264
        for <cgroups@vger.kernel.org>; Sun,  4 Sep 2022 13:38:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b196so6482097pga.7
        for <cgroups@vger.kernel.org>; Sun, 04 Sep 2022 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=iXJZ4e881QRCBkDXXM7HwesUdR/gpeowGn9TKqyGYKo=;
        b=EVe3pF0/CsWQKEAWlyJR8pGHuTyqDH5LhBPIHI52FhmvSGeZmoF3+70qU2vWg4puDS
         eDbbrdY0wVQsgnumzEPu5kYfM3ADGbCtO2BVyn7rYWfASFda6rHWjiHf/WJy26hu3q6u
         oUbcbmvzEAzv2TK44hdfcBoF+XNG6S4EC86kjh/mcdajsy6fBJhRt1I1I9asVxkRLZgX
         U47AmIiNO9qOVTAs1+daIjH8vq1O0oEvXXxcSqP7ILnDnMJWuJqU7zXrtXuztM3nlM1r
         ysWvAwvu6userSDiz4sOgHSdePMQbVpOXw0X0gzvvmyGyVoyJov+DlWpfFpaL1D6jQp5
         BzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iXJZ4e881QRCBkDXXM7HwesUdR/gpeowGn9TKqyGYKo=;
        b=7R0ItYTbWpb9sOyq3x/RaZWBKR02C+RZa3prgro1fY4lPqIZvhZe4w2/0vUs98nXmN
         3iQW7/Cg1Z7HTVj73YVdG24G1nfGbiNdL3drk0BoNBlx1cnAOPlKO1YWr5Vof3FiWjlM
         m2fxLe6ID+17HSpgeYGggwdTg3QCN1C7SX50FeN/9Vqz0fpjpEBpS9IToLg4nH69TyzR
         w24BqXDxXNZuEqsqxiu5tz4xM0gX/LW9r4IS2NudCo6zSekGtkYHLsHZgEk07TCUaX84
         tcTjwv11jx1RjfztxShPuFmWLbQ8S4+ynRRlGLlyMAjAaozxz5RkthaIi+LBYCal4dRE
         uacA==
X-Gm-Message-State: ACgBeo1hW92RT1AwSnXadQ9kgGypyl+4sRE3jVaWDWGC9vuXMDHPXU8M
        rehbwudyZBrJrSAQKU9U07q2Zw==
X-Google-Smtp-Source: AA6agR5lALPVQPiuqCwoDIMTHet+6gm1yRs9GuAWYIRn12Bpsp1QiJOzt1GIWN9DgD7/grDldTjZYQ==
X-Received: by 2002:a63:cc51:0:b0:41f:12f5:675b with SMTP id q17-20020a63cc51000000b0041f12f5675bmr38320869pgi.69.1662323919075;
        Sun, 04 Sep 2022 13:38:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00174a4bcefc7sm5810156plh.217.2022.09.04.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:38:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yi.zhang@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
In-Reply-To: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
References: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-throttle: clean up codes that can't be reached
Message-Id: <166232391804.14690.3824114675220691549.b4-ty@kernel.dk>
Date:   Sun, 04 Sep 2022 14:38:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 3 Sep 2022 14:28:26 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While doing code coverage testing while CONFIG_BLK_DEV_THROTTLING_LOW is
> disabled, we found that there are many codes can never be reached.
> 
> This patch move such codes inside "#ifdef CONFIG_BLK_DEV_THROTTLING_LOW".
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: clean up codes that can't be reached
      commit: 2d8f7a3b9fb31d2566b24fd94d5a533f9322c53c

Best regards,
-- 
Jens Axboe


