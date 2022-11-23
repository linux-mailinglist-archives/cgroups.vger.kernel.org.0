Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD66366B8
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiKWRMQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiKWRLy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 12:11:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12919FD17;
        Wed, 23 Nov 2022 09:11:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p12so17218882plq.4;
        Wed, 23 Nov 2022 09:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwhqRAJvGavoaGuqSrfgQhHpNiR8ljuOsT2sziprE50=;
        b=kR4KehW+/5RtfQodotENKJN9+dUBrQYSP1Drnr1ELPapshjSBc05FeCs5WKFwRYhPF
         5/evnW19Z3/WuKviaZQkBgYmYVsWl54dhOH3YawdfFrVbiz2wuB0KlNo28H3ATQVCRRj
         gHOjfUzqr58hJitHQP3GkzeZasRkD9Cj71Pzok8i3r4muU/UqM93A+54CXeCmatNkCTc
         VVwar/ZCrszc0IepuyjwUKg1EopF2V0JjDJSy82HO2WVCWX/zuXTY8vHKCzL/J50PqEu
         o83KfGYbocXqlMkcuW3cugTYUWCoznHe9HubGFCHzhJRIq/KqnA/eNfF0C/L1x59QrhS
         H27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwhqRAJvGavoaGuqSrfgQhHpNiR8ljuOsT2sziprE50=;
        b=Co4yWGCHqdRzNHXe6DPgG7TVGF5q1GAmgzoZ+kYgacAGAXHSyGen2dQVDDRLqOSc6j
         YwdJuVpnzhFhYRX0q/mVEz9umXMDlKnrpO9ag9QfLxKf74e4RLvGlhqUH/HYE+IW+g4D
         4sCoibcD9wIuWtahKCcJRuYORAF0TG5P5udwDytUHl3PWKY3bdin6Z564NBREmJOdDwE
         3ENTlQaee4GpDgRCyF6ZSIGm2gvdudGDF8l0KZv+f6tinfIbYwI5AvUpo5Gj9ArTalGe
         UYonRkYWxhPUc8ItAINYA1YMNNNvr8RUoR62EEZ4riw8SiuvPN2I40bXnALvAUEJez3R
         CNAg==
X-Gm-Message-State: ANoB5pnWLWeuThrLGZTVhH+ZnzQFpVY0dtIeTxMSz2j/Q8wX1SYZnW+8
        FS3+DdGJpz4B0qoL5LaF+q8=
X-Google-Smtp-Source: AA0mqf7KjgkN0jHcAVsy1r3Y3omUVQzpCEPHQxo9NJVMwkW9jfSM32OXw9Os8zoKtYe13fyfd4lXrA==
X-Received: by 2002:a17:903:3311:b0:183:ee9e:4988 with SMTP id jk17-20020a170903331100b00183ee9e4988mr9331102plb.56.1669223511298;
        Wed, 23 Nov 2022 09:11:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a318300b00218722ecac2sm1646531pjb.18.2022.11.23.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:11:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 07:11:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] blk-throttle: Limit whole system if root group is
 configured when on the default hierarchy
Message-ID: <Y35UVRg0tTfsTdrB@slm.duckdns.org>
References: <20221123060401.20392-1-shikemeng@huawei.com>
 <20221123060401.20392-2-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123060401.20392-2-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 02:03:51PM +0800, Kemeng Shi wrote:
> Quoted from comment in throtl_pd_init: "If on the default hierarchy, we
> switch to properly hierarchical behavior where limits on a given
> throtl_grp are applied to the whole subtree rather than just the group
> itself. e.g. If 16M read_bps limit is set on the root group, the whole
> system can' exceed 16M for the device."

On the default hierarchy (cgroup2), the throttle interface files don't exist
in the root cgroup. In general, cgroup doesn't wanna be in the business of
restricting resources at the system level.

Thanks.

-- 
tejun
