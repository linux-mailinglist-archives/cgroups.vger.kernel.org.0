Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358EC5F2139
	for <lists+cgroups@lfdr.de>; Sun,  2 Oct 2022 05:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJBDpd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 Oct 2022 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJBDpb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 1 Oct 2022 23:45:31 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982392EF21;
        Sat,  1 Oct 2022 20:45:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664682325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vc7/td9WozM5pVmB5K7uQM4nbJeJhzcm1HJ4XY9GakU=;
        b=lKPtg3cGoFY9Kpcu070SXiUX1GJwQaYBbfJzBQ4ZE15SZIv0jkZr0kPwUqy0BUAUPg//h5
        T9oOOROm3XM4Qi52/Z9EfdLCEUlWdP/UklihlzZf6I4ieJ2Y8BgEnxvNOnEHcyAiN5DTTA
        lEN6x8V2zTvhdvOaWB9XSVVAGJaJzTs=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: memcontrol: use mem_cgroup_is_root() helper
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
Date:   Sun, 2 Oct 2022 11:45:19 +0800
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <828C4B5A-7114-47AF-BA99-0920EA41C753@linux.dev>
References: <20220930134433.338103-1-kamalesh.babulal@oracle.com>
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Sep 30, 2022, at 21:44, Kamalesh Babulal =
<kamalesh.babulal@oracle.com> wrote:
>=20
> Replace the checks for memcg is root memcg, with mem_cgroup_is_root()
> helper.
>=20
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

