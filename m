Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2598F2D14B
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2019 00:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfE1WAc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 18:00:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43848 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1WAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 18:00:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so135892pfa.10
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zz3efGRJMkCi9u1FMXnDOgSGtU0NK8c6CTTxYaLRlUk=;
        b=UZzU4SeJuNsj1RuhrcyrwW4MS5X4kGC8Ge0T2obb1h/h/CTewhMxNkcfTqUtxV7Ybt
         l9JJno+dbcn1nkV0bH46Xhs3idLMJ4T/k55B/bpWBy9ryQnadZtrxLIcchZWxAkYBAbu
         fbhRFIDfo0/NnrAyNaE2ecYXcWho1QdaI0s/85/A+X7r9AK+tHFK+6aNWEpQy9HQs8Bb
         Li6LBCRaI75me6R17Qp1LTHnXDTPmx2UWK0vuWad9yeDuO3j4ni9wGrrdVO0l8uqGxHW
         8Dsgz6ec6+oz4dmuhnZIKpxAgp6jx6+atPwCgm0WJQwwyg81bncpkILNj4fcw8WBEp02
         G2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zz3efGRJMkCi9u1FMXnDOgSGtU0NK8c6CTTxYaLRlUk=;
        b=unU3TvB+U2h/YGi/XJnUQl/11ivk2qno4mC+cKJUQCPkbDcFOGxikF+PQbq8K+IWEB
         ygyX4Gvig1Xe/6adW3bFq83lmGHzei7eit73djORbf1rQEGnhtrQse3y8RGUeY3Ky/S+
         rtNujXCZU1a+3xS/fyo2uJlL0JV4KSyorxT97DYjPpba8vBFoktP4Bv9BSaOSwTnpkNd
         jsqhN1MzGvpYVl83VnYaBcdPY44PJEbeHyKBinIIBRFhS5JZ4ObLfJXrfErULhelJ1VG
         pmhrJ50hudBtGu7Wh05554nop+fRmWFU+kmDSZ5NJU9a7X0dBnxtqQscz3w2hWOApYp0
         wYcA==
X-Gm-Message-State: APjAAAUCIT1+Y4Ad6GVQn2MNM3z/TBGtJ7q/wJcVG/9q8S2x+z2Keg2Y
        7u+W+I8xXz0+4si65RpPfRAy7Q==
X-Google-Smtp-Source: APXvYqzcjXyIC37ZtNb/BvRceiRze2ZuMVZOqei3nfqsf/GzOqhW1pZLQ48briznsQGYnG3llCRAQA==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr146120273pfd.25.1559080831650;
        Tue, 28 May 2019 15:00:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:77ab])
        by smtp.gmail.com with ESMTPSA id i3sm8919865pfa.175.2019.05.28.15.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:00:30 -0700 (PDT)
Date:   Tue, 28 May 2019 18:00:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 4/7] mm: unify SLAB and SLUB page accounting
Message-ID: <20190528220028.GB26614@cmpxchg.org>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-5-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 01:07:32PM -0700, Roman Gushchin wrote:
> Currently the page accounting code is duplicated in SLAB and SLUB
> internals. Let's move it into new (un)charge_slab_page helpers
> in the slab_common.c file. These helpers will be responsible
> for statistics (global and memcg-aware) and memcg charging.
> So they are replacing direct memcg_(un)charge_slab() calls.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
