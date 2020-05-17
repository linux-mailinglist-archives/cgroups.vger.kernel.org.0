Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553E01D6514
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2020 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgEQBqJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 May 2020 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEQBqJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 May 2020 21:46:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15346C061A0C
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:46:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 190so6794004qki.1
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=v8/1I95wcTj1mWlxsoep0Hvc73TKsH79uHMoZbzZUWA=;
        b=mTuyBRurXQZEK9utptTiC11aN2pRP5dmNcE3mS9JBiWGvq+XHi1IprBG0ma5RZ8d1B
         mq/y+wqaSGx+FRZ55wJjSWJknBkFCrIAqsYJSJG+IJNbVLUiZY0PjS65iNMYjH5poapJ
         ano66ITpWYc7rAQifzLH5VBHZaDrUFXLp87bcqJILV29+PDGdX7D8K7W9M26JKqOX6FC
         aQiPnMJf1SdeDID06QRXlqxWkRGX8BJvxwE8AUiQJvRghyyLv3dtN/xklxayHY2TAiOW
         QudmNWPFzxw7MllH6ftOp0wvqb3tMAV8Mda48M/0Wy7idJzc4TBrjXekP9QxEtS5uGvd
         wtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=v8/1I95wcTj1mWlxsoep0Hvc73TKsH79uHMoZbzZUWA=;
        b=ZOvKGJWoemWBjx1sQqrz4utWb0kmsSEt6m/HgDOAVTUIwYvtE+l8yy7hfm34h/aA+W
         Y2yuSMaTMy9KMc/PsNA11AoaSRp0wdUjqCSJjK6zvVmBzhPxS+blvbw5EVkZ9uxULa5d
         9NqKH5EeFL+oj8lXsBPdcqEV5jhnZzqacqPuZNRI1vRws5l3r0A6dC7iramHJ6vdrpKl
         /FuTMvNxLvPoRyX2IQf4kCAo0Tf4cl9vEwrUiNXx+mtwvxkFbsws4ij6Thz5GkSopqRh
         Dd/3U0lzQcdiuEnWifJKHgf8j+rDbXBD4AFALyl6Bolk47DjaNTbnsK2KAJqNzM6Q0A0
         /TPA==
X-Gm-Message-State: AOAM531DTz4T7w3aNPaGJvPmIEeyBmb9NcviqktpQ+2s13ZLbnEDu+kG
        PSjYSaXH7fFB/rvJtbbS1Qr6lA==
X-Google-Smtp-Source: ABdhPJzStOu9xj05KLKxunZry1UUBpBOKseoEyDnnEQBwPMBKvyZuLowmwoxKqJL+Hq9l1aoJW48+Q==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr10042251qkg.478.1589679967192;
        Sat, 16 May 2020 18:46:07 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g66sm5186785qkb.122.2020.05.16.18.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 18:46:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Sat, 16 May 2020 21:46:05 -0400
Message-Id: <62C1A69E-A14F-42EE-970F-ABAEA2782256@lca.pw>
References: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
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
In-Reply-To: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 28, 2020, at 10:07 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> Trylock is handled differently from lockdep's perspective as trylock can f=
ailed. When trylock succeeds, the critical section is executed. As long as i=
t doesn't try to acquire another lock in the circular chain, the execution w=
ill finish at some point and release the lock. On the other hand, if another=
 task has already held all those locks, the trylock will fail and held locks=
 should be released. Again, no deadlock will happen.

Ok, I can see that in validate_chain() especially mentioned,

=E2=80=9CTrylock needs to maintain the stack of held locks, but it does not a=
dd new dependencies, because trylock can be done in any order.=E2=80=9D

So, I agree this trylock trick could really work. Especially, I don=E2=80=99=
t know any other better way to fix this.=
