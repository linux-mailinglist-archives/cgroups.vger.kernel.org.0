Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B1E68C8E1
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBFVn7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBFVn6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:43:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3D9ECD
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 13:43:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so13658533plo.1
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2KoQmbbXyDx/bLAsXkkqphx6KuZ7jSdX0FUGjC/cT4=;
        b=H1NKvYLM1eScv9Dqsa3OJ7+ladTqCD1+KAlq80Yb3KrBfF0JL2uAillw/F4XtL6q7K
         TUv7ChSi+dv61J/q8NYAMwjOnu28D7BJI0cxPh99jQXWbQh3SOy4XfN9M/aud8PMKh+K
         SeRYk8S5kNLheRyARIKDOcfvb/hODJ8ZyJiEVokNfCfTjcAzCVVZoi5/Qxqc7XmQWYur
         4HGUuijL02ne5KWfw5o3gSXRIpxIaclA4Vtt2N+SIoqbrTtQBOZvnpmMfxHZ+kgg7Brx
         NiN2WkDSbVRsx4w/3UjbvdICFiLHR1QDk/ImXlBrPwFU2PIGwvTgqzhWGKf+O/5bPM6X
         e31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2KoQmbbXyDx/bLAsXkkqphx6KuZ7jSdX0FUGjC/cT4=;
        b=O0K+jFhyyDAU8N/EQgXajH5zkU0XDoBwISxp3jz2m6kJA8jLQw40E0bkfl7A9NmXsf
         vB7LrLfYZGUrBjGlbRzpVLThyWvzHL4mCeo4WGUt+0yznaTeSh4VbvuYkrX8jzadN/Qk
         LkSNjTLMOHrlzp7Zl28Qfep30rjAD94//a2HVULZmiZE8QLPlpDM8vdOVG4CzztHNRxm
         Sbm4JmfxhPwcclSJYvGMQHRgh5yCPaEkhTY1HnHF1FTSyalVi9rHFLJ7WYCAiAGKw1cF
         vyiyQkqyXdidmbbYiIbm78CxUBMwBpBJ+QCLOiQFShiphsfwHGwBcBBoKjxxhuxpHBoH
         osYQ==
X-Gm-Message-State: AO0yUKWLg2+26BOXJQaTjDajydPTa4ymoG8oKueJZ4E+gaQEjGtjkZyl
        4VpT0+tA8SJA7v68n3GI2RM=
X-Google-Smtp-Source: AK7set9pTdL3az36uE/bMooIv5vh7h1s7CamjdrOBNvSU/0UJIZWKsjRnAaxi+zzJGnbmPEPWB384A==
X-Received: by 2002:a17:90a:f2d4:b0:230:d3a1:ba03 with SMTP id gt20-20020a17090af2d400b00230d3a1ba03mr1051056pjb.43.1675719835590;
        Mon, 06 Feb 2023 13:43:55 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090b018c00b00230d3a94614sm1288355pjs.45.2023.02.06.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:43:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 11:43:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Ramesh Thomas <ramesh.thomas@intel.com>
Subject: Re: Using cgroup membership for resource access control?
Message-ID: <Y+F0mXS9z0flDhf7@slm.duckdns.org>
References: <Y+FvQbfTdcTe9GVu@agluck-desk3.sc.intel.com>
 <Y+F0NA9iI0zlONz7@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+F0NA9iI0zlONz7@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 11:42:12AM -1000, Tejun Heo wrote:
> The flip side is that on vast majority of configurations, cgroup hierarchy
> more or less coincides with process tree which has the benefit of being
> available regardless of cgroups, so in a lot of cases, it can be better to
> just go the traditional way and tie these things to the process tree.

In case it wasn't clear - use the misc controller to restrict which cgroups
can get how many but as for sharing domain, use more traditional mechanisms
whether that's sharing through cloning, fd passing, shared path with perm
checks or whatever.

Thanks.

-- 
tejun
