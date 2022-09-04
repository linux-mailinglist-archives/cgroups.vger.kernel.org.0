Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710EE5AC615
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiIDTZJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDTZI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 15:25:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0711E220C1;
        Sun,  4 Sep 2022 12:25:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o15-20020a17090a3d4f00b002004ed4d77eso1248128pjf.5;
        Sun, 04 Sep 2022 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=vXBIjsLRZ8FiBLUcto9qpEu1lVOnihGBQ6Ve3aJE1jY=;
        b=OqJKP2Gt5ey7tjAktr/15wsBYApbFPipKi5BGFOd96+FL7FSCKa1YgpfPzsT6TAjho
         yeI+CpjbNfZc3egJ5vCzt/zmBNg6ErMLhd2oyeCSbWNoOao67ZKNYkfkphecFxjzYhVk
         tHXI07E62v40fdDQjeJxb2hDdG5yIzU6Pf7bBunpYAmC9QVPG7cHYo2774KVR/lIICvp
         YqtVVVxUhSKS6aUDr8/smybJ4oNCcHvX1bAwyweWL03Rbdvu7e2xI57D6GyQILyCDIo5
         01l5kPj/sZCQ5BNvCkG7ByiQ8LLCHy4kXsQPAm9HUE8tR6cxs+VfCb1qaPoOLFL+86i4
         i5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vXBIjsLRZ8FiBLUcto9qpEu1lVOnihGBQ6Ve3aJE1jY=;
        b=Fqx8GlDD9LMd/Z/pBRqQfoJlJg86oLwF97fqwgpaSfXiwgdDsEPfC4RhoOEvnGPY80
         o/Ua5tUPP51wkxtj62EI2UF5RKfMXF562JfYMkaSHGBNy01Jp1yejwRueVxgKwIi2sRG
         L96Bkqcnf2/5fQ4cxSJIjrF/kM9RUtbkjgFDHdeEQpTCE5uUB9iqKSJRudpb6r6ihR/J
         OEH7WOLct4tUOGhNVGVL6L/D6goscTXUf6doXn8zq9V13qGpHEOFy8gFBstCZ/pu93w/
         YvWlpno64yQQFFqYlNdrTPQLJJONuiF5DPDBDe4q+HRxTOcHWQ1vG+VgBSumTmVnfkjA
         6Thg==
X-Gm-Message-State: ACgBeo10moYbt2AuqKbYkjiXXEubJm/ekCeIjkQEJ/CNNWbCa82ArFm0
        SifG07rnk8H7BvO8Z3gJN7o=
X-Google-Smtp-Source: AA6agR4ZeqdW9mv8bpEXhWo/cMLQneDOCeZwB7mG88Yg3audiXV6ViCKidX8PhO6EiV3OnuNEd2uSw==
X-Received: by 2002:a17:90b:1645:b0:1fe:b8d:307c with SMTP id il5-20020a17090b164500b001fe0b8d307cmr15928094pjb.185.1662319505059;
        Sun, 04 Sep 2022 12:25:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b0017691807049sm2815285plx.151.2022.09.04.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 12:25:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 09:25:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] blk-throttle: clean up codes that can't be reached
Message-ID: <YxT7jwsIM/bUQYoZ@slm.duckdns.org>
References: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
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

On Sat, Sep 03, 2022 at 02:28:26PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While doing code coverage testing while CONFIG_BLK_DEV_THROTTLING_LOW is
> disabled, we found that there are many codes can never be reached.
> 
> This patch move such codes inside "#ifdef CONFIG_BLK_DEV_THROTTLING_LOW".
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

.low never really worked well. We might as well try removing it.

Thanks.

-- 
tejun
