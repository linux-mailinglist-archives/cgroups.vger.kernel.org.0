Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7D7B8CE7
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbjJDTKb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbjJDTKU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 15:10:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690FE729B;
        Wed,  4 Oct 2023 11:59:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5ff5f858dso704975ad.2;
        Wed, 04 Oct 2023 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445964; x=1697050764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1hvqdbML9jmUrBMXlybcpZa1pczZCR/HKc4A1lMQgY=;
        b=EXj7eEauLHNRVgPNSHL+gIZiflgb0o3nF9Yix91EZSPGjQzOHJSk0QJonjOexxoi51
         FCnUlG1hrb7r1EGPFx4mo2OzpFvjqXLuqwhSFMagbVilzov51KePeNeYKnTjXzXedeJG
         eo9Q5z56moM3WP/zxoawmkjtOYPCiiwR3oyAk0CacLp6mKHQFTW2lkGjURUYW1D4OUDp
         J0SKiyDbyBa7OwNTkCgTA4I5TsT27Up293x/5bBIa2/DUZElpL2YNfbEizrcBccty8t/
         TMe+UOJvLjqjseVSp01wT37ada5k19Gd3LygWeizvVQfG0YoHMI7x9KPiG/ZmZNM9/WV
         o3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445964; x=1697050764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1hvqdbML9jmUrBMXlybcpZa1pczZCR/HKc4A1lMQgY=;
        b=P5qD+VeBQU3bHXJqzdYcVZJ1EUXxqzCUYZO3aFA6GJieZs9+l9lw7rPkEXzjObPFgw
         L1j2u4uiVNIPUJlRfZTSSVuQrvBj+MWlpcaB2SBuOWM/CbH/45TZCGso1ANiIYda2pVi
         czSpQ47sTr9PXnCeLONNg5rAbfFoUurwlUwpIxT9KkV4v0vuDgv3CEm8TmAodOpbF2PE
         ZijU++PPxrfcxdhl2BXUP8hLQ/WlGesDbi8A0Ki66m394nDx6PWVU7whnYxIfSNxu7Ei
         M+3KlymH8zrTtXcY5GmlJPo1NXrvSkHEMVx4lhJQ0qSpE2r+JtIvpERfqcm6T0MFSdRY
         ai9Q==
X-Gm-Message-State: AOJu0YwpuZP47dfedcidOgJDGvM6TR052gbOeQg7gnPGiBsXG5Ujb1cP
        68J2c7mrFCvheZcWNjtWb9o=
X-Google-Smtp-Source: AGHT+IG75w5n02io1w2XgbjxayXe88gCBJkiBf/LNuRQyB6rWxM/VHoLwG47D/pBOW+f3fVlwp6+Wg==
X-Received: by 2002:a17:902:c40a:b0:1c3:a4f2:7c92 with SMTP id k10-20020a170902c40a00b001c3a4f27c92mr3777226plk.65.1696445963644;
        Wed, 04 Oct 2023 11:59:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001b891259eddsm4071184plx.197.2023.10.04.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:59:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 08:59:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        kamalesh.babulal@oracle.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH next] cgroup/cpuset: Cleanup signedness issue in
 cpu_exclusive_check()
Message-ID: <ZR22CYkZCv52AmML@slm.duckdns.org>
References: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 11:58:01PM -0700, Harshit Mogalapalli wrote:
> Smatch complains about returning negative error codes from a type
> bool function.
> 
> kernel/cgroup/cpuset.c:705 cpu_exclusive_check() warn:
> 	signedness bug returning '(-22)'
> 
> The code works correctly, but it is confusing.  The current behavior is
> that cpu_exclusive_check() returns true if it's *NOT* exclusive.  Rename
> it to cpusets_are_exclusive() and reverse the returns so it returns true
> if it is exclusive and false if it's not.  Update both callers as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202309201706.2LhKdM6o-lkp@intel.com/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Applied to cgroup/for-6.7.

Thanks.

-- 
tejun
