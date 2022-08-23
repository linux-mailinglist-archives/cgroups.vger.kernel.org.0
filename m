Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2159EC37
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiHWTYg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 15:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiHWTYT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 15:24:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5D137193;
        Tue, 23 Aug 2022 11:07:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso18013474pjl.1;
        Tue, 23 Aug 2022 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=zqj2sHtRyt3qxfs3B7KcWKedNnq53nEnQHSpLAsV5AQ=;
        b=cJx/f09Zo9shX7oJ81DbWCVKNwNypWdpkByQ67wp/tSrJdnjfTAp3sA7R2zQGA0v01
         eHYrj1LLyjvtpknIhIPVmqSBr/aRYZjERTqa3o7ZOMPAA8uR3aEEhQSrZIjXvS5UTx5A
         jDNQxJGfdlMwdKwheEB0XqTYFu6dgfp11ABsVuNDgCjj9TqRNfDa1Aqcyndh/BHRRKn2
         gqA+gtzhHp3CaQQOFdRKV46CFJZmd6C1sQb5s771PRbnKTSm/TMWocadgM/dpOsKAGak
         Xxl9KDGOALF/6MnaeYhCijrtzKBix/K/jlBIrzKwbm9qt98DSWf6kzNYKGF6AXv3D6+a
         +dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=zqj2sHtRyt3qxfs3B7KcWKedNnq53nEnQHSpLAsV5AQ=;
        b=Ic6aR56uD/TNogZpPj+zIUufBWkfyF9MLZ9VQS1AyyUC7LOloU4utMZlvcA2+CSYZ8
         hxtkfyBYxppP4QsmWTDXHwx1SpZlrCvOXFpZSpAJH9iBbs8XsgL8pn2dCIym81hodNPj
         bFXl6AjuuzZxO0eOgBqZ4sm9FvHAds9YCdXqdGZWspUbBk99WidW3/O1sFkqsO1/y8uC
         rPvqnuKG9BAfF6Ku2mMmu1m/++rsr43fOr6aGwUAc6glCt/QGz6yd2iBps+jJGFUACyF
         ttk7TBvpdJM4SjMF0kTECYkeFPOio/2pP7ErHWlsx7arKJ7mpw6oy9MQiCI4Og/L4dT8
         ojrQ==
X-Gm-Message-State: ACgBeo1p9bbWCwLBSWxyrTQsDC4sLNrFwAxJMDYH/veGZmvIm419EJY3
        vZcQtdxuehl8VTL01ZxjCUM=
X-Google-Smtp-Source: AA6agR7xyCc+cVrXmSBtLYNFKl49LeqUmUi1TENhxZZA56mROLhAyTX2MPBlj4Kpi/mzGJMbL3K0Jg==
X-Received: by 2002:a17:902:a608:b0:172:ffa5:2ed8 with SMTP id u8-20020a170902a60800b00172ffa52ed8mr4037206plq.164.1661278030481;
        Tue, 23 Aug 2022 11:07:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016f1ef2cd44sm10906311plh.154.2022.08.23.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:07:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 08:07:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, mkoutny@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v8 1/4] blk-throttle: fix that io throttle can only work
 for single bio
Message-ID: <YwUXTL+8E/sPcEUB@slm.duckdns.org>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823033130.874230-2-yukuai1@huaweicloud.com>
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

Hello,

Should have asked you earlier but with the BIO_THROTTLED flag setting from
clone removed, with single BIO_THROTTLED flag, does the fix still require
bytes subtraction? If we can do single flag and we don't need the bytes
subtraction, might as well just stay with single flag?

Thanks.

-- 
tejun
