Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8AD322D4B
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhBWPTR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbhBWPTP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 10:19:15 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDDCC06174A
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:18:33 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z190so16414048qka.9
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BEgzN/eWl9ypgO18zGxZMbgknCN0HuQ7lE1kZsV2Mqc=;
        b=1olQJtG/wvtNQelqBB7lkff1dMw5my00CEjeWJ1HstDl1DCMGbdlX+7YLDlDBZwK8C
         FjBU18p9rB4l/AUnaEq9Qxjl+WCChyHx3OQVGcWWqgdACPeyzBL0AdQEU7KkosHV80Ql
         ry7PE2TuhFrccnUA6Dyo2q9wTcfDkGwkbr/udctYwcZYbzmz9V3WU+zZEyiMPQXhaspB
         8FbO8VTuMKy4oOP9czAfGPOIDW3Pb8/QLa3XNYvFx5URd/JIhkT7kfTlOAAbWTfQBIdV
         Y+fBDVr3jrNydsKaeRtTuq9X8HZU60XJlsiVbDJ7x6VuqH20iGNfwwgMm3sfXgMqkePz
         657A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BEgzN/eWl9ypgO18zGxZMbgknCN0HuQ7lE1kZsV2Mqc=;
        b=QtZHrBX/yuYukI39sHqacBzN4ka7dcy2kTJVK1cA4IaBNc4OMsAE108HaVvVTzg6NL
         xbYnea2idhYhMQwMuJqdLdZaUvaA3KuyY0fUncR2ki1sS9aI6MdUwMYWOgbNGSGa3d5e
         UKx8QJ/PfIc6e7vFFwAl/W+6OPFRIY8gQwKGrFDci/+Wq9PfZq2ZjL7hYQQtSLCz2S/z
         HV9DocZXJ5Ormu+VLVUZEOCpkB4Yo+xofWd/OjgaKRFpzuirfuM9N9X8MT+K35kOtwzt
         Vu14k9sZJw/99wTcnsXzDahVpJ/Xyt/VcROSGVJqeaUlH3LjSPOWhuOAXTSrtwuNCjuk
         IljQ==
X-Gm-Message-State: AOAM530MSc30T4SFChoIzG3RNsrL0M4/hdezKFUaC1Ifv7LP6OoK7RGH
        b3BCCO2fLw1cKsr+MiAALyaqklQY3K5BVw==
X-Google-Smtp-Source: ABdhPJyxluBmo33wmV5Zdq8xSmAKSugIRQowaGA7cWV7LaCwSlnoQNrB4c6x0C4GImZr3BuOFDIxJg==
X-Received: by 2002:a05:620a:4152:: with SMTP id k18mr23885378qko.446.1614093512638;
        Tue, 23 Feb 2021 07:18:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:a2a2])
        by smtp.gmail.com with ESMTPSA id d1sm12739451qtq.94.2021.02.23.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:18:32 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:18:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YDUcxs5Zw+265Vpx@cmpxchg.org>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
 <YC4BcsNFEmW7XeqB@cmpxchg.org>
 <d141f9ec-5502-b011-167f-e24d891b0dfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d141f9ec-5502-b011-167f-e24d891b0dfe@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 22, 2021 at 10:38:27AM -0800, Tim Chen wrote:
> Johannes,
> 
> Thanks for your feedback.  Since Michal has concerns about the overhead
> this patch could incur, I think we'll hold the patch for now.  If later
> on Michal think that this patch is a good idea, I'll incorporate these
> changes you suggested.

That works for me.

Thanks!
