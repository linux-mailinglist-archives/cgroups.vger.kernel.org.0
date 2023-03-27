Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DE6CB262
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 01:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC0XcO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Mar 2023 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC0XcN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Mar 2023 19:32:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4C10B
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 16:32:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z19so10016574plo.2
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679959932; x=1682551932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzG4Gg7xIaFW9NxPXDSLRapeOggi9FCFkBSxpmUKMiE=;
        b=1RQxRkrglPTErlI0U/PiFpHVr5ejmrxc/OCGg1hCtIbIzQEPzIoej6lelnQsLX6CJN
         9Ne11OkFXot/OFpO24BTU2NOR7MS4njpY6Xg39tzGib/2x1QZ2AkTtw8U06PFpoAVpZc
         SB+YEmo2RrmJqS4l0dfcT1JZPITpV7qjbEkyEGjfn5pPFjvUIJY/dKngy52nILNPGRzY
         wWIu7d2U490aafBxBaBuoFnIhtDwujXLL0pM68Kh5gf40VN0fHyRduECcaISlzwrxNxC
         f9rU/aoOY5WGX4Txt7+8TpTgqw+vC/u38DzH5972BpvoBnjADwAC1nNhGMtjVPdKth4D
         jNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959932; x=1682551932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzG4Gg7xIaFW9NxPXDSLRapeOggi9FCFkBSxpmUKMiE=;
        b=Gb8OZ4YzRtPOsZTjWkuxGAZzDaNbjillGd0vpcXVgkgLecaqCJM84zje2ocVo/P6c8
         j5v0gK6kMcjLih7O2aDPKy/bDpI2C7d2xuf63AQUlwqhzzyrCDwCHXo8mauh6KrWo/s+
         yv2r0rpd4K+3oFe0NbbE8yV4AWXYQYbr5SVI1eqvjnweHp0oqJIyJuHgq0FPOJFQ+1Gt
         YzJJ142GdJoM4ycb/8+4fp0KNOtWIF/5g9L8k6jfVLO+SalutqCvHXOsIyhDR8TrqX4q
         8rc8CGQ7BmTAAD93tvvC2XrZfjZIW1uwE44ZhqK1rbxR1pJYG7hMO4SBA2g2iVyl62ls
         4Mag==
X-Gm-Message-State: AAQBX9eWWMSmbX3GD3hHGoJ636GtIuSaubDB7rNz/T9RLQL+klVW1hqI
        iucQ4/RegqmbclmaRMEZ3EsJuw==
X-Google-Smtp-Source: AKy350buONpdk+qgq/lSLy9K1gTrH1FH/VcbtGhAtCeKl9KQ/R4/YjoRmsUyG3Cf3D2ZOF4V+XZ39g==
X-Received: by 2002:a17:90a:c296:b0:23b:4bce:97de with SMTP id f22-20020a17090ac29600b0023b4bce97demr11502607pjt.4.1679959931763;
        Mon, 27 Mar 2023 16:32:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090a690700b0023d0c2f39f2sm4871282pjj.19.2023.03.27.16.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 16:32:11 -0700 (PDT)
Message-ID: <bfbb5ac8-60f2-2212-1ec4-5baaee7a5765@kernel.dk>
Date:   Mon, 27 Mar 2023 17:32:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 7/7] block: make blkcg_punt_bio_submit optional
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
 <20230327004954.728797-8-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327004954.728797-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/26/23 6:49 PM, Christoph Hellwig wrote:
> Guard all the code to punt bios to a per-cgroup submission helper by a
> new CONFIG_BLK_CGROUP_PUNT_BIO symbol that is selected by btrfs.
> This way non-btrfs kernel builds don't need to have this code.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


