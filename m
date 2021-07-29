Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933CE3DA6AD
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhG2Okv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhG2Okv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 10:40:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCB4C0613C1
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 07:40:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h11so7793778ljo.12
        for <cgroups@vger.kernel.org>; Thu, 29 Jul 2021 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5bAj8ty5oGdKwNlb8K8CLCbwch75jyi8lukuavge1w=;
        b=Pt/myiUcp/HcWkRJqwMsshxtVCmbTMQkOHiiYTWtRrlpIQtfIwP/TshXg/Sv8sShX9
         o2MFa/ULWHD9UC3jmOcqn1lmGxaT4wKLBTj9EmJNBAHOi7Q8KcOqOF0BKQN7ZPWxNCSJ
         XetW0whmTlm+G5aufSYRe0G9VUSjiNZ+WQeflOuu8nWflrnK9K1ff6Rd2RAu58nxE+Y6
         7qbJdt29eO3qn86prpYrCpSIiyM4hC29igxet+IGxGq7kaFkObrd4BxwXuAznFdcDM9l
         95jP6Xt6Saju2kAdhuCdAVe/F79H2aNR8AMySTMNEDU2FRE0HLzx6Q07o0jseAYwQdQb
         9Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5bAj8ty5oGdKwNlb8K8CLCbwch75jyi8lukuavge1w=;
        b=VBGKbXsm+KBChybf7yjpPvcXYn7eF7d8afKTlapeNNPTd+zoI1oGJqYZhZ7IthLjOB
         2998PSSd2l4cb/KwEgn7qSR7sLeF6bGjVcdSOgRhdka0cf78rrfUxsfHIwNwQyHtSWZM
         3LkcMhy6lT/jPdQg51c9MSRzTzYXAGcOzKMx5y0bqT3x2VFN97MauLyRIcEekqgrAApN
         vYxdg2Gg/wpZgvyW9AyMM2VdjjQmpCkp+4swoHZT8kSgf0XDS7WftW49PlM02EHwt6YX
         91sNFyKB6y1DKxM1uffN2sebAwukHTFw2G4GmeCTlwMMWgxta6A/DEDq6D7JS3hgj+Ea
         hLlQ==
X-Gm-Message-State: AOAM533nuJMsqDPqzN1klBE3/SdFAyKtspv9K7hQa8gQZ0qALqh10l6s
        bJF39liTj4jSAqKD9rr7aIWKOUKMfUqcuodsJ5Z7ng==
X-Google-Smtp-Source: ABdhPJy0WHl5s9+K9hYnC4buzSwLhc4EudrWVzNl4PYmMwFv350CnGn+D/62ehgVRJhSUPwN8mqn74ibwIDnHFvWGvY=
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr3201903lja.122.1627569645751;
 Thu, 29 Jul 2021 07:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-4-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-4-linmiaohe@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Jul 2021 07:40:34 -0700
Message-ID: <CALvZod4MpcxzZ59hTX72g7F26Kmb=hfBCGNUGq41MgRfTvuEsQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm, memcg: save some atomic ops when flush is already true
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 5:58 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Add 'else' to save some atomic ops in obj_stock_flush_required() when
> flush is already true. No functional change intended here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
