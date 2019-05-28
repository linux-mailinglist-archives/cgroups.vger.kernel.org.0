Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183882CD4D
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE1RM7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:12:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1RM7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:12:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id h13so15206400lfc.7;
        Tue, 28 May 2019 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7II5+XRnVobtVPgQVRQrDR8x4e5To08TyrztMHGvqag=;
        b=eaq0BTRPkhNafZhWSSYSrscltuZlK8p6kHWOeCVXycDQv7t3RspcGhqc4CbVFRfJ0/
         o7HJXatIFeoKZxyCMT287FoSfvrUs0U0xqqF+ZyaTxsF6AXOvHhx+mEnvBMiZVkkC7ec
         QCS0S+APb1j6fW2ryNi4o7g80ajjVeRBHQNbzfaBo7pN07pH1YZkz60t0gSOOA3Sa77n
         IUDDmczlKJ9hmuAndnQn4+Y/SUZKWO+OMmA80g+gjOLOd+UpCkLuevIe+dS8TuJtPJey
         2PC562PZ6yYaNgc3BidpuZdLxw+bNgr4tYYphKwEZ3XqIzT7w38tkPatdRI9FkWb/PTS
         N+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7II5+XRnVobtVPgQVRQrDR8x4e5To08TyrztMHGvqag=;
        b=DUO5En1dTvbSXbQmc1GJnFFO6BTzt4kM8cklYJFWB48yixiorxlkVoiTq/CxBHIffZ
         iXHVIvJO+E1H3MlLjs+L7VjJ6bmW9oXtjSuz+E1M80xJUtSiXHOVRBxHWDMMs+vYxdr3
         xgwBrmnqGu/zrcbdfPuBkBn0kMUBrw3XWHGcaUoTh0wehFtWK2F/YtcWJRKTGTcxWsX7
         r0foGPhd8Knt/9VDehH3QdBJALvz7SfQKfZ30t0k8j6p7VEpTpGu/BO1vwA2kowJVvx+
         6IGIadI3kyMYpxG1EcOxZYvXPUNygFjtHuIpGsSebpqwxVYLDjGgIyjCGU7ptKvSbhza
         TB/Q==
X-Gm-Message-State: APjAAAV93OVsPOgfGkrb1W0J7jh4irOp4k8Y9FXBiOP1B7gDtgZUVm2l
        ftnfML7vEQ2TwlaUI2Om6fk=
X-Google-Smtp-Source: APXvYqweo1MPDUPsmU7agUat02Negiwx5X1FenEPDIVNxQGPC9Z7TsrTpK50AruQozndnwRD+b61rA==
X-Received: by 2002:ac2:4908:: with SMTP id n8mr3692243lfi.10.1559063577452;
        Tue, 28 May 2019 10:12:57 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id x14sm2989317lfe.83.2019.05.28.10.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:12:56 -0700 (PDT)
Date:   Tue, 28 May 2019 20:12:54 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 4/7] mm: unify SLAB and SLUB page accounting
Message-ID: <20190528171254.ymnytie2uc4hwd4v@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-5-guro@fb.com>
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

Makes sense even without the rest of the series,

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
