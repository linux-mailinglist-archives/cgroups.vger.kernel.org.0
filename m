Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F23DB131
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 04:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhG3Cil (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3Cik (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 22:38:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC5C0613C1
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:38:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so12279832pji.5
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4WMMn3KZL/hzwCkedZqe/lll/VsdM4TyQkWpwv+pB0=;
        b=Ekx4RmWXZPFJE+OMq795Ky7l5Qiiu10/BdprEfuK7DG+c7bB5LrAOoxCfOq4LcZdVB
         yBREPZM20pqfvFU85pDqfCUKfxMy2RQvQJA1Oo9WdmQS1E3QhJLqVvKHd2W1lsTmaYFV
         IubFHVyVEUe+rkf/seQ+ZGzYLjQhZ8PdSvS2mB6lwN3aTJMTGelWDOqxJilxvC10Hyl3
         1pmNQgU/21cplXyhA7jnHCWRUeOai5mmHHhP6If+azneudn4hpuE3f5ZfN0ULd+XhatO
         PeLdmEC8sMTSch8HjtrbtNCKYJuDQ+p5Qhiwxn3ofBQmXx4KzMLaoFZSAZoDFOMBH4jD
         y7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4WMMn3KZL/hzwCkedZqe/lll/VsdM4TyQkWpwv+pB0=;
        b=EgmtT6OpXlR7+fkZrXK+fzMrt+Hux0A8unE/DUCSGiA6UNxxW5IARGgyNT+hWgkQZW
         UsCD2iYosVhdrEQ7p9ZNHRJEmHGbJHCwInAa6hddCaTNCvy5xbVZRL9e5u0meQnULdEW
         wZcr/e3Bm7R7gGzB+edBkz2dfC+rgduKJ2hFXsy9OpdktMWZ/AADMSAdoQGVgmbDj6a9
         vrPQWqOZpldEkmrNNXo1SJtqNPseEm4u/35g1xk29PH1CDBTGQV5kbJOLcFqbdGlNtOb
         ZRI/6piB4PbYfH80QhtNt78Dzduvv/tWCWmlMTKTVwj7b9eztAL2OPu4S58FJICQawyh
         Ot6w==
X-Gm-Message-State: AOAM532Ub5e2j2JGIQiIOuJqOmFrU9SeHDA16SPoRQckxpRAdXq9Dg8q
        sawR6yZqE0L3BtvuS+/uL+oxaocGy/E5Y2fFgDZtVw==
X-Google-Smtp-Source: ABdhPJxBGjZRIrUbp4ZwPJ7kfW59bEBib6O3i3OsKd96uN491iSaTFmmzpTqpEUp9/J7M5p5eVbNep3OV61b7VZBVFQ=
X-Received: by 2002:a63:550c:: with SMTP id j12mr203751pgb.31.1627612715592;
 Thu, 29 Jul 2021 19:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-4-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-4-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:37:55 +0800
Message-ID: <CAMZfGtVLd29_wmQ6iYky0WHrk+PO_AnwDBzf-bW4kMRCW=P4UQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm, memcg: save some atomic ops when flush is already true
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 8:57 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Add 'else' to save some atomic ops in obj_stock_flush_required() when
> flush is already true. No functional change intended here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
