Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B414628C23
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiKNWdJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNWdI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:33:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5919C29;
        Mon, 14 Nov 2022 14:33:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15168837pjc.3;
        Mon, 14 Nov 2022 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIJKU3snVyxC51xALky4cDkfvZqf0MxxVPDKQ4SpbaM=;
        b=cGgiYL1iQ3flF9qgaiwC8/imMygH4i4SkDvcr3Uv1pcmQTiZ831dBIi+RfFltRLjj4
         2eMZg/7p692+E6KZ0LD+7MJ1PRpayG6hnwOR60/cUy8SZgHdSElBkmrK3vbkJTizI65d
         nC0CQOIIWzTWQ1xd7FtWzKPvJBEscIHEtq2dUhUq4+cK1SXjUQboNqEczXgT6+fYl2kP
         n6PeSLBBoYOLvGg/8lTduzwXAFBSAkfrtC8BQWs7ZNWeftMYiei67ELaxUkuM8S6Zau5
         NSZsedzOCdZsgoEk3YMKdbUSmcX2Si6Q++vm2vArD0n7kkj8y1tBVYf26A+A4BHprIi7
         DvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIJKU3snVyxC51xALky4cDkfvZqf0MxxVPDKQ4SpbaM=;
        b=b/zulA3rGip8rSWjsD1QK/2nZIKuapMEIZbY32WwSgtqKqHOgUgqqTWUXvdx4+Hff3
         gMSCGz7O7RR41G0lan5gBJobJGEucBEL9aTliJPF4A9BfSC9rotIteT3DJqsXI2BPA3k
         WS+14lZCXrV0SpazoXVv3TYfmAecTYXQ4GilwYFwdXO0o23FztXJAPvBHMAxIyvt0I94
         23Z3qczLIJqTEy9IG6a0rffxu11GkSqQJNVyOSUJnUYjnPK4lxkrNpgctfg/SHVsq09t
         fgp+6Cv3ewVAWiH/X4uljZkbB9YgKbyRLPJKg8PTe61tyfakVuiAn7SIM+SF0gxbKdq4
         CIkQ==
X-Gm-Message-State: ANoB5plwpnALbDyo4oezTwGFJxRLO5kTKuuVttbKcZWx4DLEPdD5rbaw
        GBCzWwUTiDROeRIhQV2LDeg=
X-Google-Smtp-Source: AA0mqf5SHS7HyzEIX+JCzWeJNCANcTUXTOXrfzdDSdJpKG9MyX8PpVSa7pEtNwoGNH3UQhG+LANJNQ==
X-Received: by 2002:a17:902:9b83:b0:186:5f54:18cf with SMTP id y3-20020a1709029b8300b001865f5418cfmr1159977plp.141.1668465187619;
        Mon, 14 Nov 2022 14:33:07 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm8094932plh.158.2022.11.14.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:33:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:33:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 21/26] cgroup/misc: allow misc cgroup consumers to read
 the max value
Message-ID: <Y3LCIutS6JqgODFG@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-22-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-22-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:26AM -0800, Kristen Carlson Accardi wrote:
> The SGX driver will need to be able to read the max value per cgroup
> to determine how far usage is from max. Add an api to return the
> max value of the given cgroup.

You can add these helpers in one patch and I wouldn't mind a downstream user
just reading the field directly either.

Thanks.

-- 
tejun
