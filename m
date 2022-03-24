Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0146D4E66EC
	for <lists+cgroups@lfdr.de>; Thu, 24 Mar 2022 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351654AbiCXQZ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbiCXQZW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 12:25:22 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E03D4A8;
        Thu, 24 Mar 2022 09:23:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648139027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlU6JpVYC93QtZ6D2/Ze8QjTZ71IF09IQ/nMKJqg8hc=;
        b=Dz+/nGu1/jm2+vB4zQIBb+nXE2hZlNTrO17gf+Lf9ZPWIfmxoX4vihNvVMbGxXdtPDE4E7
        lYaSsRYI4FwNYMrnKL0Q9AnJhmAisTnqXmAn/ACjniKDXU20eF4DP71R5eHHuWmzE924jp
        4njvGX3E9hG2vnT2mEOR5vDAcrZBfhU=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [RFC PATCH] cgroup: introduce proportional protection on memcg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <Yjx/3yi7BfH7wLPz@chrisdown.name>
Date:   Thu, 24 Mar 2022 09:23:44 -0700
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Message-Id: <FE4CCCF9-CF08-424B-85D0-B5C1BA63329D@linux.dev>
References: <Yjx/3yi7BfH7wLPz@chrisdown.name>
To:     Chris Down <chris@chrisdown.name>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It seems like what=E2=80=99s being proposed is an ability to express the pro=
tection in % of the current usage rather than an absolute number.
It=E2=80=99s an equivalent for something like a memory (reclaim) priority: e=
.g. a cgroup with 80% protection is _always_ reclaimed less aggressively tha=
n one with a 20% protection.

That said, I=E2=80=99m not a fan of this idea.
It might make sense in some reasonable range of usages, but if your workload=
 is simply leaking memory and growing indefinitely, protecting it seems like=
 a bad idea. And the first part can be easily achieved using an userspace to=
ol.

Thanks!

> On Mar 24, 2022, at 7:33 AM, Chris Down <chris@chrisdown.name> wrote:
>=20
> =EF=BB=BFI'm confused by the aims of this patch. We already have proportio=
nal reclaim for memory.min and memory.low, and memory.high is already "propo=
rtional" by its nature to drive memory back down behind the configured thres=
hold.
>=20
> Could you please be more clear about what you're trying to achieve and in w=
hat way the existing proportional reclaim mechanisms are insufficient for yo=
u?
>=20
