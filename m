Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A056368D9
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiKWSax (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbiKWSa0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:30:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164833C6ED;
        Wed, 23 Nov 2022 10:30:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h193so17431353pgc.10;
        Wed, 23 Nov 2022 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyc2BTmrFAzthNmrP4/3H7t5RS3aYIyVMvaG95YYS+g=;
        b=Z6hHweGDCSt8n1bmaTx7zdP45Ec7KKpXEdG51XEVDX4zn+dUxBRWbAwmgNOXLSxxTA
         9bxdiYtGiGfM8j9USUbcollVRPtMnrnmknVPDo8LIQQiVRjbBLwWlG3BW9/gL6NhGwMd
         ZztkzGHTOn5T16nNqu/ISZQE5JwON4LcMxN4CxpWgt7DIZjdNn2cEYIIpZX90MDRZjBk
         HKTY0OlbzCAztF1O5EOYuxrTCfZ8YaLSrwSZ9Omlbpy1HGQU/jlZa//Rbpy7zA67uV9z
         LOy5115Z6MtjQEYZRZdBhEH5IIYGX9XJ6Rv1uEvktqgFCOozr0I9Lm23H0ShkjP7LlRj
         KN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyc2BTmrFAzthNmrP4/3H7t5RS3aYIyVMvaG95YYS+g=;
        b=g+nFXv6dqXR8M4zbtzd/YY6pjw/EIxk8UXM78R5JdvHTlRDI81WH+6gZGpHpybNLoh
         USSwyUy1fIciIOw2Mqh+f8s7JV+aIUk8IHLmYmUnmhUmvHOwhjhYn77MaSw7fCv6eChA
         mBmCMrUkHuA22xt8os9Wk9mZ1IT/xrqrNaG32j9H/1id9GMa5aiy1Yo9mfUa2DoNSXXZ
         5Dw1+6rjlrsGyUD+LaeZYb3NavsyrrHyIhqsKfm6tA+iFPzFYqNzkbIfH8oiSYakGH67
         dT7463/zDu18fg+67h6/d6tKstS5EhEQymoR0ufUvK5e6vKyOSw2dIfiw630mbYQDhzs
         WiiQ==
X-Gm-Message-State: ANoB5pmjb/m1MsFhchqgcO4XPUWXwmmwRaBx/xxwkr+N4EYwDU0BWV4A
        RiwErPBOLnvCEsxWjcsSDD4=
X-Google-Smtp-Source: AA0mqf5/HeHxVx+o+220mA1WhzN6j5K9fvTiT6P29MX1KBTtTcqswyCWE7w6OMNmxebWPUO6rzpI+g==
X-Received: by 2002:a63:e509:0:b0:474:4380:cca6 with SMTP id r9-20020a63e509000000b004744380cca6mr8352548pgh.229.1669228209435;
        Wed, 23 Nov 2022 10:30:09 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b00188ef3ea2b6sm14649671plc.262.2022.11.23.10.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:30:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:30:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] blk-throttle: remove unused variable td in
 tg_update_has_rules
Message-ID: <Y35mr8VBkdU4Ig6o@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-11-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-11-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:04:00PM +0800, Kemeng Shi wrote:
> remove unused variable td in tg_update_has_rules

Please merge this into the prev patch.

-- 
tejun
