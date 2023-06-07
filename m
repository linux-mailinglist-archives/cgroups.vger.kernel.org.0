Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89E7252D7
	for <lists+cgroups@lfdr.de>; Wed,  7 Jun 2023 06:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjFGE3t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jun 2023 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjFGE3S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jun 2023 00:29:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040B26B6
        for <cgroups@vger.kernel.org>; Tue,  6 Jun 2023 21:27:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f828ee8ecdso14805201cf.0
        for <cgroups@vger.kernel.org>; Tue, 06 Jun 2023 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686112025; x=1688704025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPSKz7WcmWYDoiWla/HjpfomHebC25lLZctCV/vLH4k=;
        b=YoflSz/WWxi5+uAGhkj3VOsHqFcBqNc2/nJq9qn0WwAt7+Jb+cNtwE/5wehV4e5iNw
         LjjKvgxxNAG2mjKSNdnhAogPK/DpK2l79V51b3G70hzwnsyGpAl4RrhLwcv3tJ9EDtTX
         vVyjcp9QiLM9j3NjPKw4mX51UiG2kxTthhPf1vSOoiLxBP7Z5S70RCo4rIddBPIKcOCD
         WrHV3kpK94KzFZ9ysDcqNaRe55bIxZC83YS8eiTw4bTv3rXdUcoG4vQY5M+7yfIm3Ysc
         rGcl9SfpUW26IMk3MddsmlZHEzf2u3GAR9oUy1X3y7c21uche6LUoeCWj6EjRoJllgRk
         zQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686112025; x=1688704025;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPSKz7WcmWYDoiWla/HjpfomHebC25lLZctCV/vLH4k=;
        b=DaTxSkkBkrL+eI6G+anmaukPnQP9PvFJQu/qQvMABAk8bluqOhQiOO2DkXapT3rwIX
         R1KYWhdW+T0JRYcDV/vrOoNQUR99TLbih9EAjku3Xaipl87zf7+1AKaNwOfK0cJ6p62p
         Nn4XKxkUBJGKJAkhbYoXfhuLwguO9g7sAKOLUbQTFmUNYgmuCL16shh2KNiUlb+9BIi+
         sXHN331dQNYZzGXFx+MUjJA6iswgrAt2/tu0tFRAy+Gaa6GSyvgP7UrfNiutByAoYzDn
         YofjcrBfxJKlHwyFktf5sP7F/eRsTU3eCOi0K0AMmZw6nDCnWiVhdVjbSeYT03a0sQq6
         Lf/Q==
X-Gm-Message-State: AC+VfDzFT3yENsvreOLQcZuWlZKJlbKJtxEcs5fFOxPc0qszKETKXuGK
        bsSjhhbi15skZt7oFQm+ulqD6A==
X-Google-Smtp-Source: ACHHUZ7NSTxdF/ubgwDQxb7ez4TU1x57Ynb13u73yomi8AoMLRBZYFeKffKYiqjTywUrm5xkQXX/YQ==
X-Received: by 2002:ac8:5c8c:0:b0:3f4:fdaa:8e14 with SMTP id r12-20020ac85c8c000000b003f4fdaa8e14mr5856641qta.2.1686112024916;
        Tue, 06 Jun 2023 21:27:04 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id l16-20020ac81490000000b003f8685c403fsm4369867qtj.22.2023.06.06.21.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 21:27:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
In-Reply-To: <20230428074404.280532-1-houtao@huaweicloud.com>
References: <20230428074404.280532-1-houtao@huaweicloud.com>
Subject: Re: [PATCH v4] blk-ioprio: Introduce promote-to-rt policy
Message-Id: <168611202214.121141.17298993524876974749.b4-ty@kernel.dk>
Date:   Tue, 06 Jun 2023 22:27:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On Fri, 28 Apr 2023 15:44:04 +0800, Hou Tao wrote:
> Since commit a78418e6a04c ("block: Always initialize bio IO priority on
> submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
> blkcg_set_ioprio(), so there will be no way to promote the io-priority
> of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
> greater than or equals to IOPRIO_CLASS_RT.
> 
> It seems possible to call blkcg_set_ioprio() first then try to
> initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
> for bio in which bi_ioprio is already initialized (e.g., direct-io), so
> introduce a new promote-to-rt policy to promote the iopriority of bio to
> IOPRIO_CLASS_RT if the ioprio is not already RT.
> 
> [...]

Applied, thanks!

[1/1] blk-ioprio: Introduce promote-to-rt policy
      commit: ddf63516d8d37528dc6834c7f19b55084e956068

Best regards,
-- 
Jens Axboe



