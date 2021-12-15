Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773674760B9
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbhLOS2l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 13:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLOS2l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 13:28:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F0C061574;
        Wed, 15 Dec 2021 10:28:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so293613pjc.1;
        Wed, 15 Dec 2021 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9xKB7125uY8kvHBhF0BhgO3Irg0Ekzdpi8lSoaB3TU=;
        b=CzxiwAxOnRR49YKD5qgwaxrwRc7E6+GE1H/V6hV55mvovKfwUDglOhPkTSxG/bPWyx
         f1dy6m1pSoAqHSC19ACg+Nm2LZrL7y1EOt105wfURgewtPi2sFVOG4di3yocH26zo0Rp
         3CUlDHSyIxrB8yXASXHxzCRH8h6aMpRMbyJIDlVxeB6tnbZSfu/tbGOgfHqKtlppcACl
         dY4aJcoZTt2RuFkFdOSX+L14PZdS36Tw1Z+EygnsRF30BUe2saYDD9aRDXjRAhitDKDt
         rY0w3veSgYUdpcuMh8iRqCMsYlgstAUIfHlns1cHA4vksVynPV6n3r6OJPLX1lOU2HHl
         70EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a9xKB7125uY8kvHBhF0BhgO3Irg0Ekzdpi8lSoaB3TU=;
        b=MifX3r2Ku1/wQqR9GqH+fZOzmdYIshpHH0TYMGU1w1236vysfZqnRmCv5R3vST08N0
         WaMJ98jH7SKnsR4GBxdJS0w6B0s9UqaDeooxVgKp3DOBqo1byOIoij6SIc4MzSkUI8Ww
         1cdaWdxa31VRj+3I9xfVqfv3YSrrkI+SQkj4cTvhhdah7DgIEDlnQsUUtbSbWLrOBwx2
         FfLpeqGwln480Au65coj8Kj0PZsbqZpg9Nd2x08Crn7uF6EzqSq63AnGtk6hcE61DgWE
         YOV/2OcbcnkUcXmncmOc3EIgjVohCGfEcqkQA+cPUGb/KYTFD3siFYHNaF6u2Iv5YEHn
         FueA==
X-Gm-Message-State: AOAM530JiyzbVFE/wfoL5mJ/fx74p2X6crjnWmWtVieiOgE1cxmKegaZ
        kwdfzkTnTdklplEA8ZGzxWo=
X-Google-Smtp-Source: ABdhPJz0+ZRBBwHvu0SQpNmsKvuni6uIw89FwUOpqy+yjcA/ZcjYrinEZwC+kudJfiqYpuUVWGJnug==
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr1203219pjb.112.1639592920623;
        Wed, 15 Dec 2021 10:28:40 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h5sm3570824pfc.113.2021.12.15.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:28:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 15 Dec 2021 08:28:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf: remove the cgroup -> bpf header
 dependecy
Message-ID: <Yboz17Cd3NrdircO@slm.duckdns.org>
References: <20211215181231.1053479-1-kuba@kernel.org>
 <20211215181231.1053479-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215181231.1053479-4-kuba@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 15, 2021 at 10:12:31AM -0800, Jakub Kicinski wrote:
> Remove the dependency from cgroup-defs.h to bpf-cgroup.h and bpf.h.
> This reduces the incremental build size of x86 allmodconfig after
> bpf.h was touched from ~17k objects rebuilt to ~5k objects.
> bpf.h is 2.2kLoC and is modified relatively often.
> 
> We need a new header with just the definition of struct cgroup_bpf
> and enum cgroup_bpf_attach_type, this is akin to cgroup-defs.h.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
