Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB71BD2A9
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 04:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgD2Cwy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 22:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgD2Cwx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 22:52:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02592C03C1AD
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 19:52:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so640150qkg.1
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZuYhQOwVqj5I2l0C3mwcWWBRC4vXsL2shmKKYh/lrQg=;
        b=aCmH7CwlwPl/0ya/suzFuA1fMGqaCRqlG1An9hZRxqlWrWA87i8lAzj19h17I7fVNY
         SkAcbxzKv2yVzNDU26bW9XPSlaGn08IkxBernQCD5ymMMy10wMAO4iA5SlJgrV6/rHaR
         UR10WckaYKHTF8QxLVBLYtLz+jd+e24vryNXvlfdrfdWXTi/pS4/yFmx45AuBPT1atFY
         e3xpNkyL5b2gkq9kVYEGW7ICo5ondTQiiXBy7zypoc2So3d00g3auY/sQKGU43yMdxoG
         ehNkl1Lxa29e4IJt1e3V3D0XETFGEopBpDd1nTLMoOy1Y1xIImQCuF2KMJqnHHy7H+M9
         uy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZuYhQOwVqj5I2l0C3mwcWWBRC4vXsL2shmKKYh/lrQg=;
        b=O/iMP2fl+vs1N03gqtmQ1JnsIvpc+iQmEAE5V+osUwTna6ZxmC7wj/WiW5KjxYZzlG
         m9q4TTPgmDyhCUdgA051+kO96eUZd4ysqNmvmOM6BgebN7WI/EdyyeGNhAPwlC4VYzKM
         M03rfbar4ASv4EZYorqUn7kaQ8P1zHhfweWeMbGMSV09g80GuTuCMRE3DFJt19eOWniW
         xxLNd136YHnv6Yb6tpqByIl3sPmEtVFcfwN07ngawa55fbEZJ/RZ2WC0r9YIZ3ow+3HG
         518c9M0lL5H2UKrMmhOZC/VgKMWeYvBO4ZAlY+hmdlD09WSUS8xjjDvqe/VFhr1aNk9n
         bauw==
X-Gm-Message-State: AGi0PuYdEwDtsIdsnNogzl+xpIUXB8XxTp6YUgsbX1p9OwSfovw/nG50
        aRDdRYhXcRQ8JRoQ0t62VYF27A==
X-Google-Smtp-Source: APiQypJiO5xWI+h/pT4bi47A94HPt7b3SBuTMERGoOCtnJcgSOKc8ipTbQTSRssdaCLVDjQ5/LtWzQ==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr31743791qkc.167.1588128771014;
        Tue, 28 Apr 2020 19:52:51 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t67sm14947399qka.17.2020.04.28.19.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 19:52:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking
 dependency
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
Date:   Tue, 28 Apr 2020 22:52:48 -0400
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <0310F66F-0ECB-43BF-B86F-3BDB74F51B06@lca.pw>
References: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
 <28BB8A1C-CFDF-4F5A-8686-537C3CE04818@lca.pw>
 <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 28, 2020, at 10:06 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 4/27/20 10:11 PM, Qian Cai wrote:
>>=20
>>> On Apr 27, 2020, at 9:39 PM, Waiman Long <longman@redhat.com> wrote:
>>>=20
>>> The sequence that was prevented by this patch is "kn->count --> =
mem_hotplug_lock.rwsem". This sequence isn't directly in the splat. Once =
this link is broken, the 3-lock circular loop cannot be formed. Maybe I =
should modify the commit log to make this point more clear.
>> I don=E2=80=99t know what you are talking about. Once trylock succeed =
once, you will have kn->count =E2=80=94> cpu/memory_hotplug_lock.
>>=20
> Trylock is handled differently from lockdep's perspective as trylock =
can failed. When trylock succeeds, the critical section is executed. As =
long as it doesn't try to acquire another lock in the circular chain, =
the execution will finish at some point and release the lock. On the =
other hand, if another task has already held all those locks, the =
trylock will fail and held locks should be released. Again, no deadlock =
will happen.

So once,

CPU0 (trylock succeed):
kn->count =E2=80=94> cpu/memory_hotplug_lock.

Did you mean that lockdep will not record this existing chain?

If it did. Then later, are you still sure that CPU1 (via memcg path =
below) will still be impossible to trigger a splat just because lockdep =
will be able to tell that those arennon-exclusive =
(cpu/memory_hotplug_lock) locks instead?

 cpu/memory_hotplug_lock -> kn->count

[  290.805818] -> #3 (kn->count#86){++++}-{0:0}:
[  290.811954]        __kernfs_remove+0x455/0x4c0
[  290.816428]        kernfs_remove+0x23/0x40
[  290.820554]        sysfs_remove_dir+0x74/0x80
[  290.824947]        kobject_del+0x57/0xa0
[  290.828905]        sysfs_slab_unlink+0x1c/0x20
[  290.833377]        shutdown_cache+0x15d/0x1c0
[  290.837964]        kmemcg_cache_shutdown_fn+0xe/0x20
[  290.842963]        kmemcg_workfn+0x35/0x50   <=E2=80=94=E2=80=94 =
cpu/memory_hotplug_lock
[  290.847095]        process_one_work+0x57e/0xb90
[  290.851658]        worker_thread+0x63/0x5b0
[  290.855872]        kthread+0x1f7/0x220
[  290.859653]        ret_from_fork+0x27/0x50=
