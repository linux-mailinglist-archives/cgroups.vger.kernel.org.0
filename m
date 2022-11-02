Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603AA61649F
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKBOMR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKBOMM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 10:12:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405227FF7
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 07:11:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so12510368qvq.7
        for <cgroups@vger.kernel.org>; Wed, 02 Nov 2022 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Km8d07l+If3latZbcnno8TWKH4LLZv0VkyhOoXFA9PI=;
        b=3K17y2wDCpq6CGFi/JqscdFCZwJGvNNaM/UrrmYofJw1wR3fGyOhi0rlaMmUvngM6N
         1krgS08m59z2fr/guD+Fxxlexzk1wWL4DDBfFKhfYnmJzVrUGe1X4SPy/ewT8BQC0GfG
         cyN/fTXQ6bcPNPSW3tnZyUIjkUqa1IflSfWNU57n1QgVF2Pfb/1krse6RRVC5tWKohru
         eaMOhLitbn3Pvl2VfFWMFZMYpBalV/17Mrynnzxe6BuDm4NHgpy96rb9Ta41d8fsSuYQ
         4HSWJFbdNieK8n5myVnk2FIvFji3UCt22731b4pIAwKKstvvQJ57GK52yWp62ipKzz8Y
         WCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km8d07l+If3latZbcnno8TWKH4LLZv0VkyhOoXFA9PI=;
        b=npdaZLFs1GFSIqHMbYKxkUv4GCiJm3SJ6YJmv3Vdr5eqGO/1oW9BcJSFsLUdX+Mp7l
         DEC40z12TbNQKwZItocxWtQ+MKit92N/1UTvI3qeNhh09WhXcivzXUm2hgNOm1pilXAj
         Lta1JTm/OJJPs1xeZvuLQcCINclG45m4XilylQbM7Ax82erv1/CoqKpFYmg+UaUTifX1
         Ynm1hhVzVRIsHDsI1A1HeCY+tciFtoEjjGOIiLV3nNmEdQSMH9jshiegdoJER2fdPPpu
         t6XwescxiW0MAxy89TtV8nuaGanL2uEIujlNxGSpP+jIDpjhXR6u0pN+La+89xWVYJYz
         JCkQ==
X-Gm-Message-State: ACrzQf1I9sEbr2fij179bzqKEWlkdnQSHwFtCtVLgVA8Rbk7lxugTDmr
        GnC2EbB6ItFiPmk4+8plQGibyQ==
X-Google-Smtp-Source: AMsMyM4K1A4U/HfQlteUYmVSAP0jWa6eNflO23gy6GLcso3nCMkqhvxGSpQm+BcuP6EyzmHHwmrnYA==
X-Received: by 2002:ad4:5c47:0:b0:4bc:f84:da8f with SMTP id a7-20020ad45c47000000b004bc0f84da8fmr8748534qva.73.1667398314614;
        Wed, 02 Nov 2022 07:11:54 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b00359961365f1sm6524563qto.68.2022.11.02.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:11:54 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:11:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: Correct comment for scale_cookie_change
Message-ID: <Y2J6pPj4/aVdoGPp@localhost.localdomain>
References: <20221018111240.22612-1-shikemeng@huawei.com>
 <20221018111240.22612-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018111240.22612-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 18, 2022 at 07:12:39PM +0800, Kemeng Shi wrote:
> Default queue depth of iolatency_grp is unlimited, so we scale down
> quickly(once by half) in scale_cookie_change. Remove the "subtract
> 1/16th" part which is not the truth and add the actual way we
> scale down.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

This is perfect, thanks Kemeng

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
