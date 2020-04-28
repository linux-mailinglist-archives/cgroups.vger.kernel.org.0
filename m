Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701B31BB3BB
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 04:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD1CLR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 22:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1CLR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 22:11:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FEC03C1A8
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2020 19:11:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h124so3181078qke.11
        for <cgroups@vger.kernel.org>; Mon, 27 Apr 2020 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7634cSYNnkEeZLF9qaQ+2AgpibDUSOrBUl4aX1MYmtc=;
        b=ZRkzebefYI8C8YM+yiMqJuIxbcoHVPnVIoxvoL8/hgvaR74uXvHOvFl4346qeUIuUr
         7GZbXnz+22W3LePUoSJ2gWqSXyMqfX1aUWsfxdOmpYbgkh8OzGZ3kG4YzmdclLPek/RO
         oVJAxqoWqeclY26sXJcQs4W2JfjNzlx4Ey0FoMnFAYL9UxTnrZyoZzIjUm4gp+ozkZZB
         vFMTJiTsxGPCrFmtoqo4y0cxos0KVXLX5nMiiWNh/Qy+CCpNKygxhfkIy3hgeOu7PyAq
         oi2Y0OKlopHWpUuBSkiL0Ed0d0RcX12M4Hl2WS0lsStn0GM0VeqsPhoQqU3g67mlydnw
         wclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7634cSYNnkEeZLF9qaQ+2AgpibDUSOrBUl4aX1MYmtc=;
        b=EfBsBYCtYYm6FYx3o/bpqzILHMqVc4gBeAX4syJ155m0APG8oL4o8QtIyXfYNq0YIp
         Mcnso0RChbCVPyAylKhyhwCTx+O4Z3UC6SxIu1YUpnzbc75bGBUtNMw6C+W5aZUv3G/j
         9Ame+C7GQVjN/CTyvVgDz5ktpTeVohMQVuxxshahcxDU7Tj1t2g1NZvRKrdpRlOKljpW
         5beXreMXeSqYHpU7lLMn19/9zMTiNyDj+5PeyZKrgflT/T9300GuimYHSWlwJdkdPyuf
         wbqzGKMJ4QFAAbhWGsOoljyVe72k1YqYH7lne5/zzy6MC2/KR+rdafontKstncX3Un15
         KWKA==
X-Gm-Message-State: AGi0PuabZcgIky1zvjs5a2N1luIXuGbBcy0bnSyEbDP68jAChShpely4
        UKD29AflnuFPq+/pue3aDM2qiA==
X-Google-Smtp-Source: APiQypLaVm9c2SWLzE0Ol8tWHv9xAxVvSk0tUEaXh6snUiBA0tr0lAOAwF/hn7HoXTPC1RAWydrxSw==
X-Received: by 2002:a05:620a:13eb:: with SMTP id h11mr23839919qkl.404.1588039874792;
        Mon, 27 Apr 2020 19:11:14 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p2sm12282513qkm.65.2020.04.27.19.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 19:11:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Mon, 27 Apr 2020 22:11:13 -0400
Message-Id: <28BB8A1C-CFDF-4F5A-8686-537C3CE04818@lca.pw>
References: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
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
In-Reply-To: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 27, 2020, at 9:39 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> The sequence that was prevented by this patch is "kn->count --> mem_hotplu=
g_lock.rwsem". This sequence isn't directly in the splat. Once this link is b=
roken, the 3-lock circular loop cannot be formed. Maybe I should modify the c=
ommit log to make this point more clear.

I don=E2=80=99t know what you are talking about. Once trylock succeed once, y=
ou will have kn->count =E2=80=94> cpu/memory_hotplug_lock.=
