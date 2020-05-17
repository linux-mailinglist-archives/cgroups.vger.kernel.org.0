Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E121D651B
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2020 03:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgEQB6B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 May 2020 21:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgEQB6B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 May 2020 21:58:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429DC05BD09
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:58:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id fb16so3045976qvb.5
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s3yeuZAhDmFpBOUorb/iouNYdnDc9CDj+UxZLN9lvxg=;
        b=nkDo28rEL9kgR2hMhdY3aEgW0FJDqa7d8Al3/yHezV2tdkx30CmhQBcLfiTqOPrgjm
         ARxWaM3min6L9oyJv9TR/E2FlcMiEFBvPZi+GOOGp8QQxTSAD1A/0d1nDMyJMiJEBFlt
         cTisUARGGxzRNNipr3nyN4uDk6/wf1RqeFdZGbWd3rIOcAkAuj4SjJMXo2XR6Rte5iG/
         T5gYipkgIEKTuHxcguMJWsNTk8+IgoOTRYVBFAdEG+tn2bDC8wbgLiiB+J0M8Uwnqbdm
         YuOZdqBrSRWUWn8mWck7nvrVHNn4YJ2VCn1Vwg1F8PbZqe145Ns41oZ15DEX/nBqYWRI
         W7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s3yeuZAhDmFpBOUorb/iouNYdnDc9CDj+UxZLN9lvxg=;
        b=mIwWHr07O/BDO4rSqYVIfjXwxv1X1B7jZPOOR+mLbf0R0+5QKsZRuuQPUAPR+KsNig
         SHGBOKu7QNsET1eBlgT6OO6uYZm9/dQoP1BEdVjF9XUUFQWor6OX+9PulqnH1jOQNgGS
         SW0qAua3rc283gDhjqoBrbq5bLhSMe5QvAAbqPOLFUe2g5MWv0kkrpYxJUtExLxDRd+t
         nZQR2XwvV/1P1Q1FidfUmdJxEj0sRMpsHJsOckGoSE54IC+Lmnlp+hs9O6uKaifidyZu
         rHZBvvcoLkxNvHJGjcoETVGWNrDvdUJnyKu+ZOz8ZOHHMswqlaeQmfLR80YY5xFXFnRv
         6GXg==
X-Gm-Message-State: AOAM533gYc8hJ9/BHFjzuw5n7XoItRwmKmkmretJWnnftpm3ivZ1yEIK
        N57XEQZA3cAakw3qwwLDy9ofvw==
X-Google-Smtp-Source: ABdhPJyNxW8iFR2eteeZ+lqQ9hA289cfRSQ9jxFJxVPy9mAJlEuKi+nIP5JCkbJ2hYF5z2utUz5qoA==
X-Received: by 2002:a0c:c603:: with SMTP id v3mr10304208qvi.82.1589680680311;
        Sat, 16 May 2020 18:58:00 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l184sm5080303qke.115.2020.05.16.18.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 18:57:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Sat, 16 May 2020 21:57:58 -0400
Message-Id: <3D1CF487-DD7E-4C5F-B977-D161CCED5234@lca.pw>
References: <20200427235621.7823-5-longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <20200427235621.7823-5-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> A lockdep splat is observed by echoing "1" to the shrink sysfs file
> and then shutting down the system:
>=20
> [  167.473392] Chain exists of:
> [  167.473392]   kn->count#279 --> mem_hotplug_lock.rw_sem --> slab_mutex
> [  167.473392]
> [  167.484323]  Possible unsafe locking scenario:
> [  167.484323]
> [  167.490273]        CPU0                    CPU1
> [  167.494825]        ----                    ----
> [  167.499376]   lock(slab_mutex);
> [  167.502530]                                lock(mem_hotplug_lock.rw_sem=
);
> [  167.509356]                                lock(slab_mutex);
> [  167.515044]   lock(kn->count#279);
> [  167.518462]
> [  167.518462]  *** DEADLOCK ***
>=20
> It is because of the get_online_cpus() and get_online_mems() calls in
> kmem_cache_shrink() invoked via the shrink sysfs file. To fix that, we
> have to use trylock to get the memory and cpu hotplug read locks. Since
> hotplug events are rare, it should be fine to refuse a kmem caches
> shrink operation when some hotplug events are in progress.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>

Feel free to use,

Reviewed-by: Qian Cai <cai@lca.pw>=
