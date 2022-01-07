Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5A487EBF
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 23:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiAGWGQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 17:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiAGWGQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 17:06:16 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D5C061574;
        Fri,  7 Jan 2022 14:06:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f5so6596031pgk.12;
        Fri, 07 Jan 2022 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tn3eWO9zz8sRJIypwap85PQFXjv9Ix4xcI+tN55JBrE=;
        b=PFm4tFrOfDjDZHQWcN2Kxn/K0Sg2LubhX99OruFwoZADzE1tw8uJXWa2gym+YCUkZq
         upwonpi3EVVTBNDD/of8XpfOHtku8uYEEsSg0Bw0B/oXUfnFoLHmv5thWYo1nZq6/4Xj
         chKi+Hz3cCiZeRfB0t9D6xB/2qkPyIdOmOboXQA+/sfYfthM08j2zussz5D/vVc/45+R
         vJ13VoBaYIjf8XgQM9zTbGp4Gic1dM5nxI1nhTcG8qdorrlp8CO5he1PtX5Gs/a4ofGJ
         Fu6H8vjM9VDT6KAvrNiWfk2+Lwm0P0JyF/C0CSldXnt3Qv5hAdw34WLuvjmm4qdtV/I5
         DhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tn3eWO9zz8sRJIypwap85PQFXjv9Ix4xcI+tN55JBrE=;
        b=3+Wk47RGYCG52myyJWSswq6c9YRXhR3M/zvObRco5petorukgamXKDjqS8Kd3PYBSD
         wpzjHOWBg4BEd+YZ2fdCAjq12+rSXCa7TSQm5JWS/2ljTB/HKiRqaRl4WKd6IBTHgqqy
         z8Mu2sHyoAVCM0hnglHBBOvah2NXH8QAlu96t42qD7qu4zbKgSffcIEzUPMkh2ZmjV9B
         aVXJHMlK3Ow7oghgOUHxd+WawXGM6yi+RZWwajGxKTTsA+LtGzsiS8g2vWjO/oHCgrUZ
         oXiHd7B+plDhIVffl/FO2hF5Ps/hR0jfoHJND5nUgugPMx6cSP3irwg0+FXqutt86Xtn
         Sinw==
X-Gm-Message-State: AOAM530/QngJQ+DgMEY9xw50huTSBW1fINO97kIwJS6M6lU3alNPbnxU
        5MJUt+fn+6jNJcpuo9iFCHE=
X-Google-Smtp-Source: ABdhPJxJFMX7ieZqKIwoYK9S9/VgibaX9Zx5SJ0CG8ADu0MfzfhAJDflfNC+7G5H1MthjWg/4RA4XQ==
X-Received: by 2002:a63:657:: with SMTP id 84mr58033444pgg.399.1641593175217;
        Fri, 07 Jan 2022 14:06:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v14sm7368420pfu.14.2022.01.07.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:06:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 12:06:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: convert 'allowed' in __cpuset_node_allowed() to
 be boolean
Message-ID: <Ydi5VRmOm5e2Malb@slm.duckdns.org>
References: <20211219024154.28853-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219024154.28853-1-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Dec 19, 2021 at 10:41:54AM +0800, Qi Zheng wrote:
> Convert 'allowed' in __cpuset_node_allowed() to be boolean since the
> return types of node_isset() and __cpuset_node_allowed() are both
> boolean.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
