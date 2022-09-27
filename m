Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D85EBCEC
	for <lists+cgroups@lfdr.de>; Tue, 27 Sep 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiI0IOV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Sep 2022 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiI0INv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Sep 2022 04:13:51 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B77140A1;
        Tue, 27 Sep 2022 01:09:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664266176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEDpjPu4yNvQDli6jyEAiLWXdmhiP5ZxnG9EUS2lS0s=;
        b=ZxC38sHMffmDzj9Q93uw6vbI2H5cF8jwndq/t9yynR1mgD41NnyBORczwFXjOa5d2iDkdI
        j/Lp3OLJblpfCI+pZRPbrGL61A2frbeqa7t7XSxAJ6zzvYWyRC5C8Mqe14qU5GIKYfiWwq
        Sg/ws9WJgnG0bog7Hf1xniXzTcYbpgk=
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks
 allocations"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
Date:   Tue, 27 Sep 2022 16:09:29 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BE849F7-5F5A-4CCB-B386-DC9A64EAC8A9@linux.dev>
References: <20220926195931.2497968-1-shakeelb@google.com>
To:     Shakeel Butt <shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Sep 27, 2022, at 03:59, Shakeel Butt <shakeelb@google.com> wrote:
>=20
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
>=20
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set =
proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.
>=20
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vasily Averin <vvs@openvz.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

