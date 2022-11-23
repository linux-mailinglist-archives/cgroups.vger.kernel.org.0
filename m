Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336EC6368C9
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiKWS30 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbiKWS26 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:28:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C7A97358;
        Wed, 23 Nov 2022 10:28:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y4so17405327plb.2;
        Wed, 23 Nov 2022 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeXP11t/+0yLhKm0StolEpyltEEHuq6W+e1tTErqQaI=;
        b=OO3acBF/AxFG9PvE3FfXDejXXULUCcDhFYGrWXM8f02v5B58SoZCg5HBB98r+jNnwD
         Qz+NUoxIxl/Eg7QNIfdgGeIxRVNwSO7xs37P/+J6Vi4UyN2jfq5LHnbwJM4Sydqvam6+
         heP0Lvyl2RfOftV00QuromUhSzPtd2zQ4rz3TNfcJv2gDAJolfN/yK53qd+/WJtf0LB4
         94BQOHf5IMg90I6b27Rrs7dm5xiYAlfbCOhh/CfGrNBFmnOTCbxiXZCessgimQYKesXZ
         EZ0yCCF3X2lypZ7NwzHg1vBIPBTriuuMqWkNfg4dfCh758tkmQhHw/QX58nbKy8HelQm
         uIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeXP11t/+0yLhKm0StolEpyltEEHuq6W+e1tTErqQaI=;
        b=uxAc+BvcC2BI62zKw3G52Aa+/6Rutcu7ou4IPYWbw/Xw1YIfkgZ2kFgvOv4nvBE5jb
         QA5U88x3sbrIMzEJIpQ8U63vEm0MCppIi9LF/J6wH4kFYN4y5F7+M2AM6hqkEsNRlz5o
         0UaMaDDcUratSjQMaJ0uT4Q2K4zkQIgF/RBCMIk5tFRoXB26GFz1cdmMUYmq4/2bEA62
         6QSh84YLiNMLovSBhsSFZugcgUBdPNKlICYIludTU7biUpAbcfV99YGZJ9QPGPOjdNcQ
         LJJNN8d4TgjK1ieZmMHvbrDoO+cg6Jg8ERARzlZNKb9tD7wwILVhTHrA+W6j8D/3FU/z
         /krg==
X-Gm-Message-State: ANoB5pnJJvrz6jDKodvGPdpVZJFQ1B8fYi+hy7NibvMNE436IDSEapFw
        xx/c7RzMKcKLP0AJjQFGykA=
X-Google-Smtp-Source: AA0mqf677qi+OR8ze787bk+49oIsafVTAux+aItt91jTR7n4sKuIHMs3PG/M1JQciezYcIgQxOLYiw==
X-Received: by 2002:a17:90a:2b43:b0:200:40a2:eaaa with SMTP id y3-20020a17090a2b4300b0020040a2eaaamr37620844pjc.68.1669228128497;
        Wed, 23 Nov 2022 10:28:48 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79543000000b005633a06ad67sm299883pfq.64.2022.11.23.10.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:28:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:28:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] blk-throttle: remove repeat check of elapsed time
 from last upgrade in throtl_hierarchy_can_downgrade
Message-ID: <Y35mXymUTC1lx50j@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-9-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-9-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:58PM +0800, Kemeng Shi wrote:
>  static bool throtl_hierarchy_can_downgrade(struct throtl_grp *tg)
>  {
> +	if (time_before(now, tg->td->low_upgrade_time + td->throtl_slice))
> +		return false;

Does this even build? Where is td defined?

-- 
tejun
