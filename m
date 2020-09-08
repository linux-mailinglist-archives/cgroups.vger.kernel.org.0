Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E4260D2B
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgIHIOE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgIHIOB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 04:14:01 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A868C061573
        for <cgroups@vger.kernel.org>; Tue,  8 Sep 2020 01:14:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t16so10273221edw.7
        for <cgroups@vger.kernel.org>; Tue, 08 Sep 2020 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9yS5F51D4ggPT5sO3CXtYZY7IS+3p8Fe7sC8hbp+FY=;
        b=WipNcCelKnPDX+MMC+RhYHhyl2r7Y/UQRpi+V6LeVgin7a8cii5jfnN1pOriG87xvp
         zGerNJ7TN0DiXyTm35s5RAKC+V3DizCPWXKhYU4HVpzcX2wLYDu5uMsY+yLElR5lBrcq
         Jh20reQOD0kigW2bW13BcgxQ8ldtiMwY6OxYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9yS5F51D4ggPT5sO3CXtYZY7IS+3p8Fe7sC8hbp+FY=;
        b=YV03ndzEm/hMO8DNHuj+aOMDzDyB3nEGke7knEYJeQ7D+s9feozCsN9PB14fNE/afs
         xOmppdCrwNMqbHCX4iL+TTBPtdBjW2Cmp6PqLFy//FTqvbQVGtAGKXG2Y2xkaQBE3/5A
         f3/YVDFCu5O5xwGbYfCkTvJ6lvzteCAWhcbfvlRcWbfE4c1uCOXbNapMkFsRdFdZPo2Q
         uxxdmFpfuX30Q8fOShGXaSbD4wNaJjRe4QC3HCVD4uQIVeanuONb2noS4f6Cuas6sNFH
         U4cUvOUr+bGdr9UQeW6+jBGrpOp0gQhcfznw+TulTqUct/3yeTyRMU7Wu5pTm//nowrX
         MqFA==
X-Gm-Message-State: AOAM533C3nvbJ6lbl8Zv6vIutu5EG3q8v91wHOXinJhG+oCft0HdfaLB
        jO6Ow8RahlvZ0LVZV3UuUDMd8g==
X-Google-Smtp-Source: ABdhPJx7nWW1b3xNeHA9A0fJgW6LRQK46nQI3cMuR8JrMQqwezNkTlkDswsxTGvsFVZeFCzv3D2lCA==
X-Received: by 2002:a05:6402:50f:: with SMTP id m15mr26829900edv.41.1599552838858;
        Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4614])
        by smtp.gmail.com with ESMTPSA id g11sm16928457edt.88.2020.09.08.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:13:58 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: no one use charge_type
Message-ID: <20200908081358.GA1219116@chrisdown.name>
References: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alex Shi writes:
>After commit 0a31bc97c80c3f mm: memcontrol: rewrite uncharge API, no one
>using MEM_CGROUP_CHARGE_TYPE_xxx, let's remove them.
>
>Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: cgroups@vger.kernel.org
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org

Acked-by: Chris Down <chris@chrisdown.name>
