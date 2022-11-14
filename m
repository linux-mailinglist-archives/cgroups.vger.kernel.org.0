Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7CF628C21
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 23:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiKNWbw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiKNWbv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 17:31:51 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C1F17587;
        Mon, 14 Nov 2022 14:31:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o13so11503158pgu.7;
        Mon, 14 Nov 2022 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5A16Ay9WyYCQmWvCX/jvqpdD2vUzvsfZOGGNVeLuVY=;
        b=TFl1ZbdlJOpsDfCgBjQF2vn2LxlHXUTAHsMp2CbR2TqdFWeND8Q+z+rRTpBQOrzdcM
         Jp+XdMQPArXvPAwCVtd9/KVVP8ONG/UHUUx/W9wYWi/dcJvXM2xw1eb2R6agutHbh/3t
         +gfQBflCAjwo+mSUg/ksCviOednjdYYfSsJ/u+0yOlO3wpmvckn4ybsMOUZ9gy2rGshp
         27kV4j0/706xRFvAhEo+S1bLasJ7wMUrn7xvMOBb2aZ/2+OcGwFG6qbjh/2g6PIOg91b
         h/SKsiQ9/FcfzwKurf/rFL8l86uH5Q00ZxRTgV3+9y/X2r5XRjoV+GCEGBbWGlZ5OOXf
         dkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5A16Ay9WyYCQmWvCX/jvqpdD2vUzvsfZOGGNVeLuVY=;
        b=5apPOibPAm9P0kojEGbnNp1bJrppXKxXrRiVVvDG21NrwlSWP0VoqLeWjhyj6J/7Z1
         j39D6lENHn/HI2gSeASgzAcvrcQMP03xGNSchr8VMQfX5yL1P4yxuiKwG3DyA7rPui83
         sm+4xGaMWf4XLSNR3Gie33s3LIgI1nTtgwxGpavhFmnGlLolXJxXG/wxGHRBWyqWbN4B
         xQS9UljIiShacaYvMoFt8VG9V5iJw7lz1wQlWACeB/wzNO7gQeL7MAn4je7CNNa1SZ7F
         Mx+zLqS/14W60JxEGD2XhdehtxtkxTjtpoM63s0IrUmKudj6SRoDLnopfjSmVLFmpdir
         63NA==
X-Gm-Message-State: ANoB5pkoLmfPze/PPMrB/CyKMMMUZod64cja17xdVv/KGkMPpQHGr4CT
        xp58mTNDeHoFy4VV5pBPCvQ=
X-Google-Smtp-Source: AA0mqf6qp2UMpDUKeTsfvWY3FJ/jqecldUlsZ8i5T1lq9Bh8RGN+bu0ldm69B4xyvTIldI/LdEc2QA==
X-Received: by 2002:a63:6205:0:b0:46e:9364:5d3f with SMTP id w5-20020a636205000000b0046e93645d3fmr13318621pgb.328.1668465110382;
        Mon, 14 Nov 2022 14:31:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d9-20020a62f809000000b0056bfebfa6e4sm7196068pfh.190.2022.11.14.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:31:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Nov 2022 12:31:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, zhiquan1.li@intel.com
Subject: Re: [PATCH 20/26] cgroup/misc: allow users of misc cgroup to read
 specific cgroup usage
Message-ID: <Y3LB1BFd/sOLsXzO@slm.duckdns.org>
References: <20221111183532.3676646-1-kristen@linux.intel.com>
 <20221111183532.3676646-21-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111183532.3676646-21-kristen@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:35:25AM -0800, Kristen Carlson Accardi wrote:
> Add a function to return the current usage of the specified cgroup.
> The SGX driver will need this information to decide whether to
> reclaim EPC pages from a cgroup.

This looks fine to me. It'd probably a good idea to keep all the interface
function names consistent with this.

Thanks.

-- 
tejun
