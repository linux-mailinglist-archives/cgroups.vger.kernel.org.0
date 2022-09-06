Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC05AF480
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 21:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIFTkA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 15:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIFTj7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 15:39:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936792A710
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 12:39:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so11545401pgb.4
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=nlsO3qydHURiPESopIov6MAWpclh/6/lYNHj0fbMC4I=;
        b=F95JAOTLsk80DmB2KeBQgUrMKsGMMDbmiSIJ2kqa34nWGZYTBl8qput1L3OvMfrpT/
         7wYPdbsd+Fi40BVF+9zcjae67Ef+gtoJ7K6An5VoNJVwtUs/3vKY7r9si0wn6Selg86T
         DBRnMRgfYKDRb/L0N3PFfwW7IpTNqxBruOrLKYXsw2n2fzKSff6w6vJ38x+Sn1Bq3cob
         GCBx+lymS4kLxe5VAN5g/DsGnOUu6r31+icQfgTovFcAXY0CPRiJqH5TaKIjKZQFi9l4
         chRU/9Dw9ZWxxkhxSrs/MNuKS8DxxTL3JS7U3VFBaiihZtzSKNCh9C/0AM8DkLmfOYZx
         vL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nlsO3qydHURiPESopIov6MAWpclh/6/lYNHj0fbMC4I=;
        b=n/GhDHcXBNcF8y86IUu0N3412FgzTwjsxM0kNEcDmpxQQHbJfW4t0WmjlEpglYeX9c
         0qR43m2263ozDspygm1kmQGNIwKyKD7krkWcpN8xE4/sJa9EHA4A7SuC7U7QApyU/Ud4
         YZh0FgIn/QRithxHcSXkxRxQQTWVFtTUO2bZ1LpMdiofkcGZCBNMRE5DYZPd+Cz4aGEM
         VCybkGoDdAAhXh5T+uuEEStGkqI3hF9bgQq17Y/N8rHuk6sfpqmQnyBoBLI1nW5znKqe
         +DjE0RgdOWPs5bZrcFKOiC9cxWbdhqBSEhW91CtJ4u6iD17TO9CCxJvipt982OGDZWZT
         gULA==
X-Gm-Message-State: ACgBeo1VB57+1dUo7uSJmRyLbPyumPfunaiNGwNVITDSw19tMzEhniih
        X+fIBcu7RnDcATuLK+PDqWE=
X-Google-Smtp-Source: AA6agR6QSdOFGOEmMBTU1S8RKHTCHjPXZccTb6DxOCdvdLTMUt3WKSwLTu/+TVK+F19KOYZauIuMJw==
X-Received: by 2002:aa7:838a:0:b0:536:101a:9ccf with SMTP id u10-20020aa7838a000000b00536101a9ccfmr61689pfm.18.1662493191998;
        Tue, 06 Sep 2022 12:39:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b00172b87d9770sm10351158plh.81.2022.09.06.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:39:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 09:39:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <YxeiBUwloEJu0lX9@slm.duckdns.org>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxUUISLVLEIRBwEY@slm.duckdns.org>
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

On Sun, Sep 04, 2022 at 11:09:53AM -1000, Tejun Heo wrote:
> Let's track whether a cftype is currently added or not using a new flag
> __CFTYPE_ADDED so that duplicate operations can be failed safely and
> consistently allow using empty cftypes.

Applying 1-2 to cgroup/for-6.1.

Thanks.

-- 
tejun
