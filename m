Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621D42C40B6
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgKYM6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 07:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgKYM6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 07:58:51 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0550C0613D4;
        Wed, 25 Nov 2020 04:58:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l2so1481681qtq.4;
        Wed, 25 Nov 2020 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jBninAlOvpYrGbFhaowzWy50Zpfu7elwWYRocqgCoUw=;
        b=RCltcKLUbOv0wiHSEWExJwFW+yO60P5UsIfxRcbymCTATMDcPJcEXr/KfMoSJPbDLz
         n7jLA1tZzTjoKOvnl8cl1kdXUSJH+fCvD/QMma/B76WYGPMw87AUriUpfyhNN2Bryl8L
         uDW7c+QxYiOV/CJLMr8rLlKxM4FcMxK2z6bBHlDRrjkCz05oUjMq9zh8SFRc1VkpeMyT
         xpw16qmlVImcO4t9m/lpP4RkAsNnCOT+sgTtxwHbOpzBgzroggmNI1t0yclCE3gUzNU6
         rxGXgn4Ruij2Ikjsizy16v/XpJb5wBXPLRMbUJ4UQSxJ1QwYinGYBrbkxGHXwiJEZlWu
         Flqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jBninAlOvpYrGbFhaowzWy50Zpfu7elwWYRocqgCoUw=;
        b=GEOPY5ueUk7K1ixYNNf6B9VSmMgMkQyFjuxD2mxqh8sEG//EseyUKTW7t9h3NrUYkY
         9/NiSZEkzZ8efK+gxwlxiMQD3WICLGxCJCDfiiyz4Razr5YWGP6YY2DOtarqjnqdqhG0
         ANp7eTkb76pXw5Gwqndpb3sQjoGEyR4P7oghZd6zp75g01EhwlE42RcU4Jl/fN4DrKbN
         HcHn3SSF/12BYuQENNGOraH7YwcLQFSB907MDMqgUVGttLdQqDPkAlHzpi8ftgYit5Cr
         /1OSRrHwfNvHT7jyq+2fYYbFP/LLI/Fh9j9Wv+dmENbkmHeSv9z4KDxgujvc6t6l2fWV
         IAHg==
X-Gm-Message-State: AOAM532fXYLxcHK9O5G3FMR2DSooR5IZvv+gRXDGnr33ff2qTef8Qggj
        B5owjBq3VXV8aAKFIi3le8Zq6jkLouTIJA==
X-Google-Smtp-Source: ABdhPJw4mQygHYPeh6LgduHGJHfbfpt1qFdgJmlNB2fbxViZkyLEoz3fP21kS6D/Ewn7xh6gZWvMHQ==
X-Received: by 2002:aed:3363:: with SMTP id u90mr2952000qtd.5.1606309130958;
        Wed, 25 Nov 2020 04:58:50 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id z19sm2272753qtu.51.2020.11.25.04.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:58:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:58:28 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Hui Su <sh_def@163.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/cgroup: update the cgroup-v1 docs
Message-ID: <X75U9NjlD4RQq3z3@mtj.duckdns.org>
References: <20201102152116.GA186491@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102152116.GA186491@rlk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 02, 2020 at 11:21:16PM +0800, Hui Su wrote:
> Since 'commit 69d0206c793a ("cgroup: bring some sanity to
> naming around cg_cgroup_link")', 'cg_cgroup_link' has been
> changed to 'cgrp_cset_link'.
> so as its element 'cgrp_link_list' and 'cg_link_list'.
> 
> Since commit 47cfcd092245 ("cgroup: kill cgroup_[un]lock()"),
> cgroup_lock/cgroup_unlock have been killed.
> 
> So update the cgroup-v1 Docs.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Applied to cgroup/for-5.10-fixes.

Thanks.

-- 
tejun
